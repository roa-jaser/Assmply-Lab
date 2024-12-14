;Ask the user to enter two numbers A and B. Both numbers can be any number of digits. Indicate to the user if:
;A>B, A=B, or A<B.
dosseg
.model small
.stack 100h

.data
    promptA db "Enter number A: $"
    promptB db 13, 10, "Enter number B: $"
    greater_msg db 13, 10, "A > B$"
    equal_msg db 13, 10, "A = B$"
    less_msg db 13, 10, "A < B$"

.code
main:
    mov ax, @data          ; Initialize data segment
    mov ds, ax

    ; Prompt user to enter number A
    mov dx, offset promptA
    mov ah, 9
    int 21h

    ; Read number A
    xor bx, bx             ; Clear BX to store A
read_A:
    mov ah, 1              ; Read character
    int 21h
    cmp al, 13             ; Check for Enter key
    je done_A
    sub al, '0'            ; Convert ASCII to integer
    mov ah, 0              ; Clear AH
    add bx, ax             ; Add the digit to BX
    mov ax, bx             ; Store BX in AX
    mov dx, 10             ; Prepare to multiply by 10
    mul dx                 ; AX = AX * 10
    mov bx, ax             ; Store result in BX
    jmp read_A
done_A:

    ; Prompt user to enter number B
    mov dx, offset promptB
    mov ah, 9
    int 21h

    ; Read number B
    xor cx, cx             ; Clear CX to store B
read_B:
    mov ah, 1              ; Read character
    int 21h
    cmp al, 13             ; Check for Enter key
    je done_B
    sub al, '0'            ; Convert ASCII to integer
    mov ah, 0              ; Clear AH
    add cx, ax             ; Add the digit to CX
    mov ax, cx             ; Store CX in AX
    mov dx, 10             ; Prepare to multiply by 10
    mul dx                 ; AX = AX * 10
    mov cx, ax             ; Store result in CX
    jmp read_B
done_B:

    ; Compare numbers A (BX) and B (CX)
    cmp bx, cx
    ja print_greater       ; If A > B
    je print_equal         ; If A = B
    jb print_less          ; If A < B

print_greater:
    mov dx, offset greater_msg
    mov ah, 9
    int 21h
    jmp end_program

print_equal:
    mov dx, offset equal_msg
    mov ah, 9
    int 21h
    jmp end_program

print_less:
    mov dx, offset less_msg
    mov ah, 9
    int 21h

end_program:
    mov ah, 4Ch            ; Exit program
    int 21h
end main
