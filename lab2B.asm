;ALP to convert a read a small letter from the keyboard to a capital letter and print it on the screen
  dosseg
.model small
.data
msg1 db "Enter a lowercase letter : ",13,"$"
msg2 db "The uppercase letter is:",13,"$"
.code

main: 
mov ax,@data
mov ds,ax

mov ah ,9 ; print msg1 to the screen
mov dx, offset msg1
int 21h 

mov ah,1
int 21h;reed from the screen

 
mov bl,al  ; stor the value in reg.
sub bl,20h  ; sub 20 from the asci to get the uppercase

mov ah,9
mov dx,offset msg2
int 21h

 mov ah,2
 mov dl,bl
 int  21h

mov ah,4ch
int 21h
end main