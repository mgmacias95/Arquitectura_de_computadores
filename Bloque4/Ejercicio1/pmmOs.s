	.file	"pmm-secuencial-modificado.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d "
	.section	.text.unlikely,"ax",@progbits
.LCOLDB1:
	.text
.LHOTB1:
	.globl	printMatriz
	.type	printMatriz, @function
printMatriz:
.LFB2:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movl	%edi, %r13d
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rsi, %r12
	pushq	%rdx
	.cfi_def_cfa_offset 48
	xorl	%ebp, %ebp
.L2:
	cmpl	%r13d, %ebp
	jge	.L1
	xorl	%ebx, %ebx
.L5:
	cmpl	%ebx, %r13d
	jle	.L8
	movl	(%r12,%rbx,4), %esi
	movl	$.LC0, %edi
	xorl	%eax, %eax
	incq	%rbx
	call	printf
	jmp	.L5
.L8:
	movl	$10, %edi
	incl	%ebp
	addq	$4, %r12
	call	putchar
	jmp	.L2
.L1:
	popq	%rax
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
.LFE2:
	.size	printMatriz, .-printMatriz
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.globl	pmm
	.type	pmm, @function
pmm:
.LFB3:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbp
	movq	%r8, %rsi
	xorl	%edi, %edi
	movl	%ecx, %ebx
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	movq	%rdx, %r13
	movq	%r9, 8(%rsp)
	call	clock_gettime
	movq	8(%rsp), %r9
	xorl	%ecx, %ecx
	xorl	%edi, %edi
.L10:
	cmpl	%ebx, %edi
	je	.L17
	xorl	%edx, %edx
	xorl	%esi, %esi
.L14:
	cmpl	%ebx, %esi
	je	.L12
	leal	(%rsi,%rcx), %eax
	leaq	(%r12,%rax,4), %r11
	xorl	%eax, %eax
.L13:
	cmpl	%ebx, %eax
	je	.L18
	leal	(%rax,%rdx), %r8d
	leal	(%rax,%rcx), %r10d
	incl	%eax
	movl	0(%r13,%r8,4), %r8d
	imull	(%r11), %r8d
	addl	%r8d, 0(%rbp,%r10,4)
	jmp	.L13
.L18:
	incl	%esi
	addl	%ebx, %edx
	jmp	.L14
.L12:
	incl	%edi
	addl	%ebx, %ecx
	jmp	.L10
.L17:
	addq	$24, %rsp
	.cfi_def_cfa_offset 40
	movq	%r9, %rsi
	xorl	%edi, %edi
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	clock_gettime
	.cfi_endproc
.LFE3:
	.size	pmm, .-pmm
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.rodata.str1.1
.LC3:
	.string	"ERROR: falta numero de filas y columnas\n"
.LC4:
	.string	"M1:"
.LC5:
	.string	"M2:"
.LC6:
	.string	"Sol:"
.LC8:
	.string	"Tiempo = %11.9f\t Primera = %d\t Ultima=%d\n"
	.section	.text.unlikely
.LCOLDB9:
	.section	.text.startup,"ax",@progbits
.LHOTB9:
	.globl	main
	.type	main, @function
main:
.LFB4:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	decl	%edi
	jg	.L20
	movq	stderr(%rip), %rsi
	movl	$.LC3, %edi
	call	fputs
	movl	$1, %edi
	call	exit
.L20:
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movl	%eax, 12(%rsp)
	movq	%rax, %rbx
	imull	%eax, %eax
	leaq	63(,%rax,4), %r12
	movq	%r12, %rdi
	call	malloc
	movq	%r12, %rdi
	leaq	63(%rax), %rbp
	movq	%rax, %r15
	call	malloc
	movq	%r12, %rdi
	leaq	63(%rax), %r13
	movq	%rax, %r14
	call	malloc
	movl	12(%rsp), %edx
	leaq	63(%rax), %r12
	andq	$-64, %rbp
	andq	$-64, %r13
	movq	%rax, (%rsp)
	xorl	%esi, %esi
	andq	$-64, %r12
	xorl	%ecx, %ecx
.L21:
	cmpl	%edx, %ecx
	jnb	.L28
	xorl	%eax, %eax
.L22:
	leal	(%rsi,%rax), %edi
	incl	%eax
	cmpl	%eax, %edx
	movl	$0, 0(%rbp,%rdi,4)
	movl	$2, 0(%r13,%rdi,4)
	movl	$1, (%r12,%rdi,4)
	ja	.L22
	incl	%ecx
	addl	%edx, %esi
	jmp	.L21
.L28:
	leaq	32(%rsp), %r9
	leaq	16(%rsp), %r8
	movl	%ebx, %ecx
	movq	%r12, %rdx
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	pmm
	cmpl	$14, %ebx
	ja	.L23
	movl	$.LC4, %edi
	call	puts
	movq	%r13, %rsi
	movl	%ebx, %edi
	call	printMatriz
	movl	$.LC5, %edi
	call	puts
	movq	%r12, %rsi
	movl	%ebx, %edi
	call	printMatriz
	movl	$.LC6, %edi
	call	puts
	movq	%rbp, %rsi
	movl	%ebx, %edi
	call	printMatriz
	jmp	.L24
.L23:
	leal	-2(%rbx,%rbx), %eax
	movl	0(%rbp), %esi
	movl	$.LC8, %edi
	movl	0(%rbp,%rax,4), %edx
	movq	40(%rsp), %rax
	subq	24(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	movb	$1, %al
	divsd	.LC7(%rip), %xmm0
	addsd	%xmm1, %xmm0
	call	printf
.L24:
	movq	%r15, %rdi
	call	free
	movq	%r14, %rdi
	call	free
	movq	(%rsp), %rdi
	call	free
	addq	$56, %rsp
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE4:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE9:
	.section	.text.startup
.LHOTE9:
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC7:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 5.1.0"
	.section	.note.GNU-stack,"",@progbits
