; also need constants.asm or
; 'stringStoragePointer' ;
storeString:
    ; puch any used registers
    push rsi
    push rdx
    push rax

    mov rdx, stringStoragePointer

storeStringLoop:
    cmp byte [rsi], 0
    je  storeStringDone ; if zero, string is done

    mov al, [rsi] ; move char to al
    mov [rdx], al ; move al to memory location

    ; inc counters
    inc rsi
    inc rdx

    jmp storeStringLoop ; jump back to the loop

storeStringDone:
    ; pop the used register
    pop rax
    pop rdx
    pop rsi

    ret
