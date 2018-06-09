; receiving data in 'dx'
; assume we're called with dx=0x1234

print_hex:
    pusha
    mov cx, 0           ; index variable

; Strategy: get the last char of 'dx', then convert to ASCII
; Numeric ASCII values: 0 (ASCII 0x30) to 9 (ASCII 0x39), so just add 0x20 to the byte N.
; For alphabetic characters A-F: 'A' (ASCII 0x41) to 'F' (ASCII 0x46) we'll add 0x40.
; Then move the ASCII byte to the correct position on the resulting string.
hex_loop:
    cmp cx, 4           ; loop 4 times
    je end

    ; 1. Convert last char of 'dx' to ASCII
    mov ax, dx          ; 'ax' is working register
    and ax, 0x00f       ; 0x1234 -> 0x0004 by asking first three to zeros (bitwise and)
    add al, 0x30        ; add 0x30 to N to convert it to ASCII "N"
    cmp al, 0x39        ; if value > 9, add extra 8 to represent 'A' to 'F' 
    jle step2
    add al, 7           ; 'A' is ASCII 65 instead of 58, so 65-58 = 7

step2:
    ; 2. get the correct position of hte string to place our ASCII char
    ; bx <- base address + string length - index of char
    mov bx, HEX_OUT + 5 ; base + length
    sub bx, cx          ; sub index variable
    mov [bx], al        ; copy ASCII char on al to the position pointed to by 'bx'
    ror dx, 4           ; 0x1234 -> 0x4123 -> 0x3412 -> 0x2341 -> 0x1234

    ; increment and loop
    add cx, 1
    jmp hex_loop

end:
    ; prepare parameter and call the function
    ; print receives in 'bx'
    mov bx, HEX_OUT
    call print_string
    popa
    ret

HEX_OUT:
    db '0x0000', 0 ; reserve memory for our new string