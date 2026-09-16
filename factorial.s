.text

basemess: .asciz "Enter a base: \n"
exponentmess: .asciz "Enter an exponent: \n"
factorialmessage: .asciz "Enter a natural number to calculate its factorial: \n"
factorialinput: .asciz "%ld"
base: .asciz "%ld"
exponent: .asciz "%ld"
result: .asciz "The result is: %ld\n"

.global main
main:
pushq %rbp #push the base pointer onto the stack
movq %rsp, %rbp #copy stack pointer value to base pointer

movq $0, %rax #no vector registers in use for printf
movq $factorialmessage, %rdi
call printf

subq $16, %rsp
movq $0, %rax
leaq -8(%rbp), %rsi
movq $factorialinput, %rdi
call scanf

movq -8(%rbp), %rdi
movq $1, %rax

call factorial

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

factorial:
pushq %rbp
movq %rsp, %rbp

cmpq $0, %rdi
je iffactorial
push %rdi
subq $8, %rsp #aligning the stack
decq %rdi
call factorial
addq $8, %rsp #cleaning upp the 8-byte padding
pop %rdi
mulq %rdi
jmp end

iffactorial:
movq $1, %rax
jmp end

end:
movq %rbp, %rsp
pop %rbp
ret



