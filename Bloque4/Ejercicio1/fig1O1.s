	.file	"figura1-modificado.c"
	.text
	.globl	Funcion
	.type	Funcion, @function
Funcion:
.LFB11:
	.cfi_startproc
	leaq	4(%rdi), %r10	# R[ii] en r10
	movl	$1, %ecx		# i = 1
	movl	$s+40000, %r9d  # rd9 = ultima direccion de s
	jmp	.L2
.L3:
	movl	(%rax), %edi		# s[i].a en edi	
	leal	(%rcx,%rdi,2), %edi # edi = 2*s[i].a
	addl	%edi, %edx  		# X1 += edi
	movl	4(%rax), %edi 		# s[i].b en edi
	leal	(%rdi,%rdi,2), %r8d # rd8 = 3*edi
	subl	%ecx, %r8d 			# rd8 = rd8 - ii
	addl	%r8d, %esi 			# X2 += rd8
	movl	8(%rax), %edi		# repetimos para las demas
	leal	(%rcx,%rdi,2), %edi
	addl	%edi, %edx
	movl	12(%rax), %edi
	leal	(%rdi,%rdi,2), %edi
	subl	%ecx, %edi
	leal	(%rdi,%rsi), %r8d
	movl	16(%rax), %esi
	leal	(%rcx,%rsi,2), %esi
	addl	%esi, %edx
	movl	20(%rax), %esi
	leal	(%rsi,%rsi,2), %esi
	subl	%ecx, %esi
	leal	(%rsi,%r8), %edi
	movl	24(%rax), %esi
	leal	(%rcx,%rsi,2), %esi
	addl	%esi, %edx
	movl	28(%rax), %esi
	leal	(%rsi,%rsi,2), %esi
	subl	%ecx, %esi
	addl	%edi, %esi
	addq	$32, %rax 		# desplazamos s 32 
	cmpq	%r9, %rax		# si s es menor que el fin de s
	jne	.L3					# volvemos al bucle.si es distinto
	cmpl	%esi, %edx # comparamos X1 < X2
	cmovg	%esi, %edx # si es menor X1, X2 = X1
	movl	%edx, (%r10) # y lo guardamos en R[ii]
	addl	$1, %ecx	# ii++
	addq	$4, %r10 	# i += 4
	cmpl	$40001, %ecx # ii < 40001
	je	.L1
.L2:
	movl	$s, %eax 	# eax = inicio de s
	movl	$0, %esi 	# esi = X2
	movl	$0, %edx 	# edx = X1
	jmp	.L3
.L1:
	rep ret
	.cfi_endproc
.LFE11:
	.size	Funcion, .-Funcion
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"R[0] = %i, R[39999] = %i\n"
.LC2:
	.string	"\nTiempo (seg.) = %11.9f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	subq	$160056, %rsp
	.cfi_def_cfa_offset 160064
	leaq	32(%rsp), %rsi
	movl	$0, %edi
	call	clock_gettime
	leaq	48(%rsp), %rdi
	call	Funcion
	leaq	16(%rsp), %rsi
	movl	$0, %edi
	call	clock_gettime
	movq	24(%rsp), %rax
	subq	40(%rsp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	divsd	.LC0(%rip), %xmm0
	movq	16(%rsp), %rax
	subq	32(%rsp), %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rsp)
	movl	160044(%rsp), %edx
	movl	48(%rsp), %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movsd	8(%rsp), %xmm0
	movl	$.LC2, %edi
	movl	$1, %eax
	call	printf
	movl	$0, %eax
	addq	$160056, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.comm	s,40000,32
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 5.1.0"
	.section	.note.GNU-stack,"",@progbits
