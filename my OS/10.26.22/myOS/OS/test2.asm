%define newline 0x0D, 0x0A
[org 0]   ; add 0 to label addresses
[bits 16]      ; tell the assembler we want 16 bit code

  mov ax, 0  ; set up segments
  mov ds, ax
  mov es, ax
  mov ss, ax     ; setup stack
  mov sp, 0x7C00 ; stack grows downwards from 0x7C00

  ; very importand do not know why
  ; Set DS = CS 
  mov ax, cs
  mov ds, ax

  mov si, welcome
  call print_string

welcome db 'Welcome to My OS!', newline, "hello world", newline, "reminder put this on github", newline, 0
buffer times 64 db 0

; ==========
; calls here
; ==========

print_string:
  lodsb        ; grab a byte from SI

  or al, al  ; logical or AL by itself
  jz .done   ; if the result is zero, get out

  mov ah, 0x0E
  int 0x10      ; otherwise, print out the character!

  jmp print_string

.done:
  ret

; padding
times 512-($-$$) db 0