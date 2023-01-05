; Since we no longer have access to BIOS utilities, this function
; takes advantage of the VGA memory area. We will go over this more
; in a subsequent chapter, but it is a sequence in memory which
; controls what is printed on the screen.
; printProtected.asm
[bits 32]

; Simple 32-bit protected print routine
; Message address stored in esi
printProtected:
    ; The pusha command stores the values of all
    ; registers so we don't have to worry about them
    pushad
    mov edx, vgaStart

    ; Do main loop
    printProtectedLoop:
        ; If char == \0, string is done
        cmp byte[esi], 0
        je  printProtectedDone

        ; Move character to al, style to ah
        mov al, byte[esi]
        mov ah, styleWB

        ; Print character to vga memory location
        mov word[edx], ax

        ; Increment counter registers
        inc esi
        add edx, 2

        ; Redo loop
        jmp printProtectedLoop

printProtectedDone:
    ; Popa does the opposite of pusha, and restores all of
    ; the registers
    popad
    ret