; Convert int to string

section .bss
  buffer resb 12 ; Reserve space for the output string
                 ; with null terminator
section .text
  global _start

_start:
  mov rax, 12345 ; Load integer to convert
  mov rdi, buffer + 11 ; Point to the end
  mov byte [rdi], 0 ; for null terminator
  dec rdi ; Move pointer before the terminator

convert_loop:
  mov rdx, 0 ; Clear RDX for division
  mov rcx, 10 ; Divisor (base 10)
  div rcx ; RAX = RAX / 10, RDX % 10 (remainder)
  add dl, '0' ; Convert remainder to ASCII
  mov [rdi], dl ; Store ASCII character
  dec rdi ; Move buffer pointer left
  test rax, rax ; Check if quotient is zero
  jnz convert_loop ; If not, continue loop

  ; System call to print string (Linux syscall)
  mov rdx, [buffer + 11]
  sub rdx, rdi

  mov rax, 1 ; sys_write
  mov rdi, 1 ; stdout
  mov rsi, rdi ; Pointer to the string
  ;mov rdx, [buffer + 11] ; Load address of the end of buffer
  ;sub rdx, rdi ; Compute string length
  syscall

  ; Exit Program
  mov rax, 60 ; sys_exit
  xor rdi, rdi ; exit status 0
  syscall
