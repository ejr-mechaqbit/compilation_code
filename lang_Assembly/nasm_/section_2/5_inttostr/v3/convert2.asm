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
  test rsi, rsi ; check if number is zero
  jnz .convert ; if not zero, proceed
  mov byte [rdi], '0' ; store '0' if number is zero
  mov byte [rdi + 1], 0
  ret

.convert:
  mov rax, rsi ; move number into rax
  mov rcx, 10 ; ensure divisor is 10
  xor rdx, rdx ; clear remainder
  mov rbx, 0 ; counter for digits

.loop:
  div rcx
  add dl, '0'
  push rdx
  inc rbx
  test rax, rax
  jnz .loop

.write:
  pop rax
  mov [rdi], al
  inc rdi
  dec rbx
  jnz .write
  mov byte [rdi], 0
  ret
