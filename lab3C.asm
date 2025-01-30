;ALP that print characters from a to z

dosseg
.model small
.data
msg db "all char" ,13,10,"$"
.code
main:
mov ax,@data
mov ds , ax

mov ah,9
mov dx,offset msg
int 21h

mov cx,26
mov dl,'a'
 

l1:
mov ah,2
int 21h

inc dl
loop l1




mov ah,4ch
int 21h
end main