;Initialize data
section .data
  prompt_output db "_______: ", 0
  prompt_output_len equ $ - prompt_output

;Holds executable data
section .text
  global print_prompt_output  
  extern print

;function for printing prompt_output
print_prompt_output:
  mov rsi, prompt_output
  mov rdx, prompt_output_len
  call print
  ret
