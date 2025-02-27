;Holds executable data
section .text
  global output_note
  global input_note
  extern print_prompt_output
  extern print_title_input
  extern print_text_input
  extern print_prompt_title
  extern print_prompt_text
  extern note_title_input
  extern note_text_input

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
