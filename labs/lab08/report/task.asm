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
   call atoi
   shl eax, 1        ; 2x
   add eax, 15       ; 2x+15
   add esi, eax      ; Суммируем f(x)
   loop next

_end:
   mov eax, msg
   call sprint
   mov eax, esi
   call iprintLF
   call quit
