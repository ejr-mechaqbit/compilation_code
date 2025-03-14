;Simple function

;Uninitialize data
section .bss
  input resb 100

;Initialize data
section .data
  msg1 db "User Input: ", 0
  msg1_len equ $ - msg1
  msg2 db "Result: ", 0
  msg2_len equ $ - msg2

;Holds executable codes
section .text
  global _start

;Entry point or _start function
_start:
  mov rsi, msg1
  mov rdx, msg1_len
  call print ;calling print function

  mov rsi, input
  call read_input ;calling read_input function 

  mov rsi, msg2
  mov rdx, msg2_len
  call print ;calling print function
  
  mov rsi, input
  mov rdx, 100
  call print ;calling print function

  ;Exit
  mov rax, 60
  mov rdi, rdi
  syscall

;function called 'print'
print: ;Print function
  mov rax, 1
  mov rdi, 1
  syscall
  ret ;return to caller

;function called 'read_input'
read_input: ;read_input function
  mov rax, 0
  mov rdi, 0
  mov rdx, 100
  syscall
  ret ;return to caller
