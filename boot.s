BITS 16
ORG 0x7C00        ; BIOSが読み込むメモリアドレス

start:
    cli           ; 割り込み禁止（おまじない）
    xor ax, ax
    mov ds, ax    ; データセグメント初期化

    mov si, msg   ; メッセージのアドレスをSIにセット
.print_char:
    lodsb         ; SIが指す文字をALにロードしてSI++
    or al, al     ; 文字が0なら終了
    jz .done
    mov ah, 0x0E  ; BIOSのテレタイプ表示
    int 0x10      ; ALの文字を出力
    jmp .print_char

.done:
    hlt
    jmp .done     ; 無限ループで停止

msg db "Hello, World!", 0

; BIOS用マジックナンバーとパディング
times 510 - ($ - $$) db 0
dw 0xAA55
