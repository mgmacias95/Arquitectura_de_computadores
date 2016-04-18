	.file	"figura1-modificado.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.globl	Funcion
	.type	Funcion, @function
Funcion:
.LFB11:
	.cfi_startproc
	leaq	4(%rdi), %r10	# R[ii] en r10
	movl	$1, %ecx 		# ii = 1
	movl	$s+40000, %r9d 	# rd9 = ultima direccion de s
	.p2align 4,,10
	.p2align 3
.L2:
	movl	$s, %eax 		# guardamos s en eax
	xorl	%esi, %esi 		# X2 = 0
	xorl	%edx, %edx 		# X1 = 0
	.p2align 4,,10
	.p2align 3
.L3:
	movl	(%rax), %edi 		# s[i].a en edi
	addq	$32, %rax 			# desplazamos rax 32
	leal	(%rcx,%rdi,2), %edi # edi = 2*s[i].a + ii
	addl	%edi, %edx 			# X1 += edi 
	movl	-28(%rax), %edi 	# s[i].b en edi
	leal	(%rdi,%rdi,2), %r8d # rd8 = 3*s[i].b
	movl	-24(%rax), %edi 	# s[i+1].a en edi
	subl	%ecx, %r8d 			# rd8 -= ii
	leal	(%rcx,%rdi,2), %edi # edi = 2*s[i+1].a
	addl	%r8d, %esi			# X2 += rd8
	addl	%edi, %edx
	movl	-20(%rax), %edi
	leal	(%rdi,%rdi,2), %edi
	subl	%ecx, %edi
	leal	(%rdi,%rsi), %r8d
	movl	-16(%rax), %esi
	leal	(%rcx,%rsi,2), %esi
	addl	%esi, %edx
	movl	-12(%rax), %esi
	leal	(%rsi,%rsi,2), %esi
	subl	%ecx, %esi
	leal	(%rsi,%r8), %edi
	movl	-8(%rax), %esi
	leal	(%rcx,%rsi,2), %esi
	addl	%esi, %edx
	movl	-4(%rax), %esi
	leal	(%rsi,%rsi,2), %esi
	subl	%ecx, %esi
	addl	%edi, %esi
	cmpq	%rax, %r9
	jne	.L3
	cmpl	%esi, %edx
	cmovg	%esi, %edx
	addl	$1, %ecx
	addq	$4, %r10
	movl	%edx, -4(%r10)
	cmpl	$40001, %ecx
	jne	.L2
	rep ret
	.cfi_endproc
.LFE11:
	.size	Funcion, .-Funcion
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"R[0] = %i, R[39999] = %i\n"
.LC3:
	.string	"\nTiempo (seg.) = %11.9f\n"
	.section	.text.unlikely
.LCOLDB4:
	.section	.text.startup,"ax",@progbits
.LHOTB4:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	subq	$160056, %rsp
	.cfi_def_cfa_offset 160064
	xorl	%edi, %edi
	leaq	16(%rsp), %rsi
	call	clock_gettime
	leaq	48(%rsp), %rdi
	call	Funcion
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movq	40(%rsp), %rax
	subq	24(%rsp), %rax
	movl	$.LC2, %edi
	pxor	%xmm0, %xmm0
	movl	160044(%rsp), %edx
	pxor	%xmm1, %xmm1
	movl	48(%rsp), %esi
	cvtsi2sdq	%rax, %xmm0
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	xorl	%eax, %eax
	divsd	.LC1(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rsp)
	call	printf
	movsd	8(%rsp), %xmm0
	movl	$.LC3, %edi
	movl	$1, %eax
	call	printf
	xorl	%eax, %eax
	addq	$160056, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE4:
	.section	.text.startup
.LHOTE4:
	.comm	s,40000,32
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 5.1.0"
	.section	.note.GNU-stack,"",@progbits
