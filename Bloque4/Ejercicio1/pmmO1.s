	.file	"pmm-secuencial-modificado.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d "
	.text
	.globl	printMatriz
	.type	printMatriz, @function
printMatriz:
.LFB33:
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
	movl	%edi, %r14d
	movq	%rsi, %r12
	movl	$0, %r13d
	testl	%edi, %edi
	jg	.L7
	jmp	.L1
.L4:
	movslq	%ebx, %rax
	movl	(%r12,%rax,4), %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jne	.L4
	movl	$10, %edi
	call	putchar
	addl	$1, %r13d
	cmpl	%r13d, %r14d
	je	.L1
.L7:
	movl	%r13d, %ebx
	leal	(%r14,%r13), %ebp
	jmp	.L4
.L1:
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
.LFE33:
	.size	printMatriz, .-printMatriz
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
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movq	%rdi, %rbx
	movq	%rsi, %r13
	movq	%rdx, %rbp
	movl	%ecx, %r12d
	movq	%r9, %r15
	movq	%r8, %rsi
	movl	$0, %edi
	call	clock_gettime
	movl	%r12d, %edi
	movl	$0, %r14d
	movl	$0, %r11d
	testl	%r12d, %r12d 			# check n>0
	jne	.L17 						# if n!=0 goto L17
	jmp	.L11 						# if n==0 goto L11
.L12:
	movl	%eax, %ecx 				# ecx = eax
	leal	(%rsi,%rax), %edx 		# edx = eax + rsi
	movl	0(%rbp,%rdx,4), %edx 	# edx = 4*rdx + rbp
	imull	(%r8), %edx 			# edx *= r8
	addl	%edx, (%rbx,%rcx,4) 	# 4*rcx+rbx = edx
	addl	$1, %eax 				# j++
	cmpl	%eax, %edi 				# compare j:n 
	jne	.L12 						# if j!=n goto L12
	addl	$1, %r9d 				# k++
	addl	%r12d, %esi 			# esi += n
	cmpl	%edi, %r9d 				# compare k:n
	je	.L13 						# if k==n goto L13
.L14:
	movl	%r9d, %eax 				# eax = j
	leaq	0(%r13,%rax,4), %r8 	# r8 = 4*j + r13
	movl	%r10d, %eax 			# eax = rd10
	jmp	.L12
.L13:
	addl	$1, %r11d 				# i++
	addl	%r12d, %edi 			# edi += n
	subl	%r12d, %r14d 
	cmpl	%r11d, %r12d 			# compare i:n
	je	.L11 						# if i==n goto L11
.L17:
	movl	%edi, %r10d 			# i = 0
	subl	%r12d, %r10d 			# rd10 = 0
	movl	%r14d, %esi 			# esi = 0
	movl	%r10d, %r9d 			# j = 0
	jmp	.L14 						# goto L14
.L11:
	movq	%r15, %rsi
	movl	$0, %edi
	call	clock_gettime
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
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
.LFE34:
	.size	pmm, .-pmm
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"ERROR: falta numero de filas y columnas\n"
	.section	.rodata.str1.1
.LC2:
	.string	"M1:"
.LC3:
	.string	"M2:"
.LC4:
	.string	"Sol:"
	.section	.rodata.str1.8
	.align 8
.LC6:
	.string	"Tiempo = %11.9f\t Primera = %d\t Ultima=%d\n"
	.text
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
	jg	.L20
	movq	stderr(%rip), %rcx
	movl	$40, %edx
	movl	$1, %esi
	movl	$.LC1, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L20:
	movq	8(%rsi), %rdi
	movl	$10, %edx
	movl	$0, %esi
	call	strtol
	movq	%rax, %r14
	movl	%eax, %r13d
	imull	%eax, %eax
	leaq	63(,%rax,4), %r12
	movq	%r12, %rdi
	call	malloc
	movq	%rax, (%rsp)
	leaq	63(%rax), %rbx
	andq	$-64, %rbx
	movq	%r12, %rdi
	call	malloc
	movq	%rax, 8(%rsp)
	leaq	63(%rax), %rbp
	andq	$-64, %rbp
	movq	%r12, %rdi
	call	malloc
	movq	%rax, %r15
	leaq	63(%rax), %r12
	andq	$-64, %r12
	movl	$0, %eax
	movl	$0, %esi
	testl	%r14d, %r14d
	jne	.L30
	jmp	.L31
.L23:
	movl	%eax, %edx
	movl	$0, (%rbx,%rdx,4)
	movl	$2, 0(%rbp,%rdx,4)
	movl	$1, (%r12,%rdx,4)
	addl	$1, %eax
	cmpl	%ecx, %eax
	jne	.L23
	addl	$1, %esi
	movl	%ecx, %eax
	cmpl	%esi, %r13d
	je	.L24
.L30:
	leal	0(%r13,%rax), %ecx
	jmp	.L23
.L24:
	leaq	16(%rsp), %r9
	leaq	32(%rsp), %r8
	movl	%r14d, %ecx
	movq	%r12, %rdx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	pmm
	cmpl	$14, %r14d
	ja	.L25
.L27:
	movl	$.LC2, %edi
	call	puts
	movq	%rbp, %rsi
	movl	%r14d, %edi
	call	printMatriz
	movl	$.LC3, %edi
	call	puts
	movq	%r12, %rsi
	movl	%r14d, %edi
	call	printMatriz
	movl	$.LC4, %edi
	call	puts
	movq	%rbx, %rsi
	movl	%r14d, %edi
	call	printMatriz
	jmp	.L26
.L25:
	leal	-2(%r14,%r14), %eax
	movl	%eax, %eax
	movl	(%rbx,%rax,4), %edx
	movq	24(%rsp), %rax
	subq	40(%rsp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movapd	%xmm0, %xmm1
	divsd	.LC5(%rip), %xmm1
	movq	16(%rsp), %rax
	subq	32(%rsp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	addsd	%xmm1, %xmm0
	movl	(%rbx), %esi
	movl	$.LC6, %edi
	movl	$1, %eax
	call	printf
	jmp	.L26
.L31:
	leaq	16(%rsp), %r9
	leaq	32(%rsp), %r8
	movl	$0, %ecx
	movq	%r12, %rdx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	pmm
	jmp	.L27
.L26:
	movq	(%rsp), %rdi
	call	free
	movq	8(%rsp), %rdi
	call	free
	movq	%r15, %rdi
	call	free
	movl	$0, %eax
	addq	$56, %rsp
	.cfi_def_cfa_offset 56
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
.LFE35:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC5:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 5.1.0"
	.section	.note.GNU-stack,"",@progbits
