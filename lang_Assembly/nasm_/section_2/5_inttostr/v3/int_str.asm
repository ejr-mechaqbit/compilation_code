section .data
  num1 dq 10 ; first number
  num2 dq 20 ; second number
  result dq 20 ; store the result
  msg db "Sum: ", 0 ; message to display
  newline db 10, 0

section .bss
  buffer resb 20 ; buffer to store string representation

section .text
  global _start

_start:
  ; Load numbers
  mov rax, [num1] ; load first number into RAX
  add rax, [num2] ; add second number
  mov [result], rax ; store result

  ; Convert result to string
  mov rdi, buffer
  mov rsi, [result]
  call int_to_str

  ; Print "Sum: "
  mov rax, 1
  mov rdi, 1
  mov rsi, msg
  mov rdx, 5
  syscall

  ; Print result
  mov rax, 1
  mov rdi, 1
  mov rsi, buffer
  mov rdx, 20
  syscall

  ; Print newline
  mov rax, 1
  mov rdi, 1
  mov rsi, newline
  mov rdx, 1
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
