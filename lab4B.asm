 
 ;ALP to tell if an enetered character is capital or small
 dosseg
.model small
 
.data
msg1 db "Enter a character: $"
capital_msg db 10, 13, "The character is uppercase (capital).$", 0
small_msg db 10, 13, "The character is lowercase (small).$", 0
not_letter_msg db 10, 13, "The character is not a letter.$", 0

.code
main:
    mov ax, @data
    mov ds, ax

     
    mov dx, offset msg1
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    mov bl, al ; Save the character in BL for later use

    ; Check if the character is uppercase (A-Z)
    cmp bl, 'A'
    jl check_lowercase ; If BL < 'A', check lowercase
    cmp bl, 'Z'
    jg check_lowercase ; If BL > 'Z', check lowercase

    ; If BL is between 'A' and 'Z', it is uppercase
    mov dx, offset capital_msg
    jmp display_message

check_lowercase:
     
    cmp bl, 'a'
    jl not_a_letter ; If BL < 'a', it's not a letter
    cmp bl, 'z'
    jg not_a_letter ; If BL > 'z', it's not a letter

    ; If BL is between 'a' and 'z', it is lowercase
    mov dx, offset small_msg
    jmp display_message

not_a_letter:
    ; If not a letter 
    mov dx, offset not_letter_msg

display_message:
     
    mov ah, 9
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
end main