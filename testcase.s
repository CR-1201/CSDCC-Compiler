.arch armv7ve

.global	_g_a

.bss
.align 4
_g_a:
	.zero	3600
.global	_g_step

.data
.align 4
_g_step:
	.word	1
	.zero	4
	.word	-1
	.zero	8
	.word	1
	.zero	4
	.word	-1

.global	_g_w

.bss
.align 4
_g_w:
	.zero	4
.global	_g_h

.bss
.align 4
_g_h:
	.zero	4
.global	_g_x_1

.bss
.align 4
_g_x_1:
	.zero	4
.global	_g_y_1

.bss
.align 4
_g_y_1:
	.zero	4
.text
.global	search
search:
	push	{r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}
b0:
	mov	r8,	r1
	mov	r6,	r0
	mov	r0,	#10
	cmp	r2,	r0
	bgt	b1
	b	b2
.ltorg
b1:
	mov	r0,	#1073741824
	pop	{r4,r5,r6,r7,r8,r9,r10,r11,r12,pc}
	bx	lr
.ltorg
b2:
	mov	r0,	#1
	add	r7,	r2,	r0
	mov	r4,	#1073741824
	mov	r5,	#0
	b	b4
.ltorg
b4:
	mov	r0,	#4
	cmp	r5,	r0
	blt	b5
	b	b6
.ltorg
b5:
	movw	r2,	:lower16:_g_step
	movt	r2,	:upper16:_g_step
	mov	r0,	#8
	mla	r3,	r5,	r0,	r2
	mov	r0,	#4
	add	r3,	r3,	r0
	movw	r2,	:lower16:_g_step
	movt	r2,	:upper16:_g_step
	mov	r0,	#8
	mla	r2,	r5,	r0,	r2
	mov	r10,	#0
	mov	r0,	r6
	mov	r1,	r8
	b	b7
.ltorg
b7:
	movw	r9,	:lower16:_g_a
	movt	r9,	:upper16:_g_a
	mov	r11,	#120
	mla	r9,	r0,	r11,	r9
	mov	r11,	#4
	mla	r9,	r1,	r11,	r9
	ldr	r11,	[r9]
	mov	r12,	#1
	cmp	r11,	r12
	bne	b8
	b	b9
.ltorg
b8:
	movw	r11,	:lower16:_g_x_1
	movt	r11,	:upper16:_g_x_1
	ldr	r11,	[r11]
	cmp	r0,	r11
	beq	b12
	b	b11
.ltorg
b11:
	ldr	r9,	[r2]
	ldr	r11,	[r3]
	mov	r12,	#1
	add	r10,	r10,	r12
	add	r1,	r1,	r11
	add	r0,	r0,	r9
	b	b7
.ltorg
b12:
	movw	r11,	:lower16:_g_y_1
	movt	r11,	:upper16:_g_y_1
	ldr	r11,	[r11]
	cmp	r1,	r11
	beq	b10
	b	b11
.ltorg
b10:
	b	b9
.ltorg
b9:
	movw	r2,	:lower16:_g_x_1
	movt	r2,	:upper16:_g_x_1
	ldr	r2,	[r2]
	cmp	r0,	r2
	beq	b15
	b	b14
.ltorg
b14:
	mov	r2,	#1
	cmp	r10,	r2
	ble	b17
	b	b18
.ltorg
b17:
	mov	r0,	#1
	add	r5,	r5,	r0
	b	b4
.ltorg
b18:
	mov	r2,	#0
	cmp	r0,	r2
	beq	b19
	b	b23
.ltorg
b23:
	movw	r3,	:lower16:_g_h
	movt	r3,	:upper16:_g_h
	ldr	r3,	[r3]
	mov	r2,	#1
	add	r2,	r3,	r2
	cmp	r0,	r2
	beq	b19
	b	b22
.ltorg
b22:
	mov	r2,	#0
	cmp	r1,	r2
	beq	b19
	b	b21
.ltorg
b21:
	movw	r3,	:lower16:_g_w
	movt	r3,	:upper16:_g_w
	ldr	r3,	[r3]
	mov	r2,	#1
	add	r2,	r3,	r2
	cmp	r1,	r2
	beq	b19
	b	b20
.ltorg
b20:
	mov	r2,	#0
	str	r2,	[r9]
	movw	r2,	:lower16:_g_step
	movt	r2,	:upper16:_g_step
	mov	r3,	#8
	mla	r2,	r5,	r3,	r2
	ldr	r3,	[r2]
	movw	r2,	:lower16:_g_step
	movt	r2,	:upper16:_g_step
	mov	r10,	#8
	mla	r2,	r5,	r10,	r2
	mov	r10,	#4
	add	r2,	r2,	r10
	ldr	r2,	[r2]
	sub	r1,	r1,	r2
	sub	r0,	r0,	r3
	mov	r2,	r7
	bl	search
	mov	r1,	#1
	add	r0,	r0,	r1
	cmp	r0,	r4
	blt	b24
	b	b25
.ltorg
b24:
	mov	r4,	r0
	b	b25
.ltorg
b25:
	mov	r0,	#1
	str	r0,	[r9]
	mov	r0,	#1
	add	r5,	r5,	r0
	b	b4
.ltorg
b19:
	mov	r0,	#1
	add	r5,	r5,	r0
	b	b4
.ltorg
b15:
	movw	r2,	:lower16:_g_y_1
	movt	r2,	:upper16:_g_y_1
	ldr	r2,	[r2]
	cmp	r1,	r2
	beq	b13
	b	b14
.ltorg
b13:
	mov	r0,	#1
	pop	{r4,r5,r6,r7,r8,r9,r10,r11,r12,pc}
	bx	lr
.ltorg
b6:
	mov	r0,	#10
	cmp	r4,	r0
	bgt	b26
	b	b27
.ltorg
b26:
	mov	r0,	#1073741824
	pop	{r4,r5,r6,r7,r8,r9,r10,r11,r12,pc}
	bx	lr
.ltorg
b27:
	mov	r0,	r4
	pop	{r4,r5,r6,r7,r8,r9,r10,r11,r12,pc}
	bx	lr
.ltorg
.global	main
main:
	push	{lr}
	sub	sp,	sp,	#4
b30:
	bl	getint
	movw	r1,	:lower16:_g_w
	movt	r1,	:upper16:_g_w
	str	r0,	[r1]
	bl	getint
	movw	r1,	:lower16:_g_h
	movt	r1,	:upper16:_g_h
	str	r0,	[r1]
	mov	r4,	#0
	mov	r6,	#0
	b	b31
.ltorg
b31:
	movw	r1,	:lower16:_g_w
	movt	r1,	:upper16:_g_w
	ldr	r1,	[r1]
	mov	r0,	#0
	cmp	r1,	r0
	bne	b32
	b	b33
.ltorg
b32:
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#4
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#8
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#12
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#16
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#20
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#24
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#28
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#32
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#36
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#40
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#44
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#48
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#52
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#56
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#60
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#64
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#68
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#72
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#76
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#80
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#84
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#88
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#92
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#96
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#100
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#104
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#108
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#112
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#116
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#120
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#124
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#128
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#132
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#136
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#140
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#144
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#148
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#152
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#156
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#160
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#164
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#168
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#172
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#176
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#180
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#184
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#188
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#192
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#196
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#200
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#204
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#208
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#212
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#216
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#220
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#224
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#228
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#232
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#236
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#240
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#244
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#248
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#252
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#256
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#260
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#264
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#268
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#272
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#276
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#280
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#284
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#288
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#292
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#296
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#300
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#304
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#308
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#312
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#316
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#320
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#324
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#328
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#332
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#336
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#340
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#344
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#348
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#352
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#356
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#360
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#364
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#368
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#372
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#376
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#380
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#384
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#388
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#392
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#396
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#400
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#404
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#408
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#412
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#416
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#420
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#424
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#428
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#432
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#436
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#440
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#444
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#448
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#452
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#456
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#460
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#464
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#468
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#472
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#476
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#480
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#484
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#488
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#492
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#496
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#500
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#504
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#508
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#512
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#516
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#520
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#524
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#528
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#532
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#536
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#540
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#544
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#548
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#552
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#556
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#560
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#564
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#568
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#572
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#576
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#580
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#584
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#588
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#592
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#596
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#600
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#604
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#608
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#612
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#616
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#620
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#624
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#628
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#632
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#636
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#640
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#644
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#648
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#652
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#656
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#660
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#664
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#668
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#672
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#676
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#680
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#684
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#688
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#692
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#696
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#700
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#704
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#708
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#712
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#716
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#720
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#724
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#728
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#732
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#736
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#740
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#744
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#748
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#752
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#756
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#760
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#764
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#768
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#772
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#776
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#780
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#784
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#788
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#792
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#796
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#800
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#804
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#808
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#812
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#816
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#820
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#824
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#828
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#832
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#836
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#840
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#844
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#848
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#852
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#856
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#860
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#864
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#868
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#872
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#876
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#880
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#884
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#888
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#892
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#896
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#900
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#904
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#908
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#912
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#916
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#920
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#924
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#928
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#932
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#936
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#940
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#944
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#948
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#952
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#956
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#960
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#964
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#968
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#972
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#976
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#980
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#984
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#988
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#992
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#996
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1000
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1004
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1008
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1012
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1016
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1020
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1024
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1028
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1032
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1036
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1040
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1044
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1048
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1052
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1056
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1060
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1064
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1068
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1072
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1076
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1080
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1084
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1088
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1092
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1096
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1100
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1104
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1108
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1112
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1116
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1120
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1124
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1128
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1132
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1136
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1140
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1144
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1148
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1152
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1156
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1160
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1164
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1168
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1172
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1176
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1180
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1184
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1188
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1192
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1196
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1200
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1204
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1208
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1212
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1216
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1220
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1224
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1228
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1232
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1236
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1240
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1244
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1248
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1252
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1256
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1260
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1264
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1268
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1272
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1276
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1280
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1284
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1288
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1292
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1296
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1300
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1304
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1308
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1312
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1316
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1320
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1324
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1328
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1332
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1336
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1340
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1344
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1348
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1352
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1356
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1360
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1364
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1368
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1372
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1376
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1380
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1384
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1388
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1392
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1396
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1400
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1404
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1408
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1412
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1416
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1420
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1424
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1428
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1432
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1436
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1440
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1444
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1448
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1452
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1456
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1460
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1464
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1468
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1472
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1476
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1480
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1484
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1488
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1492
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1496
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1500
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1504
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1508
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1512
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1516
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1520
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1524
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1528
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1532
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1536
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1540
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1544
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1548
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1552
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1556
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1560
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1564
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1568
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1572
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1576
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1580
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1584
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1588
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1592
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1596
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1600
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1604
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1608
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1612
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1616
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1620
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1624
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1628
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1632
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1636
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1640
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1644
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1648
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1652
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1656
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1660
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1664
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1668
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1672
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1676
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1680
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1684
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1688
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1692
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1696
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1700
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1704
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1708
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1712
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1716
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1720
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1724
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1728
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1732
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1736
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1740
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1744
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1748
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1752
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1756
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1760
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1764
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1768
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1772
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1776
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1780
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1784
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1788
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1792
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1796
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1800
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1804
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1808
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1812
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1816
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1820
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1824
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1828
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1832
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1836
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1840
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1844
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1848
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1852
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1856
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1860
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1864
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1868
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1872
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1876
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1880
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1884
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1888
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1892
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1896
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1900
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1904
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1908
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1912
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1916
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1920
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1924
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1928
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1932
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1936
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1940
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1944
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1948
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1952
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1956
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1960
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1964
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1968
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1972
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1976
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1980
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#1984
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1988
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1992
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#1996
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2000
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2004
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2008
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2012
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2016
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2020
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2024
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2028
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2032
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2036
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2040
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2044
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2048
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2052
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2056
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2060
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2064
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2068
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2072
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2076
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2080
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2084
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2088
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2092
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2096
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2100
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2104
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2108
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2112
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2116
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2120
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2124
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2128
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2132
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2136
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2140
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2144
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2148
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2152
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2156
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2160
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2164
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2168
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2172
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2176
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2180
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2184
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2188
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2192
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2196
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2200
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2204
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2208
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2212
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2216
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2220
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2224
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2228
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2232
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2236
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2240
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2244
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2248
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2252
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2256
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2260
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2264
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2268
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2272
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2276
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2280
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2284
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2288
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2292
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2296
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2300
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2304
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2308
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2312
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2316
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2320
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2324
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2328
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2332
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2336
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2340
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2344
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2348
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2352
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2356
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2360
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2364
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2368
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2372
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2376
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2380
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2384
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2388
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2392
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2396
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2400
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2404
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2408
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2412
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2416
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2420
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2424
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2428
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2432
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2436
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2440
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2444
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2448
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2452
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2456
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2460
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2464
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2468
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2472
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2476
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2480
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2484
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2488
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2492
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2496
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2500
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2504
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2508
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2512
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2516
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2520
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2524
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2528
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2532
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2536
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2540
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2544
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2548
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2552
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2556
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2560
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2564
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2568
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2572
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2576
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2580
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2584
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2588
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2592
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2596
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2600
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2604
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2608
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2612
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2616
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2620
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2624
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2628
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2632
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2636
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2640
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2644
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2648
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2652
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2656
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2660
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2664
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2668
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2672
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2676
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2680
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2684
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2688
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2692
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2696
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2700
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2704
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2708
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2712
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2716
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2720
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2724
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2728
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2732
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2736
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2740
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2744
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2748
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2752
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2756
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2760
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2764
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2768
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2772
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2776
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2780
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2784
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2788
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2792
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2796
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2800
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2804
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2808
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2812
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2816
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2820
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2824
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2828
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2832
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2836
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2840
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2844
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2848
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2852
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2856
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2860
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2864
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2868
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2872
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2876
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2880
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2884
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2888
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2892
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2896
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2900
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2904
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2908
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2912
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2916
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2920
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2924
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2928
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2932
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2936
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2940
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2944
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2948
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2952
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2956
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2960
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2964
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2968
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2972
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2976
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2980
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2984
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2988
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#2992
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#2996
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3000
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3004
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3008
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3012
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3016
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3020
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3024
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3028
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3032
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3036
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3040
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3044
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3048
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3052
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3056
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3060
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3064
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3068
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3072
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3076
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3080
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3084
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3088
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3092
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3096
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3100
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3104
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3108
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3112
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3116
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3120
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3124
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3128
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3132
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3136
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3140
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3144
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3148
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3152
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3156
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3160
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3164
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3168
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3172
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3176
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3180
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3184
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3188
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3192
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3196
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3200
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3204
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3208
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3212
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3216
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3220
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3224
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3228
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3232
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3236
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3240
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3244
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3248
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3252
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3256
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3260
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3264
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3268
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3272
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3276
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3280
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3284
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3288
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3292
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3296
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3300
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3304
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3308
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3312
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3316
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3320
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3324
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3328
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3332
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3336
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3340
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3344
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3348
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3352
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3356
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3360
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3364
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3368
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3372
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3376
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3380
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3384
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3388
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3392
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3396
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3400
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3404
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3408
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3412
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3416
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3420
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3424
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3428
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3432
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3436
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3440
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3444
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3448
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3452
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3456
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3460
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3464
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3468
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3472
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3476
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3480
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3484
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3488
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3492
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3496
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3500
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3504
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3508
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3512
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3516
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3520
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3524
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3528
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3532
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3536
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3540
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3544
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3548
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3552
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3556
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3560
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3564
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3568
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3572
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3576
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3580
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	#3584
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3588
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3592
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	#3596
	add	r0,	r1,	r0
	mov	r1,	#1
	str	r1,	[r0]
	mov	r5,	#1
	b	b40
.ltorg
b40:
	movw	r0,	:lower16:_g_h
	movt	r0,	:upper16:_g_h
	ldr	r0,	[r0]
	cmp	r5,	r0
	ble	b41
	b	b42
.ltorg
b41:
	mov	r7,	#1
	b	b43
.ltorg
b43:
	movw	r0,	:lower16:_g_w
	movt	r0,	:upper16:_g_w
	ldr	r0,	[r0]
	cmp	r7,	r0
	ble	b44
	b	b45
.ltorg
b44:
	bl	getint
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r2,	#120
	mla	r1,	r5,	r2,	r1
	mov	r2,	#4
	mla	r1,	r7,	r2,	r1
	str	r0,	[r1]
	ldr	r1,	[r1]
	mov	r0,	#2
	cmp	r1,	r0
	beq	b46
	b	b47
.ltorg
b46:
	mov	r4,	r5
	mov	r6,	r7
	b	b48
.ltorg
b47:
	mov	r0,	#3
	cmp	r1,	r0
	beq	b49
	b	b50
.ltorg
b49:
	movw	r0,	:lower16:_g_x_1
	movt	r0,	:upper16:_g_x_1
	str	r5,	[r0]
	movw	r0,	:lower16:_g_y_1
	movt	r0,	:upper16:_g_y_1
	str	r7,	[r0]
	b	b50
.ltorg
b50:
	b	b48
.ltorg
b48:
	mov	r0,	#1
	add	r7,	r7,	r0
	b	b43
.ltorg
b45:
	mov	r0,	#1
	add	r5,	r5,	r0
	b	b40
.ltorg
b42:
	mov	r0,	r4
	mov	r1,	r6
	mov	r2,	#1
	bl	search
	mov	r1,	#10
	cmp	r0,	r1
	ble	b51
	b	b52
.ltorg
b51:
	bl	putint
	mov	r0,	#10
	bl	putch
	b	b53
.ltorg
b52:
	mvn	r0,	#0
	bl	putint
	mov	r0,	#10
	bl	putch
	b	b53
.ltorg
b53:
	bl	getint
	movw	r1,	:lower16:_g_w
	movt	r1,	:upper16:_g_w
	str	r0,	[r1]
	bl	getint
	movw	r1,	:lower16:_g_h
	movt	r1,	:upper16:_g_h
	str	r0,	[r1]
	b	b31
.ltorg
b33:
	mov	r0,	#0
	add	sp,	sp,	#4
	pop	{pc}
	bx	lr
.ltorg
