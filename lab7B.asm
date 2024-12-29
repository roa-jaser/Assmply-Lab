;task1:allow the user to enter a string. Repreint the string after replacing each voucl letter as follows:
;a -> e
;e-> u
;o -> a u -> o
;My name is eyas My nemu is uyes

 .model small
.data
msg1 db "enter the string", 10, 13, "$"
msg2 dw 100 dup('$')

.code

main:
mov ax,@data
mov ds,ax

mov ah,9
mov dx, offset msg1
int 21h

mov cx,0
mov di, offset msg2

loop1:
mov ah, 1
int 21h
cmp al,13
je done_loop
inc cx

mov bl,al

cmp al,'a'
je replace_a

cmp al,'e'
je replace_e

cmp al,'o'
je replace_o

cmp al,'u'
je replace_u

jmp store_char

replace_a:
mov al,'e'
jmp store_char

replace_e:
mov al,'u'
jmp store_char

replace_o:
mov al,'a'
jmp store_char

replace_u:
mov al,'o'
jmp store_char

store_char:
mov [di],al
inc di

jmp loop1

done_loop: 
mov byte ptr [di],0

mov ah,9
mov dx, offset msg2
int 21h

 
mov ah, 4ch
int 21h
end main