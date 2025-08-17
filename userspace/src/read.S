; Test userspace program
global _start

section .text

_start:
    ; read syscall
    xor rax,rax
    xor rdi,rdi
    xor rsi,rsi
    mov rsi,buf
    xor rdx,rdx
    mov dl, 64
    syscall

    ; exit syscall
    xor rax,rax
    mov eax,60
    syscall

section .data
    buf: times 64 db 0