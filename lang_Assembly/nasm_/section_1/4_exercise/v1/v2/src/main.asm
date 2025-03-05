;Exercise 01 - Basic Input/Output program

;Holds executable data
section .text
  global _start
  extern input_note
  extern output_note
  extern newline
  extern exit

_start:
  ;call input_note function
  call input_note
  ;call newline_func
  call newline
  ;call output_note
  call output_note

  ;Exit
  call exit
