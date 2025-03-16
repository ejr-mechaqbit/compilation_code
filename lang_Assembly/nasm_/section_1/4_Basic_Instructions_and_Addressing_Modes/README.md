## Basic Instruction and Addressing Modes
  - `mov`, `add`, `sub`, `mul`, `div`
  - Immediate, Register, Direct, and Indirect Addressing
  - Working with Constants and Variables

 ### x86-64 Assebly Instructions: `mov`, `add`, `sub`, `mul` and `div`
  These are fundamental instructions for arithmetic and data movement in
  assembly.

  #### 1. `mov` (Move Data)
   The `mov` instruction copies data from one location to another.

   - [x] Example: **Moving Data Between Registers and Memory**
   ```assembly
   section .data
     num1 dq 42         ; Define a 64-bit integer

   section .bss
     result resq 1      ; Reserve space for a result

   section .text
     global _start

   _start:
     mov rax, [num1]    ; Move value from memory to rax
     mov rbx, 100       ; Move immediate value to rbx
     mov [result], rbx  ; Store rbx in memory

     mov rax, 60        ; syscall: exit
     xor rdi, rdi
     syscall
   ```
   **Explanation**
   - Moves values between registers, memory, and immediate values.

  #### 2. `add` (Addition)
   The `add` instruction adds two values and stores the result in the
   destination operand.

   - [x] Example: **Adding Two Numbers**
   ```assembly
   section .data
     num1 dq 20
     num2 dq 30

   section .bss
     sum resq 1

   section .text
     global _start

   _start:
    mov rax, [num1]   ; Load num1 into rax
    add rax, [num2]   ; Add num2 to rax
    mov [sum], rax    ; Store result in sum

    mov rax, 60
    xor rdi, rdi
    syscall
  ```
  **Explanation**
  - `add rax, [num2]` equivalent to rax = rax + num2
  - Stores the result in sum.

  #### 3. `sub` (Subtraction)
   The `sub` instruction subtracts the source operand from the destination
   operand.

   - [x] Example: **Subtracting Two Numbers**
   ```assembly
   section .data
     num1 dq 50
     num2 dq 15

   section .bss
     diff resq 1

   section .text
     global _start

   _start:
     mov rax, [num1]      ; Load num1 into rax
     sub rax, [num2]      ; Subtract num2 from rax
     mov [diff], rax      ; Store result in diff

     mov rax, 60
     xor rdi, rdi
     syscall
   ```
   **Explanation**
   - `sub rax, [num2]` equivalent to rax = rax - num2
   - Store the result in diff.

  #### 4. `mul` (Multiplication)
   The `mul` instruction performs **unsigned multiplication**.
   - if `mul` `operand` is used, it multiplies `rax` by `operand`, storing
     the result in `rdx`:`rdx`.

   - [x] Example: **Multiplication**
   ```assembly
   section .data
     num1 dq 10
     num2 qword [num2]
     
   section .bss
     product resq 1

   section .text
     global _start

   _start:
     mov rax, [num1]      ; Load num1 into rax
     mul qword [num2]     ; rdx:rdx = rax * num2
     mov [product], rax   ; Store result in product

     mov rax, 60
     xor rdi, rdi
     syscall
   ```
   **Explanation**
   - `mul qword [num2]` **It multiplies rax by num2, result stored in
     rdx:rdx**.

  #### 5. `div` (Division)
   The `div` instruction performs **unsigned division**.
   - Dividend is in rdx:rdx.
   - Quotient is stored in `rax`, remainder in`rdx`.

   - [x] Example: **Division**
   ```assembly
   section .data
     dividend dq 50
     divisor dq 7

   section .bss
     quotient resq 1
     quotient resq 1

   section .text
     global _start

   _start:
     mov rax, [dividend]    ; Load dividend into rax
     xor rdx, rdx           ; Clear rdx (high part of dividend)
     div qword [divisor]    ; rax = rax / divisor, rdx = remainder
     mov [quotient], rax    ; Store quotient

     mov rax, 60
     xor rdi, rdi
     syscall
   ```
   **Explanation**
   - `div qword [divisor]` The rax = rax / divisor, remainder stored in rdx.

  #### 6. Signed vs. Unsigned Operations
  |Operation  |Signed Instruction |Unsigned Instruction |
  |-----|-----|-----|
  |Multiply|`imul` |`mul`|
  |Divide |`idiv` |`div` |

  - **Signed Multiplication** (`imul`)
   The `imul` instruction perform **signed multiplication**, meaning it
   properly handles **negative numbers** using **two's complement
   arithmetic**.

  - [x] Example: **Signed Multiplication**
  ```assembly
  imul operand
  ```
  - Multiplies `rax` by `operand` and stores the **64-bit result in rdx:rdx**.
  **Two-Operand Form**
  ```assembly
  imul destination, source
  ```
  - Multiplies `destination` by `source`, and the result is stored in
    `destination`.
  **Three-Operand Form**
  ```assembly
  imul destination, source1, immediate
  ```
  - `destination = source1 * immadiate`
  - [x] Example: **One-operand `imul`**
  ```assembly
  section .data
    num1 dq -5
    num2 dq 7

  section .bss
    product resq 1

  section .text
    global _start

  _start:
    mov rax, [num1]     ; Load num1 into rax
    imul qword [num2]   ; Signed multiplication rax * num2 then rdx:rax
    mov [product], rax  ; Store result

    mov rax, 60         ; syscall: exit
    xor rdi, rdi
    syscall
  ```
  - **Explanation**
  - `imul [num2]` multiplies `rax` by `num2` (signed)
  - Result is stored in rdx:rax.

  - [x] Example: **Two-Operand `imul`**
  ```assembly
  mov rax, -8
  mov rbx, 6
  imul rax, rbx   ; rax = rax * rbx
  ```
  - **Explanation**
  - `imul rax, rbx` equivalent to rax = -8 * 6 = -48

  - [x] Example: **Three-Operand `imul`**
   Multiplying a Register by an Immediate Value
  ```assembly
  mov rax, 4
  imul rbx, rax, -3   ; rbx = rax * -3
  ```
  - **Explanation**
  - `imul rbx, rax, -3` equivalent to rbx = 4 * -3 = -12.

  **Overflow Handling**
  - If the result **fits in the destination register**, no overflow occurs.
  - If the result **exceeds the register size**, it **overflows into
    `rdx`**.

  ```assembly
  mov rax, 0x7FFFFFFFFFFFFFFF   ; Largest positive 64-bit value
  imul rax, 2                   ; Overflow occurs: `rdx` stores high bits
  jo overflow_handler           ; Jump if overflow flag is set

  overflow_handler:
    mov rax, 60
    mov rdi, 1
    syscall
  ```

  **Signed vs Unsigned Multiplication**
  |Operation |Signed(`imul`) |Unsigned (`mul`) |
  |-----|-----|-----|
  |`mov rax, -5`
  |`imul rbx, rax, 7` |-35(correct) |Undefined result |
  |`mov rax, 5`|-35(correct) |Undefined result|
  |`imul rbx, rax, -7` | | |
  |`mov rax, 5` |Correct(positive) |Correct(positive) |
  |`mul rbx`| | |



