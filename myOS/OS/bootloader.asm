; Bootloader
[org 0x7C00] ; Set Program Origin
[bits 16] ; 16-bit Mode

; Initialize the base pointer and the stack pointer
; The initial values should be fine for what we've done so far,
; but it's better to do it explicitly
mov bp, 0x0500
mov sp, bp

; Before we do anything else, we want to save the ID of the boot
; drive, which the BIOS stores in register dl. We can offload this
; to a specific location in memory
mov byte[bootDrive], dl

; Print Message
mov bx, msgHelloWorld
call printBios

; Load the next sector

; The first sector's already been loaded, so we start with the second sector
; of the drive. Note: Only bl will be used
mov bx, 0x0002

; Now we want to load 5 sectors for the bootloader and kernel
mov cx, 0x0005

; Finally, we want to store the new sector immediately after the first
; loaded sector, at adress 0x7E00. This will help a lot with jumping between
; different sectors of the bootloader.
mov dx, 0x7E00

; Now we're fine to load the new sectors
call loadBios

; Elevate our CPU to 32-bit mode
call elevateBios

; Infinite Loop
bootsectorHold:
jmp $               ; Infinite loop

; INCLUDES
%include "bootloaderThings/realMode/elevateBios.asm"
%include "bootloaderThings/realMode/GDT_32_start.asm"
%include "bootloaderThings/realMode/loadBios.asm"
%include "bootloaderThings/realMode/printBios.asm"
%include "bootloaderThings/realMode/printHexBios.asm"

; DATA STORAGE AREA

; String Message
msgHelloWorld:                db `\r\nHello World, from the BIOS!\r\n`, 0

; Boot drive storage
bootDrive:                     db 0x00

; boot sector padding
times 510 - ($ - $$) db 0x00

; Magic bootloader number
dw 0xAA55


; BEGIN SECOND SECTOR. THIS ONE CONTAINS 32-BIT CODE ONLY

bootsectorExtended:
; check and possible enable A20
; INCLUDES
%include "bootloaderThings/realMode/secondHalf/checkA20.asm"
%include "bootloaderThings/realMode/secondHalf/enableA20.asm"
%include "bootloaderThings/realMode/secondHalf/loadIDT.asm"


call enableA20
A20Enabled:

call loadIDT

beginProtected:

[bits 32]

; Clear vga memory output
call clearProtected

; Detect long mode
; This function will return if there's no error
call detectLM_Protected

; Test VGA-style print function
mov esi, protectedAlert
call printProtected

; Initialize the page table
call initPT_Protected

call elevateProtected

jmp $       ; Infinite Loop

; INCLUDE protected-mode functions
%include "bootloaderThings/protectedMode/clearProtected.asm"
%include "bootloaderThings/protectedMode/detectLM_Protected.asm"
%include "bootloaderThings/protectedMode/elevateProtected.asm"
%include "bootloaderThings/protectedMode/GDT.asm"
%include "bootloaderThings/protectedMode/initPT_Protected.asm"
%include "bootloaderThings/protectedMode/printProtected.asm"

; Define necessary constants
vgaStart:                  equ 0x000B8000
vgaExtent:                 equ 80 * 25 * 2             ; VGA Memory is 80 chars wide by 25 chars tall (one char is 2 bytes)
styleWB:                   equ 0x0F

; Define messages
protectedAlert:                 db '64-bit long mode supported', 0

; Fill with zeros to the end of the sector
times 1024 - ($ - bootsectorExtended) db 0x00
beginLongMode:

[bits 64]


mov rdi, styleBlue
call clearLong

;mov rdi, styleBlue ; bootloader text string style
;mov rsi, longModeNote ; bootloader test string
;call printLong ; print bootloader test string

call kernelStart

jmp $

%include "bootloaderThings/longMode/clearLong.asm"
%include "bootloaderThings/longMode/printLong.asm"

kernelStart:                   equ 0x8400
longModeNote:                 db `Now running in fully-enabled, 64-bit long mode!`, 0
longModeNote2:                db `Now I am here`, 0
styleBlue:                    equ 0x1F

times 512 - ($ - beginLongMode) db 0x00