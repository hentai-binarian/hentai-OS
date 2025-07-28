section .text
global print_hello

print_hello:
    cli
    xor ax, ax
    mov ds, ax

    mov si, msg
.print_char:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp .print_char

.done:
    ret

section .data
msg db "Hello, Hentai OS!", 0

