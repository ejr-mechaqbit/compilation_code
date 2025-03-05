;Uninitialize data
section .bss
  note_text resb 100

;Initialize data
section .data
  prompt_text db "Note: ", 0
  prompt_text_len equ $ - prompt_text

;Holds executable data
section .text
  global print_prompt_text
  global note_text_input
  global print_text_input
  extern print
  extern read

;function for printing prompt_text
print_prompt_text:
  mov rsi, prompt_text
  mov rdx, prompt_text_len
  call print
  ret

;function for reading input for text
note_text_input:
  mov rsi, note_text
  mov rdx, 100
  call read
  ret

;function for printing text input
print_text_input:
  mov rsi, note_text
  mov rdx, 100
  call print
  ret
