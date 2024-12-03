  ;Specify whether the entry is a number or other character like: 5 number , a other character

dosseg
.model small
.data
msg db "enter any mum/char ",13,10,"$"
msg2 db "number",13,10,"$"
msg3 db " other char",13,10,"$"
.code 

main:
mov ax,@data
mov ds,ax

mov ah,9
mov dx,offset msg
int 21h

mov ah,1
int 21h

mov bl,al 
cmp bl,39h
jg char
cmp bl,30h
jl char

mov ah,9
mov dx,offset msg2
int 21h
jmp end_p
char:
mov ah,9
mov dx,offset msg3
int 21h

end_p:
mov ah,4Ch
int 21h
end main