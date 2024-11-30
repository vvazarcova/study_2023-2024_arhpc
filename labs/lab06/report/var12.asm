%include 'in_out.asm' ; подключение внешнего файл in_out.asm

SECTION .data
    msg: DB 'Вычисление выражения f(x)=(8*x-6)/2. Введите значение переменной x: ',0 ;
    rem: DB 'Результат: ',0

SECTION .bss
    x: RESB 80 ; Размер строки введеной с клавиатуры - 80 байт

SECTION .text
    GLOBAL _start

_start:
; Вывод строки  'Вычисление выражения f(x)=(8*x-6)/2. Введите значение переменной x: '
    mov eax,msg
    call sprint
; Считывание x
    mov ecx, x
    mov edx, 80 ; Максимальная длина
    call sread
; Вызов подпрограммы преобразования x из ASCII в цел. число
    mov eax,x
    call atoi
; Вычисление выражения
    mov ebx,8 ; ebx=8
    mul ebx ; eax = eax*8
    sub eax, 6  ;eax= eax-6
    mov ebx, 2
    div ebx ; eax=eax/ebx
    mov edi, eax ; Результат вычисления записывается в edi
; Вывод результата на экран
    mov eax,rem
    call sprint ; Вывод строки  'Результат: '
    mov eax,edi
    call iprintLF ; Вывод результата на новой строке
; Вызов подпрограммы завершения программы
    call quit

