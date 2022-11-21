KLPop:
  pop ax

.loop:
  pop ax

  cmp al, 0 ; if char is 0 jmp to done
  je .done

  mov ah, 0x0E
  int 0x10      ; print out character

  jmp .loop ; else jump back to the top

.done:
  mov si, endline
  call printStr

  mov si, msg_pop
  call printStr

  jmp kernelLoop