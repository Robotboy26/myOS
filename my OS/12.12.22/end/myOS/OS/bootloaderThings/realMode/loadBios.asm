; loadBios
[bits 16]

; Define load_sectors
;   Sector start point in bx
;   Number of sectors to read in cx
;   Destination address in dx
loadBios:
    ; Save the registers
    push ax
    push bx
    push cx
    push dx

    ; Save the number of registers to load for later
    push cx

    ; For the ATA Read bios utility, the value of ah must be 0x02
    ; See the BIOS article from Chapter 1.2 for more info
    mov ah, 0x02

    ; The number of sectors to read must be in al, but our function
    ; takes it in cl
    mov al, cl

    ; The sector to read from must be in cl, but our function takes it
    ; in bl
    mov cl, bl

    ; The destination address must be in bx, but our function takes it
    ; in dx
    mov bx, dx

    mov ch, 0x00        ; Cylinder goes in ch
    mov dh, 0x00        ; Cylinder head goes in dh

    ; Store boot drive in dl
    mov dl, byte[bootDrive]

    ; Perform the BIOS disk read
    int 0x13

    ; Check read error
    jc biosDiskError

    ; Pop number of sectors to read
    ; Compare with sectors actually read
    pop bx
    cmp al, bl
    jne biosDiskError

    ; If all goes well, we can now print the success message and return
    mov bx, successMsg
    call printBios

    ; Restore the registers
    pop dx
    pop cx
    pop bx
    pop ax

    ; Return
    ret


biosDiskError:
    ; Print out the error code and hang, since
    ; the program didn't work correctly
    mov bx, errorMsg
    call printBios

    ; The error code is in ah, so shift it down to mask out al
    shr ax, 8
    mov bx, ax
    call printHexBios

    ; Infinite loop to hang
    jmp $

errorMsg:              db `\r\nERROR Loading Sectors. Code: `, 0
successMsg:            db `\r\nAdditional Sectors Loaded Successfully!\r\n`, 0