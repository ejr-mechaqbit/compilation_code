; function
; uninitialize data
section .bss
  input resb 100

; initialize data
section .data
  msg1 db "User input: ", 0
  msg1_len equ $ - msg1
  msg2 db "Result: ", 0
  msg2_len equ $ - msg2
  newLine db 10, 0

; holds executable codes
section .text
  global _start

; entry point function
_start:
  ; use or call functions
  ; print msg1
  mov rsi, msg1
  mov rdx, msg1_len
  call print

  ; read input
  mov rsi, input
  mov rdx, 100
  call read

  ; print newline
  mov rsi, newLine
  mov rdx, 1
  call print

  ; print msg2
  mov rsi, msg2
  mov rdx, msg2_len
  call print

  ; print user input
  mov rsi, input
  mov rdx, 100
  call print

  ; exit program
  call exit

; print function called 'print'
print:
  mov rax, 1 ; syscall: write
  mov rdi, 1 ; file descriptor: stdout
  syscall
  ret ; return to caller

; read function called 'read'
read:
  mov rax, 0 ; syscall: read
  mov rdi, 0 ; file descriptor: stdin
  syscall
  ret ; return to caller

; exit function called 'exit'
exit:
   mov rax, 60 ; syscall: exit
   xor rdi, rdi ; exit status 0
   syscall
   ret ; return to caller
