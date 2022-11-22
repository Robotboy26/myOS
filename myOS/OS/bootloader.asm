
mov ah, 0x0e

mov al, 'h'

int 0x10

times 510 - ($ - $$) db 0 ; padding to fill the bootsector up to 512 bytes
dw 0xAA55 ; boot signiture (tells the computer that this is the boot sector)