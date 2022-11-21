KLPush:
  push 0 ; push the start zero of the string
  mov cl, 0 ; set char counter to zero

.loop:
  mov ah, 0
  int 0x16   ; wait for keypress
  mov bx, ax

  cmp al, 0x08    ; backspace pressed?
  je .backspace   ; yes, handle it

  cmp al, 0x0D  ; enter pressed?
  je .done      ; yes, we're done

  cmp cl, 0x3F  ; 63 chars inputted (you can change the hex number to allow more or to allow less char's)
  je .loop      ; yes, only let in backspace and enter

  mov ah, 0x0E
  int 0x10      ; print out character

  mov ax, bx
  push ax
  inc cl

  jmp .loop

.backspace:
  dec cl
  mov ah, 0x0E
  mov al, 0x08
  int 10h		; backspace on the screen

  mov al, ' '
  int 10h		; blank character out

  mov al, 0x08
  int 10h		; backspace again

  jmp .loop

.done:
  mov si, endline
  call printStr

  mov si, msg_push
  call printStr

  push 0 ; push the zero for the end of the string

  jmp kernelLoop
