;TASK 1: plot one   blue vertical line, and another horizontal line
 ;making a + shape.
dosseg
.model small
.stack 100h
.data
.code
main:
    mov ax, @data
    mov ds, ax

    ; قراءة وضع الفيديو الحالي وحفظه في المكدس
    mov ah, 0FH
    int 10h
    push ax

    ; تعيين وضع الفيديو إلى 640x480 مع 16 لونًا
    mov ah, 00h
    mov al, 12h
    int 10h

    ; رسم الخط العمودي الأزرق
    mov cx, 320      ; منتصف الشاشة على المحور X
    mov dx, 200      ; بداية الخط على المحور Y
    mov al, 01H      ; اللون الأزرق
    mov ah, 0CH      ; وظيفة رسم البكسل

vertical_line:
    int 10h          ; رسم البكسل
    inc dx           ; زيادة قيمة Y للانتقال إلى البكسل التالي
    cmp dx, 280      ; مقارنة مع نهاية الخط
    jnz vertical_line ; إذا لم نصل إلى النهاية، نستمر في الرسم

    ; رسم الخط الأفقي الأحمر
    mov cx, 270      ; بداية الخط على المحور X
    mov dx, 240      ; منتصف الشاشة على المحور Y
    mov al, 04H      ; اللون الأحمر
    mov ah, 0CH      ; وظيفة رسم البكسل

horizontal_line:
    int 10h          ; رسم البكسل
    inc cx           ; زيادة قيمة X للانتقال إلى البكسل التالي
    cmp cx, 370      ; مقارنة مع نهاية الخط
    jnz horizontal_line ; إذا لم نصل إلى النهاية، نستمر في الرسم

    ; انتظار ضغط مفتاح من المستخدم
    mov ah, 1
    int 21h

    ; استعادة وضع الفيديو الأصلي
    pop ax
    mov ah, 00h
    int 10h

    ; إنهاء البرنامج
    mov ah, 4Ch
    int 21h
end main