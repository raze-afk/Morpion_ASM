# Morpion_ASM

## RUN
nasm -f elf64 main.asm -o main.o

nasm -f elf64 win_check.asm -o win_check.o

nasm -f elf64 draw_check.asm -o draw_check.o

ld -T linker.ld main.o win_check.o draw_check.o -o morpion
