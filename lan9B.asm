;Allow the user to enter a min and max value of x. Both cannot exceed 80.
; Print all values of x, and for eacj its corresponding y value, where y=3x.
 .model small
.stack 100
.data
    msg1 db "Enter the min num x: ", 10, 13, "$"
    newline db 10, 13, "$"
    msg2 db "Enter the max num x: ", 10, 13, "$"
    value_before db "The value of x: ", 10, 13, "$"
    value_after db "The value of y=3x: ", 10, 13, "$"
    msg3 db "ERROR ", 10, 13, "$"
    minx db ?
    maxx db ?
    num db ?

.code
main:
    mov ax, @data
    mov ds, ax

    ; Read minimum value of x
    mov ah, 9
    mov dx, offset msg1
    int 21h
    call reads
    cmp num, 80
    ja err1
    mov al, num
    mov minx, al

    ; Print newline
    mov ah, 9
    mov dx, offset newline
    int 21h

    ; Read maximum value of x
    mov ah, 9
    mov dx, offset msg2
    int 21h
    call reads
    cmp num, 80
    ja err1
    mov al, num
    mov maxx, al

    ; Loop to print values from minx to maxx
    mov bl, minx
ag5:
    call print
    inc minx
    mov bl, minx
    cmp bl, maxx
    jbe ag5

    jmp ex

err1:
    ; Display error message
    mov ah, 9
    mov dx, offset msg3
    int 21h
    jmp ex

print:
    ; Print the value of x
    mov ah, 9
    mov dx, offset value_before
    int 21h

    mov num, bl
    call writes

    ; Print newline
    mov ah, 9
    mov dx, offset newline
    int 21h

    ; Print the value of y=3x
    mov ah, 9
    mov dx, offset value_after
    int 21h

    mov cl, 3
    mov al, num
    mul cl
    mov num, al
    call writes

    ; Print newline
    mov ah, 9
    mov dx, offset newline
    int 21h

    ret

reads:
    ; Read a multi-digit number
    mov ax, 0
    mov bx, 0
    mov cx, 0
    mov num, 0
ag:
    mov ah, 1
    int 21h
    cmp al, 13
    je re
    sub al, 30h
    mov bh, al
    mov al, 10
    mul cl
    add al, bh
    mov cl, al
    mov num, al
    jmp ag
re:
    ret

writes:
    ; Write a multi-digit number
    mov ax, 0
    mov bx, 0
    mov cx, 0
    mov dx, 0
    mov bl, 10
    mov al, num
    mov cl, 0

ag1:
    div bl
    push ax
    inc cl
    cmp al, 0
    mov ah, 0
    jnz ag1

ag2:
    pop ax
    mov dl, ah
    add dl, 30h
    mov ah, 2
    int 21h
    dec cl
    cmp cl, 0
    jnz ag2
    ret

ex:
    ; Exit program
    mov ah, 4Ch
    int 21h

end main