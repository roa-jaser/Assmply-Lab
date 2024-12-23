;Write an assembly language program that print the sum of A and B , where A and B are two number enetered from the keyboard.
; A, B can be (0-255). If the result is more than 255, display an error message.

 dosseg
.model small
.data
msg1 db "A= ","$"
msg2 db "B= ","$"
numA db ?
numB db ?
sum db  ?
msg3 db "more than 255" ,"$"
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

n1:mov ah,1
int 21h
cmp al,13
je num1
sub al,30h
mov bl,al
mov al,10d
mul cl
add al,bl
mov cl,al
mov numA,al
jmp n1

num1:
mov ax,0
mov bx,0
mov cx,0

;;;;;;;;;;
mov dx,offset msg2
mov ah,9
int 21h

n2:mov ah,1
int 21h
cmp al,13
je num2
sub al,30h
mov bl,al
mov al,10d
mul cl
add al,bl
mov cl,al
mov numB,al
jmp  n2

num2:
 mov al,0
 mov al,numB
 add al,numA
 jc AB
 mov sum,al
 cmp al,255d
 ja AB

 mov ax,0
mov bx,0
mov cx,0

mov al,sum
mov bl,10d
mov cl,0

res1:
div bl
push ax
inc cl
cmp al,0
mov ah,0
jnz res1


 res2:
 pop ax
 mov dl,ah
 add dl,30h

 mov ah,2
 int 21h
 dec cl
 cmp cl,0
 jnz res2
 jmp end_program

 AB:
 mov dx,offset msg3
 mov ah,9
 int 21h

 end_program:
 mov ah,4ch
 int 21h

end main