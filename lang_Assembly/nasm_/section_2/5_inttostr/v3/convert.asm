section .bss
  buffer resb 20 ; buffer to store string representation

section .text
  global _start

_start:
  ; Load numbers
  mov rsi, 12345 ; number to convert
  mov rdi, buffer ; destination buffer
  call int_to_str

  ; Print result
  mov rax, 1
  mov rdi, 1
  mov rsi, buffer
  mov rdx, 20
  syscall

  ; Exit
  mov rax, 60
  xor rdi, rdi
  syscall

; Function: Convert integer to string
int_to_str:
  mov rax, rsi
  mov rcx, 10
  mov rbx, 0
  mov rdx, 0
.loop:
  div rcx
  add dl, '0'
  push rdx
  inc rbx
  cmp rax, 0
  jne .loop
.write:
  pop rax
  mov [rdi], al
  inc rdi
  dec rbx
  cmp rbx, 0
  jne .write
  mov byte [rdi], 0
  ret
