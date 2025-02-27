; User Input

; Uninitialize data
section .bss
  input resb 100

; Initialize data
section .data
  prompt db "User Input: ", 0
  prompt_len equ $ - prompt

; Holds executable codes
section .text
  global _start

; Entry point function
_start:
  ; Print prompt
  mov rax, 1 ;syscall: write
  mov rdi, 1 ;file descriptor: stdout
  mov rsi, prompt ;pointing to prompt
  mov rdx, prompt_len
  syscall

  ; Read input
  mov rax, 0 ;syscall: read
  mov rdi, 0 ;file descriptor: stdin
  mov rsi, input ;pointing to input
  mov rdx, 100
  syscall

  ; Print user input
  mov rax, 1
  mov rdi, 1
  mov rsi, input
  mov rdx, 100
  syscall

  ; Exit
  mov rax, 60 ;syscall: exit
  xor rdi, rdi ;exit status 0
  syscall
