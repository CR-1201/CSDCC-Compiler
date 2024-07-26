.arch armv7ve

.global	_g___HELLO

.data
.align 4
_g___HELLO:
	.word	87
	.word	101
	.word	108
	.word	99
	.word	111
	.word	109
	.word	101
	.word	32
	.word	116
	.word	111
	.word	32
	.word	116
	.word	104
	.word	101
	.word	32
	.word	74
	.word	97
	.word	112
	.word	97
	.word	114
	.word	105
	.word	32
	.word	80
	.word	97
	.word	114
	.word	107
	.word	33
	.word	10
	.zero	288
.global	_g_N4__mE___

.data
.align 4
_g_N4__mE___:
	.word	83
	.word	97
	.word	97
	.word	98
	.word	97
	.word	114
	.word	117
	.zero	172
	.word	75
	.word	97
	.word	98
	.word	97
	.word	110
	.zero	180
	.word	72
	.word	97
	.word	115
	.word	104
	.word	105
	.word	98
	.word	105
	.word	114
	.word	111
	.word	107
	.word	111
	.word	117
	.zero	152
	.word	65
	.word	114
	.word	97
	.word	105
	.word	103
	.word	117
	.word	109
	.word	97
	.zero	168
	.word	72
	.word	117
	.word	110
	.word	98
	.word	111
	.word	114
	.word	117
	.word	116
	.word	111
	.word	32
	.word	80
	.word	101
	.word	110
	.word	103
	.word	105
	.word	110
	.zero	136
	.word	84
	.word	97
	.word	105
	.word	114
	.word	105
	.word	107
	.word	117
	.word	32
	.word	79
	.word	111
	.word	107
	.word	97
	.word	109
	.word	105
	.zero	144
.global	_g_saY_HeI10_To

.data
.align 4
_g_saY_HeI10_To:
	.word	32
	.word	115
	.word	97
	.word	121
	.word	115
	.word	32
	.word	104
	.word	101
	.word	108
	.word	108
	.word	111
	.word	32
	.word	116
	.word	111
	.word	32
	.zero	100
.global	_g_RET

.data
.align 4
_g_RET:
	.word	10
	.zero	16
.text
.global	putstr
putstr:
	push	{r4,r5,lr}
	sub	sp,	sp,	#4
b0:
	mov	r5,	r0
	mov	r4,	#0
	b	b1
.ltorg
b1:
	mov	r4,	r4
	mov	r2,	#4
	mla	r2,	r4,	r2,	r5
	ldr	r1,	[r2]
	mov	r0,	#0
	cmp	r1,	r0
	bne	b2
	b	b3
.ltorg
b2:
	ldr	r0,	[r2]
	mov	r0,	r0
	bl	putch
	mov	r0,	#1
	add	r4,	r4,	r0
	mov	r4,	r4
	b	b1
.ltorg
b3:
	mov	r0,	r4
	add	sp,	sp,	#4
	pop	{r4,r5,pc}
	bx	lr
.ltorg
.global	main
main:
	push	{lr}
	sub	sp,	sp,	#4
b5:
	movw	r0,	:lower16:_g___HELLO
	movt	r0,	:upper16:_g___HELLO
	mov	r0,	r0
	mov	r0,	r0
	bl	putstr
	mov	r0,	r0
	movw	r4,	:lower16:_g_RET
	movt	r4,	:upper16:_g_RET
	mov	r4,	r4
	movw	r6,	:lower16:_g_saY_HeI10_To
	movt	r6,	:upper16:_g_saY_HeI10_To
	mov	r6,	r6
	mov	r7,	#0
	mov	r5,	#0
	mov	r8,	#0
	b	b6
.ltorg
b6:
	mov	r8,	r8
	mov	r5,	r5
	mov	r7,	r7
	mov	r0,	#6
	sdiv	r5,	r7,	r0
	mov	r0,	#6
	mul	r0,	r5,	r0
	sub	r8,	r7,	r0
	cmp	r5,	r8
	bne	b9
	b	b10
.ltorg
b9:
	movw	r0,	:lower16:_g_N4__mE___
	movt	r0,	:upper16:_g_N4__mE___
	mov	r0,	r0
	mov	r1,	#200
	mla	r0,	r5,	r1,	r0
	mov	r0,	r0
	mov	r0,	r0
	bl	putstr
	mov	r0,	r0
	mov	r0,	r6
	bl	putstr
	mov	r0,	r0
	movw	r0,	:lower16:_g_N4__mE___
	movt	r0,	:upper16:_g_N4__mE___
	mov	r0,	r0
	mov	r1,	#200
	mla	r0,	r8,	r1,	r0
	mov	r0,	r0
	mov	r0,	r0
	bl	putstr
	mov	r0,	r0
	mov	r0,	r4
	bl	putstr
	mov	r0,	r0
	b	b10
.ltorg
b10:
	mov	r0,	#17
	mul	r0,	r7,	r0
	mov	r1,	#23
	add	r0,	r0,	r1
	mov	r1,	#32
	sdiv	r7,	r0,	r1
	mul	r7,	r7,	r1
	sub	r7,	r0,	r7
	mov	r0,	#0
	cmp	r7,	r0
	beq	b11
	b	b12
.ltorg
b11:
	mov	r0,	#0
	add	sp,	sp,	#4
	pop	{pc}
	bx	lr
.ltorg
b12:
	mov	r7,	r7
	mov	r5,	r5
	mov	r8,	r8
	b	b6
.ltorg
