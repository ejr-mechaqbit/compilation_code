## Basic Assembly Syntax
 - Writing and Compiling Assembly Code
 - Directives (.text, .data, .bss)
 - Labels, Instructions, and Comments
 - Basic Data Types (Bytes, Words, Double Words, Quad Words)

### 1. Writing and Compiling Assembly Code (x86-64, Linux)
 To write and compile **x86-64 assembly** code, follow thes steps:
  1. **Write the Assembly Code** (.asm file)
  2. **Assemble it into an object file** (.o)
  3. **Link it to create an executable**
  4. **Run the executable**

 #### - Writing a Simple Asembly Program
  Let's write a "Hello, World!", program in **x86-64 Assembly(Linux, NASM
  syntax)**.

 **hello.asm**
 ```assembly
 section .data 
   msg db "Hello, World!", 0  ; Message with null terminator
   len equ $ - msg            ; Calculate message length

 section .text
   global _start

 _start:
   mov rax, 1         ; syscall: write
   mov rdi, 1         ; file descriptor: stdout
   mov rsi, msg       ; move message to rsi
   mov rdx, len       ; message length
   syscall            ; system call

   mov rax, 60        ; syscall: exit
   xor rdi, rdi       ; exit code 0
   syscall            ; system call
 ```

 #### - Compiling the Assembly Code
  Use the **NASM assembler** and the **GCC linker or ld** to compile.

 ```bash
 # Assemble (convert .asm to .o)
 nasm -f elf64 hello.asm -o hello.o

 # Linker gcc
 # Link (create executable)
 gcc hello.o -no-pie -o hello
 
 # Or Linker ld
 # Link (create executable)
 ld -o hello hello.o

 # Run the program
 ./hello
 ```
 - [x] **Output**
 ```
 Hello, World!
 ```

 #### - Writing an Assembly Program with Input (Reading from User)
  We use the read syscall to get user input.

 **input.asm**
 ```assembly
 section .bss
   buffer resb 100    ; Reserve 100 bytes for input

 section .text
   global _start

 _start:
   mov rax, 0         ; syscall: read
   mov rdi, 0         ; file descriptor: stdin
   mov rsi, buffer    ; buffer to store input
   mov rdx, 100       ; max number of bytes to read
   syscall

   mov rax, 1         ; syscall: write
   mov rdi, 1         ; file descriptor: stdout
   mov rsi, buffer    ; buffer with user input
   mov rdx, 100       ; length (same as read)
   syscall

   mov rax, 60        ; syscall: exit
   xor rdi, rdi       ; exit code 0
   syscall
 ```
 
 - [x] **Compile & Run**
 ```bash
 nasm -f elf64 input.asm -o input.o
 gcc input.o -no-pie -o input
 ./input
 ```
 **or**
 ```bash
 nasm -f elf64 input.asm -o input.o
 ld -o input input.o
 ./input
 ```

 - [x] **Output**
 ```
 Hello Assembly! # User Input
 Hello Assembly! # Output (echoed back)
 ```

 #### Summary

 |Step                |Command                            |
 |--------------------|-----------------------------------|
 |Write Assembly Code |hello.asm                          |
 |Assemble            |nasm -f elf64 hello.asm -o hello.o |
 |Link                |gcc hello.o -no-pie -o hello       |
 |                    |ld -o hello hello.o                |
 |Run                 |./hello                            |

### Assembly Directives: `.text`, `.data`, `.bss`
 In x86-64 assembly (NASM syntax), **directives** like `.text`, `.data`, and
 `.bss` define different memory sections in a program.

 #### 1. Overview of Sections

 |Directive   |Purpose              |Read/Write  |Example Usage                              |
 |------------|---------------------|------------|-------------------------------------------|
 |`.text`     |Code (instructions)  |Read-only   |Contains executable instructions           |
 |`.data`     |Initialized data     |Read/Write  |Constants and initialized variables        |
 |`.bss`      |Uninitialized data   |Read/Write  |Space for variables without initial values |

 #### 2. Explanation of Each Section
  - **`.text` (Code Section)**
   - Contains the **executable instructions** of the program
   - Marked as **read-only** in many operating systems.
   - Always contains the program's **entry point** (_start).

   ```assembly
   section .text
     global _start
   
   _start:
     mov rax, 60    ; syscall: exit
     xor rdi, rdi   ; exit code 0
     syscall
   ```

  - **`.data` (Initialized Data Section)**
   - Stores **constants and initialized variables** (global/static).
   - Read/write memory, but values are **predefined**.
   - Useful for **strings, counters, and predefined numbers**.

   ```assembly
   section .data
     msg db "Hello, World!", 0    ; String with newline
     msg_len equ $ - msg          ; Calculate length

   section .text
     global _start

   _start:
     mov rax, 1         ; syscall: write
     mov rdi, 1         ; file descriptor: stdout
     mov rsi, msg       ; pointer to msg
     mov rdx, msg_len   ; length of msg
     syscall

     mov rax, 60        ; syscall: exit
     xor rdi, rdi       
     syscall
   ```
   - **Notes:**
    - `db` (define byte) stores a string.
    - `equ` defines a constant (message length).

  - **`.bss` (Uninitialized Data Section)**
   - Reserves memory for **variables without initial values**.
   - Used for **buffers, arrays, and dynamic storage**.
   - Faster that `.data` because memory isn't initialized at program start.

   ```assembly
   section .bss
     buffer resb 100      ; Reserve 100 bytes for input

   section .text
     global _start

   _start:
     mov rax, 0           ; syscall: read
     mov rdi, 0           ; file descriptor: stdin
     mov rsi, buffer      ; buffer to store input
     mov rdx, 100         ; max number of bytes to read
     syscall

     mov rax, 60          ; syscall: exit
     xor rdi, rdi
     syscall
   ```
   - **Notes:**
    - `resb 100` reserves **100 bytes** for input.
    - No initial value is assigned.

