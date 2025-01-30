
;TASK 3: Ask the user to enter any two digit number, then draw a triangle that corresponds to the number (number=base=hight)
model small
.stack 100
.data
msg1 db "Please enter the Number(number=base=hight) of triangle: ", 10, 13, "$"
num dw ? 
.code
main:

mov ax,@data
mov ds, ax

 mov ah, 9
    mov dx, offset msg1
    int 21h

    
    mov bx,0
ag1:
    mov ah,1   
    int 21h
    cmp al,13 
    je ag2
    sub al,30h
    mov cl,al
    mov ax,bx
    mov bh,10
    mul bh
    mov bx,ax
    add bx,cx
   jmp ag1

    ag2:
    mov [num],bx 

    
mov ah, 0fh
int 10h
push ax

mov ah, 00h
mov al, 12h
int 10h

mov cx, 100
add num,100
mov dx, num
mov ax, 0c03h
back: 
int 10h
inc cx
cmp cx,num
jb back

mov cx, 100
mov dx, 100
mov ax, 0c02h
back2: 
int 10h
inc dx
cmp dx,num
jb back2

mov cx, 100
mov dx, 100
mov ax, 0c01h
back1: 
int 10h
inc cx
inc dx
cmp dx,num
jb back1


mov ah, 07h
int 21h

pop ax
mov ah, 00h
int 10h

mov ax, 4c00h
int 21h

end main