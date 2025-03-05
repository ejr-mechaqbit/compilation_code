section .text
  global output_note
  global input_note
  extern newline
  extern print_prompt_output
  extern print_title_input
  extern print_text_input
  extern print_prompt_title
  extern print_prompt_text
  extern note_title_input
  extern note_text_input

; input display function
input_note:
  ; print title prompt and read input
  call print_prompt_title
  call note_title_input
  ; print text prompt and read input
  call print_prompt_text
  call note_text_input
  ret

; output display function
output_note:
  call newline
  ; print out title
  call print_prompt_output
  call print_title_input
  ; print out text
  call print_prompt_output
  call print_text_input
  ret


