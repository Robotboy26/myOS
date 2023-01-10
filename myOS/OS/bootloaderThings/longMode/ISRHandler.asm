isr_common_stub:
    ; push general purpose registers
    mov ds, eax
    push rax

    ; push data segment selector
    mov ax, ds
    push rax

    ; use kernel data segment
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    ; hand over stack to C function
    push rsp
    ; and call it
    ;call isr_handler
    ; pop stack pointer again
    pop rax

    ; restore original segment pointers segment
    pop rax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; restore registers
    pop rax
    mov eax, ds

    ; remove int_no and err_code from stack
    add rsp, 8

    ; pops cs, eip, eflags, ss, and esp
    ; https://www.felixcloutier.com/x86/iret:iretd
    iret