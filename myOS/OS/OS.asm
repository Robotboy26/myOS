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

kernelLoop:
  mov si, prompt
  call printStr

  mov di, buffer
  call getString

  mov si, buffer
  cmp byte [si], 0  ; blank line?
  je kernelLoop       ; yes, ignore it

  mov si, buffer
  mov di, cmd_hello  ; "hello" command
  call strCmp
  jc KLHello

  mov si, buffer
  mov di, cmd_help  ; "help" command
  call strCmp
  jc KLHelp

  mov si, buffer
  mov di, cmd_echo  ; "echo" command
  call strCmp
  jc KLEcho

  mov si, buffer
  mov di, cmd_push  ; "push" command
  call strCmp
  jc KLPush

  mov si, buffer
  mov di, cmd_pop  ; "pop" command
  call strCmp
  jc KLPop

  mov si, buffer
  mov di, cmd_rstring ; "rstring" command
  call strCmp
  jc KLRstring

  mov si, buffer
  mov di, cmd_jump ; "jump" command
  call strCmp
  jc .jumps

  mov si, badcommand
  call printStr 
  jmp kernelLoop

.jumps:
  jmp 0x04f00

welcome db 'Welcome to My OS!', newline, 'type help to see a list of commands', newline, 0
msg_hello db 'Hello World!', newline, 0
badcommand db 'Bad command entered.', newline, 0
prompt db '>', 0
prompt_echo db 'type what you want to echo on the line below', newline, 0
cmd_hello db 'hello', 0
cmd_help db 'help', 0
cmd_echo db 'echo', 0
cmd_push db 'push', 0
cmd_pop db 'pop', 0
cmd_rstring db 'rstring', 0
cmd_readSector db 'readSector', 0
cmd_jump db 'jump', 0
msg_help db 'My OS: Commands: hello, help, echo, push, pop, rstring', newline, 0
msg_echo db 'str echoed', newline, 0
msg_push db 'pushed string',newline, 0
msg_pop db 'poped string', newline, 0
msg_rstring db 'reversing string', newline, 0
test_str db 'test', newline, 0
endline db newline, 0
buffer times 64 db 0

; ==========
; calls here
; ==========

; =============================
; include kernel function files
; =============================

%include "kernelFunctions/KLHello.asm"
%include "kernelFunctions/KLHelp.asm"
%include "kernelFunctions/KLEcho.asm"
%include "kernelFunctions/KLPush.asm"
%include "kernelFunctions/KLPop.asm"
%include "kernelFunctions/KLRstring.asm"

; =====================
; include files go here
; =====================

%include "debug/print_test.asm"
%include "stringStuff/printStr.asm"
%include "stringStuff/strCmp.asm"
%include "userInput/getString.asm"


; padding
times 1024-($-$$) db 0