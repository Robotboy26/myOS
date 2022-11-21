KLHello:
  mov si, msg_hello; prints the startup message for command hello
  call printStr

  jmp kernelLoop