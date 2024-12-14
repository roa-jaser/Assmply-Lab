;ask the user to enter any number. The output should indicate if the number is less,equal or greater than 55
dosseg
.model small
.stack 100h

.data
    prompt db "Enter a number: $"
    less_msg db 13, 10, "The number is less than 55.$"
    equal_msg db 13, 10, "The number is equal to 55.$"
    greater_msg db 13, 10, "The number is greater than 55.$"

.code
main:
    mov ax, @data         ; Initialize the data segment
    mov ds, ax

    ; Display prompt to enter a number
    mov dx, offset prompt
    mov ah, 9
    int 21h

    ; Read the first digit
    mov ah, 1             ; Read a character
    int 21h
    sub al, '0'           ; Convert ASCII to integer
    mov bl, al            ; Store first digit in BL

    ; Read the second digit
    mov ah, 1
    int 21h
    sub al, '0'           ; Convert ASCII to integer
    mov bh, al            ; Store second digit in BH

    ; Calculate the number (tens and ones)
    mov al, bl
    mov cl, 10
    mul cl                ; Multiply by 10
    add al, bh            ; Add the second digit
    mov bl, al            ; Final number in BL

    ; Compare the number with 55
    mov al, 55
    cmp bl, al
    jl less_than_55       ; If less than 55
    je equal_to_55        ; If equal to 55
    jg greater_than_55    ; If greater than 55

less_than_55:
    mov dx, offset less_msg
    mov ah, 9
    int 21h
    jmp end_program

equal_to_55:
    mov dx, offset equal_msg
    mov ah, 9
    int 21h
    jmp end_program

greater_than_55:
    mov dx, offset greater_msg
    mov ah, 9
    int 21h

end_program:
    mov ah, 4Ch           ; Exit program
    int 21h
end main
