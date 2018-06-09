[bits 16]
switch_to_pm:
    cli                     ; suspend interrupts
    lgdt [gdt_descriptor]   ; load the GDT descriptor
    mov eax, cr0            ; set 32-bit mode in cr0
    or eax, 0x1             ; literally change the bit in cr0 to make switch!
    mov cr0, eax

    jmp CODE_SEG:init_pm    ; FAR JUMP! to flush pipeline

[bits 32]
init_pm:                    ; We are now using 32-bit instructions!
    mov ax, DATA_SEG        ; Point segments to GDT
    mov ds, ax              ; update the segment registers to DATA_SEG
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000        ; Set stack position to top of free space
    mov esp, ebp

    call BEGIN_PM           ; Call code to execute