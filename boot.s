[bits 16]
[org 0x7C00]  ; BIOSがここに読み込む

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    mov ah, 0x02        ; int 13h read sector
    mov al, 10          ; 読み込むセクタ数（必要に応じて増減）
    mov ch, 0           ; シリンダ 0
    mov cl, 2           ; セクタ 2（1はbootloader）
    mov dh, 0           ; ヘッド 0
    mov dl, 0           ; フロッピー A:（QEMUなら0）
    mov bx, 0x7E00      ; 読み込み先アドレス
    int 0x13
    jc disk_error       ; 読み込み失敗

    jmp 0x0000:0x7E00   ; 読み込んだカーネルにジャンプ

disk_error:
    mov si, msg
.print:
    lodsb
    or al, al
    jz .halt
    mov ah, 0x0E
    int 0x10
    jmp .print
.halt:
    hlt
    jmp .halt

msg db "Disk read error!", 0

times 510-($-$$) db 0
dw 0xAA55

