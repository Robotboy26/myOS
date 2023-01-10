[bits 64]

lea  rsi, [rel helloworld] ; this is interesting but it works
call storeString

call basicPrint

mov cx, 0

temp:
    push 1
    inc cx
    cmp cx, 350
    jne temp

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