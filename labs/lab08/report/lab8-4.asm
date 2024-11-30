%include 'in_out.asm'
SECTION .data
msg db "Результат: ",0
SECTION .text
global _start
_start:
pop ecx    ; кол-в аргументов (первое знач. стека)
pop ebx  ; имя программы (второе знач. в стеке)
sub ecx, 1 ; кол-во аргументов без названия программы (ecx=ecx-1)
mov esi, 0 ; промежуточные суммы
next:
cmp ecx,0h ; проверяем наличие аргументов
jz _end ; если нет, переходим на '_end'
mov edx, 15
pop eax ; извлекаем следующий аргумент из стека
call atoi ; преобразуем в число
mul edx
add eax, 2
add esi,eax ; добавляем к промежуточной сумме
loop next ; переход к обработке следующего аргумента
_end:
mov eax, msg ; вывод сообщения "Результат: "
call sprint
mov eax, esi ; записываем сумму в регистр `eax`
call iprintLF ; печать результата
call quit ; завершение программы

