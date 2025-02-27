; Exercise 01 - Basic Input/Output

section .bss
  note_title resb 50
  note_text resb 100

section .data
  prompt_title db "Title: ", 0
  prompt_title_len equ $ - prompt_title
  prompt_text db "Note: ", 0
  prompt_text_len equ $ - prompt_text
  prompt_output db "_____:  ", 0
  prompt_output_len equ $ - prompt_output
  newLine db 10, 0

section .text
  global _start

_start:
  ; call functions
  call input_note
  call output_note

  ; exit program
  call exit

; output function
output_note:
  call newline
  ; Print out title
  call print_prompt_output
  call print_title_input
  ; Print out text
  call print_prompt_output
  call print_text_input
  ret

; input function
input_note:
  ; Print title prompt and read input
  call print_prompt_title
  call note_title_input
  ; Print text prompt and read input
  call print_prompt_text
  call note_text_input
  ret

; title
; print prompt_title
print_prompt_title:
  mov rsi, prompt_title
  mov rdx, prompt_title_len
  call print
  ret

; read title input
note_title_input:
  mov rsi, note_title
  mov rdx, 50
  call read
  ret

; print title input
print_title_input:
  mov rsi, note_title
  mov rdx, 50
  call print
  ret

; text
; print prompt_text
print_prompt_text:
  mov rsi, prompt_text
  mov rdx, prompt_text_len
  call print
  ret

; read text input
note_text_input:
  mov rsi, note_text
  mov rdx, 100
  call read
  ret

; print text input
print_text_input:
  mov rsi, note_text
  mov rdx, 100
  call print
  ret

; prompt_output
; print output
print_prompt_output:
  mov rsi, prompt_output
  mov rdx, prompt_output_len
  call print
  ret

; utility
; print function
print: 
  mov rax, 1
  mov rdi, 1
  syscall
  ret

; read function
read:
  mov rax, 0
  mov rdi, 0
  syscall
  ret

; newline function
newline:
  mov rsi, newLine
  mov rdx, 1
  call print
  ret

; exit function
exit:
  mov rax, 60
  xor rdi, rdi
  syscall
  ret















