## CPU Architecture Basics
- x86-64 Architecture Overview
- Registers (General Purpose, Special Purpose, Segment and Flags)
- Memory Segments (Code, Data, Stack, Heap)
- Endiannes (Little-endian vs. Big-endian)

### x86-64 Architexture Overview
  - The x86-64 (also called x64 or AMD64) architecture is a 64-bit extension
    of the older x86 (IA-32) architecture, introduced by AMD in 2003 and
    later adopted by Intel. It is widely used in modern desktop, server, and
    high-performance computing systems.

####  1. Key Features of x86-64
  - [x] 64-bit Registers and Memory Addressing
    - Supports 64-bit general-purpose registers (GPRs).
    - Can directly address 16 exabytes (2^64 bytes) of memory, but practical
      limits are much lower.
    - Provides backward compatibility with 32-bit x86 program (IA-32 mode).
  - [x] More General-Purpose Registers (GPRs)
    - x86-64 adds 8 extra GPRs, making a total of 16 registers:
    - (x86)
      - `rax` 
      - `rbx`
      - `rcx`
      - `rdx`
      - `rbp`
      - `rsp`
      - `rsi`
      - `rdi`
    - (additional in x86-64)
      - `r8` to `r15i`
    - Registers can be accessed as 64-bit, 32-bit, 16-bit, or 8-bit:
      - `rax` (64-bit)
      - `eax` (32-bit)
      - `ax` (16-bit)
      - `ah` / `al` (8-bit)
  - [x] Improved Calling Conventions
    - Uses the System V AMI for Linux/macOS and Microsoft x64 ABI for
      Windows.
    - Function parameters are passed in registers instead of the stack:
      - System V ABI (Linux/macOS): First six integer arguments 'n `rdi`,
        `rsi`, `rdx`, `rcx`, `r8`, `r9`.
      - Microsoft x64 ABI (Windows): First four arguments 'n `rcx`, `rdx`,
        `r8`, `r9`.
  - [x] Additional Instructions and Features
    - SSE (Streaming SIMD Extension) and AVX (Advanced Vector Extensions)
      for optimized floating-point and vector processing.
    - RIP-relative addressing simplifies position-independent code.

####  2. x86-64 CPU Modes
  1. Long Mode (64-bit mode)
    - Enables full 64-bit memory addressing
    - Uses x86-64 instructions.
    - Can run 64-bit and 32-bit applications.
  2. Compatibility Mode
    - Allows runnin 32-bit x86 programs on a 64-bit OS.
  3. Legacy Mode (Protected Mode)
    - Runs a 32-bit OS without 64-bit features.

####  3. x86-64 Registers
  |Register                        |Description                                                                  |
  |--------------------------------|-----------------------------------------------------------------------------|
  |General-Purpose Register (GPRs) |`rax`, `rbx`, `rcx`, `rdx`, `rsi`, `rdi`, `rbp`, `rsp`, `r8` - `r15`         |
  |Instruction Pointer             |`rip` (Holds the address of the next instruction)                            |
  |Stack Pointer                   |`rsp` (Points to the top of the stack)                                       |
  |Base Pointer                    |`rbp` (Used for stack frame referencing)                                     |
  |Flags Register                  |`rflags` (Contains status flags like Zero Flag, Carry Flag)                  |
  |Segment Registers               |`cs`, `ds`, `es`, `fs`, `gs`, `ss`, (Mainly for compatibility with older x86 |

  - [x] Example: Accessing Registers in Assembly
  ```assembly
  section .text
    global _start

  _start:
    mov rax, 1      ; move 1 into rax
    add rax, 5      ; add 5 to rax
    mov rbx, rax    ; copy rax to rbx
    
    mov rax, 60     ; exit system call
    xor rdi, rdi    ; exit code 0
    syscall
  ```

####  4. Memory Addressing in x86-64
  Types of Addressing Modes
  1.  Immediate Addressing:
    - `mov rax, 10` (Loads an immediate value)
  2. Register Addressing:
    - `mov rax, rbx` (Moves data between registers)
  3. Memory Addressing:
    - `mov rax, [rbx]` (Loads data from memory)
  4. RIP-Relative Addressing:
    - `mov rax, [rel msg]` (Used in Position-Independent Code)
  5. Indexed Addressing:
    - `mov rax, [rbx + rcx*4]` (Access array elements)

  - [x] Example: Accessing Memory
  ```assembly
  section .data
    value dq 42       ;Define a 64-bit integer in memory

  section .text
    global _start

  _start:
    mov rax, [value]  ; Load the value from memory
    add rax, 8        ; Modify it

    mov rax, 60
    xor rdi, rdi
    syscall
  ```

####  5. System Calls in x86-64 Linux
  - System calls use `rax` to specify the syscall number.
  - Arguments are passed in `rdi`, `rsi`, `rdx`, `r10`, `r8`, `r9`.
  - The syscall instruction calls the kernel.

  - [x] Example: Writing to stdout
  ```assembly
  section .data
    msg db "Hello, x86-64!", 0

  section .text
    global _start

  _start:
    mov rax, 1      ; sys_write
    mov rdi, 1      ; stdout
    mov rsi, msg    ; address of message
    mov rdx, 14     ; length of message
    syscall         ; system call

    mov rax, 60     ; sys_exit
    xor rdi, rdi    ; exit code 0
    syscall
  ```

####  6. Stack and Function Calls
  - The stack follows a **Last In, First Out (LIFO)** order.
  - `push` and `pop` instructions are used to manipulate the stack.
  - `call` pushes the return address onto the stack and jumps to a function.
  - `ret` pops the return address and return to the caller.

  - [x] Example: Function Call in Assembly
  ```assembly
  section .text
    global _start

  _start:
    call my_function      ; call my_function function
    
    call exit             ; call exit function

  my_function:
    mov rax, 5
    ret                   ; return to caller

  exit:
    mov rax, 60
    xor rdi, rdi
    syscall
    ret                   ; return to caller
  ```

#### 7. Comparison: x86-64 vs x86 (32-bit)
  |Feature             |x86(IA-32)           |x86-64                          |
  |--------------------|---------------------|--------------------------------|
  |Address Size        |32-bit (4GB max)     |64-bit (16 exabytes theoretical |
  |General Registers   |8 (`eax`, `ebx`, etc)|16 (`rax`, `rbx`, `r8`-`r15`)   |
  |Instruction Pointer |`eip`                |`rip`                           |
  |Stack Pointer       |`esp`                |`rsp`                           |
  |Function Parameters |Passed on stack      |Passed in registers             |
  |Compatibility       |Runs on x86 CPUs     |Runs both x86-64 & x86 programs |


### x86-64 Registers Overview
- In x86-64 architecture, registers are categorized into General-Purpose
  Registers (GPRs), Special-Purpose Registers, Segment Registers and Flags
  Register. These registers are crucial for excuting instructions, storing
  data, and managing system operations.

#### 1. General-Purpose Registers (GPRs)
These registers are used for arithmetic operations, data storage, and
passing function parameters.

|Register |64-bit     |32-bit       |16-bit       |8-bit        |Description                                          |
|---------|-----------|-------------|-------------|-------------|-----------------------------------------------------|
|RAX      |`rax`      |`eax`        |`ax`         |`al`/`ah`    |Accumulator or (used in arithmetic and system calls) |
|RBX      |`rbx`      |`ebx`        |`bx`         |`bl`/`bh`    |Base register (used for addressing memory)           |
|RCX      |`rcx`      |`ecx`        |`cx`         |`cl`/`ch`    |Counter (used in loops and shifts)                   |
|RDX      |`rdx`      |`edx`        |`dx`         |`dl`/`dh`    |Data register (used in multiplication, division, I/O)|
|RSI      |`rsi`      |`esi`        |`si`         |`sil`        |Source index (used for string operations)            |
|RDI      |`rdi`      |`edi`        |`di`         |`dil`        |Destination index (used for string operations)       |
|RBP      |`rbp`      |`ebp`        |`bp`         |`bpl`        |Base pointer (used in stack frames)                  |
|RSP      |`rsp`      |`esp`        |`sp`         |`spl`        |Stack pointer (points to top of the stack)           |
|R8 - R15 |`r8`-`r15` |`r8d`-`r15d` |`r8w`-`r15w` |`r8b`-`r15b` |Additional registers (introduced in x86-64)          |

- [x] Example: Using GPRs in Assembly
```assembly
section .text
  global _start

_start:
  mov rax, 10     ; Store 10 in rax
  add rax, 5      ; Add 5 to rax (now rax = 15)
  mov rbx, rax    ; Copy rax value to rbx

  mov rax, 60     ; sys_exit
  xor rdi, rdi    ; exit code 0
  syscall
```

#### 2. Special-Purpose Registers
These registers control CPU operations, memory management, and instruction
execution.

|Register                      |Description                                                      |
|------------------------------|-----------------------------------------------------------------|
|RIP (Instruction Pointer)     |Holds the memory address of the next instruction to execute      |
|RFLAGS (Flags Register)       |Stores status flags (zero flag, carry flag, overflow flag, etc.) |
|RSP (Stack Pointer)           |Points to the current stack position                             |
|RBP (Base Pointer)            |Used for referencing stack frames                                |
|CR0-CR4 (Control Registers)   |Used for memory protection, virtual memory, and system control   |
|XMM0-XMM15                    |SSE vector registers for floating-point and SIMD operations      |
|YMM0-YMM15                    |AVX vector registers (for wider 256-bit SIMD operations)         |

- [x] Example: Using the Instruction Pointer (RIP)
```assembly
section .data
  message db "Hello, World!", 0

section .text
  global _start

_start:
  mov rax, 1        ; sys_write
  mov rdi, 1        ; stdout
  mov rsi, message  ; load address of message
  mov rdx, 13       ; message length
  syscall           ; system call

  mov rax, 60       ; sys_exit
  xor rdi, rdi      ; exit code 0
  syscall
```

#### 3. Segment Registers
Segment registers are mostly used for **compatibility with older x86
systems*. They define segments in memory for **code, data, stack, and extra
data**.

|Register             |Description                                            |
|---------------------|-------------------------------------------------------|
|CS (Code Segment)    |Holds the segment for executing instructions           |
|DS (Data Segment)    |Points to general-purpose data storage                 |
|SS (Stack Segment)   |Points to the stack memory segment                     |
|ES (Extra Segment)   |Used for additional data segment (legacy use)          |
|FS, GS               |Used for thread-local storage and special OS structures|

- [x] Example: Using FS/GS for Thread-Local Storage
```assembly
mov rax, qword [fs:0]     ; load thread-specific data
```

#### 4. Flags Register (RFLAGS)
The RFLAGS register contains various status and control flags that affect
how instructions execute.

**Common Flags in RFLAGS**
|Flag               |Bit  |Decription                                             |
|-------------------|-----|-------------------------------------------------------|
|ZF (Zero Flag)     |6    |Set if result of an operation is zero                  |
|CF (Carry Flag)    |0    |Set if an arithmetic operation generates a carry/borrow|
|OF (Overflow Flag) |11   |Set if signed arithmetic overflows                     |
|SF (Sign Flag)     |7    |Set if result is negative                              |
|PF (Parity Flag)   |2    |Set if number of set bits in the result is even        |
|DF (Direction Flag)|10   |Determines the direction of string operations          |
|IF (Interrupt Flag)|9    |Enables/disables hardware interrupts                   |

- [x] Example: Checking the Zero Flag
```assembly
section .text
  global _start

_start:
  mov rax, 5
  sub rax, 5        ; rax becomes 0
  jz exit           ; jump if Zero Flag (ZF) is set

exit:
  mov rax, 60       ; sys_exit
  xor rdi, rdi      ; exit code 0
  syscall
```
Here, `jz exit` jumps to exit if the result of sub rax, 5 is zero.

#### 5. Summary Table
|Register Type            |Example                            |Purpose                               |
|-------------------------|-----------------------------------|--------------------------------------|
|General-Purpose Register |RAX, RBX, RCX, RDX, R8-R15         |Store values, pass function arguments |
|Special-Purpose Register |RIP, RSP, RBP, CR0-CR4, XMM0-XMM15 |Control execution, manage memory      |
|Segment Registers        |CS, DS, SS, FS, GS                 |Define memory segments (legacy)       |
|Flags Register           |RFLAGS (ZF, CF, OF, SF, DF, IF)    |Store status flags for CPU operation  |

