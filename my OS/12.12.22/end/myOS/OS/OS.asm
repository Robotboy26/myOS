[bits 64]
lea  rsi, [rel helloworld] ; this is interesting but works
call storeString

call basicPrint

jmp $

; #######
; strings
; #######

helloworld:
    db 'hello world', 0

; #############
; include files
; #############

%include "OSThings/Constants.asm"
%include "OSThings/basicPrint.asm"
%include "OSThings/storeString.asm"

times 1024 - ($ - $$) db 0x00