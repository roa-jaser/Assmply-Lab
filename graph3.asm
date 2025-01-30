; التحكم في نقطة خضراء حسب الاسهم  الاعلى الاسفل يمسن يسار والخروج من الشاشة بالضغط على ESC
.model small
.stack 100h
.data
    msgExit db 'Exiting Program...', 0
    x dw 320      ; إحداثيات X (منتصف الشاشة)
    y dw 240      ; إحداثيات Y (منتصف الشاشة)
.code
main:
    mov ax, @data
    mov ds, ax

    ; إعداد وضع الفيديو 640x480 مع 16 لونًا
    mov ah, 0
    mov al, 12h
    int 10h

start_program:
    ; رسم النقطة الخضراء في الموقع الحالي
    mov cx, [x]
    mov dx, [y]
    mov al, 02h        ; اللون الأخضر
    mov ah, 0Ch        ; وظيفة رسم البكسل
    int 10h

wait_for_key:
    ; قراءة المفتاح المضغوط
    mov ah, 0
    int 16h

    ; التحقق من مفاتيح الأسهم
    cmp ah, 48h        ; سهم لأعلى
    je move_up
    cmp ah, 50h        ; سهم لأسفل
    je move_down
    cmp ah, 4Bh        ; سهم لليسار
    je move_left
    cmp ah, 4Dh        ; سهم لليمين
    je move_right
    cmp al, 1Bh        ; ESC = 27 (مفتاح الخروج)
    je exit_program
    jmp wait_for_key

move_up:
    ; مسح النقطة القديمة
    call clear_pixel
    dec word ptr [y]   ; تحريك النقطة لأعلى
    cmp word ptr [y], 0 ; التحقق من الحدود
    jge start_program
    inc word ptr [y]   ; التراجع إذا تجاوز الحد
    jmp start_program

move_down:
    ; مسح النقطة القديمة
    call clear_pixel
    inc word ptr [y]   ; تحريك النقطة لأسفل
    cmp word ptr [y], 479 ; التحقق من الحدود
    jle start_program
    dec word ptr [y]   ; التراجع إذا تجاوز الحد
    jmp start_program

move_left:
    ; مسح النقطة القديمة
    call clear_pixel
    dec word ptr [x]   ; تحريك النقطة لليسار
    cmp word ptr [x], 0 ; التحقق من الحدود
    jge start_program
    inc word ptr [x]   ; التراجع إذا تجاوز الحد
    jmp start_program

move_right:
    ; مسح النقطة القديمة
    call clear_pixel
    inc word ptr [x]   ; تحريك النقطة لليمين
    cmp word ptr [x], 639 ; التحقق من الحدود
    jle start_program
    dec word ptr [x]   ; التراجع إذا تجاوز الحد
    jmp start_program

clear_pixel:
    mov cx, [x]
    mov dx, [y]
    mov al, 00h        ; اللون الأسود (مسح النقطة)
    mov ah, 0Ch
    int 10h
    ret

exit_program:
    ; عرض رسالة الخروج
    lea dx, msgExit
    mov ah, 9
    int 21h

    ; استعادة وضع الفيديو الافتراضي
    mov ah, 0
    mov al, 3h
    int 10h

    ; إنهاء البرنامج
    mov ah, 4Ch
    int 21h
end main