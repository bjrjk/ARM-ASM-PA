.text
.align 2
.arch armv7-a
.syntax unified
.arm

.extern getint
.extern putint

/*
	Read a decimal int from STDIN, print it out in binary form. 
*/

.global divout
divout:
	push	{fp,lr}
	add	fp,sp,#0
	sub	sp,sp,#8

	/* Trivial Case, if r0==0 return*/
	cmp	r0,#0
	beq	_divout_fi
	/* call divout recursively and output */
	str	r0,[fp,#-4]
	mov	r0,r0,LSR #1
	bl	divout
	ldr	r0,[fp,#-4]
	and	r0,r0,#1
	bl	putint

_divout_fi:
	sub	sp,fp,#0
	pop	{fp,pc}

.global main
main:
	push	{fp,lr}
	add	fp,sp,#0
	sub	sp,sp,#8

	bl	getint
	bl	divout

	sub	sp,fp,#0
	pop	{fp,pc}
