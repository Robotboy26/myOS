; ClearLong.asm
[bits 64]

; Clear the VGA memory. (AKA write blank spaces to every character slot)
; Style in rdi
clearLong:
    ; The pusha command stores the values of all
    ; registers so we don't have to worry about them
    push rdi
    push rax
    push rcx

    shl rdi, 8
    mov rax, rdi

    mov al, spaceChar

    mov rdi, vgaStart
    mov rcx, vgaExtent / 2

    rep stosw

    pop rcx
    pop rax
    pop rdi
    ret


spaceChar:                     equ ` `