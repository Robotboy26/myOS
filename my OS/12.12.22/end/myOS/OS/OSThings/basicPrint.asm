; also need constants.asm or
; 'vgaStart:'; 'style:' ; 'stringStoragePointer' ;
basicPrint:
    ; puch any used registers
    push rdx
    push rsi
    push rax

    mov rdx, vgaStart

    mov rsi, stringStoragePointer

    mov ah, style

basicPrintLoop:
    cmp byte [rsi], 0
    je  basicPrintDone ; if zero, string is done

    mov al, byte [rsi] ; move char to al

    mov word [rdx], ax ; move char to vga memory location

    ; inc counters
    inc rsi
    add rdx, 2

    jmp basicPrintLoop ; jump back to the loop

basicPrintDone:
    ; pop the used register
    pop rax
    pop rsi
    pop rdx

    ret

