; load 'dh' sectors from drive 'dl' into 'es:bx'
disk_load:
    pusha
    ;reading from disk requires setting specific values in all registers
    ; so we will overwrite our input parameters from 'dx'. Let's save it
    ; to the stack for later use.
    push dx                 ; Push 'dx to stack for later

    ; BIOS read section function
    mov ah, 0x02            ; ah <- int 0x13 function 0x02 = read
    mov al, dh              ; al <- number of sectors to read (0x01 .. 0x80)
    
    
    mov cl, 0x02            ; cl <- sector (0x01 .. 0x11)
                            ; 0x01 is our boot sector. 0x02 is the first 'available' sector
    mov ch, 0x00            ; ch <- cylinder (0x0 .. 0x3FF, upper 2 bits in 'cl')                      
                            ; dl <- drive number. Our caller sets it as a parameter
                            ; and gets it from BIOS
                            ; (0 = floppy, 1 = floppy1, 0x80 = hdd, 0x81 = hdd1)
    mov dh, 0x00            ; hd <- head number (0x0 .. 0xF)
    
    ; [es:bx] <- pointer to buffer where the data will be stored
    ; caller sets it up for us, and it is actually the standard location of int 13h
    int 0x13                ; BIOS interrupt
    jc disk_error           ; jump if error flag (error stored in carry bit)

    pop dx
    cmp dh, al              ; BIOS sets al to number of sectors read, Compare it.
    jne sectors_error       ; if AL != DH 
    popa
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    call print_nl
    mov dh, ah              ; ah = error code, dl = disk drive that dropped the error
    call print_hex          ; check out the code at http://stanislavs.org/helppc/int_13-1.html
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_READ_ERROR
    call print_string

disk_loop:
    jmp $

DISK_ERROR_MSG: db "Disk read error", 0
SECTORS_READ_ERROR: db "Incorrect number of sectors read", 0