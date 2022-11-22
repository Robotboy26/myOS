%define newline 0x0D, 0x0A
[org 0]   ; add 0 to label addresses
[bits 16]      ; tell the assembler we want 16 bit code

  ;stack breaks something testing needed!
  mov ax, 0  ; set up segments
  ;mov ds, ax
  ;mov es, ax
  mov ss, ax     ; setup stack
  mov sp, 0x7C00 ; stack grows downwards from 0x7C00

  ; very importand do not know why
  ; Set DS = CS 
  mov ax, cs
  mov ds, ax

  mov si, welcome
  call printStr

;##############
;define strings
;##############

welcome db 'Welcome to My OS!', newline, 'type help to see a list of commands', newline, 0

;######################
;import functions files
;######################

%include "bootloaderThings/stringStuff/printStr.asm"

times 2048 -($-$$) db 0