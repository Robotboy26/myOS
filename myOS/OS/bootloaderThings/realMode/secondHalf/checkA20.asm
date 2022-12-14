
checkA20:
  pushf                          ; Save registers that
  push ds                        ; we are going to
  push es                        ; overwrite.
  push di
  push si

  cli                            ; No interrupts, please
  xor ax, ax                     ; Set es:di = 0000:0500
  mov es, ax
  mov di, 0x0500

  mov ax, 0xffff                 ; Set ds:si = ffff:0510
  mov ds, ax
  mov si, 0x0510

  mov al, byte [es:di]       ; Save byte at es:di on stack.
  push ax                        ; (we want to restore it later)
  mov al, byte [ds:si]       ; Save byte at ds:si on stack.
  push ax                        ; (we want to restore it later)

  mov byte [es:di], 0x00     ; [es:di] = 0x00
  mov byte [ds:si], 0xFF     ; [ds:si] = 0xff

  cmp byte [es:di], 0xFF     ; Did memory wrap around?

  pop ax
  mov byte [ds:si], al       ; Restore byte at ds:si

  pop ax
  mov byte [es:di], al       ; Restore byte at es:di

  sti
  mov ax, 0
  je checkA20Exit             ; If memory wrapped around, return 0.

  mov ax, 1                      ; else return 1.

  checkA20Exit:
    pop si                       ; Restore saved registers.
    pop di
    pop es
    pop ds
    popf

    ret