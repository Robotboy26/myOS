[bits 64]

mov [vga_start], byte 'H'
mov [vga_start + 2], byte 'e'
mov [vga_start + 4], byte 'l'
mov [vga_start + 6], byte 'l'
mov [vga_start + 8], byte 'o'


jmp $

vga_start:                  equ 0x000B8000
vga_extent:                 equ 80 * 25 * 2             ; VGA Memory is 80 chars wide by 25 chars tall (one char is 2 bytes)

times 1024 - ($ - $$) db 0x00