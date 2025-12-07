; файл lab09-1.asm
%include 'in_out.asm'

SECTION .data
   msg: DB 'Введите x: ',0
   result: DB 'f(g(x)): ',0

SECTION .bss
   x: RESB 80
   res: RESB 80

SECTION .text
GLOBAL _start
   _start:
;------------------------------------------
; Основная программа
;------------------------------------------
mov eax, msg
call sprint

mov ecx, x
mov edx, 80
call sread

mov eax,x
call atoi

call _calcul ; Вызов подпрограммы f(g(x))

mov eax,result
call sprint
mov eax,[res]
call iprintLF

call quit

;------------------------------------------
; Подпрограмма вычисления
; выражения f(x) = 2*x + 7 g(x) = 3*x - 1
; Нужно найт f(g(x))

; Подпрограмма f(g(x))
_calcul:
   push eax              ; Сохраняем x в стеке
   call _subcalcul       ; Вычилсяем g(x) = 3*x - 1
	                 ; Результат g(x) теперь в eax
   mov ebx, 2            ; ebx = 2
   mul ebx               ; eax = eax * 2
   add eax, 7            ; eax = eax + 7
   mov [res], eax
   pop ebx               ; Очищаем стек
   ret                   ; выход из подпрограммы


; Подпрограмма g(x) = 3x - 1
_subcalcul:
    mov ebx, 3   ; ebx = 3
    mul ebx      ; eax = eax * 3
    sub eax, 1   ; eax = eax - 1
    ret
