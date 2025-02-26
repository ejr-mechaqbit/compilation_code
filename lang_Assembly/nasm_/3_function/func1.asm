;Simple function

;Initialize data
section .data
  msg db "This is a function", 0
  msg_len equ $ - msg
  newLine db 10, 0

;Holds executable codes
section .text
  global _start

;function called 'func'
func: ;function name
  mov rax, 1
  mov rdi, 1
  mov rsi, msg
  mov rdx, msg_len
  syscall
  ret ;return to caller

;function called 'newLine_func'
newLine_func: ;function name
  mov rax, 1
  mov rdi, 1
  mov rsi, newLine
  mov rdi, 1
  syscall
  ret ;return to caller

;Entry point
_start:
  call func
  call newLine_func
  call newLine_func
  call func

  mov rax, 60
  xor rdi, rdi
  syscall
