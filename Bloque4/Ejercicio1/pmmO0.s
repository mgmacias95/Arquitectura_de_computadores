	.file	"pmm-secuencial-modificado.c"
	.section	.rodata
.LC0:
	.string	"%d "
	.text
	.globl	printMatriz
	.type	printMatriz, @function
printMatriz:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L5:
	movl	$0, -8(%rbp)
	jmp	.L3
.L4:
	movl	-4(%rbp), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	addl	$1, -8(%rbp)
.L3:
	movl	-8(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L4
	movl	$10, %edi
	call	putchar
	addl	$1, -4(%rbp)
.L2:
	movl	-4(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L5
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	printMatriz, .-printMatriz
	.globl	pmm
	.type	pmm, @function
pmm:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	%ecx, -44(%rbp)
	movq	%r8, -56(%rbp)
	movq	%r9, -64(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	clock_gettime
	movl	$0, -4(%rbp) 		# i = 0
	jmp	.L7
.L12:
	movl	$0, -12(%rbp) 		# k = 0
	jmp	.L8 					# goto L8
.L11:
	movl	$0, -8(%rbp)		# j = 0
	jmp	.L9 					# goto L9
.L10:
	movl	-4(%rbp), %eax 		# eax = i
	imull	-44(%rbp), %eax 	# eax = n*i
	movl	%eax, %edx 			# edx = eax
	movl	-8(%rbp), %eax 		# eax = j
	addl	%edx, %eax 			# eax = j + (n*i)
	movl	%eax, %eax 			# eax = eax
	leaq	0(,%rax,4), %rdx 	# rdx = posicion del vector
	movq	-24(%rbp), %rax 	# rax = a
	addq	%rax, %rdx 			# rdx = posicion de memoria actual
	movl	-4(%rbp), %eax 		# eax = i
	imull	-44(%rbp), %eax 	# eax = i*n
	movl	%eax, %ecx 			# ecx = eax
	movl	-8(%rbp), %eax 		# eax = j
	addl	%ecx, %eax 			# eax = j + i*n
	movl	%eax, %eax 			# eax = eax
	leaq	0(,%rax,4), %rcx 	# rcx = posicion del vector
	movq	-24(%rbp), %rax 	# rcx = a
	addq	%rcx, %rax 			# rax = posicion de memoria actual
	movl	(%rax), %ecx 		# ecx = rax
	movl	-4(%rbp), %eax 		# eax = i
	imull	-44(%rbp), %eax 	# eax = i*n
	movl	%eax, %esi 			# esi = i*n
	movl	-12(%rbp), %eax 	# eax = k
	addl	%esi, %eax 			# eax = k + i*n
	movl	%eax, %eax 			# eax = eax
	leaq	0(,%rax,4), %rsi 	# rsi = posicion del vector
	movq	-32(%rbp), %rax 	# rax = b 
	addq	%rsi, %rax 			# rax = posicion de memoria actual
	movl	(%rax), %esi 		# esi = rax
	movl	-12(%rbp), %eax 	# eax = k
	imull	-44(%rbp), %eax 	# eax = k*n
	movl	%eax, %edi 			# edi = k*n
	movl	-8(%rbp), %eax 		# eax = j
	addl	%edi, %eax 			# eax = k*n + j
	movl	%eax, %eax 			# eax = eax
	leaq	0(,%rax,4), %rdi 	# rdi = posicion del vector
	movq	-40(%rbp), %rax 	# rax = c
	addq	%rdi, %rax 			# rax = posicion de memoria actual
	movl	(%rax), %eax 		# eax = rax
	imull	%esi, %eax 			# eax = b * c
	addl	%ecx, %eax 			# eax = b * c + a
	movl	%eax, (%rdx) 		# rdx = eax
	addl	$1, -8(%rbp) 		# j++
.L9:
	movl	-8(%rbp), %eax 		# eax = j
	cmpl	-44(%rbp), %eax 	# compare j:n
	jb	.L10 					# if j<n goto L10
	addl	$1, -12(%rbp)
.L8:
	movl	-12(%rbp), %eax 	# eax = k
	cmpl	-44(%rbp), %eax 	# compare k:n
	jb	.L11 					# if k<n foto L11
	addl	$1, -4(%rbp)
.L7:
	movl	-4(%rbp), %eax		# eax = i
	cmpl	-44(%rbp), %eax 	# compare i:n
	jb	.L12 					# if i<n goto L2
	movq	-64(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	clock_gettime
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	pmm, .-pmm
	.section	.rodata
	.align 8
.LC1:
	.string	"ERROR: falta numero de filas y columnas\n"
.LC3:
	.string	"M1:"
.LC4:
	.string	"M2:"
.LC5:
	.string	"Sol:"
	.align 8
.LC6:
	.string	"Tiempo = %11.9f\t Primera = %d\t Ultima=%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$144, %rsp
	movl	%edi, -116(%rbp)
	movq	%rsi, -128(%rbp)
	cmpl	$1, -116(%rbp)
	jg	.L14
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$40, %edx
	movl	$1, %esi
	movl	$.LC1, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L14:
	movq	-128(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movl	$10, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	strtol
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	imull	-12(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	-16(%rbp), %eax
	salq	$2, %rax
	addq	$63, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	addq	$63, %rax
	andq	$-64, %rax
	movq	%rax, -32(%rbp)
	movl	-16(%rbp), %eax
	salq	$2, %rax
	addq	$63, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	addq	$63, %rax
	andq	$-64, %rax
	movq	%rax, -48(%rbp)
	movl	-16(%rbp), %eax
	salq	$2, %rax
	addq	$63, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	addq	$63, %rax
	andq	$-64, %rax
	movq	%rax, -64(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L15
.L18:
	movl	$0, -8(%rbp)
	jmp	.L16
.L17:
	movl	-4(%rbp), %eax
	imull	-12(%rbp), %eax
	movl	%eax, %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, %eax
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	$0, (%rax)
	movl	-4(%rbp), %eax
	imull	-12(%rbp), %eax
	movl	%eax, %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, %eax
	leaq	0(,%rax,4), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movl	$2, (%rax)
	movl	-4(%rbp), %eax
	imull	-12(%rbp), %eax
	movl	%eax, %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, %eax
	leaq	0(,%rax,4), %rdx
	movq	-64(%rbp), %rax
	addq	%rdx, %rax
	movl	$1, (%rax)
	addl	$1, -8(%rbp)
.L16:
	movl	-8(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jb	.L17
	addl	$1, -4(%rbp)
.L15:
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jb	.L18
	leaq	-112(%rbp), %r8
	leaq	-96(%rbp), %rdi
	movl	-12(%rbp), %ecx
	movq	-64(%rbp), %rdx
	movq	-48(%rbp), %rsi
	movq	-32(%rbp), %rax
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	pmm
	movq	-112(%rbp), %rdx
	movq	-96(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movq	-104(%rbp), %rdx
	movq	-88(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC2(%rip), %xmm2
	divsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -72(%rbp)
	cmpl	$14, -12(%rbp)
	ja	.L19
	movl	$.LC3, %edi
	call	puts
	movl	-12(%rbp), %eax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	printMatriz
	movl	$.LC4, %edi
	call	puts
	movl	-12(%rbp), %eax
	movq	-64(%rbp), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	printMatriz
	movl	$.LC5, %edi
	call	puts
	movl	-12(%rbp), %eax
	movq	-32(%rbp), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	printMatriz
	jmp	.L20
.L19:
	movl	-12(%rbp), %eax
	addl	%eax, %eax
	subl	$2, %eax
	movl	%eax, %eax
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %edx
	movq	-32(%rbp), %rax
	movl	(%rax), %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, -136(%rbp)
	movsd	-136(%rbp), %xmm0
	movl	$.LC6, %edi
	movl	$1, %eax
	call	printf
.L20:
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC2:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 5.1.0"
	.section	.note.GNU-stack,"",@progbits
