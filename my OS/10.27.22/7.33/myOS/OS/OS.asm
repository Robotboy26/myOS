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
  call printStr

  call mainloop

mainloop:
  mov si, prompt
  call printStr

  mov di, buffer
  call get_keys

  mov si, buffer
  call printStr
  cmp byte [si], 0  ; blank line?
  ;je mainloop       ; yes, ignore it

  call print_test

  mov si, buffer
  mov di, cmd_hi  ; "hi" command
  call strcmp
  jc .helloworld

  mov si, buffer
  mov di, cmd_help  ; "help" command
  call strcmp
  jc .help

  jmp mainloop

  .helloworld:
    mov si, test_str
    call printStr

    call mainloop

  .help:
    mov si, test_str
    call printStr

    call mainloop

prompt db '>', 0
welcome db 'Welcome to My OS!', newline, "Hello World!!!", newline, 0
test_str db 'this is testing', newline, 0
cmd_hi db 'hi', 0
cmd_help db 'help', 0
buffer times 64 db 0

; ==========
; calls here
; ==========

print_test:
  mov si, test_str ; move str to si register
  call printStr

  ret

get_keys:
  .loop:
    mov ah, 0
    int 0x16   ; wait for keypress

    cmp al, 0x08    ; backspace pressed?
    je .backspace   ; yes, handle it

    cmp al, 0x0D  ; enter pressed?
    je .done      ; yes, we're done

    cmp cl, 0x3F  ; 63 chars inputted?
    je .loop      ; yes, only let in backspace and enter

    mov ah, 0x0E
    int 0x10      ; print out character

    stosb  ; put character in buffer
    inc cl
    jmp .loop

  .backspace:
    cmp cl, 0	; beginning of string?
    je .loop	; yes, ignore the key

    dec di
    mov byte [di], 0	; delete character
    dec cl		; decrement counter as well

    mov ah, 0x0E
    mov al, 0x08
    int 10h		; backspace on the screen

    mov al, ' '
    int 10h		; blank character out

    mov al, 0x08
    int 10h		; backspace again

  jmp .loop	; go to the main loop
 

.done:
  mov al, 0	; null terminator
  stosb

  mov ah, 0x0E
  mov al, 0x0D
  int 0x10
  mov al, 0x0A
  int 0x10		; newline

  ret


strcmp:
  xor cl, cl

  .loop:
    mov al, [si]   ; grab a byte from SI
    mov bl, [di]   ; grab a byte from DI
    cmp al, bl     ; are they equal?
    jne .notequal  ; nope, we're done.

    cmp al, 0  ; are both bytes (they were equal before) null?
    je .done   ; yes, we're done.

    inc di     ; increment DI
    inc si     ; increment SI
    jmp .loop  ; loop!
 
  .notequal:
    clc  ; not equal, clear the carry flag
    ret
 
  .done: 	
    stc  ; equal, set the carry flag
    ret

; =====================
; include files go here
; =====================

%include "stringStuff/printStr.asm"

; padding
times 512-($-$$) db 0