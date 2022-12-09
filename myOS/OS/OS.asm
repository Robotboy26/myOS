[bits 64]

mov rdi, style_blue
call clear_long

mov rdi, style_blue
mov rsi, long_mode_note
call print_long

jmp $

%include "bootloaderThings/long_mode/clear.asm"
%include "bootloaderThings/long_mode/print.asm"

long_mode_note:                 db 'Now', 0
style_blue:                     equ 0x1F
vga_start:                  equ 0x000B8000
vga_extent:                 equ 80 * 25 * 2             ; VGA Memory is 80 chars wide by 25 chars tall (one char is 2 bytes)

times 512 - ($ - $$) db 0x00