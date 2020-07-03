.text
.align 2
.arch armv7-a
.syntax unified
.arm

.extern getint
.extern putint

.global add
add:
	add 	r0,r0,r1
	bx	lr

.global main
main:
	push	{fp,lr}
	add	fp,sp,#0
	sub	sp,sp,#8

	bl	getint
	str	r0,[fp,#-4]
	bl	getint
	str	r0,[fp,#-8]
	ldr	r0,[fp,#-4]
	ldr	r1,[fp,#-8]
	bl	add
	bl	putint

	sub	sp,fp,#0
	pop	{fp,pc}
