; output.asm
section .data
  newLine db 10, 0
  prompt_output db "_____:  ", 0
  prompt_output_len equ $ - prompt_output

section .text
  global print_prompt_output
  global newline
  extern print

; print prompt_output
print_prompt_output:
  mov rsi, prompt_output
  mov rdx, prompt_output_len
  call print
  ret

; newline
newline:
  mov rsi, newLine
  mov rdx, 1
  call print
  ret

