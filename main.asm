section .data
    global board
    board db '1|2|3',0xA,'4|5|6',0xA,'7|8|9',0xA,0
    board_len equ $ - board
    prompt db 'Joueur X, choisissez une position (1-9): ',0
    prompt_len equ $ - prompt
    invalid db 'Position invalide, réessayez.',0xA,0
    invalid_len equ $ - invalid
    win_msg db 'Joueur X a gagné!',0xA,0
    win_msg_len equ $ - win_msg
    draw_msg db 'Match nul!',0xA,0
    draw_msg_len equ $ - draw_msg
    clear_terminal db 0x1B, 'c'
    clear_terminal_len equ $ - clear_terminal
    turn db 'X'

section .bss
    input resb 2

section .text
    global _start
    extern check_win, check_draw

_start:
    call clear_screen
    mov rax, 1
    mov rdi, 1
    lea rsi, [board]
    mov rdx, board_len
    syscall

game_loop:
    mov rax, 1
    mov rdi, 1
    lea rsi, [prompt]
    mov rdx, prompt_len
    syscall

    mov rax, 0
    mov rdi, 0
    lea rsi, [input]
    mov rdx, 2
    syscall

    movzx rbx, byte [input]
    sub rbx, '1'
    cmp rbx, 9
    jae invalid_input

    lea rsi, [board + rbx * 2]
    cmp byte [rsi], 'X'
    je invalid_input
    cmp byte [rsi], 'O'
    je invalid_input

    mov al, [turn]
    mov [rsi], al

    call clear_screen
    mov rax, 1
    mov rdi, 1
    lea rsi, [board]
    mov rdx, board_len
    syscall

    call check_win
    cmp rax, 1
    je game_over

    call check_draw
    cmp rax, 1
    je game_draw

    mov al, [turn]
    cmp al, 'X'
    je set_o
    mov byte [turn], 'X'
    jmp game_loop
set_o:
    mov byte [turn], 'O'
    jmp game_loop

invalid_input:
    mov rax, 1
    mov rdi, 1
    lea rsi, [invalid]
    mov rdx, invalid_len
    syscall
    jmp game_loop

game_over:
    mov rax, 1
    mov rdi, 1
    lea rsi, [win_msg]
    mov rdx, win_msg_len
    syscall
    jmp exit

game_draw:
    mov rax, 1
    mov rdi, 1
    lea rsi, [draw_msg]
    mov rdx, draw_msg_len
    syscall

exit:
    mov rax, 60
    xor rdi, rdi
    syscall

clear_screen:
    mov rax, 1
    mov rdi, 1
    lea rsi, [clear_terminal]
    mov rdx, clear_terminal_len
    syscall
    ret
