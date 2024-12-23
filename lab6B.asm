;Print the calculated area of a triabgle with base B and hight H. Both base and hight are obtained from the user.
; Print an error message of the area is greater than 255.

  dosseg
 .model small
 .data
 msg1 db "base=","$"
 msg2 db "higth=","$"
 msg3 db "more than 255","$"
 area db ?
 .code 
 main:
 mov ax,@data
 mov ds,ax

 mov ax,0
 mov bx,0
 mov cx,0

 mov dx,offset msg1
 mov ah,9
 int 21h

 n1:
 mov ah,1
 int 21h
 cmp al,13
 je num1
 sub al,30h
 mov bl,al
 mov al,10d
 mul cl
 add al,bl
 mov cl,al
 jmp n1

 num1:
 mov ax,0
 mov al,cl
 mov bl,2
 div bl
 mov cl,al

  mov dx,offset msg2
 mov ah,9
 int 21h

 mov dx,0
 n2:
 mov ah,1
 int 21h
 cmp al,13
 je num2
 sub al,30h

 mov bl,al
 mov al,10d
 mul dl
 mov dl,al
add dl,bl
jmp n2

num2:
mov ax,0
mov al,dl
mul cl
jc AB
mov area,al
cmp al,255d
ja AB 
mov ax,0
mov bx,0
mov bh,10
mov al,area
mov cl,0

res1:
div bh
push ax
inc cl
cmp al,0
mov ah,0
jnz res1

res2:
pop  ax
mov dl,ah
add dl,30h
mov ah,2
int 21h
dec cl
cmp cl,0
jnz res2
jmp ex

AB:
mov dx,offset msg3
mov ah,9
int 21h

ex:
mov ah,4ch
int 21h

 end main