nasm -f bin boot.s -o boot.bin
nasm -f elf32 kernel.s -o kernel.o
nasm -f elf32 lib.s -o lib.o

ld -m elf_i386 -Ttext 0x7e00 -o kernel.elf kernel.o lib.o

objcopy -O binary kernel.elf kernel.bin

cat boot.bin kernel.bin > os.img

