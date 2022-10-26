; used a motified version of the code from 'https://stackoverflow.com/questions/39534327/bootloader-not-loading-second-sector'
[bits 16]
[ORG 0x7c00]      ; Bootloader starts at physical address 0x07c00

    ; At start bootloader sets DL to boot drive

    ; Since we specified an ORG(offset) of 0x7c00 we should make sure that
    ; Data Segment (DS) is set accordingly. The DS:Offset that would work
    ; in this case is DS=0 . That would map to segment:offset 0x0000:0x7c00
    ; which is physical memory address (0x0000<<4)+0x7c00 . We can't rely on
    ; DS being set to what we expect upon jumping to our code so we set it
    ; explicitly
    xor ax, ax
    mov ds, ax        ; DS=0

    cli               ; Turn off interrupts for SS:SP update
                      ; to avoid a problem with buggy 8088 CPUs
    mov ss, ax        ; SS = 0x0000
    mov sp, 0x7c00    ; SP = 0x7c00
                      ; We'll set the stack starting just below
                      ; where the bootloader is at 0x0:0x7c00. The
                      ; stack can be placed anywhere in usable and
                      ; unused RAM.
    sti               ; Turn interrupts back on

reset:                ; Resets floppy drive

    xor ax,ax         ; AH = 0 = Reset floppy disk
    int 0x13
    jc reset          ; If carry flag was set, try again

    mov ax,0x07e0     ; When we read the sector, we are going to read to
                      ;    address 0x07e0:0x0000 (phys address 0x07e00)
                      ;    right after the bootloader in memory
    mov es,ax         ; Set ES with 0x07e0
    xor bx,bx         ; Offset to read sector to

load:
    mov ah,0x2        ; 2 = Read drive
    mov al,0x1        ; Reading one sector
    mov ch,0x0        ; Track(Cylinder) 1
    mov cl,0x2        ; Sector 2
    mov dh,0x0        ; Head 1
    int 0x13
    jc load         ; If carry flag was set, try again

    jmp 0x07e0:0x0000 ; Jump to 0x7e0:0x0000 setting CS to 0x07e0
                      ;    IP to 0 which is code in second stage
                      ;    (0x07e0<<4)+0x0000 = 0x07e00 physical address

times 510 - ($ - $$) db 0   ; Fill the rest of sector with 0
dw 0xAA55                   ; This is the boot signature