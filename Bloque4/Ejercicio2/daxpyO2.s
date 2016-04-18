	.file	"daxpy.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.globl	DAXPY
	.type	DAXPY, @function
DAXPY:
.LFB21:
	.cfi_startproc
	xorl	%eax, %eax 				# i = 0
	testl	%ecx, %ecx 				# check n > 0
	je	.L1 						# if n < 0 fin de la funcion
	.p2align 4,,10
	.p2align 3
.L5: 								# bucle for
	movl	(%rsi,%rax,4), %r8d 	# rd8 = x[i]
	imull	%edx, %r8d 				# rd8 *= a
	addl	%r8d, (%rdi,%rax,4) 	# y[i] += rd8
	addq	$1, %rax 				# i++
	cmpl	%eax, %ecx 				# compare i:n
	ja	.L5 						# if n>i goto L5
.L1:
	rep ret
	.cfi_endproc
.LFE21:
	.size	DAXPY, .-DAXPY
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"ERROR: falta tam del vector y constante\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"y[0] = %i, y[%i] = %i\n"
.LC4:
	.string	"\nTiempo (seg.) = %11.9f\n"
	.section	.text.unlikely
.LCOLDB5:
	.section	.text.startup,"ax",@progbits
.LHOTB5:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB22:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$48, %rsp
	.cfi_def_cfa_offset 96
	cmpl	$2, %edi
	jle	.L21
	movq	8(%rsi), %rdi
	movq	%rsi, %rbx
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movq	16(%rbx), %rdi
	movq	%rax, %rbp
	xorl	%esi, %esi
	movl	%ebp, %r12d
	movl	$10, %edx
	movl	%eax, %r14d
	salq	$2, %r12
	call	strtol
	movq	%r12, %rdi
	movl	%eax, %r13d
	call	malloc
	movq	%r12, %rdi
	movq	%rax, %rbx
	call	malloc
	testl	%ebp, %ebp
	movq	%rax, %r12
	je	.L10
	leal	2(%rbp), %eax
	xorl	%edi, %edi
	xorl	%esi, %esi
	movl	$2, %ecx
	.p2align 4,,10
	.p2align 3
.L11:
	movl	%ecx, (%rbx,%rsi)
	addl	$1, %ecx
	movl	%edi, (%r12,%rsi)
	addq	$4, %rsi
	addl	$2, %edi
	cmpl	%eax, %ecx
	jne	.L11
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L13:
	movl	(%r12,%rcx,4), %edx
	imull	%r13d, %edx
	addl	%edx, (%rbx,%rcx,4)
	addq	$1, %rcx
	cmpl	%ecx, %r14d
	ja	.L13
.L14:
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movq	40(%rsp), %rax
	subq	24(%rsp), %rax
	movl	$.LC3, %edi
	pxor	%xmm0, %xmm0
	movl	(%rbx), %esi
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm0
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	leal	-1(%rbp), %eax
	movl	(%rbx,%rax,4), %ecx
	movq	%rax, %rdx
	xorl	%eax, %eax
	divsd	.LC2(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rsp)
	call	printf
	movsd	8(%rsp), %xmm0
	movl	$.LC4, %edi
	movl	$1, %eax
	call	printf
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L10:
	.cfi_restore_state
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	jmp	.L14
.L21:
	movq	stderr(%rip), %rcx
	movl	$.LC1, %edi
	movl	$40, %edx
	movl	$1, %esi
	call	fwrite
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE22:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE5:
	.section	.text.startup
.LHOTE5:
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC2:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 5.1.0"
	.section	.note.GNU-stack,"",@progbits
