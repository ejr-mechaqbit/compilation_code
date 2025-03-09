; Conversion int to str

section .data
  ; Buffer to store digits
  ; max 10 digits + newline
  buffer db '0000000000', 10
  ; Max length 10 digits
  len equ 10 

section .bss
  strng resb 12 ; string buffer includding null terminator

section .text
  global _start

_start:
  mov rax, -12345 ; integer to convert

  ; check if number is negative
  cmp rax, 0
  jge convert ; if positive, skip sign handling

  ; if negative, make it positive and store '-' sign
  neg rax
  mov byte [strng], '-' ; store '-' at the start
  mov rdi, strng + 1 ; start storing digits after '-'
  jmp convert_loop

convert:
  mov rdi, strng ; start storing digits at the beginning

convert_loop:
  mov rdx, 0 ; clear remainder
  mov rcx, 10
  div rcx ; rax / 10, quotient in rax, remainder in rdx
  add dl, '0' ; convert remainder to ASCII
  push rdx ; store the character on the stack
  test rax, rax ; check if rax == 0
  jnz convert_loop ; if not, continue

store_digits:
  pop rax ; get the last stored digit
  mov [rdi], al ; store in buffer
  inc rdi ; move forward
  cmp rsp, rbp ; check if all digits are popped
  jne store_digits

  mov byte [rdi], 10 ; newline for output
  inc rdi

print_string:
  mov rdx, rdi ; end of string
  sub rdx, strng ; compute length
  add rsi, strng ; address of string
  mov rax, 1 ; sys_write
  mov rdi, 1 ; stdout
  syscall

exit:
  mov rax, 60 ; sys_exit
  xor rdi, rdi ; exit status 0
  syscall
