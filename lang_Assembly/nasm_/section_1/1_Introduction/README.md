# Introduction to Assembly Language
  - What is Assembly?
  - Role of Assemblers:
    - NASM
    - MASM
    - GAS
    - FASM
  - Relationship between Assembly and Machine Code
  - Assembly vs. High-Level language

## What is Assembly?
  - Assembly is a low-level programming language that is closely related to machine code, the binary instructions executed directly by a computer's CPU. It provides a human-readable representation of machine instruction using mnemonics (e.g., `mov`, `add`, `jmp`) instead of raw binary or hexadecimal numbers.

### Key features of Assembly language:
  - Hardware-Specific
    - Each CPU architecture has its own Assembly language, meaning code written for one architecture won't work on another without modification.
  - Efficient & Fast
    - Since it directly translates to machine code, Assembly is highly efficient and used for performance-critical applications.  
  - Low-Level Control
    - It allow direct manipulation of register, memory and CPU instructions, making it ideal for systems programming, embedded systems, and operating system development.
  - Minimal Abstraction
    - Unlike high-level languages, Assembly has minimal built-in abstractions, requiring the programmer to manage memory and CPU resoures manually.
  - Assembler Required
    - Assembly code must be translated into machine code using an assembler like: NASM, MASM, GAS, FASM, TASM.

  Example: (x86-64 Assembly using NASM)

  ```assembly
  section .data
    msg db "Hello, World", 0 ; Define a string with a null terminator

  section .text
    global _start

  _start:
    mov rax, 1        ; System call for write (sys_write)
    mov rdi, 1        ; File descriptor 1 (stdout)
    mov rsi, msg      ; Message address
    mov rdx, 13       ; Message length
    syscall           ; Executes System Call

    mov rax, 60       ; System call for exit (sys_exit)
    xor rdi, rdi      ; Exit code 0
    syscall           ; Executes System Calls
  ```

## Role of Assemblers
  - An assembler is a tool that converts Assembly language code into machine code (binary instructions) that the CPU can execute. It acts as a translator between human-readable Assembly mnemonics and low-level machine instructions.

### Key roles of an Assembler:
1. Translation of Assembly Code to Machine Code
  - Converts mnemonics (e.g., `mov`, `add`, `jmp`) into binary instructions that the CPU understands.

  Example:
  ```assembly
  mov ax, 5   ; Move the value 5 into register ax
  ```

  Assembler converts this into machine code:
  ```
  B8 05 00
  ```

2. Symbolic Addressing & Label Resolution
  - Replaces labels and variable names with actual memory addresses.

  Example:
  ```assembly
  jmp loop_start    ; jump to a labeled instruction
  ```
  The assembler determines the address of `loop_start` and replaces it with the correct memory location.
  
3. Macro Processing
  - Assemblers allow defining macros, which are reusable code blocks, improving code organization and reducing repetition.

  Example:
  ```assembly
  %macro print_hello 0
    mov rax, 1
    mov rdi, 1
    mov rsi, hello_msg
    mov rdx, 13
    syscall
  %endmacro
  ```

4. Optimizing Code for Performace & Size
  - Some assemblers perform basic optimizations like reducing instruction size or improving execution speed.

5. Handling Data Directives & Constants
  - Converts high-level data definitions ( `db`, `dw`, `dd`, etc.) into memory allocations.

  Example:
  ```assembly
  msg db "Hello", 0   ; Defines a string in memory
  ```

6. Generating Object Files & Linking
  - Produces object files (.o, .obj) that can be linked into executable programs.
  - Works with a linker (e.g., ld) to resolve external dependencies and create final executables.

### Types of Assemblers
1. One-Pass Assembler
  - Processes the source code once, faster but with limited capabilities.
2. Two-Pass Assembler
  - Makes two passes over the code, resolving addresses and symbols more accurately.
3. Cross Assembler
  - Runs on one system but generates machine code for another (useful for embedded systems).

### Popular Assemblers
- NASM (Netwide Assembler)
  - used for x86-64 Assembly in Linux and Windows.

- MASM (Microsoft Macro Assembler)
  - Microsoft's assembler for Windows.

- GAS (GNU Assembler)
  - Default assembler for Linux.

- FASM (Flat Assembler)
  - High-speed assembler with macro support.

- TASM (Turbo Assembler)
  - Used for DOS-era Assembly programming.

## Relationship Between Assembly and Machine Code
-  Assembly language and machine code are closely related, with Assembly serving as a human-readable representation of machine code. The main relationship between the two is that Assembly is a symbolic, mnemonic-based version of machine code, making it easier for programmers to write and understand low-level instructions.

### How They Relate
1. One-to-One Correspondence
  - Each Assembly instruction typically corresponds to one machine code instruction.

  Example (x86-64 Assembly using NASM):
  ```assembly
  mov ax, 5 ; move the value 5 into register ax
  ```
  The assembler converts this into machine code:
  ```
  B8 05 00 (in hexadecimal)

  1011 1000 0000 0101 (in binary)
  ```

  - Here, `mov ax, 5` is a mnemonic representation of the machine code `B8 05 00`.
  
2. Assembly is Human-readable, Machine Code is Binary
  - Assembly uses mnemonics (e.g., `mov`, `add`, `jmp`) that are easier to understand.

  - Machine code is in binary or hexadecimal, which is difficult for humans to read directly.
  
3. Assemblers Convert Assembly to Machine Code
  - An assembler (e.g., NASM, MASM, GAS) translates Assembly instructions into machine code.
  - The CPU executes only machine code, not Assembly directly.

4. CPU-Specific Relationship
  - Assembly and machine code are both CPU architecture-specidic.
  - An x86-64 Assembly program produces x86-64 machine code, which cannot run on an ARM CPU without modification.

5. Direct Memory and Hardware Control
  - Both Assembly and machine code provide low-level access to registers, memory, and hardware.

  Example:
  ```assembly
  mov al, [ax1000]    ; load value from memory address 0x1000 into
                      ; al register
  ```
  Assembler translates it into binary instructions understood by the CPU.

### Example: Assembly vs. Machine Code
- Assembly (x86-64 using NASM):

  ```assembly
  section .data
    msg db "Hello, World!", 0

  section .text
    global _start

  _start:
    mov rax, 1      ; sys_write
    mov rdi, 1      ; stdout
    mov rsi, msg    ; message address
    mov rdx, 13     ; message length
    syscall         ; system call or call kernel

    mov rax, 60     ; sys_exit
    xor rdi, rdi    ; exit code 0
    syscall
  ```

- Equivalent Machine Code (Hexadecimal)

  ```
  48 C7 C0 01 00 00 00
  48 C7 C7 01 00 00 00
  48 C7 C6 00 20 60 00
  48 C7 C2 0D 00 00 00
  0F 05
  48 C7 C0 3C 00 00 00
  48 31 FF
  0F 05
  ```
  This binary representation is what the CPU actually executes.

## Assembly vs High-Level Language (HLL)
  - Assembly and high-level programming language (HLLs) serve different purposes and have distinct characteristics.

  1. Level of Abstraction
  - Assembly Language
    - Low-level, close to machine code. Requires direct control over CPU
      registers, memory and hardware.
  - High-Level Language
    - Abstracts hardware details, allowing developers to focus on logic
      rather than hardware-specific instructions.

  Example:

  - Assembly (x86-64 using NASM)
  ```assembly
  section .data
    msg db "Hello, World!", 0

  section .text
    global _start

  _start:
    mov rax, 1    ; sys_write
    mov rdi, 1    ; stdout
    mov rsi, msg  ; message address
    mov rdx, 13   ; message length
    syscall       ; system call or call kernel

    mov rax, 60   ; sys_exit
    xor rdi, rdi  ; exit code 0
    syscall
  ```

  - High-Level Language (C language)
  ```c
  #includ <stdio.h>

  int main() {
    printf("Hello, World!\n");
    return 0;
  }
  ```
  Difference: The C language version is more readable and doesn't require
  direct memory manipulation.

  2. Readability and Ease of Use
  - Assembly language
    - Hard to read, requires knowledge of CPU architecture.
  - High-level language
    - Easier to write and understand.

  3. Portability
  - Assembly language
    - CPU-dependent (e.g., x86-64 Assembly won't work on ARM).
  - High-level language
    - Platform-independent (C, Python, Java can run on different CPUs with
      re-compilation or interpretation).

  4. Performance
  - Assembly language
    - Faster, since it's directly translated to machine code.
  - High-level language
    - Slightly slower due to abstraction but optimized by compilers (e.g.,
      GCC, LLVM).

  Example:
  - Assembly (requires manual sorting logic)
  - C language
  ```c
  #include <stdlib.h>

  int arr[] = {5, 2, 9, 1, 5, 6};
  qsort(arr, 6, sizeof(int), compare);
  ```
  The high-level language provides built-in functions like qsort().

  5. Memory Management
  - Assembly language
    - Full control, but requires manual memory handling.
  - High-level language
    - Uses automatic memory management (e.g., garbage collection in Python,
      C#).

  Example:
    - Assembly: Manually allocate stack or heap memory.
    - C: Uses malloc(), free().
    - Python: Uses automatic garbage collection.




