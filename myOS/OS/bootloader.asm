[ORG 0x7c00]      ; Bootloader starts at physical address 0x07c00
; start

; setting up the stack
cli     ; Turn off interrupts for SS:SP update
                  ; to avoid a problem with buggy 8088 CPUs
mov ax, 0         ; set up segments
mov ds, ax        ; DS = 0x0000
mov es, ax        ; ES = 0x0000
mov ss, ax        ; SS = 0x0000
mov sp, 0x7c00    ; SP = 0x7c00
                  ; We'll set the stack starting just below
                  ; where the bootloader is at 0x0:0x7c00. The
                  ; stack can be placed anywhere in usable and
                  ; unused RAM.
sti               ; Turn interrupts back on

; very importand do not know why
; Set DS = CS 
mov ax, cs
mov ds, ax

; startup string
mov si, welcome
call printStr

;##############
;define strings
;##############

welcome db 'booting my OS', 0

; read and load the OS into memory
reset:                ; Resets drive

    xor ax, ax         ; AH = 0 = Reset diskdrive
    int 0x13
    jc reset          ; If carry flag was set, try again

    mov ax, 0x07e0     ; When we read the sector, we are going to read to
                    ;    address 0x07e0:0x0000 (phys address 0x07e00)
                    ;    right after the bootloader in memory
    mov es, ax         ; Set ES with 0x07e0
    xor bx, bx         ; Offset to read sector to

load:
    mov ah, 0x2        ; 2 = Read drive
    mov al, 0x4        ; Reading two sector (two sector is 2048 bytes)
    mov ch, 0x0        ; Track (Cylinder) 1
    mov cl, 0x2        ; start reading at svector 2
    mov dh, 0x0        ; Head 1
    int 0x13
    jc load         ; If carry flag was set, try again

    jmp 0x07e0:0x0000 ; Jump to 0x7e0:0x0000 setting CS to 0x07e0
                      ;    IP to 0 which is code in second stage
                      ;    (0x07e0<<4)+0x0000 = 0x07e00 physical address

;######################
;import functions files
;######################

%include "bootloaderThings/stringStuff/printStr.asm"

times 510 - ($ - $$) db 0 ; padding to fill the bootsector up to 512 bytes
dw 0xAA55 ; boot signiture (tells the computer that this is the boot sector)