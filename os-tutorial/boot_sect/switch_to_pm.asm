[bits 16]

switch_to_pm:
    cli                     ; suspend interrupts
    lgdt [gdt_descriptor]

    mov eax, cr0            ; change the bit in CR0 to make switch!
    or eax, 0x1
    mov cr0, eax

    jmp CODE_SEG:init_pm    ; FAR JUMP! to flush pipeline

[bits 32]

init_pm:
    mov ax, DATA_SEG        ; Point segments to GDT
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000        ; Set stack position
    mov esp, ebp

    call BEGIN_PM