%include 'in_out.asm' ; подключение внешнего файла in_out.asm

SECTION .data
    msg_a: DB 'Введите значение переменной a: ', 0
    msg_x: DB 'Введите значение переменной x: ', 0
    msg_result: DB 'Результат: ', 0

SECTION .bss
    a RESB 11 ; Размер строки для ввода a
    x RESB 11 ; Размер строки для ввода x
    result RESB 12 ; Для хранения результата

SECTION .text
    GLOBAL _start

_start:
    ; Ввод a
    mov eax, msg_a
    call sprint
    mov ecx, a
    mov edx, 10 ; Максимальная длина
    call sread
    mov eax, a
    call atoi
    mov [a], eax ; Сохраняем a в ebx

    ; Ввод x
    mov eax, msg_x
    call sprint
    mov ecx, x
    mov edx, 10 ; Максимальная длина
    call sread
    mov eax, x
    call atoi
    mov [x], eax ; Сохраняем x в ecx

    ; Проверка x < 5
    mov eax, [x]
    cmp eax, 5
    jl _a_x
    jge _x_5
_x_5:
    mov eax, [x] ; Загружаем a
    sub eax, 5 ; Загружаем 5
    mov ecx, eax ; Переносим результат
    jmp _res

_a_x:
    ; Вычисляем a*x
    mov eax, [x] ; Загружаем a
    mov ebx, [a] ; Загружаем x
    mul ebx ; Умножаем a на x
    jmp _res

_res:
    ; Подготовка результата для вывода
    mov edi, eax ; Результат находится в eax
    mov eax, msg_result
    call sprint ; Вывод строки 'Результат: '
    mov eax, edi
    call iprintLF ; Вывод результата на новой строке

    ; Завершение программы
    call quit
