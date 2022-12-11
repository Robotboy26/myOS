; also need constants.asm or
; 'vgaStart:'; 'styleBlue:' ; 
basicPrint:
    ; puch any used registers
    push rdx
    push rsi
    push rax

    mov rdx, vgaStart

    mov ah, styleBlue

basicPrintLoop:
    cmp byte[rsi], 0
    je  basicPrintDone ; if zero string is done

    mov al, byte[rsi] ; move char to al

    mov word[rdx], ax ; move char to vga memory location

    ; inc counters
    add rsi, 1
    add rdx, 2

    jmp basicPrintLoop ; jump back to the loop

basicPrintDone:
    ; pop the used register
    pop rax
    pop rsi
    pop rdx

    ret

