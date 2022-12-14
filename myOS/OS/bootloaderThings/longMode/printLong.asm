;
; Long Mode
;
; print.asm
;

; Since we no longer have access to BIOS utilities, this function
; takes advantage of the VGA memory area. We will go over this more
; in a subsequent chapter, but it is a sequence in memory which
; controls what is printed on the screen.

[bits 64]

; Simple 32-bit protected print routine
; Style stored in rdi, message stored in rsi
printLong:
    ; The pusha command stores the values of all
    ; registers so we don't have to worry about them
    push rax
    push rdx
    push rdi
    push rsi

    mov rdx, vgaStart
    shl rdi, 8

    ; Do main loop
    printLongLoop:
        ; If char == \0, string is done
        cmp byte[rsi], 0
        je  printLongDone

        ; Handle strings that are too long
        cmp rdx, vgaStart + vgaExtent
        je printLongDone

        ; Move character to al, style to ah
        mov rax, rdi
        mov al, byte[rsi]

        ; Print character to vga memory location
        mov word[rdx], ax

        ; Increment counter registers
        inc rsi
        add rdx, 2

        ; Redo loop
        jmp printLongLoop

printLongDone:
    ; Popa does the opposite of pusha, and restores all of
    ; the registers
    pop rsi
    pop rdi
    pop rdx
    pop rax

    ret