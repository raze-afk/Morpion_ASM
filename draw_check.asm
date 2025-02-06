section .text
    global check_draw
    extern board

check_draw:
    mov rsi, board
    mov rcx, 9
.check_loop:
    cmp byte [rsi], 'X'
    je .next
    cmp byte [rsi], 'O'
    je .next
    xor rax, rax
    ret
.next:
    add rsi, 2
    loop .check_loop
    mov rax, 1
    ret
