; todo:
; - [x] fix mod op
; - [x] make it print FizzBuzz
; - [ ] print counter instead of "Neit"
; - [x] println instead of print


section .data
    fizz db "Fizz", 0x0a
    buzz db "Buzz", 0x0a
    newline db 0x0a

section .text
    global _start

_start:
    mov ebx, 0      ; prime counter with 1
    call loop
    call exit

loop:
    inc ebx         ; count +1 in rax

    mov eax, ebx    ; temp store ebx
    sub eax, 25     ; check if eax has counted to X
    je exit         ; exit if so

    mov eax, ebx    ; dividend
    mov ecx, 15     ; divisor
    xor edx, edx    ; zero EDX (top half of 'EDX:EAX')
    div ecx         ; div counter by 3
    cmp edx, 0
    je is_both

    mov eax, ebx    ; dividend
    mov ecx, 3      ; divisor
    xor edx, edx    ; zero EDX (top half of 'EDX:EAX')
    div ecx         ; div counter by 3
    cmp edx, 0      ; check remainder
    je is_fizz

    mov eax, ebx    ; dividend
    mov ecx, 5      ; divisor
    xor edx, edx    ; zero EDX
    div ecx         ; div counter by 5
    cmp edx, 0      ; check remainder
    je is_buzz

    call print_int  ; if neither print int
    jmp loop

is_fizz:            ; print fizz
    mov ecx, fizz
    call print
    jmp loop

is_buzz:
    mov ecx, buzz   ; print fizz
    call print
    jmp loop

is_both:
    mov ecx, fizz   ; print fizz
    call print
    mov ecx, buzz   ; print buzz
    call print
    jmp loop

print_int:
    mov eax, ebx   ; store counter
    mov ecx, 10    ; prime div by 10
    div eax

    mov ecx, edx
    add ecx, "0"
    call print

; takes str in ecx
print:
    push ebx                ; save counter value
    mov eax, 4              ; syscall: sys_write
    mov ebx, 1              ; fd: stdout
    mov edx, 5              ; fizz and buzz are both len 4 + nl
    int 0x80                ; call kernel
    pop ebx                 ; restore counter
    ret

; exit(0)
exit:
    mov eax, 1              ; syscall: sys_exit
    mov ebx, 0              ; exit code
    int 0x80
