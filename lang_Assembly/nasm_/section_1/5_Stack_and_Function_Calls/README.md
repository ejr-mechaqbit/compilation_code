## Stack and Function Calls
  - `push` and `pop` Instructions
  - Calling Conventions (System V for Linux, stdcall for windows)
  - Function Prologues and Epilogues
  - Calling C Functions from Assembly

### `push` and `pop` Instructions
 The `push` and `pop` instructions are used for **stack operations**. The
 **stack** is a LIFO (Last In, First Out) data structure used for function
 calls, storing local variables and saving registers.

#### 1. `push` Instruction
  - **Sytax**: `push operand`
  - **Effect**:
    - Decrements the stack pointer (`rsp`) by the size of the operand
      (usually 8 bytes for 64-bit values).
    - Stores the operand at the new stack location (`rsp`).

  - [x] Example: **Pushing Register**
  ```assembly
  push rax      ; Store rax on the stack
  push rbx      ; Store rbx on the stack
  push 42       ; Push immediate value 42 (64-bit)
  ```

#### 2. `pop` Instruction
  - **Syntax**: `pop` destination
  - **Effect**:
    - Loads the value at the **top of the stack** (`rsp`) into destination.
    - Increments `rsp` to remove the popped value.

  - [x] Example: **Popping Register**
  ```assembly
  pop rbx     ; Restore rbx from the stack
  pop rax     ; Restore rax from the stack
  ```

#### 3. Full Example: Using `push` and `pop`
  - [x] Saving and Restoring Registers in a Function
  ```assembly
  section .text
    global _start

  _start:
    mov rax, 10
    mov rbx, 20

    push rax        ; Save rax
    push rbx        ; Save rbx

    mov rax, 100    ; Change rax
    mov rbx, 200    ; Change rbx

    pop rbx         ; Restore rbx
    pop rax         ; Restore rax

    mov rax, 60     ; syscall: exit
    xor rdi, rdi
    syscall
  ```
  **Explanation**
  - `push rax` and `push rbx` save register values.
  - We modify `rax` and `rbx` to different values.
  - `pop rbx` and `pop rax` restore original values.

#### 4. `push` and `pop` with Function Calls

  ```assembly
  section .text
    global _start

  _start:
    mov rdi, 5        ; Argument for function
    call my_function  ; call my_function

    mov rax, 60       ; Exit program
    xor rdi, rdi
    syscall

  my_function:
    push rbp          ; Save old base pointer
    mov rbp, rsp      ; Set up new stack frame

    push rdi          ; Save function argument

    pop rax           ; Load argument into rax (return value)

    pop rbp           ; Restore base pointer
    ret               ; Return to caller
  ```
  **Explanation**
  - `push rbp` saves the base pointer.
  - `push rdi` saves the function argument.
  - `pop rax` restores the argument as a return value.
  - `ret` return to _start.

#### 5. Common Use Cases
  - [x] **Stack Frame in Function Calls**
    - Saves function arguments, return addresses, and local variables.
  - [x] **Saving and Restoring Registers**
    - Prevents register values from being lost during function execution.
  - [x] Manually Managing Data on the Stack
    - Useful for tempory storage without using global variables.

#### Conclusion
  - `push` stores a value on the stack, decreasing rsp.
  - `pop` retrieves a value from the stack, increasing rsp.
  - Used in function calls, register saving, and temporary storage.

### Calling Convention (System V for Linux & stdcall for Windows)
 Calling conventions define how function arguments are passed, how return
 values are handled, and who is responsible for cleaning up the stack.

#### 1. system V AMD64 Calling Convention (Linux, macOS)
  - [x] Used by:
    - Linux
    - macOS
    - BSD

  **Register Usage**
   - **First six integer arguments**: `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9`
   - **Floating-point arguments**: Passed in `XMM0-XMM7`
   - **Return value**: `rax` (and `rdx` if needed for 128-bit values)
   - **Stack alignment**: Must be **16-bit aligned** before **CALL**

  - Example: **Function with Two Arguments**
  ```assembly
  section .text
    global my_function

  my_function:
    push rbp        ; Save old base pointer
    mov rbp, rsp    ; Set up new stack frame

    mov rax, rdi    ; First Argument (in rdi)
    add rax, rsi    ; Second Argument (in rsi), add them

    pop rbp         ; Restore base pointer
    ret             ; Return (rax holds the result)
  ```
  - [x] **C Equivalent**
  ```c
  long my_function(long a, long b) {
    return a + b;
  }
  ```
  - [x] **Caller Code in Assembly**
  ```assembly
  mov rdi, 10         ; First argument
  mov rsi, 20         ; Second argument
  call my_function    ; Call function
  ```

#### 2. stdcall (Windows 64-bit)
  - [x] Used by:
    - Windows (64-bit)
    - Microsoft Visual Studio
    - Windows API

  **Register Usage**
   - **First four integer arguments**: `rcx`, `rdx`, `r8`, `r9`
   - **Floating-point argumnets**: Passed in `XMM0-XMM3`
   - **Return values**: `rax`
   - **Stack alignment**: **16-byte aligned before `CALL`**
   - **Caller cleans up the stack** (Unlike Windows 32-bit stdcall, which used cleanup)
  
  - Example: **Function with Two Arguments**
  ```assembly
  section .text
    global my_function

  my_function:
    push rbp
    mov rbp, rsp

    mov rax, rcx        ; First arguments (in rcx)
    add rax, rdx        ; Second arguments (in rdx)

    pop rbp
    ret
  ```
  - [x] **C Equivalent**
  ```c
  long __stdcall my_function(long a, long b) {
    return a + b;
  }
  ```
  - [x] **Caller Code in Assembly**
  ```assembly
  mov rcx, 10       ; First argument
  mov rdx, 20       ; Second argument
  call my_function  ; Call function
  ```

#### 3. Key Differences: System V vs. stdcall

  |Feature |System V (Linux) |stdcall (Windows) |
  |-----|-----|-----|
  |First argument |`rdi` |`rcx` |
  |Second argument |`rsi` |`rdx` |
  |Third argument |`rdx` |`r8` |
  |Fourth argument |`rcx` |`r9` |
  |Additional arguments |Pushed on **stack**(right to left) |Pushed on **stack**(right to left) |
  |Return value |`rax` |`rax` |
  |Floating-point args |`XMM0-XMM7` |`XMM0-XMM3` |
  |Stack cleanup |Caller |Caller |
  |Stack alignment |**16-byte aligned** |**16-byte aligned** |

#### 4. Function Call Example: System V vs. stdcall
  - [x] **System V (Linux)**
  ```assembly
  mov rdi, 5      ; First argument
  mov rsi, 10     ; Second argument
  call my_function
  ```
  - [x] **stdcall (Windows)**
  ```assembly
  mov rcx, 5      ; First argument
  mov rdx, 10     ; Second argument
  call my_function
  ```

#### Conclusion
  - **System V (Linux/macOS)**: Uses `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9`
    for arguments.
  - **stdcall (Windows 64-bit)**: Uses `rcx`, `rdx`, `r8`, `r9` for
    arguments.
  - **Both require 16-byte stack alignment** before `CALL`.
