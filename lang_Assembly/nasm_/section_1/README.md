## Section 1
In this section it will have:
 1. Hello, World! program
 2. Input
 3. Function
 4. Exercise

### Hello, World! program
A first sample program that will display 'Hello, World!' string.

In the code, initialize the data that contains 'Hello, World!' string
or equivalent having a variable with a data on it and calculate it's length.

To initialize data it must put inside the `section .data`.
```
section .data
  msg1 db "Hello, World!", 0
  msg1_len equ $ - msg1
```

Implement a functionality to display the initialize data it must be done
inside the entry point function.
```
  ; Print msg1
  mov rax, 1
  mov rdi, 1
  mov rsi, msg1
  mov rdx, msg1_len
  syscall
```
This line of code will print or display the "Hello, World!" to the console.


### Input
This sample program will have the user input.

For input it must have uninitialize data or equivalent to empty variable.

To uninitialize data it must put inside the `section .bss`
```
section .bss
  input resb 100
```

Implement a functionality to read the input and display it back to the
console. It can be done inside a function or directly to entry point
function.
```
  ; Read input
  mov rax, 0
  mov rdi, 0
  mov rsi, input
  mov rdx, 100
  syscall

  ; Print user input
  mov rax, 1
  mov rdi, 1
  mov rsi, input
  mov rdx, 100
  syscall
```
This line of codes will read and print the user input.

