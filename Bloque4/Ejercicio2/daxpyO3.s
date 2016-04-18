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
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movl	%ecx, %r14d
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
	movq	%r8, %rsi
	movq	%rdi, %rbx
	xorl	%edi, %edi
	movl	%edx, %r13d
	movq	%r9, %rbp
	subq	$16, %rsp
	.cfi_def_cfa_offset 64
	







	call	clock_gettime
	testl	%r14d, %r14d 		# check n>0
	je	.L10 					# if n<0 ret
	leaq	16(%r12), %rax
	cmpq	%rax, %rbx
	leaq	16(%rbx), %rax
	setnb	%dl
	cmpq	%rax, %r12
	setnb	%al
	orb	%al, %dl
	je	.L3
	cmpl	$6, %r14d
	jbe	.L3
	movq	%rbx, %rax
	andl	$15, %eax
	shrq	$2, %rax
	negq	%rax
	andl	$3, %eax
	cmpl	%r14d, %eax
	cmova	%r14, %rax
	xorl	%edx, %edx
	testl	%eax, %eax
	je	.L4
	movl	(%r12), %edx
	imull	%r13d, %edx
	addl	%edx, (%rbx)
	cmpl	$1, %eax
	movl	$1, %edx
	je	.L4
	movl	4(%r12), %edx
	imull	%r13d, %edx
	addl	%edx, 4(%rbx)
	cmpl	$3, %eax
	movl	$2, %edx
	jne	.L4
	movl	8(%r12), %edx
	imull	%r13d, %edx
	addl	%edx, 8(%rbx)
	movl	$3, %edx
.L4:
	movl	%r14d, %edi
	movl	%r13d, 12(%rsp)
	xorl	%ecx, %ecx
	subl	%eax, %edi
	movd	12(%rsp), %xmm4
	salq	$2, %rax
	leal	-4(%rdi), %esi
	leaq	(%rbx,%rax), %r10
	xorl	%r9d, %r9d
	pshufd	$0, %xmm4, %xmm2
	addq	%r12, %rax
	shrl	$2, %esi
	addl	$1, %esi
	movdqa	%xmm2, %xmm3
	leal	0(,%rsi,4), %r8d
	psrlq	$32, %xmm3
#-----------------------------------------------------------
# utilizamos las instrucciones multimedia para desenrollar cuatro
# iteraciones del bucle empaquetando los datos en los registros de
# coma flotante y utilizando las extensiones SIMD del procesador
.L6:
	movdqu	(%rax,%rcx), %xmm0
	addl	$1, %r9d
	movdqa	%xmm0, %xmm1
	psrlq	$32, %xmm0
	pmuludq	%xmm3, %xmm0
	pshufd	$8, %xmm0, %xmm0
	pmuludq	%xmm2, %xmm1
	pshufd	$8, %xmm1, %xmm1
	punpckldq	%xmm0, %xmm1
	movdqa	(%r10,%rcx), %xmm0
	paddd	%xmm1, %xmm0
	movaps	%xmm0, (%r10,%rcx)
	addq	$16, %rcx
	cmpl	%esi, %r9d
	jb	.L6
#------------------------------------------------------
	addl	%r8d, %edx
	cmpl	%r8d, %edi
	je	.L10
	movl	%edx, %eax
	movl	(%r12,%rax,4), %ecx
	imull	%r13d, %ecx
	addl	%ecx, (%rbx,%rax,4)
	leal	1(%rdx), %eax
	cmpl	%eax, %r14d
	jbe	.L10
	movl	(%r12,%rax,4), %ecx
	addl	$2, %edx
	imull	%r13d, %ecx
	addl	%ecx, (%rbx,%rax,4)
	cmpl	%edx, %r14d
	jbe	.L10
	movl	%edx, %eax
	imull	(%r12,%rax,4), %r13d
	addl	%r13d, (%rbx,%rax,4)
.L10:
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movq	%rbp, %rsi
	xorl	%edi, %edi
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
	jmp	clock_gettime
	.p2align 4,,10
	.p2align 3
.L3:
	.cfi_restore_state
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L11:
	movl	(%r12,%rax,4), %edx
	imull	%r13d, %edx
	addl	%edx, (%rbx,%rax,4)
	addq	$1, %rax
	cmpl	%eax, %r14d
	ja	.L11
	jmp	.L10
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
.LCOLDB8:
	.section	.text.startup,"ax",@progbits
.LHOTB8:
	.p2align 4,,15
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
	jle	.L56
	movq	8(%rsi), %rdi
	movq	%rsi, %rbp
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movq	16(%rbp), %rdi
	movq	%rax, %rbx
	xorl	%esi, %esi
	movl	%ebx, %r13d
	movl	$10, %edx
	salq	$2, %r13
	call	strtol
	movq	%r13, %rdi
	movq	%rax, %rbp
	call	malloc
	movq	%r13, %rdi
	movq	%rax, %r12
	orl	$-1, %r13d
	call	malloc
	testl	%ebx, %ebx
	je	.L42
	movq	%r12, %rdi
	andl	$15, %edi
	shrq	$2, %rdi
	negq	%rdi
	andl	$3, %edi
	cmpl	%ebx, %edi
	cmova	%ebx, %edi
	cmpl	$5, %ebx
	ja	.L57
	movl	%ebx, %edi
.L33:
	cmpl	$1, %edi
	movl	$2, (%r12)
	movl	$0, (%rax)
	je	.L45
	cmpl	$2, %edi
	movl	$3, 4(%r12)
	movl	$2, 4(%rax)
	je	.L46
	cmpl	$3, %edi
	movl	$4, 8(%r12)
	movl	$4, 8(%rax)
	je	.L47
	cmpl	$5, %edi
	movl	$5, 12(%r12)
	movl	$6, 12(%rax)
	jne	.L48
	movl	$6, 16(%r12)
	movl	$8, 16(%rax)
	movl	$5, %edx
.L35:
	cmpl	%edi, %ebx
	leal	-1(%rbx), %r13d
	je	.L42
.L34:
	movl	%ebx, %r9d
	leal	-1(%rbx), %r13d
	movl	%edi, %esi
	subl	%edi, %r9d
	leal	-4(%r9), %ecx
	movl	%r13d, %r11d
	subl	%edi, %r11d
	shrl	$2, %ecx
	addl	$1, %ecx
	cmpl	$2, %r11d
	leal	0(,%rcx,4), %r10d
	jbe	.L37
	movl	%edx, 8(%rsp)
	leaq	0(,%rsi,4), %rdi
	xorl	%r8d, %r8d
	movd	8(%rsp), %xmm5
	xorl	%esi, %esi
	movdqa	.LC6(%rip), %xmm3
	leaq	(%r12,%rdi), %r11
	addq	%rax, %rdi
	pshufd	$0, %xmm5, %xmm0
	movdqa	.LC7(%rip), %xmm2
	paddd	.LC5(%rip), %xmm0
.L38:
	movdqa	%xmm0, %xmm1
	addl	$1, %r8d
	movdqa	%xmm0, %xmm4
	pslld	$1, %xmm0
	paddd	%xmm2, %xmm1
	movups	%xmm0, (%rdi,%rsi)
	paddd	%xmm3, %xmm4
	movaps	%xmm1, (%r11,%rsi)
	addq	$16, %rsi
	cmpl	%r8d, %ecx
	jbe	.L58
	movdqa	%xmm4, %xmm0
	jmp	.L38
.L58:
	addl	%r10d, %edx
	cmpl	%r10d, %r9d
	je	.L42
.L37:
	leal	2(%rdx), %ecx
	leal	(%rdx,%rdx), %edi
	movl	%edx, %esi
	movl	%ecx, (%r12,%rsi,4)
	movl	%edi, (%rax,%rsi,4)
	leal	1(%rdx), %esi
	cmpl	%esi, %ebx
	jbe	.L42
	leal	3(%rdx), %r8d
	movl	%esi, %edi
	addl	%esi, %esi
	cmpl	%ecx, %ebx
	movl	%esi, (%rax,%rdi,4)
	movl	%r8d, (%r12,%rdi,4)
	jbe	.L42
	movl	%ecx, %esi
	addl	$4, %edx
	addl	%ecx, %ecx
	movl	%edx, (%r12,%rsi,4)
	movl	%ecx, (%rax,%rsi,4)
.L42:
	leaq	32(%rsp), %r9
	leaq	16(%rsp), %r8
	movl	%ebx, %ecx
	movl	%ebp, %edx
	movq	%rax, %rsi
	movq	%r12, %rdi
	call	DAXPY
	movq	40(%rsp), %rax
	subq	24(%rsp), %rax
	movl	%r13d, %edx
	pxor	%xmm0, %xmm0
	movl	(%r12), %esi
	pxor	%xmm1, %xmm1
	movl	$.LC3, %edi
	cvtsi2sdq	%rax, %xmm0
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	movl	%r13d, %eax
	movl	(%r12,%rax,4), %ecx
	xorl	%eax, %eax
	divsd	.LC2(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rsp)
	call	printf
	movsd	8(%rsp), %xmm0
	movl	$.LC4, %edi
	movl	$1, %eax
	call	printf
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L57:
	.cfi_restore_state
	xorl	%edx, %edx
	testl	%edi, %edi
	je	.L34
	jmp	.L33
.L48:
	movl	$4, %edx
	jmp	.L35
.L45:
	movl	$1, %edx
	jmp	.L35
.L46:
	movl	$2, %edx
	jmp	.L35
.L47:
	movl	$3, %edx
	jmp	.L35
.L56:
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
.LCOLDE8:
	.section	.text.startup
.LHOTE8:
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC2:
	.long	0
	.long	1104006501
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC5:
	.long	0
	.long	1
	.long	2
	.long	3
	.align 16
.LC6:
	.long	4
	.long	4
	.long	4
	.long	4
	.align 16
.LC7:
	.long	2
	.long	2
	.long	2
	.long	2
	.ident	"GCC: (GNU) 5.1.0"
	.section	.note.GNU-stack,"",@progbits
