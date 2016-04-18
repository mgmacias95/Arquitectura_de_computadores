	.file	"daxpy.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.globl	DAXPY
	.type	DAXPY, @function
DAXPY:
.LFB2:
	.cfi_startproc
	xorl	%eax, %eax 				# i = 0
.L2:
	cmpl	%eax, %ecx				# compare i:n
	jbe	.L5 						# if i<= n goto L5
	movl	(%rsi,%rax,4), %r8d 	# r8d = x[i]
	imull	%edx, %r8d 				# rd8 *= a
	addl	%r8d, (%rdi,%rax,4) 	# y[i] += rd8
	incq	%rax 					# i++
	jmp	.L2 						# goto L2
.L5:								# return
	ret
	.cfi_endproc
.LFE2:
	.size	DAXPY, .-DAXPY
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"ERROR: falta tam del vector y constante\n"
.LC3:
	.string	"y[0] = %i, y[%i] = %i\n"
.LC4:
	.string	"\nTiempo (seg.) = %11.9f\n"
	.section	.text.unlikely
.LCOLDB5:
	.section	.text.startup,"ax",@progbits
.LHOTB5:
	.globl	main
	.type	main, @function
main:
.LFB3:
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
	jg	.L7
	movq	stderr(%rip), %rsi
	movl	$.LC1, %edi
	call	fputs
	movl	$1, %edi
	call	exit
.L7:
	movq	8(%rsi), %rdi
	movq	%rsi, %rbp
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movq	16(%rbp), %rdi
	movq	%rax, %rbx
	movl	$10, %edx
	movl	%ebx, %r12d
	xorl	%esi, %esi
	movl	%eax, %r14d
	salq	$2, %r12
	call	strtol
	movq	%r12, %rdi
	movq	%rax, %r13
	call	malloc
	movq	%r12, %rdi
	movq	%rax, %rbp
	call	malloc
	movq	%rax, %r12
	xorl	%eax, %eax
.L8:
	cmpl	%eax, %r14d
	jbe	.L11
	leal	2(%rax), %edx
	movl	%edx, 0(%rbp,%rax,4)
	leal	(%rax,%rax), %edx
	movl	%edx, (%r12,%rax,4)
	incq	%rax
	jmp	.L8
.L11:
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movl	%ebx, %ecx
	movl	%r13d, %edx
	movq	%r12, %rsi
	movq	%rbp, %rdi
	call	DAXPY
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movq	40(%rsp), %rax
	subq	24(%rsp), %rax
	movl	$.LC3, %edi
	movl	0(%rbp), %esi
	cvtsi2sdq	%rax, %xmm0
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	leal	-1(%rbx), %eax
	movl	0(%rbp,%rax,4), %ecx
	movq	%rax, %rdx
	xorl	%eax, %eax
	divsd	.LC2(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rsp)
	call	printf
	movsd	8(%rsp), %xmm0
	movl	$.LC4, %edi
	movb	$1, %al
	call	printf
	addq	$48, %rsp
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
	.cfi_endproc
.LFE3:
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
