;task3: write ALP TO encrypt any string enterd by the user by adding 5 to each ascii of the given chracters
; ex: input:abcd   output:  fghi

 .model small
.data
msg1 db "Enter the string to encrypt: ", 10, 13, "$"
msg2 db 100 dup('$')    ; Buffer to store the input string
msg3 db 100 dup('$')    ; Buffer to store the encrypted string

.code
main:
    mov ax, @data
    mov ds, ax

    ; Prompt user to enter a string
    mov ah, 9
    mov dx, offset msg1
    int 21h

    ; Input string
    mov cx, 0
    mov di, offset msg2
    mov si, offset msg3

input_loop:
    mov ah, 1
    int 21h
    cmp al, 13          ; Check if Enter key is pressed
    je end_input
    mov [di], al        ; Store character in msg2
    inc di
    inc cx
    jmp input_loop

end_input:
    mov byte ptr [di], 0 ; Null terminate the input string

    ; Encrypt string
    mov di, offset msg2
    mov si, offset msg3

encrypt_loop:
    mov al, [di]
    cmp al, 0           ; Check for end of string
    je display_result
    add al, 5           ; Add 5 to ASCII value
    mov [si], al        ; Store encrypted character
    inc di
    inc si
    jmp encrypt_loop

display_result:
    mov byte ptr [si], 0 ; Null terminate the encrypted string

    ; Display the encrypted string
    mov ah, 9
    mov dx, offset msg3
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
end main
