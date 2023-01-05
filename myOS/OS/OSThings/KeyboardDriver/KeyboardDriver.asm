; KeyboardDriver.asm
%define IDTSize 256
%define KernelCodeSegmentOffset 0x8
%define IDTInteruptGate_32_Bit 0x8E
%define PIC_1_CommandPort 0x20
%define PIC_1_DataPort 0x21
%define PIC_2_CommandPort 0xA0
%define PIC_1_DataPort 0xA1
%define KeyboardDataPort 0x60
%define KeyboardStatusPort 0x64
