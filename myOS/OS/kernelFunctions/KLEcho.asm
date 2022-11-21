KLEcho:
  mov si, prompt_echo
  call printStr

  mov di, buffer
  call getString
  
  mov si, buffer
  call printStr

  mov si, endline
  call printStr

  jmp kernelLoop
