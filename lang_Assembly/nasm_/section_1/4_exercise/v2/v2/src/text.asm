; text.asm
section .bss
  note_text resb 100

section .data
  prompt_text db "Note: ", 0
  prompt_text_len equ $ - prompt_text

section .text
  global print_prompt_text
  global note_text_input
  global print_text_input
  extern print
  extern read

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
