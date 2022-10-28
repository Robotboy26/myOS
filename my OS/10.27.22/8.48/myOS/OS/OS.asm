%define newline 0x0D, 0x0A
[org 0]   ; add 0 to label addresses
[bits 16]      ; tell the assembler we want 16 bit code

  ;stack breaks something testing needed
  ;mov ax, 0  ; set up segments
  ;mov ds, ax
  ;mov es, ax
  ;mov ss, ax     ; setup stack
  ;mov sp, 0x7C00 ; stack grows downwards from 0x7C00

  ; very importand do not know why
  ; Set DS = CS 
  mov ax, cs
  mov ds, ax

  mov si, welcome
  call printStr

mainloop:
  mov si, prompt
  call printStr

  mov di, buffer
  call getString

  mov si, buffer
  cmp byte [si], 0  ; blank line?
  je mainloop       ; yes, ignore it

  mov si, buffer
  mov di, cmd_hello  ; "hello" command
  call strcmp
  jc .helloworld

  mov si, buffer
  mov di, cmd_help  ; "help" command
  call strcmp
  jc .help

  mov si,badcommand
  call printStr 
  jmp mainloop  

.helloworld:
  mov si, msg_helloworld
  call printStr

  jmp mainloop

.help:
  mov si, msg_help
  call printStr

  jmp mainloop

welcome db 'Welcome to My OS!', newline, 'type help to see a list of commands', newline, 0
msg_helloworld db 'Hello World!', newline, 0
badcommand db 'Bad command entered.', newline, 0
prompt db '>', 0
cmd_hello db 'hello', 0
cmd_help db 'help', 0
msg_help db 'My OS: Commands: hello, help', newline, 0
test_str db 'test', 0
buffer times 64 db 0

; ==========
; calls here
; ==========

print_test:
  mov si, test_str ; move str to si register
  call printStr

  ret

strcmp:
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
%include "userInput/getString.asm"

; padding
times 512-($-$$) db 0