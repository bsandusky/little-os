print_string:
    pusha

; main print routine:
; while (string[i] != 0) { print string[i]; i++ }

start:  
    mov al, [bx]        ; 'bx' is base address for the string
    cmp al, 0           ; compare to 0 for end byte
    je done             ; jump to done if end byte

    mov ah, 0x0e        ; tty
    int 0x10            ; interrupt
    
    add bx, 1           ; go to next memory address in bx
    jmp start           ; loop

done:
    popa
    ret

print_nl:
    pusha

    mov ah, 0x0e
    mov al, 0x0a        ; newline char
    int 0x10
    mov al, 0x0d        ; carriage return
    int 0x10

    popa
    ret