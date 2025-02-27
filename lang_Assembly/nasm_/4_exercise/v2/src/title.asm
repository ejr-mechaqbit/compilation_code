;Uninitialize data
section .bss
  note_title resb 50

;Initialize data
section .data
  prompt_title db "Title: ", 0
  prompt_title_len equ $ - prompt_title

;Holds executable data
section .text
  global print_prompt_title
  global note_title_input
  global print_title_input
  extern print
  extern read
  

;function for printing prompt_title
print_prompt_title:
  mov rsi, prompt_title
  mov rdx, prompt_title_len
  call print
  ret

;function for reading input for title
note_title_input:
  mov rsi, note_title 
  mov rdx, 50
  call read
  ret

;function for printing title input
print_title_input:
  mov rsi, note_title
  mov rdx, 50
  call print
  ret
