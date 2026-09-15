.text

basemess: .asciz "Enter a base: \n"
exponentmess: .asciz "Enter an exponent: \n"
base: .asciz "%ld"
exponent: .asciz "%ld"
result: .asciz "The result is: %ld\n"

.global main
main:
pushq %rbp
movq %rsp, %rbp

subq $16, %rsp

movq $0, %rax
movq $basemess, %rdi
call printf

leaq -8(%rbp), %rsi
movq $base, %rdi
movq $0, %rax
call scanf

movq $0, %rax
movq $exponentmess, %rdi
call printf

leaq -16(%rbp), %rsi
movq $exponent, %rdi
movq $0, %rax
call scanf

movq -8(%rbp), %rdi
movq -16(%rbp), %rsi

call pow

movq $result, %rdi
movq %rax, %rsi
movq $0, %rax
call printf

movq %rbp, %rsp
pop %rbp
ret

pow:
push %rbp
mov %rsp, %rbp

cmpq $0, %rsi
je ifcode
jne elsecode

ifcode:
movq $1, %rax
jmp end

elsecode:
movq $1, %rcx
movq $1, %rax
loop:
cmpq %rsi, %rcx
jg end

mulq %rdi

addq $1, %rcx #cnt++
jmp loop

end:
movq %rbp, %rsp
pop %rbp
ret