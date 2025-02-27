;Holds executable data
section .text
  global print
  global read
  global newline
  global exit

;function for printing
print:
  mov rax, 1
  mov rdi, 1
  syscall
  ret

;function for reading input
read:
  mov rax, 0
  mov rdi, 0
  syscall
  ret

;function for newline
newline:
  mov rax, 1
  mov rdi, 1
  mov rsi, newline
  mov rdx, 1
  syscall
  ret

;exit function
exit:
  mov rax, 60
  mov rdi, rdi
  syscall
