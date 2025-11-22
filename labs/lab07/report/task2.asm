%include 'in_out.asm'

  SECTION .data
   msg1 DB 'Введите a: ',0h
   msg2 DB "Ответ: ",0h
   msg3 DB 'Введите x: ',0h

  SECTION .bss
   a RESB 10
   x RESB 10
   result RESD 1 ; переменная для результата, если ее не добавить,то мы не сможем вывести ответ,так как в противном случае значение будет стираться

  SECTION .text
  global _start
   _start:


; ---------- Вывод сообщения 'Введите a: '
    mov eax,msg1
    CALL sprint

; ---------- Ввод 'a'
    mov ecx,a
    mov edx,10
    CALL sread
; ---------- Преобразование 'a' из символа в число
    mov eax,a
    CALL atoi ; Вызов подпрограммы перевода символа в число
    mov [a],eax ; запись преобразованного числа в 'a'



; ---------- Вывод сообщения 'Введите x: '
    mov eax,msg3
    CALL sprint
; ---------- Ввод 'x'
    mov ecx,x
    mov edx,10
    CALL sread
; ---------- Преобразование 'x' из символа в число
    mov eax,x
    CALL atoi ; Вызов подпрограммы перевода символа в число
    mov [x],eax ; запись преобразованного числа в 'x'


; ---------- Сравниваем 'x' и 'a' (как символы)
   mov eax,[x] ; 'ecx = x'
   cmp eax,[a] ; Сравниваем 'x' и 'a'
   JGE output_8 ; если 'x>=a', то переходим на метку 'output_8',

; Решение уравнения 2*a-x
   mov eax, [a] ; eax = a
   imul eax, 2 ; eax = a*2

   mov ebx, [x] ; ebx = x
   sub eax, ebx ; eax = 2*a-x
   mov [result], eax ; записываем результат уравнения в переменную
   JMP fin

; ---------- Метка output_8
  output_8:
   mov dword [result], 8 ; Записываем в переменную число 8
; ---------- Вывод результата
  fin:
   mov eax, msg2
   CALL sprint ; Вывод сообщения 'Ответ: '
   mov eax, [result] ; Записываем ответ в регистр eax,чтобы вывести ответ на экран
   CALL iprintLF ; Вывод ответа уравнения 2*a-x

   CALL quit ; Выход
