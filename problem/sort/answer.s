.text
.align 2
.arch armv7-a
.syntax unified
.arm

.extern getint
.extern putint

.comm	n,4,4
.comm	arr,40,4

.global cmpSwap
cmpSwap:
	/* 
		int address in r0,r1. 
		if r0>r1,
		Swap the value in address stored in register r0,r1. 
	*/
	ldr	r2,[r0]
	ldr	r3,[r1]
	cmp	r2,r3
	ble	_cmpSwap_fi
	str	r2,[r1]
	str	r3,[r0]
_cmpSwap_fi:
	bx	lr

.global sort
sort:
	push	{fp,lr}
	push	{r4-r10}
	add	fp,sp,#0
	sub	sp,sp,#8

	/* Bubble Sort  */
	/*
		Equivalent C:
		for(int i=0;i<n;i++){
			for(int j=n-1;j>0;j--){
				if(arr[j-1]>arr[j])swap(arr[j-1],arr[j]);
			}
		}
	*/

	ldr	r9,=n
	ldr	r9,[r9] /* r9(n) */
	ldr	r10,=arr /* r10(&arr) */

	ldr	r4,=0 /* r4(i) */
_sort_outer_start:
	cmp	r4,r9
	bge	_sort_fi

	sub	r5,r9,#1 /* r5(j),j=n-1 */
_sort_inner_start:
	cmp	r5,#0
	ble	_sort_outer_fi

	sub	r6,r5,#1 /* r6(j-1) */
	add	r0,r10,r6,LSL #2 /* r0=arr+j-1 */
	add	r1,r10,r5,LSL #2 /* r1=arr+j */
	bl	cmpSwap

	sub	r5,r5,#1
	b	_sort_inner_start
_sort_outer_fi:
	add	r4,r4,#1
	b	_sort_outer_start

_sort_fi:
	sub	sp,fp,#0
	pop	{r4-r10}
	pop	{fp,pc}

.global main
main:
	push	{fp,lr}
	add	fp,sp,#0
	sub	sp,sp,#8

	/* n=getint()  */
	bl	getint
	mov	r9,r0
	ldr	r8,=n
	str	r9,[r8]

	/* i=0,r4(i) */
	ldr	r4,=0
	ldr	r7,=arr
_main_input_start:
	cmp	r4,r9
	bge	_main_sort
	bl	getint
	str	r0,[r7,r4,LSL #2]
	add	r4,r4,#1
	b	_main_input_start

_main_sort:
	bl	sort

	ldr	r8,=n
	ldr	r9,[r8]
	ldr	r4,=0
	ldr	r7,=arr
_main_output_start:
	cmp	r4,r9
	bge	_main_fi
	ldr	r0,[r7,r4,LSL #2]
	bl	putint
	add	r4,r4,#1
	b 	_main_output_start

_main_fi:
	sub	sp,fp,#0
	pop	{fp,pc}
