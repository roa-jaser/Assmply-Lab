   ; allow the user to enter some numbers "with validation" terminated by Enter.
	;example: 134259354  print the maximum digit entered.

   dosseg
.model small
.stack 100h

.data
msg db "Enter a sequence of numbers (digits only, end with Enter): $"
result_msg db 10, 13, "The largest number is: $"

.code
main:
    mov ax, @data
    mov ds, ax

    ; --- Display prompt message ---
    mov dx, offset msg
    mov ah, 9
    int 21h

    ; --- Initialize largest number ---
    mov ah, 1           ; Prepare to read a character
    int 21h             ; Read first character
    sub al, '0'         ; Convert from ASCII to integer
    mov bl, al          ; Store first number as the largest so far

read_loop:
    mov ah, 1           ; Read next character
    int 21h
    cmp al, 0Dh         ; Check if Enter (carriage return) is pressed
    je display_result   ; If yes, stop processing

    sub al, '0'         ; Convert from ASCII to integer
    cmp al, bl          ; Compare with the largest number
    jle read_loop       ; If current number is smaller, continue
    mov bl, al          ; Update the largest number

    jmp read_loop       ; Continue reading characters

display_result:
    ; --- Display result message ---
    mov dx, offset result_msg
    mov ah, 9
    int 21h

    ; --- Convert largest number to ASCII ---
    add bl, '0'         ; Convert integer back to ASCII
    mov dl, bl          ; Load largest number into DL
    mov ah, 2           ; Display single character
    int 21h

    ; --- Exit program ---
    mov ah, 4Ch
    int 21h
end main
