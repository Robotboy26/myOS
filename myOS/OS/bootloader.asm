
jmp $

times 510 - ($ - $$) db 0 ; padding to fill the bootsector up to 512 bytes
dw 0xAA55 ; boot signiture (tells the computer that this is the boot sector)