;Exercise 01 - Basic Input/Output program

;Uninitialize data
section .bss
  note_title resb 50
  note_text resb 100

;Initialize data
section .data
  prompt_title db "Title: ", 0
  prompt_title_len equ $ - prompt_title

  prompt_text db "Note: ", 0
  prompt_text_len equ $ - prompt_text

  newLine db 10, 0

  prompt_output db "*****==>  ", 0
  prompt_output_len equ $ - prompt_output

;Holds executable data
section .text
  global _start

_start:
  ;call input_note function
  call input_note
  ;call newline_func
  call newline_func
  ;call output_note
  call output_note

  ;Exit
  mov rax, 60
  xor rdi, rdi
  syscall

output_note:
  call print_prompt_output
  call print_title_input
  call print_prompt_output
  call print_text_input
  ret

;function for input anote
input_note:
  call print_prompt_title ;print prompt for title
  call note_title_input ;read title input
  call print_prompt_text ; print prompt for text
  call note_text_input ;read text input
  ret

;function for printing prompt_title
print_prompt_title:
  mov rsi, prompt_title
  mov rdx, prompt_title_len
  call print_func
  ret

;function for reading input for title
note_title_input:
  mov rsi, note_title 
  mov rdx, 50
  call read_func
  ret

;function for printing title input
print_title_input:
  mov rsi, note_title
  mov rdx, 50
  call print_func
  ret

;function for printing prompt_text
print_prompt_text:
  mov rsi, prompt_text
  mov rdx, prompt_text_len
  call print_func
  ret

;function for reading input for text
note_text_input:
  mov rsi, note_text
  mov rdx, 100
  call read_func
  ret

;function for printing text input
print_text_input:
  mov rsi, note_text
  mov rdx, 100
  call print_func
  ret

;function for printing prompt_output
print_prompt_output:
 mov rsi, prompt_output
 mov rdx, prompt_output_len
 call print_func
 ret

;function for printing
print_func:
  mov rax, 1
  mov rdi, 1
  syscall
  ret

;function for reading input
read_func:
  mov rax, 0
  mov rdi, 0
  syscall
  ret

;function for newline
newline_func:
  mov rax, 1
  mov rdi, 1
  mov rsi, newLine
  mov rdx, 1
  syscall
  ret
