; todo:
; - [ ] fix mod op
; - [ ] make it print FizzBuzz
; - [ ] print counter instead of "Neit"
; - [ ] println instead of print


section .data
    fizz db "Fizz", 0x0a
    buzz db "Buzz", 0x0a
    neither db "Neit", 0x0a    ; DEBUG, i dont know how to print ints yet

section .text
    global _start

_start:
    mov ebx, 0      ; prime counter with 1
    call loop
    call exit

loop:
    inc ebx         ; count +1 in rax

    mov eax, ebx    ; temp store ecx
    sub eax, 25     ; check if eax has counted to X
    je exit         ; exit if so

    mov eax, ebx    ; dividend
    xor edx, edx    ; zero EDX (required!, # QUESTION: why?)
    mov eax, 3      ; divisor
    div ebx         ; div counter by 3
    cmp edx, 0
    je is_fizz

    mov eax, ebx    ; dividend
    xor edx, edx    ; zero EDX
    mov eax, 5      ; divisor
    div ebx         ; div counter by 5
    cmp edx, 0
    je is_buzz

is_neither:         ; print counter value
    mov ecx, neither
    call print
    jmp loop

is_fizz:            ; print fizz
    mov ecx, fizz
    call print
    jmp loop

is_buzz:
    mov ecx, buzz   ; print fizz
    call print
    jmp loop

; takes str in ecx
print:
    push ebx                ; save counter value
    mov eax, 4              ; syscall: sys_write
    mov ebx, 1              ; fd: stdout
    mov edx, 4              ; fizz and buzz are both len 4
    int 0x80                ; call kernel
    pop ebx                 ; restore counter
    ret

; exit(0)
exit:
    mov eax, 1              ; syscall: sys_exit
    mov ebx, 0              ; exit code
    int 0x80
