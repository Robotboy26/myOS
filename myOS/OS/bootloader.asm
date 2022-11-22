%xdefine PML4_BASE  0x70000     ; Address of PML4-table.
%xdefine CR0_PE     1 << 0
%xdefine CR0_PG     1 << 31
%xdefine CR4_PAE    1 << 5
%xdefine CR4_PGE    1 << 7
%xdefine EFER_LME   1 << 8

mov  eax, CR4_PAE | CR4_PGE     ; Set PAE- (Physical Address Extensions) and
mov  cr4, eax                   ;   PGE- (Page Global Enable).
mov  eax, PML4_BASE             ; Address of PML4.
mov  cr3, eax                   ; Point CR3 to PML4.
mov  ecx, 0xC0000080            ; EFER MSR selector.
rdmsr                           ; Read from model specific register.
or   eax, EFER_LME              ; Set LME (Long Mode Enable).
wrmsr                           ; Write to model specific register.
mov  ebx, cr0                   ; Get CR0.
or   ebx, CR0_PG | CR0_PE       ; Set PG (Paging) and PE (Protection Enabled).
mov  cr0, ebx                   ; Set flags to CR0.
lgdt [GDT.ptr]                  ; Load global descriptor table.
jmp  GDT.code_0:long_mode_entry ; Jump to long mode.
