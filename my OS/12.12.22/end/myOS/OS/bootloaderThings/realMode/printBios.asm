; printBios.asm
[bits 16]

; Define function print_bios
; Input pointer to string in bx
printBios:
    ; Save state
    push ax
    push bx

    ; Enter Print Mode
    mov ah, 0x0E


    printBiosLoop:

        ; Null Check
        cmp byte[bx], 0
        je printBiosEnd

        ; Print Character
        mov al, byte[bx]
        int 0x10

        ; Increment pointer and reenter loop
        inc bx
        jmp printBiosLoop


; End of print_bios
printBiosEnd:

    ; Restore State
    pop bx
    pop ax

    ; Jump to last instruction
    ret