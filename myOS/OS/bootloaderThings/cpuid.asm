DetectCPUID:
    pushfd
    pop eax

    mov ecx, eax

    xor eax, 1 << 21

    push eax
    popfd

    pushfd
    pop eax

    push ecx
    popfd

    xor eax, ecx
    jz NoCPUID

    ret

DetectLongMode:
    mov eax, 0x80000001
    CPUID
    test edx, 1 << 29
    jz NoLongMode
    ret

NoLongMode:
    hlt ; no 64 bit support

NoCPUID:
    hlt ; no CPUID support