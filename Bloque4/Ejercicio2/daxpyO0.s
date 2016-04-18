	.file	"daxpy.c"
	.text
	.globl	DAXPY
	.type	DAXPY, @function
DAXPY:
.LFB2:
	.cfi_startproc
	pushq	%rbp				# metemos los argumentos en la pila
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp			# movemos el puntero de pila a rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)		# -24(%rbp) = y
	movq	%rsi, -32(%rbp) 	# -32(%rbp) = x
	movl	%edx, -36(%rbp)		# -36(%rbp) = a
	movl	%ecx, -40(%rbp) 	# -40(%rbp) = n
	movl	$0, -4(%rbp)		# i = 0
	jmp	.L2
.L3:
	movl	-4(%rbp), %eax		# eax = i
	leaq	0(,%rax,4), %rdx 	# obtener la posicion de memoria
	movq	-24(%rbp), %rax 	# rax = y
	addq	%rax, %rdx 			# llevar el puntero a la posicion de memoria
	movl	-4(%rbp), %eax 		# eax = i
	leaq	0(,%rax,4), %rcx 	# rcx = 4*i
	movq	-24(%rbp), %rax 	# rax = y
	addq	%rcx, %rax 			# rax = 4*i + y
	movl	(%rax), %ecx 		# ecx = rax
	movl	-4(%rbp), %eax      # eax = i
	leaq	0(,%rax,4), %rsi    # calculamos la posicion
	movq	-32(%rbp), %rax     # guardamos x en rax
	addq	%rsi, %rax 			# llevar el puntero a la posicion de memoria
	movl	(%rax), %eax 		# guardamos el puntero en eax
	imull	-36(%rbp), %eax 	# eax = x[i]*a
	addl	%ecx, %eax 			# eax = x[i]*a + y
	movl	%eax, (%rdx) 		# rdx = eax
	addl	$1, -4(%rbp) 		# i++
.L2:
	movl	-4(%rbp), %eax		# eax = i
	cmpl	-40(%rbp), %eax 	# compare n : i
	jb	.L3						# if i < n goto L3
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	DAXPY, .-DAXPY
	.section	.rodata
	.align 8
.LC0:
	.string	"ERROR: falta tam del vector y constante\n"
.LC2:
	.string	"y[0] = %i, y[%i] = %i\n"
.LC3:
	.string	"\nTiempo (seg.) = %11.9f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movl	%edi, -84(%rbp)
	movq	%rsi, -96(%rbp)
	cmpl	$2, -84(%rbp)
	jg	.L5
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$40, %edx
	movl	$1, %esi
	movl	$.LC0, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L5:
	movq	-96(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movl	$10, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	strtol
	movl	%eax, -8(%rbp)
	movq	-96(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movl	$10, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	strtol
	movl	%eax, -12(%rbp)
	movl	-8(%rbp), %eax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -24(%rbp)
	movl	-8(%rbp), %eax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -32(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L6
.L7:
	movl	-4(%rbp), %eax
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	-4(%rbp), %edx
	addl	$2, %edx
	movl	%edx, (%rax)
	movl	-4(%rbp), %eax
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	-4(%rbp), %edx
	addl	%edx, %edx
	movl	%edx, (%rax)
	addl	$1, -4(%rbp)
.L6:
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jb	.L7
	leaq	-64(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	clock_gettime
	movl	-8(%rbp), %ecx
	movl	-12(%rbp), %edx
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	DAXPY
	leaq	-80(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	clock_gettime
	movq	-80(%rbp), %rdx
	movq	-64(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movq	-72(%rbp), %rdx
	movq	-56(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC1(%rip), %xmm2
	divsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -40(%rbp)
	movl	-8(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %eax
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %edx
	movl	-8(%rbp), %eax
	leal	-1(%rax), %esi
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	movl	%edx, %ecx
	movl	%esi, %edx
	movl	%eax, %esi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
	movq	-40(%rbp), %rax
	movq	%rax, -104(%rbp)
	movsd	-104(%rbp), %xmm0
	movl	$.LC3, %edi
	movl	$1, %eax
	call	printf
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC1:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 5.1.0"
	.section	.note.GNU-stack,"",@progbits
