[bits 16]
PROGRAM_SPACE equ 0x7e00

ReadDisk:

    mov ah, 0x02
    mov bx, PROGRAM_SPACE
    mov al, 4
    mov dl, [Boot_Drive]
    mov ch, 0x00
    mov dh, 0x00
    mov cl, 0x02

    int 0x13

    jc DiskReadFailed
    ret

Boot_Drive:
    db 0

DiskReadFailed:
    mov bx, DiskReadError
    call print16

    jmp $

DiskReadError db 'Disk Read Failed', 0