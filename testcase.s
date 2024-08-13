.arch armv7ve
.arm
.global	_g_A

.section .bss
.align 2
_g_A:
	.zero	7840000
.global	_g_b

.section .bss
.align 2
_g_b:
	.zero	5600
.global	_g_x

.section .bss
.align 2
_g_x:
	.zero	5600
.global	_g_y

.section .bss
.align 2
_g_y:
	.zero	5600
.section .text
.global	main
main:
	push	{lr}
	sub	sp,	sp,	#4
b28:
	movw	r0,	:lower16:_g_A
	movt	r0,	:upper16:_g_A
	bl	getarray
	movw	r0,	:lower16:_g_b
	movt	r0,	:upper16:_g_b
	bl	getarray
	movw	r5,	:lower16:_g_x
	movt	r5,	:upper16:_g_x
	mov	r0,	r5
	bl	getarray
	movw	r0,	:lower16:_g_y
	movt	r0,	:upper16:_g_y
	bl	getarray
	bl	_sysy_starttime
	mov	r1,	#0
b32:
	movw	r0,	#1400
	cmp	r1,	r0
	blt	b33
b46:
	mov	r1,	#0
b47:
	movw	r0,	#1400
	cmp	r1,	r0
	blt	b48
b52:
	movw	r1,	#1399
b53:
	mov	r0,	#0
	cmp	r1,	r0
	bge	b54
	b	b58
.ltorg
b54:
	movw	r0,	:lower16:_g_y
	movt	r0,	:upper16:_g_y
	ldr	r2,	[r0,	r1, lsl #2]
	mov	r0,	#1
	add	r3,	r1,	r0
b55:
	movw	r0,	#1400
	cmp	r3,	r0
	blt	b56
	b	b57
.ltorg
b56:
	movw	r0,	:lower16:_g_A
	movt	r0,	:upper16:_g_A
	movw	r4,	#5600
	mla	r0,	r1,	r4,	r0
	ldr	r4,	[r0,	r3, lsl #2]
	movw	r5,	:lower16:_g_x
	movt	r5,	:upper16:_g_x
	ldr	r0,	[r5,	r3, lsl #2]
	mul	r0,	r4,	r0
	sub	r2,	r2,	r0
	mov	r0,	#1
	add	r3,	r3,	r0
	b	b55
.ltorg
b57:
	movw	r5,	:lower16:_g_x
	movt	r5,	:upper16:_g_x
	add	r4,	r5,	r1, lsl #2
	movw	r0,	:lower16:_g_A
	movt	r0,	:upper16:_g_A
	movw	r3,	#5600
	mla	r0,	r1,	r3,	r0
	mov	r3,	r1, lsl #2
	ldr	r0,	[r0,	r1, lsl #2]
	sdiv	r0,	r2,	r0
	str	r0,	[r4]
	mov	r0,	#1
	sub	r1,	r1,	r0
	b	b53
.ltorg
b58:
	bl	_sysy_stoptime
	movw	r0,	#1400
	mov	r1,	r5
	bl	putarray
	mov	r0,	#0
	add	sp,	sp,	#4
	pop	{pc}
	bx	lr
.ltorg
b48:
	movw	r0,	:lower16:_g_b
	movt	r0,	:upper16:_g_b
	add	r0,	r0,	r1, lsl #2
	ldr	r2,	[r0]
	mov	r3,	#0
b49:
	cmp	r3,	r1
	blt	b50
	b	b51
.ltorg
b50:
	movw	r0,	:lower16:_g_A
	movt	r0,	:upper16:_g_A
	movw	r4,	#5600
	mla	r0,	r1,	r4,	r0
	ldr	r6,	[r0,	r3, lsl #2]
	movw	r0,	:lower16:_g_y
	movt	r0,	:upper16:_g_y
	mov	r4,	r3, lsl #2
	ldr	r0,	[r0,	r3, lsl #2]
	mul	r0,	r6,	r0
	sub	r2,	r2,	r0
	mov	r0,	#1
	add	r3,	r3,	r0
	b	b49
.ltorg
b51:
	movw	r0,	:lower16:_g_y
	movt	r0,	:upper16:_g_y
	mov	r3,	r1, lsl #2
	str	r2,	[r0,	r1]
	mov	r0,	#1
	add	r1,	r1,	r0
	b	b47
.ltorg
b33:
	mov	r4,	#0
b34:
	cmp	r4,	r1
	blt	b35
	b	b39
.ltorg
b35:
	movw	r0,	:lower16:_g_A
	movt	r0,	:upper16:_g_A
	movw	r2,	#5600
	mla	r6,	r1,	r2,	r0
	add	r6,	r6,	r4, lsl #2
	ldr	r2,	[r6]
	mov	r3,	#0
b36:
	cmp	r3,	r4
	blt	b38
b37:
	movw	r0,	:lower16:_g_A
	movt	r0,	:upper16:_g_A
	movw	r3,	#5600
	mla	r0,	r4,	r3,	r0
	mov	r3,	r4, lsl #2
	ldr	r0,	[r0,	r4, lsl #2]
	sdiv	r0,	r2,	r0
	str	r0,	[r6]
	mov	r0,	#1
	add	r4,	r4,	r0
	b	b34
.ltorg
b38:
	movw	r0,	:lower16:_g_A
	movt	r0,	:upper16:_g_A
	movw	r7,	#5600
	mla	r0,	r1,	r7,	r0
	ldr	r8,	[r0,	r3, lsl #2]
	movw	r0,	:lower16:_g_A
	movt	r0,	:upper16:_g_A
	movw	r7,	#5600
	mla	r0,	r3,	r7,	r0
	mov	r7,	r4, lsl #2
	ldr	r0,	[r0,	r4, lsl #2]
	mul	r0,	r8,	r0
	sub	r2,	r2,	r0
	mov	r0,	#1
	add	r3,	r3,	r0
	b	b36
.ltorg
b39:
	mov	r2,	r1
b40:
	movw	r0,	#1400
	cmp	r2,	r0
	blt	b41
	b	b45
.ltorg
b41:
	movw	r0,	:lower16:_g_A
	movt	r0,	:upper16:_g_A
	movw	r3,	#5600
	mla	r6,	r1,	r3,	r0
	add	r6,	r6,	r2, lsl #2
	ldr	r3,	[r6]
	mov	r4,	#0
b42:
	cmp	r4,	r1
	blt	b43
	b	b44
.ltorg
b43:
	movw	r0,	:lower16:_g_A
	movt	r0,	:upper16:_g_A
	movw	r7,	#5600
	mla	r0,	r1,	r7,	r0
	ldr	r7,	[r0,	r4, lsl #2]
	movw	r0,	:lower16:_g_A
	movt	r0,	:upper16:_g_A
	movw	r8,	#5600
	mla	r0,	r4,	r8,	r0
	mov	r8,	r2, lsl #2
	ldr	r0,	[r0,	r2, lsl #2]
	mul	r0,	r7,	r0
	sub	r3,	r3,	r0
	mov	r0,	#1
	add	r4,	r4,	r0
	b	b42
.ltorg
b44:
	str	r3,	[r6]
	mov	r0,	#1
	add	r2,	r2,	r0
	b	b40
.ltorg
b45:
	mov	r0,	#1
	add	r1,	r1,	r0
	b	b32
.ltorg
