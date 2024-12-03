 ;ALP that reads a character and a number. It prints the alphabet starting from the character a number of times equal to the number.
 ;example a 3 => a b c

  dosseg
.model small
.data
msg1 db "Enter one character: $"
msg2 db 10,13,"Enter a number: $"
msg3 db 10,13,"Result: $"
newline db 10,13,"$"
.code
main:
    mov ax, @data
    mov ds, ax

    mov ah, 9
    mov dx, offset msg1
    int 21h

    mov ah, 1
    int 21h
    mov bl, al

    mov ah, 9
    mov dx, offset msg2
    int 21h

    mov ah, 1
    int 21h
    
    sub al, '0'
    mov cl, al

    mov ah, 9
    mov dx, offset msg3
    int 21h

newl:
    mov ah, 2
    mov dl, bl
    int 21h

    inc bl
    dec cl
    jnz newl

    mov ah, 4ch
    int 21h
end main