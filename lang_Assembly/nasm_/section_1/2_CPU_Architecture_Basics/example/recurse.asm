section .text
  global _start

_start:
  call recurse

  mov rax, 60
  xor rdi, rdi
  syscall

recurse:
  sub rsp, 8
  call recurse
  add rsp, 8
  ret
