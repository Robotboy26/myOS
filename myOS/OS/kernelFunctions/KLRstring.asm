KLRstring: ; this command reveses a string that has a start and end zero and is stored by char in the stack
  mov si, msg_rstring
  call printStr

  mov di, buffer

  pop ax ; pop the first one here to skip the first zero
  stosb ; put char in buffer

.loop1:
  pop ax
  stosb ; store char in buffer

  cmp al, 0
  je .done1

  jmp .loop1

.done1:
  mov di, buffer
  mov bl, [di]   ; grab a byte from DI
  mov ax, 0
  mov al, bl
  push ax
  inc di
  jmp .loop2

.loop2:
  mov bl, [di]   ; grab a byte from DI

  mov al, bl
  push ax
  inc di

  cmp bl, 0 ; check if di char == 0 for the end termination
  je .done2

  jmp .loop2

.done2:
  jmp kernelLoop
