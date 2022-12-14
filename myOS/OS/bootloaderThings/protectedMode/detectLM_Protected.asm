;detectLM_Protected
[bits 32]

; Detect Long Mode
detectLM_Protected:
    pushad

    ; Check for CPUID
    ; Read from FLAGS
    pushfd                          ; Copy FLAGS to eax via stack
    pop eax

    ; Save to ecx for comparison later
    mov ecx, eax

    ; Flip the ID bit (21st bit of eax)
    xor eax, 1 << 21

    ; Write to FLAGS
    push eax
    popfd

    ; Read from FLAGS again
    ; Bit will be flipped if CPUID supported
    pushfd
    pop eax

    ; Restore eflags to the older version saved in ecx
    push ecx
    popfd

    ; Perform the comparison
    ; If equal, then the bit got flipped back during copy,
    ; and CPUID is not supported
    cmp eax, ecx
    je cpuidNotFoundProtected        ; Print error and hang if CPUID unsupported


    ; Check for extended functions of CPUID
    mov eax, 0x80000000             ; CPUID argument than 0x80000000
    cpuid                           ; Run the command
    cmp eax, 0x80000001             ; See if result is larger than than 0x80000001
    jb cpuidNotFoundProtected    ; If not, error and hang


    ; Actually check for long mode
    mov eax, 0x80000001             ; Set CPUID argument
    cpuid                           ; Run CPUID
    test edx, 1 << 29               ; See if bit 29 set in edx
    jz LM_NotFoundProtected       ; If it is not, then error and hang
    
    ; Return from the function
    popad
    ret


; Print an error message and hang
cpuidNotFoundProtected:
    call clearProtected
    mov esi, cpuidNotFoundStr
    call printProtected
    jmp $


; Print an error message and hang
LM_NotFoundProtected:
    call clearProtected
    mov esi, LM_NotFoundStr
    call printProtected
    jmp $

LM_NotFoundStr:                   db `ERROR: Long mode not supported. Exiting...`, 0
cpuidNotFoundStr:                db `ERROR: CPUID unsupported, but required for long mode`, 0