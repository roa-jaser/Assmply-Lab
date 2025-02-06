
; رسم خط عمودي وخطيين افقيات 
dosseg
.model small
.stack 100h
.data
.code
main:
    mov ax, @data
    mov ds, ax

    mov ah, 0FH
    int 10h
    push ax

    mov ah, 00h
    mov al, 12h
    int 10h

    mov cx, 320
    mov dx, 170
    mov al, 02H
    mov ah, 0CH

v_green:
    int 10h
    inc dx
    cmp dx, 320
    jnz v_green 

    mov cx, 270
    mov dx, 220
    mov al, 01H
    mov ah, 0CH

h_blue:
    int 10h
    inc cx
    cmp cx, 370
    jnz h_blue

    mov cx, 300
    mov dx, 280
    mov al, 04H
    mov ah, 0CH

h_red:
    int 10h
    inc cx
    cmp cx, 340
    jnz h_red

    mov ah, 1
    int 21h

    pop ax
    mov ah, 00h
    int 10h

    mov ah, 4Ch
    int 21h
end main
