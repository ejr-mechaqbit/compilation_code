;Simple function
section .data
  msg db "This is a function", 0
  msg_len equ $ - msg
  newLine db 10, 0

section .text
  global _start

func: ;function name
  mov rax, 1
  mov rdi, 1
  mov rsi, msg
  mov rdx, msg_len
  syscall
  ret ;return to caller

newLine_func: ;function name
  mov rax, 1
  mov rdi, 1
  mov rsi, newLine
  mov rdi, 1
  syscall
  ret ;return to caller

_start:
  call func
  call newLine_func
  call newLine_func
  call func

  mov rax, 60
  xor rdi, rdi
  syscall
