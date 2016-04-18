	.file	"pmm-secuencial-modificado.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d "
	.section	.text.unlikely,"ax",@progbits
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	printMatriz
	.type	printMatriz, @function
printMatriz:
.LFB33:
	.cfi_startproc
	testl	%edi, %edi
	jle	.L8
	leal	-1(%rdi), %eax
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
	movq	%rsi, %r12
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	leaq	4(%rsi,%rax,4), %r14
	leaq	4(,%rax,4), %r13
	.p2align 4,,10
	.p2align 3
.L3:
	leaq	0(%r13,%r12), %rbp
	movq	%r12, %rbx
	.p2align 4,,10
	.p2align 3
.L4:
	movl	(%rbx), %esi
	xorl	%eax, %eax
	movl	$.LC0, %edi
	addq	$4, %rbx
	call	printf
	cmpq	%rbp, %rbx
	jne	.L4
	movl	$10, %edi
	addq	$4, %r12
	call	putchar
	cmpq	%r14, %r12
	jne	.L3
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_restore 13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_restore 14
	.cfi_def_cfa_offset 8
.L8:
	rep ret
	.cfi_endproc
.LFE33:
	.size	printMatriz, .-printMatriz
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.globl	pmm
	.type	pmm, @function
pmm:
.LFB34:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	xorl	%r15d, %r15d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	xorl	%r14d, %r14d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbp
	movq	%rdi, %rbx
	movq	%r8, %rsi
	xorl	%edi, %edi
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	%rdx, 24(%rsp)
	movl	%ecx, 20(%rsp)
	movq	%r9, 8(%rsp)
	call	clock_gettime
	movl	20(%rsp), %ecx
	movq	8(%rsp), %r9
	movq	24(%rsp), %rdx
	testl	%ecx, %ecx
	movl	%ecx, %r10d
	je	.L12
.L18:
	movl	%r10d, %r13d
	movl	%r15d, %r8d
	subl	%ecx, %r13d
	movl	%r13d, %r12d
	.p2align 4,,10
	.p2align 3
.L15:
	movl	%r12d, %eax
	leaq	0(%rbp,%rax,4), %r11
	movl	%r13d, %eax
	.p2align 4,,10
	.p2align 3
.L13:
	leal	(%r8,%rax), %esi
	movl	%eax, %edi
	addl	$1, %eax
	movl	(%rdx,%rsi,4), %esi
	imull	(%r11), %esi
	addl	%esi, (%rbx,%rdi,4)
	cmpl	%eax, %r10d
	jne	.L13
	addl	$1, %r12d
	addl	%ecx, %r8d
	cmpl	%r10d, %r12d
	jne	.L15
	addl	$1, %r14d
	addl	%ecx, %r10d
	subl	%ecx, %r15d
	cmpl	%r14d, %ecx
	jne	.L18
.L12:
	addq	$40, %rsp
	.cfi_def_cfa_offset 56
	movq	%r9, %rsi
	xorl	%edi, %edi
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
	jmp	clock_gettime
	.cfi_endproc
.LFE34:
	.size	pmm, .-pmm
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	"ERROR: falta numero de filas y columnas\n"
	.section	.rodata.str1.1
.LC4:
	.string	"M1:"
.LC5:
	.string	"M2:"
.LC6:
	.string	"Sol:"
	.section	.rodata.str1.8
	.align 8
.LC8:
	.string	"Tiempo = %11.9f\t Primera = %d\t Ultima=%d\n"
	.section	.text.unlikely
.LCOLDB9:
	.section	.text.startup,"ax",@progbits
.LHOTB9:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB35:
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
	cmpl	$1, %edi
	jle	.L33
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movq	%rax, %r12
	movl	%eax, 12(%rsp)
	imull	%eax, %eax
	leaq	63(,%rax,4), %r14
	movq	%r14, %rdi
	call	malloc
	movq	%r14, %rdi
	leaq	63(%rax), %rbx
	movq	%rax, (%rsp)
	call	malloc
	movq	%r14, %rdi
	leaq	63(%rax), %rbp
	movq	%rax, %r13
	call	malloc
	leaq	63(%rax), %r15
	andq	$-64, %rbx
	andq	$-64, %rbp
	movq	%rax, %r14
	andq	$-64, %r15
	testl	%r12d, %r12d
	je	.L23
	movl	12(%rsp), %r8d
	xorl	%eax, %eax
	xorl	%esi, %esi
	.p2align 4,,10
	.p2align 3
.L25:
	leal	(%r8,%rax), %ecx
	.p2align 4,,10
	.p2align 3
.L24:
	movl	%eax, %edx
	addl	$1, %eax
	cmpl	%eax, %ecx
	movl	$0, (%rbx,%rdx,4)
	movl	$2, 0(%rbp,%rdx,4)
	movl	$1, (%r15,%rdx,4)
	jne	.L24
	addl	$1, %esi
	movl	%ecx, %eax
	cmpl	%esi, %r8d
	jne	.L25
	leaq	32(%rsp), %r9
	leaq	16(%rsp), %r8
	movl	%r12d, %ecx
	movq	%r15, %rdx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	pmm
	cmpl	$14, %r12d
	jbe	.L28
	leal	-2(%r12,%r12), %eax
	pxor	%xmm0, %xmm0
	movl	(%rbx), %esi
	movl	$.LC8, %edi
	movl	(%rbx,%rax,4), %edx
	movq	40(%rsp), %rax
	subq	24(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	divsd	.LC7(%rip), %xmm1
	cvtsi2sdq	%rax, %xmm0
	movl	$1, %eax
	addsd	%xmm1, %xmm0
	call	printf
.L27:
	movq	(%rsp), %rdi
	call	free
	movq	%r13, %rdi
	call	free
	movq	%r14, %rdi
	call	free
	addq	$56, %rsp
	.cfi_remember_state
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
.L23:
	.cfi_restore_state
	leaq	32(%rsp), %r9
	leaq	16(%rsp), %r8
	xorl	%ecx, %ecx
	movq	%r15, %rdx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	pmm
.L28:
	movl	$.LC4, %edi
	call	puts
	movq	%rbp, %rsi
	movl	%r12d, %edi
	call	printMatriz
	movl	$.LC5, %edi
	call	puts
	movq	%r15, %rsi
	movl	%r12d, %edi
	call	printMatriz
	movl	$.LC6, %edi
	call	puts
	movq	%rbx, %rsi
	movl	%r12d, %edi
	call	printMatriz
	jmp	.L27
.L33:
	movq	stderr(%rip), %rcx
	movl	$.LC3, %edi
	movl	$40, %edx
	movl	$1, %esi
	call	fwrite
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE35:
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
