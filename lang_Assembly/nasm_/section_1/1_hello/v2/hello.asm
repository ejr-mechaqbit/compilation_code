; Hello World! -

; Initialize data
section .data
  msg1 db "Hello, World!", 0 ; db - define bytes & 0 - null terminator
  msg1_len equ $ - msg1 ; equ - equate

  newline db 10, 0 ; 10 - new line

  msg2 db "Assembly programming language", 0
  msg2_len equ $ - msg2

; Holds executable codes
section .text
  global _start

; Entry point function
_start:
  ; Print msg1
  mov rax, 1 ; syscall: write
  mov rdi, 1 ; file descriptor: stdout
  mov rsi, msg1
  mov rdx, msg1_len
  syscall

  ; Newline
  mov rax, 1
  mov rdi, 1
  mov rsi, newline
  mov rdx, 1
  syscall

  ; Print msg2
  mov rax, 1
  mov rdi, 1
  mov rsi, msg2
  mov rdx, msg2_len
  syscall

  ; Exit 
  mov rax, 60 ; syscall: exit
  xor rdi, rdi ; exit status 0
  syscall
