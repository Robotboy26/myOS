; no please
KLReadSector:
reset:                ; Resets drive

    xor ax, ax         ; AH = 0 = Reset diskdrive
    int 0x13
    jc reset          ; If carry flag was set, try again

    mov ax, 0x9fc0     ; When we read the sector, we are going to read to
                      ;    address 0x055e:0x0000 (phys address 0x07e00)
                      ;    right after the bootloader in memory
    mov es, ax         ; Set ES with 0x07e0
    xor bx, bx         ; Offset to read sector to

load:
    mov ah, 0x2        ; 2 = Read drive
    mov al, 0x1        ; Reading one sector (one sector is 512 bytes)
    mov ch, 0x0        ; Track (Cylinder) 1
    mov cl, 0x5        ; Sector 5
    mov dh, 0x0        ; Head 1
    int 0x13
    jc load         ; If carry flag was set, try again


    jmp 0x9fe0:0x0000


    mov si, msg_hello
    call printStr

    jmp kernelLoop
