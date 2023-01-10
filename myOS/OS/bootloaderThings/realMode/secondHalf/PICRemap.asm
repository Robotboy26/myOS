
PICRemap:
    push ax

    ; ICW1
    mov al, 0x11
    out 0x20, al
    out 0xA0, al

    ; ICW2
    mov al, 0x20
    out 0x21, al
    mov al, 0x28
    out 0xA1, al

    ; ICW3
    mov al, 0x04
    out 0x21, al
    mov al, 0x02
    out 0xA1, al

    ; ICW4
    mov al, 0x01
    out 0x21, al
    out 0xA1, al

    ; OCW1
    mov al, 0x00
    out 0x21, al
    out 0xA1, al

    pop ax
    ret
    

