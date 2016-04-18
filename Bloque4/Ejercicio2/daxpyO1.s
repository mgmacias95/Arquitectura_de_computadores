	.file	"daxpy.c"
	.text
	.globl	DAXPY
	.type	DAXPY, @function
DAXPY:
.LFB21:
	.cfi_startproc
	testl	%ecx, %ecx 				# check n > 0	
	je	.L1							# if n < 0 fin de la funcion
	movl	$0, %eax				# i = 0
.L3: 								# bucle for
	movl	%edx, %r8d 				# r8d = a
	imull	(%rsi,%rax,4), %r8d 	# r8d *= 4*i + x
	addl	%r8d, (%rdi,%rax,4) 	# y[i] += r8d
	addq	$1, %rax 				# i++
	cmpl	%eax, %ecx 				# compare i:n
	ja	.L3 						# if n>i goto L3
.L1:
	rep ret
	.cfi_endproc
.LFE21:
	.size	DAXPY, .-DAXPY
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"ERROR: falta tam del vector y constante\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"y[0] = %i, y[%i] = %i\n"
.LC3:
	.string	"\nTiempo (seg.) = %11.9f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB22:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$56, %rsp
	.cfi_def_cfa_offset 96
	cmpl	$2, %edi
	jg	.L6
	movq	stderr(%rip), %rcx
	movl	$40, %edx
	movl	$1, %esi
	movl	$.LC0, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L6:
	movq	%rsi, %rbx
	movq	8(%rsi), %rdi
	movl	$10, %edx
	movl	$0, %esi
	call	strtol
	movq	%rax, %r12
	movq	16(%rbx), %rdi
	movl	$10, %edx
	movl	$0, %esi
	call	strtol
	movq	%rax, %r13
	movl	%r12d, %ebp
	salq	$2, %rbp
	movq	%rbp, %rdi
	call	malloc
	movq	%rax, %rbx
	movq	%rbp, %rdi
	call	malloc
	movq	%rax, %rbp
	testl	%r12d, %r12d
	je	.L7
	leal	2(%r12), %esi
	movl	$0, %edx
	movl	$0, %ecx
	movl	$2, %eax
.L8:
	movl	%eax, (%rbx,%rcx)
	movl	%edx, 0(%rbp,%rcx)
	addl	$1, %eax
	addq	$4, %rcx
	addl	$2, %edx
	cmpl	%esi, %eax
	jne	.L8
.L7:
	leaq	32(%rsp), %rsi
	movl	$0, %edi
	call	clock_gettime
	movl	%r12d, %ecx
	movl	%r13d, %edx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	DAXPY
	leaq	16(%rsp), %rsi
	movl	$0, %edi
	call	clock_gettime
	movq	24(%rsp), %rax
	subq	40(%rsp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	divsd	.LC1(%rip), %xmm0
	movq	16(%rsp), %rax
	subq	32(%rsp), %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rsp)
	leal	-1(%r12), %edx
	movl	%edx, %eax
	movl	(%rbx,%rax,4), %ecx
	movl	(%rbx), %esi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
	movsd	8(%rsp), %xmm0
	movl	$.LC3, %edi
	movl	$1, %eax
	call	printf
	movl	$0, %eax
	addq	$56, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE22:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 5.1.0"
	.section	.note.GNU-stack,"",@progbits
