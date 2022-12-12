[bits 64]

lea rsi, [welcome]
call storeString

call basicPrint


jmp $

welcome: 
    db 'welcome', 0

; #############
; include files
; #############

%include "OSThings/Constants.asm"
%include "OSThings/basicPrint.asm"
%include "OSThings/storeString.asm"

times 1024 - ($ - $$) db 0x00