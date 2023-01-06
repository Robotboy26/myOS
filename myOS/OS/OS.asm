[bits 64]

lea  rsi, [rel helloworld] ; this is interesting but it works
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

%include "OSThings/KeyboardDriver/KeyboardDriver.asm"
%include "OSThings/VGADriver/VGADriver.asm"
%include "OSThings/Constants.asm"
%include "OSThings/storeString.asm"

times 1024 - ($ - $$) db 0x00