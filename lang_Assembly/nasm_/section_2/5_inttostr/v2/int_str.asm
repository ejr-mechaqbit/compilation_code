; Conversion int to str

section .data
  ; Buffer to store digits
  ; max 10 digits + newline
  buffer db '0000000000', 10
  ; Max length 10 digits
  len equ 10 

section .bss
  strng resb 11 ; string buffer includding null terminator

section .text
  global _start

_start:
  mov rax, 12345 ; integer to convert
  mov rdi, strng + len ; point to the end of buffer
  mov byte [rdi], 0 ; null terminator

convert_loop:
  dec rdi
  mov rdx, 0 ; clear remainder
  mov rcx, 10
  div rcx ; rax / 10, quotient in rax, remainder in rdx
  add dl, '0' ; convert remainder to ASCII
  mov [rdi], dl ; store ASCII digit
  test rax, rax ; check if rax == 0
  jnz convert_loop ; if not, continue

print_string:
  mov rsi, rdi ; address of converted string
  mov rdx, strng ; load base address of str into rdx
  add rdx, len ; add len to rdx
  sub rdx, rdi ; subtract rdi from rdx
  mov rax, 1 ; sys_write
  mov rdi, 1 ; stdout
  syscall

exit:
  mov rax, 60 ; sys_exit
  xor rdi, rdi ; exit status 0
  syscall
