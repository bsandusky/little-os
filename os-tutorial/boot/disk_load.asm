
disk_load:

    push dx                 ; Push DX to stack for later

    mov ah, 0x02            ; BIOS read section function
    mov al, dh
    mov ch, 0x00
    mov dh, 0x00
    mov cl, 0x02
    int 0x13             

    jc disk_error           ; jump if error flag

    pop dx
    cmp dh, al
    jne disk_error           ; if AL != DH 
    ret

disk_error:
    
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

DISK_ERROR_MSG: db "Disk read error", 0