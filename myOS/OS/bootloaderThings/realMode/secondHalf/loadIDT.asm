; loadIDT.asm
loadIDT:
        pushad
        cli
        lidt [IDTPoint]
        sti
        popad

IDTStart:

IRQ0:
        dw ISR0
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ1:
        dw ISR1
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ2:
        dw ISR2
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ3:
        dw ISR3
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ4:
        dw ISR4
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ5:
        dw ISR5
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ6:
        dw ISR6
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ7:
        dw ISR7
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ8:
        dw ISR8
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ9:
        dw ISR9
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ10:
        dw ISR10
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ11:
        dw ISR11
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ12:
        dw ISR12
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ13:
        dw ISR13
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ14:
        dw ISR14
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ15:
        dw ISR15
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ16:
        dw ISR16
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ17:
        dw ISR17
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ18:
        dw ISR18
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ19:
        dw ISR19
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ20:
        dw ISR20
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ21:
        dw ISR21
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ22:
        dw ISR22
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ23:
        dw ISR23
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ24:
        dw ISR24
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ25:
        dw ISR25
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ26:
        dw ISR26
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ27:
        dw ISR27
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ28:
        dw ISR28
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ29:
        dw ISR29
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ30:
        dw ISR30
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ31:
        dw ISR31
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ32:
        dw ISR32
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IRQ33:
        dw ISR33
        dw 0x0008
        db 0x00
        db 10101110b
        dw 0x0000

IDTEnd:
 
 
IDTPoint:
        dw IDTEnd - IDTStart - 1
        dw 0x0000
        dw IDTStart
 

ISR0: ; Divide By Zero Exception
        pusha
        push byte 0
        push byte 0

        jmp isr_common_stub
        popa
        iret

ISR1: ; Debug Exception
        pusha
        push byte 0
        push byte 1
        jmp isr_common_stub
        popa
        iret

ISR2:
        pusha
        ; interrupt handler for ISR2
        popa
        iret

ISR3:
        pusha
        ; interrupt handler for ISR3
        popa
        iret

ISR4:
        pusha
        ; interrupt handler for ISR4
        popa
        iret

ISR5:
        pusha
        ; interrupt handler for ISR5
        popa
        iret

ISR6:
        pusha
        ; interrupt handler for ISR6
        popa
        iret

ISR7:
        pusha
        ; interrupt handler for ISR7
        popa
        iret

ISR8:
        pusha
        ; interrupt handler for ISR8
        popa
        iret

ISR9:
        pusha
        ; interrupt handler for ISR9
        popa
        iret

ISR10:
        pusha
        ; interrupt handler for ISR10
        popa
        iret

ISR11:
        pusha
        ; interrupt handler for ISR11
        popa
        iret

ISR12: ; Stack Fault Exception
        pusha
        push byte 12 ; error info pushed by CPU
        jmp isr_common_stub
        popa
        iret

ISR13:
        pusha
        ; interrupt handler for ISR13
        popa
        iret

ISR14:
        pusha
        ; interrupt handler for ISR14
        popa
        iret

ISR15:
        pusha
        ; interrupt handler for ISR15
        popa
        iret

ISR16:
        pusha
        ; interrupt handler for ISR16
        popa
        iret

ISR17:
        pusha
        ; interrupt handler for ISR17
        popa
        iret

ISR18:
        pusha
        ; interrupt handler for ISR18
        popa
        iret

ISR19:
        pusha
        ; interrupt handler for ISR19
        popa
        iret

ISR20:
        pusha
        ; interrupt handler for ISR20
        popa
        iret

ISR21:
        pusha
        ; interrupt handler for ISR21
        popa
        iret

ISR22:
        pusha
        ; interrupt handler for ISR22
        popa
        iret

ISR23:
        pusha
        ; interrupt handler for ISR23
        popa
        iret

ISR24:
        pusha
        ; interrupt handler for ISR24
        popa
        iret

ISR25:
        pusha
        ; interrupt handler for ISR25
        popa
        iret

ISR26:
        pusha
        ; interrupt handler for ISR26
        popa
        iret

ISR27:
        pusha
        ; interrupt handler for ISR27
        popa
        iret

ISR28:
        pusha
        ; interrupt handler for ISR28
        popa
        iret

ISR29:
        pusha
        ; interrupt handler for ISR29
        popa
        iret

ISR30:
        pusha
        ; interrupt handler for ISR30
        popa
        iret

ISR31: ; Reserved
        pusha
        push byte 0
        push byte 31
        jmp isr_common_stub
        popa
        iret
 
ISR32:
        pusha
        ; interrupt handler for ISR32
        popa
        iret
ISR33:
        pusha
        ; interrupt handler for ISR33
        popa
        iret