; title.asm
section .bss
  note_title resb 50

section .data
  prompt_title db "Title: ", 0
  prompt_title_len equ $ - prompt_title

section .text
  global print_prompt_title ; expose this function
  global note_title_input ; outside using 
  global print_title_input ; [global]
  extern print ; import or use external function
  extern read ; using [extern]

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

