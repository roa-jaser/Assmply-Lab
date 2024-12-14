;Determine if the number is even or odd.
dosseg
.model small
.data
msg db "enter a num:",13,10,"$"
msg2 db 13,10,"even num",13,10,"$"
msg3 db 13,10,"odd num",13,10,"$"
.code

main:
mov ax,@data
mov ds,ax

mov ah,9
mov dx, offset msg
int 21h

mov ah,1
int 21h

and al,01h
jnz odd
mov ah,9
mov dx, offset msg2
int 21h
jmp end_pro

odd:
mov ah,9
mov dx, offset msg3
int 21h

end_pro:
mov ah,4ch
int 21h
end main