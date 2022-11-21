KLHelp:
  mov si, msg_help ; prints the startup message for command help
  call printStr

  jmp kernelLoop