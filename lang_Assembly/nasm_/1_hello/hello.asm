;Hello World! Assembly program
section .data ;Declare a constant
  msg1 db "Hello, World!", 0
  msg1_len equ $ - msg1
  newLine db 10, 0
  msg2 db "Assembly programming language.", 0
  msg2_len equ $ - msg2

section .text
  global _start

_start: ;Entry point
  mov rax, 1 ;syscall : write
  mov rdi, 1 ;file descriptor : stdout
  mov rsi, msg1
  mov rdx, msg1_len
  syscall

  mov rax, 1
  mov rdi, 1
  mov rsi, newLine
  mov rdx, 1
  syscall

  mov rax, 1
  mov rdi, 1
  mov rsi, msg2
  mov rdx, msg2_len
  syscall

  mov rax, 60 ;syscall : exit
  mov rdi, rdi ;exit status 0
  syscall

