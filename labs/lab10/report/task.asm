;--------------------------------
; Программа для записи имени в файл
;--------------------------------
%include 'in_out.asm'
SECTION .data
filename db 'name.txt', 0h        ; Имя файла
msg_prompt db 'Как Вас зовут? ', 0h ; Приглашение для ввода
msg_intro db 'Меня зовут ', 0h    ; Вступительное сообщение
SECTION .bss
name_input resb 255               ; переменная для введенного имени
SECTION .text
global _start
_start:
    ; --- Вывод приглашения "Как Вас зовут?"
    mov eax, msg_prompt
    call sprint
    
    ; --- Ввод фамилии и имени с клавиатуры
    mov ecx, name_input
    mov edx, 255
    call sread
    
    ; --- Создание нового файла name.txt
    ; Права доступа: 0644 (владелец: rw-, группа: r--, остальные: r--)
    mov eax, 5
    mov ebx, filename   ; имя файла
    mov ecx, 577
    mov edx, 0644h      ; права доступа (octal 644)
    int 80h

    ; --- Сохранение дескриптора файла
    mov esi, eax

    ; --- Запись строки "Меня зовут " в файл
    mov eax, msg_intro
    call slen           ; вычисляем длину строки
    mov edx, eax        ; длина строки
    mov ecx, msg_intro  ; указатель на строку
    mov ebx, esi        ; дескриптор файла
    mov eax, 4          ; sys_write
    int 80h

    ; --- Запись введенного имени в файл
    mov eax, name_input
    call slen           ; вычисляем длину введенного имени
    mov edx, eax        ; длина строки
    mov ecx, name_input ; указатель на строку
    mov ebx, esi        ; дескриптор файла
    mov eax, 4          ; sys_write
    int 80h

    ; --- Закрытие файла
    mov ebx, esi        ; дескриптор файла
    mov eax, 6          ; sys_close
    int 80h

    ; --- Успешное завершение программы
    call quit

