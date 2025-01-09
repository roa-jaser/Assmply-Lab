;modify the code given in class such that the multi-digit read, and multi digit write are subroutines.
.model small
.stack 100
.data
    msg1 db "Enter a number: ", 10, 13, "$"   ; رسالة الإدخال
    msg2 db "The number is: $", 10, 13        ; رسالة الإخراج
    msg3 db "ERROR: Number too large!", 10, 13, "$" ; رسالة خطأ
    buffer db 100 dup ('$')                   ; مخزن للإدخال
    num dw 0                                  ; لتخزين الرقم إذا كان <= 255

.code
main:
    ; تهيئة segment البيانات
    mov ax, @data
    mov ds, ax

    ; عرض رسالة الإدخال
    mov ah, 9
    mov dx, offset msg1
    int 21h

    ; قراءة الإدخال كسلسلة أحرف
    mov ah, 0Ah
    mov dx, offset buffer
    int 21h

    ; تحويل السلسلة إلى رقم والتحقق من القيمة
    call convert_and_check

    ; إذا كان الرقم <= 255، طباعته كرقم
    cmp word ptr [num], 255
    jbe print_number

    ; إذا كان الرقم > 255، طباعته كسلسلة أحرف
    jmp print_string

print_number:
    ; طباعة الرقم كعدد
    mov ah, 9
    mov dx, offset msg2
    int 21h

    mov ax, [num]
    call print_digit
    jmp ex

print_string:
    ; طباعة الرقم كسلسلة أحرف
    mov ah, 9
    mov dx, offset msg2
    int 21h

    mov dx, offset buffer + 2 ; بداية السلسلة المدخلة
    int 21h
    jmp ex

convert_and_check:
    ; تحويل السلسلة إلى رقم
    mov si, offset buffer + 2 ; بداية السلسلة المدخلة
    mov cx, 0                 ; عداد للأرقام
    mov ax, 0                 ; تخزين الرقم المؤقت

convert_loop:
    mov bl, [si]              ; قراءة حرف من السلسلة
    cmp bl, 13                ; التحقق من نهاية السلسلة (Enter)
    je convert_done

    ; تحويل الحرف إلى رقم
    sub bl, '0'
    mov bh, 0
    mov dx, 10
    mul dx                    ; ضرب الرقم الحالي في 10
    add ax, bx                ; إضافة الرقم الجديد
    inc si                    ; الانتقال إلى الحرف التالي
    inc cx                    ; زيادة العداد
    jmp convert_loop

convert_done:
    ; التحقق من أن الرقم <= 255
    cmp ax, 255
    jbe store_number

    ; إذا كان الرقم > 255، عرض رسالة خطأ
    mov ah, 9
    mov dx, offset msg3
    int 21h
    jmp ex

store_number:
    ; تخزين الرقم في المتغير num
    mov [num], ax
    ret

print_digit:
    ; طباعة الرقم الموجود في AX
    mov bx, 10                ; القسمة على 10
    mov cx, 0                 ; عداد للأرقام

push_digits:
    mov dx, 0
    div bx                    ; تقسيم AX على 10
    push dx                   ; حفظ الباقي (الرقم) في المكدس
    inc cx                    ; زيادة العداد
    cmp ax, 0                 ; التحقق من انتهاء الرقم
    jne push_digits

pop_digits:
    pop dx                    ; استرجاع الرقم من المكدس
    add dl, '0'               ; تحويل الرقم إلى ASCII
    mov ah, 2                 ; عرض الحرف
    int 21h
    loop pop_digits           ; تكرار حتى تنتهي الأرقام
    ret

ex:
    ; إنهاء البرنامج
    mov ah, 4Ch
    int 21h

end main