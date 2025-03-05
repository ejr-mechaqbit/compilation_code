section .text
  global _start
  extern input_note
  extern output_note
  extern exit

_start:
  ; call extern functions
  call input_note
  call output_note

  ; exit program
  call exit
