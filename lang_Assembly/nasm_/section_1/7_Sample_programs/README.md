## Sample Program
In this sample program it will have:
 1. Hello, World! program
 2. Input
 3. Function
 4. Exercise

### 1. Hello, World! program
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
  mov rax, 1        ; system call: sys_write
  mov rdi, 1        ; file descriptor: stdout
  mov rsi, msg1     ; move msg1 to rsi(source index)
  mov rdx, msg1_len ; move msg1_len to rdx(data/extended space accumulator)
  syscall           ; execute system call
```
This line of code will print or display the "Hello, World!" to the console.


### 2. Input
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
  mov rax, 0          ; system call: sys_read
  mov rdi, 0          ; file descriptor: stdin
  mov rsi, input      ; move input to rsi
  mov rdx, 100        ; move 100 to rdx
  syscall             ; execute system call

  ; Print user input
  mov rax, 1          ; system call: sys_write
  mov rdi, 1          ; file descriptor: stdout
  mov rsi, input      ; move input to rsi
  mov rdx, 100        ; move 100 to rdx
  syscall             ; execute system call
```
This line of codes will read and print the user input.

### 3. Function
For this sample program it will utilize function and create function.

To create a local function pick a name of a function follow by colon
`function_name:` and end it with `ret` to return to caller.
Example:
```
; Print user input function
; Function name: print_user_input
print_user_input:
  mov rax, 1
  mov rdi, 1
  mov rsi, input
  mov rdx, input_len
  syscall
  ret ; return to caller
```
To use the local function just `call print_user_input`.
Example utilizing local function inside the entry point function or
`_start:` function.
```
; Entry point function
_start:
  ; use or call local function
  call print_user_input

  ; Exit function
  call exit
```

To create a global function that can be import or export.
First label the function as global inside `section .text`.
Example a utility.asm file have 2 function print and exit.
```
; This is a utility.asm file
; In section .text globalize functions
section .text
  global print    ; exporting print function
  global exit     ; exporting exit function

print: ; function name
  mov rax, 1
  mov rdi, 1
  syscall
  ret ; return to caller

exit: ; function name
  mov rax, 60     ; system call: sys_exit
  xor rdi, rdi    ; exit status 0
  syscall         ; execute system call
  ret             ; return to caller
```

Use this function inside to your main file where your entry point function
located. To able to import external function use `extern` followed by the
function name.

```
section .data
  display_text db "Hello, user!", 0
  display_text_len equ $ - display_text

section .text
  global _start
  extern print
  extern exit

_start:
  ; print display_text
  mov rsi, display_text
  mov rdx, display_text_len
  call print

  call exit
```
Now we successfully import and export function.

### 4. Exercise
For the exercise is the combination of printing string, reading input and
print it back to the console, import and export function.
of function

### Recap

- Printing text
- Reading input
- Import or export function
- Uninitialize data
```
  section .bss
    ; Uninitialize data or variables
```
- Initialize data
```
  section .data
    ; Initialize data or varaibles
```
- Global and External functions
```
  section .text
    ; Global and External functions
```
- And a few mnemonics in assembly
  - `mov`
  - `xor`
  - `call`
  - `syscall`
  - `ret`


