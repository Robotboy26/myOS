[bits 64]

mov rsi, coolString
call basicPrint


jmp $

; #############
; include files
; #############

%include "OSThings/basicPrint.asm"

coolString db 'welcome', 0

times 1024 - ($ - $$) db 0x00