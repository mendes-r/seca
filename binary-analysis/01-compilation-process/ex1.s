	.file	"ex1.c"
	.intel_syntax noprefix
	.text
	.globl	factorial
	.type	factorial, @function
factorial:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	DWORD PTR [rbp-20], edi
	mov	DWORD PTR [rbp-8], 1
	mov	DWORD PTR [rbp-4], 2
	jmp	.L2
.L3:
	mov	eax, DWORD PTR [rbp-8]
	imul	eax, DWORD PTR [rbp-4]
	mov	DWORD PTR [rbp-8], eax
	add	DWORD PTR [rbp-4], 1
.L2:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-20]
	jle	.L3
	mov	eax, DWORD PTR [rbp-8]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	factorial, .-factorial
	.section	.rodata
.LC0:
	.string	"! is equal to "
.LC1:
	.string	"%d%s"
.LC2:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	DWORD PTR [rbp-4], 5
	mov	eax, DWORD PTR [rbp-4]
	mov	edx, OFFSET FLAT:.LC0
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC1
	mov	eax, 0
	call	printf
	mov	eax, DWORD PTR [rbp-4]
	mov	edi, eax
	call	factorial
	mov	DWORD PTR [rbp-8], eax
	mov	eax, DWORD PTR [rbp-8]
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC2
	mov	eax, 0
	call	printf
	mov	eax, 0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (GNU) 13.2.1 20230728 (Red Hat 13.2.1-1)"
	.section	.note.GNU-stack,"",@progbits
