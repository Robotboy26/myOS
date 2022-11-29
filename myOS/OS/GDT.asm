gdt_nulldeac:
    dd 0
    dd 0

gdt_codedeac:
    dw 0xFFFF     ; Limit
    dw 0x0000     ; Base (low)
    db 0x00       ; Base (medium)
    db 10011010b  ; Flags
    db 11001111b  ; Flags + Upper limit
    db 0x00       ; Base (high)

gdt_datadeac:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10011010b
    db 11001111b
    db 0x00

gdt_end:

gdt_descriptor:
    gdt_size:
        dw gdt_end - gdt_nulldeac - 1
        dd gdt_nulldeac

codeseg equ gdt_codedeac - gdt_nulldeac
dataseg equ gdt_datadeac - gdt_nulldeac