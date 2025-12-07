%include 'in_out.asm'

SECTION .data
   func_msg db "Функция: f(x)=2x+15", 10, 0
   msg db "Результат: ",0

SECTION .text
global _start

_start:
   pop ecx           ; Извлекаем количество аргументов
   pop edx           ; Извлекаем имя программы
   sub ecx,1         ; Уменьшаем на 1 (без имени программы)
   mov esi, 0        ; Начальное значение суммы

   ; Выводим сообщение о функции
   mov eax, func_msg
   call sprint

next:
   cmp ecx,0h
   jz _end
   pop eax
   call atoi         ; Преобразуем аргумент в число
   call _calculate_fx ; Вызываем подпрограмму для вычисления f(x)
   add esi, eax      ; Суммируем результат
   loop next

_end:
   mov eax, msg
   call sprint
   mov eax, esi
   call iprintLF
   call quit

; Подпрограмма для вычисления f(x) = 2x + 15
; Вход: eax = x
; Выход: eax = f(x) = 2x + 15
_calculate_fx:
   push ebx           ; Сохраняем ebx (регистр вызывающего)
   mov ebx, eax       ; ebx = x
   shl ebx, 1         ; ebx = 2x
   add ebx, 15        ; ebx = 2x + 15
   mov eax, ebx       ; eax = результат
   pop ebx            ; Восстанавливаем ebx
   ret                ; Возврат в основную программу
