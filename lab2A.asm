 ;ALP to enter a character and a number and print the character as many times as the number, including 0 times.
  dosseg
.model small
 

.data
msg1 db "please enter a key ",13,10,"$"
msg2 db "please enter a number ",13,10,"$"

.code
main:
    ; Initialize data segment
    mov ax, @data
    mov ds, ax

    ; Display "please enter a key"
    mov ah, 9
    mov dx, offset msg1
    int 21h

    ; Read a single key and store it in BL
    mov ah, 1
    int 21h
    mov bl, al

    ; Display "please enter a number"
    mov ah, 9
    mov dx, offset msg2
    int 21h

    ; Read a single digit number
    mov ah, 1
    int 21h

    sub al, 30h         ; Convert ASCII to numeric
    xor cx, cx          ; Clear CX register
    mov cl, al          ; Set loop count

    ; Check if the number is zero
    cmp cl, 0
    je end_program       ; If CX = 0, skip the loop

l1:
    ; Print the key (stored in BL)
    mov ah, 2
    mov dl, bl
    int 21h
    loop l1             ; Repeat until CX = 0

end_program:
    ; Exit program
    mov ah, 4Ch
    int 21h
end main