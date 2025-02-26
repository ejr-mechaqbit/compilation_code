;User Input
section .bss
  input resb 100

section .data
  prompt db "User Input: ", 0
  prompt_len equ $ - prompt

section .text
  global _start

_start:
  ;Print prompt
  mov rax, 1 ;syscall : write
  mov rdi, 1 ;file decriptor : stdout
  mov rsi, prompt
  mov rdx, prompt_len
  syscall
  ;Read input
  mov rax, 0 ;syscall : read
  mov rdi, 0 ;file decriptor : stdin
  mov rsi, input
  mov rdx, 100
  syscall
  ;Print user input
  mov rax, 1
  mov rdi, 1
  mov rsi, input
  mov rdx, 100
  syscall
  ;Exit
  mov rax, 60 ;syscall : exit
  mov rdi, rdi ;exit status 0
  syscall
