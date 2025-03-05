; function

; initialize data
section .data
  msg db "This is a function", 0
  msg_len equ $ - msg
  newline db 10, 0

; holds executable codes
section .text
  global _start

; function called 'display'
display: ; function name
  mov rax, 1
  mov rdi, 1
  mov rsi, msg
  mov rdx, msg_len
  syscall
  ret ; return to caller

; function called 'newline_func'
newline_func:
  mov rax, 1
  mov rdi, 1
  mov rsi, newline
  mov rdx, 1
  syscall
  ret

; function called 'exit'
exit:
  mov rax, 60
  xor rdi, rdi
  syscall
  ret

; entry point function
_start:
  ; call all the functions
  call display
  call newline_func
  call newline_func
  call display

  ; call to exit the program
  call exit


