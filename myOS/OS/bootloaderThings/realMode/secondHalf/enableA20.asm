
enableA20:
    call checkA20
    cmp ax, 1
    je A20Enabled

    mov ax, 0x2401 ; try to enable useing bios
    int 0x15

    call checkA20
    cmp ax, 1
    je A20Enabled

    Wait_8042_command:       ; pulling in keyboard controller to start A20 enableing on some computers
      in      al,0x64
      test    al,2
      jnz     Wait_8042_command
      ret

    Wait_8042_data:
      in      al,0x64
      test    al,1
      jz      Wait_8042_data
      ret

    cli                        ; Disable interrupts

    call    Wait_8042_command  ; When controller ready for command
    mov     al,0xAD            ; Send command 0xad (disable keyboard).
    out     0x64,al

    call    Wait_8042_command  ; When controller ready for command
    mov     al,0xD0            ; Send command 0xd0 (read from input)
    out     0x64,al

    call    Wait_8042_data     ; When controller has data ready
    in      al,0x60            ; Read input from keyboard
    push    eax                ; ... and save it

    call    Wait_8042_command  ; When controller is ready for command
    mov     al,0xD1            ; Set command 0xd1 (write to output)
    out     0x64,al            

    call    Wait_8042_command  ; When controller is ready for command
    pop     eax                ; Write input back, with bit #2 set
    or      al,2
    out     0x60,al

    call    Wait_8042_command  ; When controller is ready for command
    mov     al,0xAE            ; Write command 0xae (enable keyboard)
    out     0x64,al

    call    Wait_8042_command  ; Wait until controller is ready for command

    sti                        ; Enable interrupts

    call checkA20
    cmp ax, 1
    je A20Enabled


    ; 3rd way to enable A20 if this dosen't work that we assume that A20 is not enabled on the computer.
    in al, 0x92
    or al, 2
    out 0x92, al


    call checkA20
    cmp ax, 1
    je A20Enabled

    mov bx, msgA20notAvalable
    call printBios
    hlt

    msgA20notAvalable:
      db 'A20 is not Avalable', 0