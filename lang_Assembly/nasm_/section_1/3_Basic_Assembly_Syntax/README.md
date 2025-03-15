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

 #### Writing a Simple Asembly Program
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

 #### Compiling the Assembly Code
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

 #### Writing an Assembly Program with Input (Reading from User)
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
  **`.text` (Code Section)**
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

  **`.data` (Initialized Data Section)**
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

  **`.bss` (Uninitialized Data Section)**
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

### Labels, Instructions, and Comments in Assembly (x86-64 NASM Syntax)
 In **x86-64 Assembly**, programs are structured using **labels,
 instructions, and comments** for readability and execution control.

 #### 1. Labels (`_start`, loops, function names)
  **Labels** act as named locations in code and are used for:
  - Marking the **entry point** (`_start`)
  - **Looping and branching** (`jmp`, `je`, `jne`, `call`)
  - Defining **functions** in assembly

  - [x] Example: **Using Labels for Flow Control**
  ```assembly
  section .text
    global _start

  _start:
    mov rax, 5      ; Store 5 in rax
    mov rbx, 0      ; Counter (initialize to 0)

  loop_start:
    add rbx, 1      ; Increment counter
    cmp rbx, rax    ; Compare counter with 5
    jne loop_start  ; Jump back if not equal

    mov rax, 60     ; syscall: exit
    xor rdi, rdi    
    syscall
  ```
  - **Explanation:**
  - `_start:` **(Program entry point)**
  - `loop_start:` **(Loop label)**
  - `jne loop_start` **Jumps back** to `loop_start` if `rbx != rax`

#### 2. Instructions (Operations like `mov`, `add`, `cmp`, `jmp`)
 **Instructions** tell the CPU what to do.

  **Common Instruction Categories**
  |Type           |Example Instructions                     |Description
  |---------------|-----------------------------------------|--------------------------
  |Data Movement  |`mov`, `lea`, `push`, `pop`              |Load, store, and move data     |
  |Arithmetic     |`add`, `sub`, `mul`, `div`, `inc`, `dec` |Perform math operations        |
  |Logical        |`and`, `or`, `xor`, `not`, `test`        |Perform bitwise operations     |
  |Control Flow   |`jmp`, `je`, `jne`, `call`, `ret`        |Change execution flow          |
  |Comparison     |`cmp`, `test`                            |Compare values for conditions  |
  |Syscalls       |`syscall`                                |Invoke OS system calls         |

  - [x] Example: **Using Instructions**
  ```assembly
  section .text
    global _start

  _start:
    mov rax, 10       ; Store 10 in rax
    mov rbx, 5        ; Store 5 in rbx
    add rax, rbx      ; rax = rax + rbx equivalent (10 + 5)

    cmp rax, 20       ; Compare rax with 20
    je equal          ; Jump to "equal" if rax == 20

    mov rax, 60       ; syscall: exit
    xor rdi, rdi      
    syscall

  equal:
    mov rax, 60       ; syscall: exit
    mov rdi, 1        ; Exit code 1
    syscall
  ```
  - **Explanation:**
  - `add rax, rbx` **(Adds: `rax` + `rbx`)**
  - `cmp rax, 20` **(Compares `rax` with 20)**
  - `je equal` **(Jumps to equal if `rax == 20`)**

#### 3. Comments ( ';' for single-line, '%if' for macros)
 - **Single-line comments** use `;`
 - **Multi-line comments** use `%%if 0 ... %%endif` (for macros)

 - [x] Example: **Using Comments**
 ```assembly
 section .data
   message db "Hello, Assembly!", 0
   msg_len equ $ - message

 section .text
   global _start

 _start:
   mov rax, 1         ; syscall: write
   mov rdi, 1         ; file descriptor: stdout
   mov rsi, message   ; pointer to message
   mov rdx, msg_len   ; message length
   syscall            ; system call

   mov rax, 60        ; syscall: exit
   xor rdi, rdi       ; exit code 0
   syscall            ; system call
 ```
 - **Key Points:**
 - `;` is used for **single-line comments**
 - `message db "Hello, Assembly!", 0` **stores a string with a newline**

#### 4. Summary

 |Concept        |Description                    |Example                 |
 |---------------|-------------------------------|------------------------|
 |Labels         |Named locations for code flow  |`_start:`,`loop_start:` |
 |Instructions   |CPU operations                 |`mov`,`add`,`cmp`,`jmp` |
 |Comments       |Notes for readability          |`; This is a comment`   |

### Basic Data Types in x86-64 Assembly (NASM Syntax)
 In x86-64 assembly, **data types** are based on size rather than high-level
 concepts like integers or floating points. The most common types are
 **bytes words, double words, and quad words**.

 #### 1. Common Data Types in x86-64
 |Data type|Size(Bits) |Size(Bytes) |NASM Keyword | Example |
 |----------|----------|----------|----------|----------|
 |Byte |8 bits |1 byte |`db` (define byte) |`dd 0x41` |
 |Word |16 bits |2 bytes |`dw` (define word) |`dw 0x1234` |
 |Double Word |32 bits |4 bytes |`dd` (define double word) | `dd 0x12345678` |
 |Quad Word |64 bits |8 bytes |`dq` (define quad word) | `dq 0x123456789ABCDEF0` |

