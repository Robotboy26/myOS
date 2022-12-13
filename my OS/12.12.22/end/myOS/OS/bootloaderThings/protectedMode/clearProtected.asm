; clearProtected.asm
[bits 32]

; Clear the VGA memory. (AKA write blank spaces to every character slot)
; This function takes no arguments
clearProtected:
    ; The pusha command stores the values of all
    ; registers so we don't have to worry about them
    pushad

    ; Set up constants
    mov ebx, vgaExtent
    mov ecx, vgaStart
    mov edx, 0

    ; Do main loop
    clearProtectedLoop:
        ; While edx < ebx
        cmp edx, ebx
        jge clearProtectedDone

        ; Free edx to use later
        push edx

        ; Move character to al, style to ah
        mov al, spaceChar
        mov ah, styleWB

        ; Print character to VGA memory
        add edx, ecx
        mov word[edx], ax

        ; Restore edx
        pop edx

        ; Increment counter
        add edx,2

        ; GOTO beginning of loop
        jmp clearProtectedLoop

clearProtectedDone:
    ; Restore all registers and return
    popad
    ret


spaceChar:                     equ ` `