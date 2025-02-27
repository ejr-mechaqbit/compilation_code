; Hello World! Assembly program

; initialize data
; 'msg1' & 'msg2' name of the string
; db - define bytes - Assembly directive
; 0 - null terminator
; 'msg1_len' & 'msg2_len' holds the length of string
; equ - equate
; 10 - newline
section .data ; initialization
  msg1 db "Hello, World!", 0 
  msg1_len equ $ - msg1
  newLine db 10, 0 
  msg2 db "Assembly programming language.", 0 ;
  msg2_len equ $ - msg2

section .text
  global _start

_start: ;Entry point
  ;Print string called 'msg1'
  mov rax, 1 ;syscall : write
  mov rdi, 1 ;file descriptor : stdout
  mov rsi, msg1
  mov rdx, msg1_len
  syscall
  
  ;Print newLine
  mov rax, 1
  mov rdi, 1
  mov rsi, newLine
  mov rdx, 1
  syscall

  ;Print string called 'msg2'
  mov rax, 1
  mov rdi, 1
  mov rsi, msg2
  mov rdx, msg2_len
  syscall

  ;Exit
  mov rax, 60 ;syscall : exit
  mov rdi, rdi ;exit status 0
  syscall

