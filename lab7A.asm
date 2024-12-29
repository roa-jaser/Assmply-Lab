 ; example in class 
 dosseg
 .model small
.stack 100h
.data
   msg0 db "please enter your password ",10,13,"$" 
   msg1 db "abcd",13  
   msg2 db 100 dup(?)
   msg3 db "incorect password","$"
   msg4 db "your password is correct ","$"
.code
main :
     
    mov ax, @data
    mov ds, ax

    
    mov dx, offset msg0
    mov ah, 9
    int 21h

     
    mov si, offset msg2
    ag:
    mov ah,7
    int 21h
    mov cl,al
    mov al,"*"
    mov ah,2
    int 21h

    mov al,cl

    mov [si],al
    inc si
    cmp al,13
    jnz ag

    mov si,offset msg2
    mov di,offset msg1

    ag2:
    mov bl,[si]
    cmp [di],bl
    jnz er
    cmp bl,13
    jz cr
    inc si
    inc di
    jmp ag2

    cr:
    mov ah,9
    mov dx,offset msg4
    int 21h
    jmp xt
    
    er:
    mov ah,9
    mov dx,offset msg3
    int 21h

    xt:
    mov ah, 4Ch
    int 21h
 
end main
