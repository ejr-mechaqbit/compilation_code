section .data
  newline db 0xA

section .bss
  counter resb 1      ; Reserve 1 byte for a counter

section .text
  global _start

_start:
  mov byte [counter], 5   ; Store 5 in counter

loop_start:
  mov rax, 1        ; syscall: write
  mov rdi, 1        ; stdout
  mov rsi, "New"  ; Address of counter
  mov rdx, 1        ; Print 1 byte
  syscall

  mov rax, 1        ; Print newline
  mov rdi, 1
  mov rsi, newline
  mov rdx, 1
  syscall

  dec byte [counter]    ; Decrement counter
  cmp byte [counter], 0
  jne loop_start        ; If not 0, repeat loop

  mov rax, 60           ; syscall: exit
  xor rdi, rdi
  syscall
