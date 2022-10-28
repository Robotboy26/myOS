%define newline 0x0D, 0x0A
[org 0]   ; add 0 to label addresses
[bits 16]      ; tell the assembler we want 16 bit code

  ;stack breaks something testing needed!
  ;mov ax, 0  ; set up segments
  ;mov ds, ax
  ;mov es, ax
  ;mov ss, ax     ; setup stack
  mov sp, 0x7C00 ; stack grows downwards from 0x7C00

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
  call strCmp
  jc .helloworld

  mov si, buffer
  mov di, cmd_help  ; "help" command
  call strCmp
  jc .help

  mov si, buffer
  mov di, cmd_push  ; "push" command
  call strCmp
  jc .push

  mov si, buffer
  mov di, cmd_pop  ; "pop" command
  call strCmp
  jc .pop

  mov si,badcommand
  call printStr 
  jmp mainloop  

.helloworld:
  mov si, msg_helloworld; prints the startup message for command hello
  call printStr

  jmp mainloop

.help:
  mov si, msg_help ; prints the startup message for command help
  call printStr

  jmp mainloop

.push:

  call getString

  

  push buffer ; push buffer to the stack to be piched up later

  mov si, msg_push ; prints the message for command push
  call printStr

  jmp mainloop

.pop:
  mov si, msg_pop ; prints the startup message for command pop
  call printStr

  pop si          ; get the most recent thing pushed to stack and puts it in the SI register
  call printStr
  mov si, endline ; move and prints endline so that you get the pop string on one line
  call printStr

  jmp mainloop

welcome db 'Welcome to My OS!', newline, 'type help to see a list of commands', newline, 0
msg_helloworld db 'Hello World!', newline, 0
badcommand db 'Bad command entered.', newline, 0
prompt db '>', 0
cmd_hello db 'hello', 0
cmd_help db 'help', 0
cmd_push db 'push', 0
cmd_pop db 'pop', 0
msg_help db 'My OS: Commands: hello, help, push, pop', newline, 0
msg_push db 'pushed buffer string', newline, 0
msg_pop db 'poped buffer string', newline, 0
test_str db 'test', newline, 0
endline db newline, 0
buffer times 64 db 0

; ==========
; calls here
; ==========




; =====================
; include files go here
; =====================

%include "debug/print_test.asm"
%include "stringStuff/printStr.asm"
%include "stringStuff/strCmp.asm"
%include "userInput/getString.asm"

; padding
times 1024-($-$$) db 0