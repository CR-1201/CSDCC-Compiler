.arch armv7ve

.global	_g_x

.bss
.align 4
_g_x:
	.zero	864000000
.global	_g_y

.bss
.align 4
_g_y:
	.zero	864000000
.text
.global	main
main:
	push	{lr}
	sub	sp,	sp,	#36
b0:
	bl	getint
	mov	r0,	r0
	str	r0,	[sp,	#16]
	bl	getint
	mov	r0,	r0
	str	r0,	[sp,	#20]
	bl	_sysy_starttime
	mov	r2,	#0
	b	b1
.ltorg
b1:
	mov	r2,	r2
	ldr	r0,	[sp,	#16]
	cmp	r2,	r0
	blt	b2
	b	b3
.ltorg
b2:
	mov	r3,	#0
	b	b4
.ltorg
b4:
	mov	r3,	r3
	ldr	r0,	[sp,	#16]
	cmp	r3,	r0
	blt	b5
	b	b6
.ltorg
b5:
	mov	r0,	#0
	b	b7
.ltorg
b7:
	mov	r0,	r0
	ldr	r1,	[sp,	#16]
	cmp	r0,	r1
	blt	b8
	b	b9
.ltorg
b8:
	movw	r1,	:lower16:_g_x
	movt	r1,	:upper16:_g_x
	movw	r4,	#63744
	movt	r4,	#21
	mla	r5,	r2,	r4,	r1
	mov	r4,	#2400
	mla	r5,	r3,	r4,	r5
	mov	r4,	#4
	mla	r5,	r0,	r4,	r5
	mov	r1,	#1
	str	r1,	[r5]
	movw	r4,	:lower16:_g_y
	movt	r4,	:upper16:_g_y
	movw	r1,	#63744
	movt	r1,	#21
	mla	r4,	r2,	r1,	r4
	mov	r1,	#2400
	mla	r4,	r3,	r1,	r4
	mov	r1,	#4
	mla	r4,	r0,	r1,	r4
	mov	r1,	#0
	str	r1,	[r4]
	mov	r1,	#1
	add	r0,	r0,	r1
	mov	r0,	r0
	b	b7
.ltorg
b9:
	mov	r0,	#1
	add	r3,	r3,	r0
	mov	r3,	r3
	b	b4
.ltorg
b6:
	mov	r0,	#1
	add	r2,	r2,	r0
	mov	r2,	r2
	b	b1
.ltorg
b3:
	mov	r0,	#1
	ldr	r1,	[sp,	#16]
	sub	r0,	r1,	r0
	str	r0,	[sp,	#28]
	mov	r1,	#1
	mov	r0,	#1
	b	b10
.ltorg
b10:
	mov	r0,	r0
	str	r0,	[sp,	#12]
	mov	r1,	r1
	str	r1,	[sp,	#8]
	ldr	r0,	[sp,	#8]
	ldr	r1,	[sp,	#28]
	cmp	r0,	r1
	blt	b11
	b	b12
.ltorg
b11:
	mov	r0,	#1
	ldr	r1,	[sp,	#8]
	add	r5,	r1,	r0
	mov	r0,	#1
	ldr	r1,	[sp,	#8]
	sub	r4,	r1,	r0
	mov	r0,	#1
	b	b13
.ltorg
b13:
	mov	r0,	r0
	ldr	r1,	[sp,	#28]
	cmp	r0,	r1
	blt	b14
	b	b15
.ltorg
b14:
	mov	r1,	#1
	add	r7,	r0,	r1
	mov	r1,	#1
	sub	r6,	r0,	r1
	mov	r3,	#1
	b	b16
.ltorg
b16:
	mov	r2,	r3
	ldr	r1,	[sp,	#28]
	cmp	r2,	r1
	blt	b17
	b	b18
.ltorg
b17:
	movw	r1,	:lower16:_g_x
	movt	r1,	:upper16:_g_x
	movw	r3,	#63744
	movt	r3,	#21
	mla	r1,	r4,	r3,	r1
	mov	r3,	#2400
	mla	r1,	r0,	r3,	r1
	mov	r3,	#4
	mla	r1,	r2,	r3,	r1
	ldr	r1,	[r1]
	str	r1,	[sp,	#0]
	movw	r1,	:lower16:_g_x
	movt	r1,	:upper16:_g_x
	movw	r3,	#63744
	movt	r3,	#21
	mla	r1,	r5,	r3,	r1
	mov	r3,	#2400
	mla	r1,	r0,	r3,	r1
	mov	r3,	#4
	mla	r1,	r2,	r3,	r1
	ldr	r1,	[r1]
	str	r1,	[sp,	#4]
	movw	r1,	:lower16:_g_x
	movt	r1,	:upper16:_g_x
	movw	r8,	#63744
	movt	r8,	#21
	ldr	r3,	[sp,	#8]
	mla	r1,	r3,	r8,	r1
	mov	r8,	#2400
	mla	r1,	r6,	r8,	r1
	mov	r8,	#4
	mla	r1,	r2,	r8,	r1
	ldr	r1,	[r1]
	str	r1,	[sp,	#24]
	movw	r1,	:lower16:_g_x
	movt	r1,	:upper16:_g_x
	movw	r8,	#63744
	movt	r8,	#21
	ldr	r3,	[sp,	#8]
	mla	r1,	r3,	r8,	r1
	mov	r8,	#2400
	mla	r1,	r7,	r8,	r1
	mov	r8,	#4
	mla	r1,	r2,	r8,	r1
	ldr	r9,	[r1]
	mov	r1,	#1
	sub	r10,	r2,	r1
	movw	r1,	:lower16:_g_x
	movt	r1,	:upper16:_g_x
	movw	r8,	#63744
	movt	r8,	#21
	ldr	r3,	[sp,	#8]
	mla	r1,	r3,	r8,	r1
	mov	r8,	#2400
	mla	r1,	r0,	r8,	r1
	mov	r8,	#4
	mla	r1,	r10,	r8,	r1
	ldr	r10,	[r1]
	mov	r1,	#1
	add	r3,	r2,	r1
	movw	r1,	:lower16:_g_x
	movt	r1,	:upper16:_g_x
	movw	r11,	#63744
	movt	r11,	#21
	ldr	r8,	[sp,	#8]
	mla	r1,	r8,	r11,	r1
	mov	r11,	#2400
	mla	r1,	r0,	r11,	r1
	mov	r11,	#4
	mla	r1,	r3,	r11,	r1
	ldr	r8,	[r1]
	ldr	r11,	[sp,	#0]
	ldr	r1,	[sp,	#4]
	add	r1,	r11,	r1
	ldr	r11,	[sp,	#24]
	add	r1,	r1,	r11
	add	r1,	r1,	r9
	add	r1,	r1,	r10
	add	r1,	r1,	r8
	ldr	r8,	[sp,	#20]
	sdiv	r10,	r1,	r8
	movw	r1,	:lower16:_g_x
	movt	r1,	:upper16:_g_x
	movw	r9,	#63744
	movt	r9,	#21
	ldr	r8,	[sp,	#8]
	mla	r1,	r8,	r9,	r1
	mov	r9,	#2400
	mla	r1,	r0,	r9,	r1
	mov	r9,	#4
	mla	r1,	r2,	r9,	r1
	str	r10,	[r1]
	mov	r3,	r3
	b	b16
.ltorg
b18:
	mov	r1,	#1
	add	r0,	r0,	r1
	mov	r0,	r0
	b	b13
.ltorg
b15:
	mov	r1,	#1
	ldr	r2,	[sp,	#8]
	add	r1,	r2,	r1
	mov	r1,	r1
	mov	r0,	r0
	b	b10
.ltorg
b12:
	bl	_sysy_stoptime
	movw	r1,	:lower16:_g_x
	movt	r1,	:upper16:_g_x
	ldr	r0,	[sp,	#16]
	mov	r0,	r0
	mov	r1,	r1
	bl	putarray
	mov	r0,	#2
	ldr	r1,	[sp,	#16]
	sdiv	r2,	r1,	r0
	movw	r1,	:lower16:_g_x
	movt	r1,	:upper16:_g_x
	movw	r0,	#63744
	movt	r0,	#21
	mla	r1,	r2,	r0,	r1
	mov	r0,	#2400
	mla	r1,	r2,	r0,	r1
	ldr	r0,	[sp,	#16]
	mov	r0,	r0
	mov	r1,	r1
	bl	putarray
	mov	r0,	#1
	ldr	r1,	[sp,	#12]
	sub	r3,	r1,	r0
	mov	r1,	#1
	ldr	r0,	[sp,	#8]
	sub	r2,	r0,	r1
	movw	r1,	:lower16:_g_x
	movt	r1,	:upper16:_g_x
	movw	r0,	#63744
	movt	r0,	#21
	mla	r1,	r2,	r0,	r1
	mov	r0,	#2400
	mla	r1,	r3,	r0,	r1
	ldr	r0,	[sp,	#16]
	mov	r0,	r0
	mov	r1,	r1
	bl	putarray
	mov	r0,	#0
	add	sp,	sp,	#36
	pop	{pc}
	bx	lr
.ltorg
