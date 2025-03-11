; utils.asm
section .text
  global print ; expose the function 
  global read ; outside using the
  global exit ; global

; print function
print:
  mov rax, 1 ; syscall: write
  mov rdi, 1 ; file descriptor: stdout
  syscall
  ret ; return to caller

; read function
read:
  mov rax, 0 ; syscall: read
  mov rdi, 0 ; file decriptor: stdin
  syscall
  ret ; return to caller

; exit
exit:
  mov rax, 60 ; syscall: exit
  xor rdi, rdi ; exit status 0
  syscall
  ret


