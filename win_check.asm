section .text
    global check_win, check_line, check_column, check_diagonal
    extern board

check_win:
    mov rsi, board
    call check_line
    cmp rax, 1
    je .win
    add rsi, 6
    call check_line
    cmp rax, 1
    je .win
    add rsi, 6
    call check_line
    cmp rax, 1
    je .win

    mov rsi, board
    call check_column
    cmp rax, 1
    je .win
    add rsi, 2
    call check_column
    cmp rax, 1
    je .win
    add rsi, 2
    call check_column
    cmp rax, 1
    je .win

    mov rsi, board
    call check_diagonal
    cmp rax, 1
    je .win
    add rsi, 4
    call check_diagonal
    cmp rax, 1
    je .win

    xor rax, rax
    ret
.win:
    mov rax, 1
    ret

check_line:
    mov al, [rsi]
    cmp al, [rsi + 2]
    jne .no_win
    cmp al, [rsi + 4]
    jne .no_win
    cmp al, 'X'
    je .win
    cmp al, 'O'
    je .win
.no_win:
    xor rax, rax
    ret
.win:
    mov rax, 1
    ret

check_column:
    mov al, [rsi]
    cmp al, [rsi + 6]
    jne .no_win
    cmp al, [rsi + 12]
    jne .no_win
    cmp al, 'X'
    je .win
    cmp al, 'O'
    je .win
.no_win:
    xor rax, rax
    ret
.win:
    mov rax, 1
    ret

check_diagonal:
    mov al, [rsi]
    cmp al, [rsi + 8]
    jne .no_win
    cmp al, [rsi + 16]
    jne .no_win
    cmp al, 'X'
    je .win
    cmp al, 'O'
    je .win
.no_win:
    xor rax, rax
    ret
.win:
    mov rax, 1
    ret
