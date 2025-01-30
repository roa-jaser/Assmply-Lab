  ;ALP that accepts two digits and prints their sum. If the sum is greater than 10, print " greater than 10".

dosseg
 .model small
 .data
 num1 db "please enter a first number :",13,10,"$"
 num2 db  13,10,"please enter a secound number :","$"
 res db  13,10, "the summation is = " ,"$"
 msg db   " greater than 10 ", "$"
 .code 
 main :
 mov ax,@data
 mov ds,ax

 ;read num1
 mov dx,offset num1
 mov ah,9
 int 21h

 mov ah,1
 int 21h

 sub al,30h ;Convert ASCII to integer
 mov bl,al   ; Store first digit in bl


 ;read num2
 mov dx,offset num2
 mov ah,9
 int 21h

 mov ah,1
 int 21h

 sub al,30h
 mov bh,al

 ;get the sum 
 add bl,bh

 ;print the result 
 mov dx,offset res
 mov ah,9
 int 21h

 mov al,bl
 add al, 30h     ; Convert to ASCII
 mov dl, al
 mov ah, 2
 int 21h

   ; Check if sum > 10
   cmp bl,10
   jle end_program ;If sum <= 10, exit

   ; Display "greater than 10" message
   mov dx,offset msg
   mov ah,9 
   int 21h


   end_program:
   mov ah,4ch
   int 21h
 end main