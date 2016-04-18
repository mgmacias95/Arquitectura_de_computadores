	.file	"figura1-modificado.c"
	.comm	s,40000,32
	.text
	.globl	Funcion
	.type	Funcion, @function
Funcion:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	$1, -4(%rbp)	# variable ii en -4(%rbp)
	jmp	.L2
.L5:
	movl	$0, -12(%rbp)	# variable X1
	movl	$0, -16(%rbp)	# variable X2
	movl	$0, -8(%rbp)	# variable i en -8(%rbp)
	jmp	.L3 				# nos vamos a L3
.L4:	# BUCLE FOR INTERNO
	movl	-8(%rbp), %eax		# guardamos i en eax
	cltq						# extendemos su valor a 64 bits
	movl	s(,%rax,8), %eax	# cogemos 2*s[i].a
	leal	(%rax,%rax), %edx 	# edx = s[i].a
	movl	-4(%rbp), %eax		# eax = ii
	addl	%edx, %eax			# sumamos ambos valores
	addl	%eax, -12(%rbp)		# guardamos el valor en X1
	movl	-8(%rbp), %eax		# copiamos i en eax
	cltq						# extendemos su valor a 64bits
	movl	s+4(,%rax,8), %edx 	# cogemos s[i].b
	movl	%edx, %eax 			# lo guardamos en eax
	addl	%eax, %eax			# lo sumamos consigo mismo
	addl	%edx, %eax 			# y lo sumamos con lo inicial
	subl	-4(%rbp), %eax 		# le restamos ii
	addl	%eax, -16(%rbp)		# lo guardamos en X2
	movl	-8(%rbp), %eax 		# movemos i a eax
	addl	$1, %eax 			# y le sumamos 1
	cltq						# extendemos a 64 bits
	movl	s(,%rax,8), %eax 	# cogemos s[i+1].a
	leal	(%rax,%rax), %edx 	# guardamos el doble en edx
	movl	-4(%rbp), %eax		# guardamos ii en eax
	addl	%edx, %eax 			# lo sumamos
	addl	%eax, -12(%rbp) 	# y lo sumamos al valor de X1
	movl	-8(%rbp), %eax 		# guardamos i en eax
	addl	$1, %eax  			# incrementamos i en 1
	cltq 						# extendemos a 64 bits
	movl	s+4(,%rax,8), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	subl	-4(%rbp), %eax
	addl	%eax, -16(%rbp)
	movl	-8(%rbp), %eax
	addl	$2, %eax
	cltq
	movl	s(,%rax,8), %eax
	leal	(%rax,%rax), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	addl	%eax, -12(%rbp)
	movl	-8(%rbp), %eax
	addl	$2, %eax
	cltq
	movl	s+4(,%rax,8), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	subl	-4(%rbp), %eax
	addl	%eax, -16(%rbp)
	movl	-8(%rbp), %eax
	addl	$3, %eax
	cltq
	movl	s(,%rax,8), %eax
	leal	(%rax,%rax), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	addl	%eax, -12(%rbp)
	movl	-8(%rbp), %eax
	addl	$3, %eax
	cltq
	movl	s+4(,%rax,8), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	subl	-4(%rbp), %eax
	addl	%eax, -16(%rbp)
	addl	$4, -8(%rbp)		# suma 4 a i
.L3:
	cmpl	$4999, -8(%rbp)	# comparamos i y 4999
	jle	.L4 				# si es menor o igual vamos a L4
	movl	-4(%rbp), %eax # guardamos ii en eax
	cltq					# extendemos su valor a 64 bits
	leaq	0(,%rax,4), %rdx 	
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-12(%rbp), %eax
	cmpl	%eax, -16(%rbp)
	cmovle	-16(%rbp), %eax # operador ternario
	movl	%eax, (%rdx)
	addl	$1, -4(%rbp)	# incrementamos ii en 1
.L2:
	cmpl	$40000, -4(%rbp) # comparamos ii con 400000
	jle	.L5 			# si es menor volvemos al inicio del bucle
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	Funcion, .-Funcion
	.section	.rodata
.LC1:
	.string	"R[0] = %i, R[39999] = %i\n"
.LC2:
	.string	"\nTiempo (seg.) = %11.9f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$160064, %rsp
	leaq	-160032(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	clock_gettime
	leaq	-160016(%rbp), %rax
	movq	%rax, %rdi
	call	Funcion
	leaq	-160048(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	clock_gettime
	movq	-160048(%rbp), %rdx
	movq	-160032(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movq	-160040(%rbp), %rdx
	movq	-160024(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC0(%rip), %xmm2
	divsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rbp)
	movl	-20(%rbp), %edx
	movl	-160016(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movq	-8(%rbp), %rax
	movq	%rax, -160056(%rbp)
	movsd	-160056(%rbp), %xmm0
	movl	$.LC2, %edi
	movl	$1, %eax
	call	printf
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 5.1.0"
	.section	.note.GNU-stack,"",@progbits
