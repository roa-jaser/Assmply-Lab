//Write an assembly language program to trace 4 arithmatic and 4 logical instructions of your choice
dosseg
.model small
.data
.code

main:
;arithmetic instractions
mov ax,@data
mov bx,ax
mov ax,3Fh
add ax,24h

mov bx,12h
sub bx,120h

mov cx,48h
mov dx,23h
mul dx

mov ax,10h
mov bx,78h
div bx

;logical instractions
 mov ax,1011
 and ax,1001

 mov bx,1011
 or  bx,1000

 mov cx,1100
 xor cx,1010

 mov dx,1010
 not dx

mov ah,4ch
int 21h
end main