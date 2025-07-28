section .text
global _start
extern print_hello

_start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax

    mov esi, msg
.print_char:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp .print_char

.done:
    ;call print_hello
    jmp .hang

.hang:
    jmp .hang

msg db "Hello,world!", 0

