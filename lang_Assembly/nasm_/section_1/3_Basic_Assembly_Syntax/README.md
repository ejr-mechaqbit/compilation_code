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

 #### 2. NASM Data Type Definitions

  NASM provides the following **directives** for declaring data:
 |Directive|Meaning|Size|
 |----------|----------|----------|
 |`db` |Define byte(8-bit) |1 byte|
 |`dw` |Define word(16-bit) |2 bytes |
 |`dd` |Define double word(32-bit) |4 bytes|
 |`dq` |Define quad word(64-bit) |8 bytes |
 |`dt` |Define ten bytes(80-bit) |10 bytes (for FPU) |

 - [x] Example: **Declaring Different Data Types**
 ```assembly
 section .data
   myByte     dd  0x41                  ; 1 byte (ASCII 'A')
   myWord     dw  0x1234                ; 2 bytes (16-bit value)
   myDWord    dd  0x12345678            ; 4 bytes (32-bit value)
   myQWord    dq  0x123456789ABCDEF0    ; 8 bytes (64-bit value)
 ```

 #### 3. Memory Layout of Different Data Types
  Assuming `myDWord dd 0x12345678` is stored in **little-endian format**:
 
 ```
 Memory Address  Value (Hex)
 ---------------------------
 0x1000          78
 0x1001          56
 0x1002          34
 0x1003          12
 ```
 - **Little-endian** mains **LSB (least significant byte) is stored first**.
 
 #### 4. Accessing Different Data Sizes in Registers
  In x86-64, registers have different sizes that match data types.

 |Register |Size |Example Data Type |
 |----------|----------|----------|
 |`al`,`bl`,`cl`,`dl` |8-bit |Byte (`db`) |
 |`ax`,`bx`,`cx`,`dx` |16-bit | Word (`dw`) |
 |`eax`,`ebx`,`ecx` |32-bit |Double word (dd) |
 |`rax`,`rbx`,`rcx` |64-bit |Quad word (`dq`) |

 - [x] Example: **Moving Different Data Types into Registers**
 ```assembly
 section .data
   myByte   db  0x41                ; 1 byte
   myWord   dw  0x1234              ; 2 bytes
   myDWord  dd  0x12345678          ; 4 bytes
   myQWord  dq  0x12345678ABCDEF0   ; 8 bytes
 
 section .text
   global _start

 _start:
   mov al, [myByte]       ; Load 8-bit value into al
   mov ax, [myWord]       ; Load 16-bit value into ax
   mov eax, [myDWord]     ; Load 32-bit value into eax
   mov rax, [myQWord]     ; Load 64-bit value into rax

   mov rax, 60
   xor rdi, rdi
   syscall
 ```
 - **Notes:**
 - `mov al, [myByte]` (Loads **1 byte** into al)
 - `mov eax, [myDWord]` (Loads **4 bytes** into eax (zero-extends to 64-bit
   in rax).
 - `mov rax, [myQWord]` (Loads **8 bytes** into rax)

 #### 5. Using Different Data Types in Arithmetic Operations
  
  - [x] Example: **Adding Different-Sized Numbers**
  ```assembly
  section .data
    num1  db  10          ; 1 byte (8-bit)
    num2  dw  1000        ; 2 bytes (16-bit)
    num3  dd  50000       ; 4 bytes (32-bit)
    num4  dq  1000000     ; 8 bytes (64-bit)

  section .text
    global _start

  _start:
    mov al, [num1]        ; Load 8-bit number
    add al, 5             ; al = 10 + 5

    mov ax, [num2]        ; Load 16-bit number
    add ax, 500           ; ax = 1000 + 500

    mov eax, [num3]       ; Load 32-bit number
    add eax, 25000        ; eax = 50000 + 25000

    mov rax, [num4]       ; Load 64-bit number
    add rax, 500000       ; rax = 100000 + 500000

    mov rax, 60           ; syscall: exit
    xor rdi, rdi
    syscall
  ```

  - [x] **Output in Registers**:
  |Register |Value After Operation |
  |----------|----------|
  |`al =`  |15(10 + 5) |
  |`ax =`  |1500(1000 + 500) |
  |`eax =` |75000(50000 + 25000) |
  |`rax =` |1500000(1000000 + 500000) |

 #### 6. Summary Table
 |Data Type |Size |NASM Keyword |Example Declaration |Register Example |
 |-----|-----|-----|-----|-----|
 |Byte |1 byte (8-bit) |`db` |`myByte db 0x41` |`mov al, [myByte]` |
 |Word |2 bytes (16-bit) |`dw` |`myWord dw 0x1234` |`mov ax, [myWord]` |
 |Double Word |4 bytes (32-bit) |`dd` |`myDWord dd 0x12345678` |`mov eax, [myDWord]` |
 |Quad Word |8 bytes (64-bit) |`dq` |`myQWord dq 0x123456789ABCDEF0` | `mov rax, [myQWord]` |

 #### 7. Key Takeaways
  - **Bytes (8-bit)** are for **characters**(`db`).
  - **Words (16-bit)** are for **short integers**(`dw`).
  - **Double Words (32-bit)** are for **standard integers**(`dd`).
  - **Quad Words (64-bit)** are for **large integers & addresses**(`dq`).
  - Data is stored in **little-endian** format in x86-64.

 ### Summary
  #### Basic Assembly Syntax

  - Writing and Compiling Assembly Code
  - Directives (.text, .data, .bss)
  - Labels, Instructions, and Comments
  - Basic Data Types (Bytes, Words, Double Words, Quad Words)

