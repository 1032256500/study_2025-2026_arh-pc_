;--------------------------------
; Программа вычисления выражения
;--------------------------------

%include 'in_out.asm' ; подключение внешнего файла
SECTION .data

msg: DB 'Введите значение x: ',0
div: DB 'Результат: ',0

SECTION .bss
x: RESB 80

SECTION .text
GLOBAL _start

_start:
; ---- Вычисление выражения
mov eax, msg
call sprint ;Выводим сообщение о вводе X

mov ecx, x ;Вводим X
mov edx, 80
call sread

mov eax, x
call atoi ;ASCII кода в число, `eax=x`

; Пишем наше выражение
mov ebx, 2 ; EBX=2
mul ebx ; EAX=EAX*EBX = 2*x
add eax, 10 ; EAX=EAX+10 = 2*x + 10
mov ebx, 3 ; EBX = 3
div ebx ; (2*x + 10)/3

mov edi, eax ;Записываем конечный результат выражения в edi

; ---- Вывод результата на экран
mov eax, div
call sprintLF ; Выводим "Результат: " с переводом строки

; ВЫВОД РЕЗУЛЬТАТА (исправленная часть)
mov eax, edi ; Помещаем результат обратно в eax
call iprintLF ; Выводим число из eax с переводом строки

call quit ; вызов подпрограммы завершения
