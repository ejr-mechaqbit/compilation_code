## Section 1
In this section it will have:
 1. Hello, World! program
 2. Input
 3. Function
 4. Exercise

### Hello, World! program
A first sample program that will display 'Hello, World!' string.

In the code we initialize the data that contains 'Hello, World!' string
and calculate it's length.
`
section .data
  msg1 db "Hello, World!", 0
  msg1_len equ $ - msg1
`

Implement a functionality to display the initialize data it must be done
inside the entry point function.
`
  mov rax, 1
  mov rdi, 1
  mov rsi, msg1
  mov rdx, msg1_len
  syscall
`
This line of code will print or display the "Hello, World!" to the console.


### Input

