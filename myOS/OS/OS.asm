[ORG 0]
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

welcome db 'welcome to my OS', 0

;######################
;import functions files
;######################

%include "bootloaderThings/stringStuff/printStr.asm"

times 2048 -($-$$) db 0