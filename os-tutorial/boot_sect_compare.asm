mov bx, 50          ; set bx to value

cmp bx, 4           ; compare bx to 4
jle first_block     ; if bx<=4, jump to first_block

cmp bx, 40          ; compare bx to 40
jl second_block     ; if bx < 40, jump to second_block

jmp third_block     ; if neither case, jump to third_block

first_block:
    mov al, 'A'     ; set al to 'A'
    jmp the_end     ; jump to the_end

second_block:
    mov al, 'B'     ; set al to 'B'
    jmp the_end     ; jump to the_end

third_block:    
    mov al, 'C'     ; set al to 'C'

the_end:
    mov ah, 0x0e    ; tty
    int 0x10        ; screen interrupt to print value of al

    jmp $           ; infinite loop

    times 510-($-$$) db 0   ; 512 byte padding
    dw 0xaa55       ; magic number
