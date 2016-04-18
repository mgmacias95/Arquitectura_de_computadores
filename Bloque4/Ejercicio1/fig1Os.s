	.file	"figura1-modificado.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.globl	Funcion
	.type	Funcion, @function
Funcion:
.LFB0:
	.cfi_startproc
	addq	$4, %rdi
	movl	$1, %esi				# ii = 1
	movl	$s+40000, %r11d			# rd11 = ultima direccion de s
.L2:
	movl	$s, %ecx				# ecx = primera direccion de s
	xorl	%r8d, %r8d				# rd8 = X2 = 0
	xorl	%eax, %eax				# eax = X1 = 0
.L3:
	movl	(%rcx), %edx			# s[i].a en edx
	addq	$32, %rcx 				# sumamos 32 a s
	imull	$3, -20(%rcx), %r9d 	# rd9 = 3*s[i].b
	leal	(%rsi,%rdx,2), %edx 	# edx = 2*s[i].a + ii
	addl	%eax, %edx 				# X1 = eax + edx
	imull	$3, -28(%rcx), %eax 	# eax = 3*s[i+1].b
	subl	%esi, %r9d 				# rd9 -= ii
	subl	%esi, %eax 				# eax -= ii
	addl	%r8d, %eax				# X2 += eax
	movl	-24(%rcx), %r8d 		
	leal	(%r9,%rax), %r10d
	movl	-16(%rcx), %eax
	leal	(%rsi,%r8,2), %r8d
	leal	(%rsi,%rax,2), %eax
	addl	%r8d, %edx
	imull	$3, -12(%rcx), %r8d
	addl	%eax, %edx
	movl	-8(%rcx), %eax
	leal	(%rsi,%rax,2), %eax
	subl	%esi, %r8d
	addl	%edx, %eax
	leal	(%r8,%r10), %r9d
	imull	$3, -4(%rcx), %r8d
	subl	%esi, %r8d
	addl	%r9d, %r8d
	cmpq	%rcx, %r11
	jne	.L3
	cmpl	%r8d, %eax
	cmovg	%r8d, %eax
	incl	%esi				# ii++
	addq	$4, %rdi 			# i += 4
	movl	%eax, -4(%rdi)
	cmpl	$40001, %esi		# i < 40000
	jne	.L2						# inicio del bucle
	ret
	.cfi_endproc
.LFE0:
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
	.globl	main
	.type	main, @function
main:
.LFB1:
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
	movl	160044(%rsp), %edx
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
	movb	$1, %al
	call	printf
	xorl	%eax, %eax
	addq	$160056, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1:
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
