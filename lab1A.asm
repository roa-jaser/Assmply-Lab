//Write an Assembly language program to set all flags
dosseg
.model small
.data
.code
main:
mov ax,@data
mov ds,ax

mov ax,0fffh
push ax
popf

mov ah,4ch
int 21h
end main 
end 