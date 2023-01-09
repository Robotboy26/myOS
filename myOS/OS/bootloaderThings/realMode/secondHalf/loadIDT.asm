; loadIDT.asm
loadIDT:
  call setupIDT
  lidt [IDT]
  ret

setupIDT:
  mov   ax, 0x0000      ; Have es:di point to 0000:0000
  mov   es, ax
  mov   di, 0
  mov   cx, 2048        ; Write 2048 zeroes
  rep   stosb           ; since the 2048 has 256 entries of 8 bytes.
  ret

IDT:
    dw 2048  ; Size of IDT (256 entries of 8 bytes)
    dd 0x0   ; Linear address of IDT