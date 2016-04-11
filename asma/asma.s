
.global asma

.text

#long  asma(long a, long b, long c) { return (a*b)/c; }
#Input in registers: rdi, rsi, rdx
asma:
    push %rdx
    xor %rdx, %rdx
	mov %rsi, %rax
    imulq %rdi
	pop %r8
    idivq %r8

end:
	ret    
