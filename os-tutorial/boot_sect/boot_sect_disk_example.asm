mov ah, 0x02            ; BIOS read section function

mov dl, 0               ; Read drive 0 (first 0-indexed floppy)
mov ch, 3               ; Select cylinder 3
mov dh, 1               ; Select the track on 2nd side of the floppy (Sides are 0-indexed)
mov cl, 4               ; Select the 4th sector on the track (this is 1-indexed)
mov al, 5               ; Read 5 sectors from the start point


; Set address to read to
; BIOS expects to find in ES:BX
mov bx, 0xa000          ; Indirectly set ES
mov es, bx
mov bx, 0x1234          ; Set BX to 0x1234

int 0x13                ; Interrupt BIOS to complete action

jc disk_error           ; jump if error flag

cmp al, <no. sectors expected>
jne disk_error

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

DISK_ERROR_MSG: db "Disk read error", 0