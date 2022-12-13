[bits 64]
mov rdi, style_blue
call clear_long

lea  rsi, [rel string] ; this is interesting but works
call storeString

call basicPrint

jmp $

string:
    db 'hello world', 0

; #############
; include files
; #############

%include "OSThings/Constants.asm"
%include "OSThings/basicPrint.asm"
%include "OSThings/storeString.asm"

%include "bootloaderThings/long_mode/clear.asm"

times 1024 - ($ - $$) db 0x00