
.global asmb

.text

#long asmb(long a, long b[], long c[], size_t n)
#a := rdi
#b := rsi
#c := rdx
#n := rcx

#optimizations:
#	No stack frame

asmb:
#	push %rbp
#	mov %rsp, %rbp

	movq %rdi, %rax #rax := a
	
	cmp $0, %rcx	#rcx = n
	jz loop_end
	
	movq %rdx, %r8  #r8  := c
	
	loop:
	#Clear rdx in preparation of imulq then multiply
	xor %rdx, %rdx #clear rdx
	imulq (%rsi) #rdx:rax = a * b[x]

	#divide the result by ra8 (c[i])
	idivq (%r8)  #rax = rdx:rax / %r8(c)
	
	#address next element in the array
	addq $8, %rsi
	addq $8, %r8

	#decrement rcx, jump to loop:
	loop loop
	
	loop_end:
#	pop %rbp
	ret


