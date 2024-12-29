;task 2: regenerate the original message from task 1.
.model small
.data
msg1 db "Enter the modified string: ", 10, 13, "$"
msg2 db 100 dup('$')   ; Buffer to store the modified string
msg3 db 100 dup('$')   ; Buffer to store the regenerated original string

.code
main:
    mov ax, @data
    mov ds, ax

    ; Prompt user for input
    mov ah, 9
    mov dx, offset msg1
    int 21h

    ; Input loop
    mov cx, 0
    mov di, offset msg2
    mov si, offset msg3

loop_input:
    mov ah, 1
    int 21h
    cmp al, 13          ; Check for Enter key
    je done_loop
    mov [di], al        ; Store character in msg2
    inc di
    inc cx
    jmp loop_input

done_loop:
    mov byte ptr [di], 0  ; Null terminate the string

    ; Regenerate original message
    mov di, offset msg2
    mov si, offset msg3

loop_regenerate:
    mov al, [di]
    cmp al, 0            ; Check for end of string
    je display_result

    cmp al, 'e'
    je replace_to_a

    cmp al, 'u'
    je replace_to_e

    cmp al, 'a'
    je replace_to_o

    cmp al, 'o'
    je replace_to_u

    jmp store_original

replace_to_a:
    mov al, 'a'
    jmp store_original

replace_to_e:
    mov al, 'e'
    jmp store_original

replace_to_o:
    mov al, 'o'
    jmp store_original

replace_to_u:
    mov al, 'u'

store_original:
    mov [si], al
    inc di
    inc si
    jmp loop_regenerate

display_result:
    mov byte ptr [si], 0 ; Null terminate the result string

    ; Display the regenerated string
    mov ah, 9
    mov dx, offset msg3
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
end main
