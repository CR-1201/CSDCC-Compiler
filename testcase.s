.arch armv7ve
.arm
.global	_g_state

.section .data
.align 2
_g_state:
	.word	19260817

.global	_g_buffer

.section .bss
.align 2
_g_buffer:
	.zero	131072
.section .text
.global	main
main:
	push	{lr}
	sub	sp,	sp,	#428
b43:
	add	r0,	sp,	#0
	str	r0,	[sp,	#404]
	add	r0,	sp,	#320
	str	r0,	[sp,	#400]
	add	r0,	sp,	#340
	str	r0,	[sp,	#396]
	ldr	r0,	[sp,	#396]
	mov	r1,	#0
	mov	r2,	#20
	bl	memset
	mov	r0,	#0
	ldr	r1,	[sp,	#396]
	str	r0,	[r1]
	mov	r0,	#4
	ldr	r1,	[sp,	#396]
	add	r0,	r1,	r0
	mov	r1,	#0
	str	r1,	[r0]
	mov	r1,	#8
	ldr	r0,	[sp,	#396]
	add	r1,	r0,	r1
	mov	r0,	#0
	str	r0,	[r1]
	mov	r1,	#12
	ldr	r0,	[sp,	#396]
	add	r1,	r0,	r1
	mov	r0,	#0
	str	r0,	[r1]
	mov	r1,	#16
	ldr	r0,	[sp,	#396]
	add	r1,	r0,	r1
	mov	r0,	#0
	str	r0,	[r1]
	bl	getint
	movw	r3,	:lower16:_g_state
	movt	r3,	:upper16:_g_state
	str	r0,	[r3]
	bl	getint
	mov	r4,	r0
	bl	_sysy_starttime
	mov	r0,	#0
	ldr	r1,	[sp,	#400]
	str	r0,	[r1]
	mov	r0,	#4
	ldr	r1,	[sp,	#400]
	add	r1,	r1,	r0
	mov	r0,	#0
	str	r0,	[r1]
	mov	r0,	#8
	ldr	r1,	[sp,	#400]
	add	r1,	r1,	r0
	mov	r0,	#0
	str	r0,	[r1]
	mov	r0,	#12
	ldr	r1,	[sp,	#400]
	add	r1,	r1,	r0
	mov	r0,	#0
	str	r0,	[r1]
	mov	r0,	#16
	ldr	r1,	[sp,	#400]
	add	r1,	r1,	r0
	mov	r0,	#0
	str	r0,	[r1]
	b	b44
.ltorg
b44:
	str	r4,	[sp,	#368]
	mov	r1,	#0
	ldr	r0,	[sp,	#368]
	cmp	r0,	r1
	bgt	b45
	b	b46
.ltorg
b45:
	mov	r0,	#0
	b	b47
.ltorg
b47:
	mov	r1,	#32000
	cmp	r0,	r1
	blt	b48
	b	b49
.ltorg
b48:
	movw	r1,	:lower16:_g_buffer
	movt	r1,	:upper16:_g_buffer
	str	r1,	[sp,	#412]
	mov	r1,	r0, lsl #2
	ldr	r2,	[sp,	#412]
	add	r1,	r1,	r2
	movw	r3,	:lower16:_g_state
	movt	r3,	:upper16:_g_state
	ldr	r3,	[r3]
	movw	r2,	:lower16:_g_state
	movt	r2,	:upper16:_g_state
	ldr	r2,	[r2]
	mov	r2,	r2, lsl #13
	add	r2,	r3,	r2
	movw	r3,	:lower16:_g_state
	movt	r3,	:upper16:_g_state
	str	r2,	[r3]
	movw	r4,	:lower16:_g_state
	movt	r4,	:upper16:_g_state
	ldr	r4,	[r4]
	movw	r3,	:lower16:_g_state
	movt	r3,	:upper16:_g_state
	ldr	r3,	[r3]
	mov	r2,	r3, asr #31
	add	r2,	r3,	r2, lsr #15
	mov	r2,	r2, asr #17
	add	r2,	r4,	r2
	movw	r3,	:lower16:_g_state
	movt	r3,	:upper16:_g_state
	str	r2,	[r3]
	movw	r3,	:lower16:_g_state
	movt	r3,	:upper16:_g_state
	ldr	r3,	[r3]
	movw	r2,	:lower16:_g_state
	movt	r2,	:upper16:_g_state
	ldr	r2,	[r2]
	mov	r2,	r2, lsl #5
	add	r2,	r3,	r2
	movw	r3,	:lower16:_g_state
	movt	r3,	:upper16:_g_state
	str	r2,	[r3]
	movw	r3,	:lower16:_g_state
	movt	r3,	:upper16:_g_state
	ldr	r3,	[r3]
	mov	r2,	r3, asr #31
	ands	r3,	r3,	#255
	orrne	r3,	r3,	r2, lsl #8
	str	r3,	[r1]
	mov	r1,	#1
	add	r0,	r0,	r1
	b	b47
.ltorg
b49:
	movw	r0,	:lower16:_g_buffer
	movt	r0,	:upper16:_g_buffer
	str	r0,	[sp,	#412]
	mov	r0,	#128000
	ldr	r1,	[sp,	#412]
	add	r1,	r1,	r0
	mov	r0,	#128
	str	r0,	[r1]
	movw	r0,	#32001
	b	b190
.ltorg
b190:
	mov	r1,	r0, asr #31
	ands	r2,	r0,	#63
	orrne	r2,	r2,	r1, lsl #6
	mov	r1,	#60
	cmp	r2,	r1
	bne	b191
	b	b192
.ltorg
b191:
	mov	r1,	r0, lsl #2
	ldr	r2,	[sp,	#412]
	add	r2,	r1,	r2
	mov	r1,	#0
	str	r1,	[r2]
	mov	r1,	#1
	add	r0,	r0,	r1
	b	b190
.ltorg
b192:
	mov	r1,	r0, lsl #2
	ldr	r2,	[sp,	#412]
	add	r2,	r1,	r2
	mov	r1,	#0
	str	r1,	[r2]
	mov	r1,	#1
	add	r1,	r0,	r1
	mov	r1,	r1, lsl #2
	ldr	r2,	[sp,	#412]
	add	r2,	r1,	r2
	mov	r1,	#0
	str	r1,	[r2]
	mov	r1,	#2
	add	r1,	r0,	r1
	mov	r1,	r1, lsl #2
	ldr	r2,	[sp,	#412]
	add	r2,	r1,	r2
	mov	r1,	#125
	str	r1,	[r2]
	mov	r1,	#3
	add	r1,	r0,	r1
	mov	r1,	r1, lsl #2
	ldr	r2,	[sp,	#412]
	add	r1,	r1,	r2
	mov	r2,	#0
	str	r2,	[r1]
	mov	r1,	#4
	add	r4,	r0,	r1
	ldr	r0,	[sp,	#404]
	mov	r1,	#0
	mov	r2,	#320
	bl	memset
	mov	r0,	#0
	ldr	r1,	[sp,	#404]
	str	r0,	[r1]
	mov	r7,	#0
	mov	r1,	#0
	mov	r0,	#0
	movw	r2,	#57840
	movt	r2,	#50130
	movw	r3,	#21622
	movt	r3,	#4146
	movw	r10,	#56574
	movt	r10,	#39098
	movw	r9,	#43913
	movt	r9,	#61389
	movw	r8,	#8961
	movt	r8,	#26437
	b	b193
.ltorg
b193:
	str	r8,	[sp,	#388]
	str	r9,	[sp,	#392]
	str	r10,	[sp,	#376]
	str	r2,	[sp,	#420]
	cmp	r7,	r4
	blt	b194
	b	b323
.ltorg
b194:
	mov	r2,	#0
	b	b195
.ltorg
b195:
	mov	r5,	#16
	cmp	r2,	r5
	blt	b196
	b	b197
.ltorg
b196:
	mov	r5,	r2, lsl #2
	ldr	r6,	[sp,	#404]
	add	r5,	r5,	r6
	mov	r6,	r2, lsl #2
	add	r6,	r7,	r6
	mov	r6,	r6, lsl #2
	ldr	r8,	[sp,	#412]
	add	r6,	r6,	r8
	ldr	r6,	[r6]
	mov	r6,	r6, lsl #24
	mov	r8,	r2, lsl #2
	add	r8,	r7,	r8
	mov	r9,	#1
	add	r8,	r8,	r9
	mov	r8,	r8, lsl #2
	ldr	r9,	[sp,	#412]
	add	r8,	r8,	r9
	ldr	r8,	[r8]
	mov	r8,	r8, lsl #16
	add	r6,	r6,	r8
	mov	r8,	r2, lsl #2
	add	r8,	r7,	r8
	mov	r9,	#2
	add	r8,	r8,	r9
	mov	r8,	r8, lsl #2
	ldr	r9,	[sp,	#412]
	add	r8,	r8,	r9
	ldr	r8,	[r8]
	mov	r8,	r8, lsl #8
	add	r6,	r6,	r8
	mov	r8,	r2, lsl #2
	add	r9,	r7,	r8
	mov	r8,	#3
	add	r8,	r9,	r8
	mov	r8,	r8, lsl #2
	ldr	r9,	[sp,	#412]
	add	r8,	r8,	r9
	ldr	r8,	[r8]
	add	r6,	r6,	r8
	str	r6,	[r5]
	mov	r5,	#1
	add	r2,	r2,	r5
	b	b195
.ltorg
b197:
	b	b198
.ltorg
b198:
	mov	r5,	#80
	cmp	r2,	r5
	blt	b199
	b	b220
.ltorg
b199:
	mov	r5,	r2, lsl #2
	ldr	r6,	[sp,	#404]
	add	r5,	r5,	r6
	mov	r6,	#3
	sub	r6,	r2,	r6
	mov	r6,	r6, lsl #2
	ldr	r8,	[sp,	#404]
	add	r6,	r6,	r8
	ldr	r6,	[r6]
	mov	r8,	#8
	sub	r8,	r2,	r8
	mov	r8,	r8, lsl #2
	ldr	r9,	[sp,	#404]
	add	r8,	r8,	r9
	ldr	r8,	[r8]
	add	r6,	r6,	r8
	mov	r8,	#0
	sub	r6,	r8,	r6
	mov	r8,	#14
	sub	r8,	r2,	r8
	mov	r8,	r8, lsl #2
	ldr	r9,	[sp,	#404]
	add	r8,	r8,	r9
	ldr	r8,	[r8]
	add	r6,	r6,	r8
	mov	r8,	#0
	sub	r6,	r8,	r6
	mov	r8,	#16
	sub	r8,	r2,	r8
	mov	r8,	r8, lsl #2
	ldr	r9,	[sp,	#404]
	add	r8,	r8,	r9
	ldr	r8,	[r8]
	add	r6,	r6,	r8
	mov	r8,	#0
	sub	r6,	r8,	r6
	mov	r8,	r6, lsl #1
	mov	r9,	r6, asr #31
	ands	r6,	r6,	#1
	orrne	r6,	r6,	r9, lsl #1
	add	r6,	r8,	r6
	str	r6,	[r5]
	mov	r5,	#1
	add	r2,	r2,	r5
	b	b198
.ltorg
b220:
	mov	r8,	#0
	ldr	r6,	[sp,	#420]
	mov	r5,	r3
	ldr	r2,	[sp,	#376]
	ldr	r10,	[sp,	#392]
	ldr	r9,	[sp,	#388]
	b	b221
.ltorg
b221:
	str	r9,	[sp,	#384]
	str	r10,	[sp,	#372]
	str	r8,	[sp,	#380]
	mov	r8,	#80
	ldr	r9,	[sp,	#380]
	cmp	r9,	r8
	blt	b222
	b	b322
.ltorg
b322:
	ldr	r9,	[sp,	#384]
	ldr	r8,	[sp,	#388]
	add	r8,	r8,	r9
	ldr	r10,	[sp,	#372]
	ldr	r9,	[sp,	#392]
	add	r9,	r9,	r10
	ldr	r10,	[sp,	#376]
	add	r10,	r10,	r2
	add	r3,	r3,	r5
	ldr	r2,	[sp,	#420]
	add	r2,	r2,	r6
	mov	r5,	#64
	add	r7,	r7,	r5
	b	b193
.ltorg
b222:
	mov	r9,	#20
	ldr	r8,	[sp,	#380]
	cmp	r8,	r9
	blt	b223
	b	b251
.ltorg
b223:
	ldr	r0,	[sp,	#372]
	add	r0,	r0,	r2
	mvn	r8,	#0
	ldr	r1,	[sp,	#372]
	sub	r1,	r8,	r1
	add	r9,	r1,	r5
	add	r8,	r0,	r9
	mov	r1,	#0
	sub	r1,	r1,	r8
	add	r0,	r0,	r9
	add	r0,	r1,	r0
	mov	r1,	#0
	sub	r0,	r1,	r0
	movw	r1,	#31129
	movt	r1,	#23170
	b	b246
.ltorg
b246:
	ldr	r8,	[sp,	#384]
	mov	r8,	r8, lsl #5
	ldr	r9,	[sp,	#384]
	mov	r9,	r9, asr #31
	ldr	r10,	[sp,	#384]
	ands	r10,	r10,	#31
	str	r10,	[sp,	#360]
	ldr	r10,	[sp,	#360]
	orrne	r10,	r10,	r9, lsl #5
	str	r10,	[sp,	#360]
	ldr	r9,	[sp,	#360]
	add	r8,	r8,	r9
	add	r8,	r8,	r0
	add	r6,	r8,	r6
	add	r6,	r6,	r1
	ldr	r8,	[sp,	#380]
	mov	r8,	r8, lsl #2
	ldr	r9,	[sp,	#404]
	add	r8,	r8,	r9
	ldr	r8,	[r8]
	add	r9,	r6,	r8
	ldr	r6,	[sp,	#372]
	mov	r6,	r6, lsl #30
	ldr	r8,	[sp,	#372]
	mov	r8,	r8, asr #31
	mvn	r10,	#-1073741824
	str	r10,	[sp,	#408]
	ldr	r10,	[sp,	#372]
	ldr	r11,	[sp,	#408]
	str	r11,	[sp,	#416]
	ldr	r11,	[sp,	#416]
	ands	r10,	r10,	r11
	str	r10,	[sp,	#364]
	ldr	r10,	[sp,	#364]
	orrne	r10,	r10,	r8, lsl #30
	str	r10,	[sp,	#364]
	ldr	r8,	[sp,	#364]
	add	r10,	r6,	r8
	mov	r6,	#1
	ldr	r8,	[sp,	#380]
	add	r8,	r8,	r6
	mov	r6,	r5
	mov	r5,	r2
	mov	r2,	r10
	ldr	r10,	[sp,	#384]
	b	b221
.ltorg
b251:
	mov	r8,	#40
	ldr	r9,	[sp,	#380]
	cmp	r9,	r8
	blt	b252
	b	b266
.ltorg
b265:
	b	b246
.ltorg
b266:
	mov	r8,	#60
	ldr	r9,	[sp,	#380]
	cmp	r9,	r8
	blt	b267
	b	b307
.ltorg
b306:
	b	b265
.ltorg
b307:
	mov	r8,	#80
	ldr	r9,	[sp,	#380]
	cmp	r9,	r8
	blt	b308
	b	b321
.ltorg
b321:
	b	b306
.ltorg
b308:
	ldr	r0,	[sp,	#372]
	add	r0,	r0,	r2
	mov	r1,	#0
	sub	r0,	r1,	r0
	add	r1,	r0,	r5
	mov	r0,	#0
	sub	r0,	r0,	r1
	movw	r1,	#49414
	movt	r1,	#51810
	b	b321
.ltorg
b267:
	ldr	r0,	[sp,	#372]
	add	r1,	r0,	r2
	ldr	r0,	[sp,	#372]
	add	r0,	r0,	r5
	add	r8,	r1,	r0
	mov	r9,	#0
	sub	r8,	r9,	r8
	add	r0,	r1,	r0
	add	r0,	r8,	r0
	mov	r1,	#0
	sub	r9,	r1,	r0
	add	r1,	r2,	r5
	add	r0,	r9,	r1
	mov	r8,	#0
	sub	r0,	r8,	r0
	add	r1,	r9,	r1
	add	r0,	r0,	r1
	mov	r1,	#0
	sub	r0,	r1,	r0
	movw	r1,	#48348
	movt	r1,	#36635
	b	b306
.ltorg
b252:
	ldr	r0,	[sp,	#372]
	add	r0,	r0,	r2
	mov	r1,	#0
	sub	r0,	r1,	r0
	add	r0,	r0,	r5
	mov	r1,	#0
	sub	r0,	r1,	r0
	movw	r1,	#60289
	movt	r1,	#28377
	b	b265
.ltorg
b323:
	ldr	r0,	[sp,	#388]
	ldr	r1,	[sp,	#396]
	str	r0,	[r1]
	mov	r0,	#4
	ldr	r1,	[sp,	#396]
	add	r0,	r1,	r0
	ldr	r1,	[sp,	#392]
	str	r1,	[r0]
	mov	r0,	#8
	ldr	r1,	[sp,	#396]
	add	r0,	r1,	r0
	ldr	r1,	[sp,	#376]
	str	r1,	[r0]
	mov	r0,	#12
	ldr	r1,	[sp,	#396]
	add	r0,	r1,	r0
	str	r3,	[r0]
	mov	r0,	#16
	ldr	r1,	[sp,	#396]
	add	r0,	r1,	r0
	ldr	r1,	[sp,	#420]
	str	r1,	[r0]
	mov	r0,	#0
	b	b50
.ltorg
b50:
	mov	r1,	#5
	cmp	r0,	r1
	blt	b51
	b	b52
.ltorg
b52:
	mov	r0,	#1
	ldr	r1,	[sp,	#368]
	sub	r4,	r1,	r0
	b	b44
.ltorg
b51:
	mov	r1,	r0, lsl #2
	ldr	r2,	[sp,	#400]
	add	r1,	r1,	r2
	mov	r2,	r0, lsl #2
	ldr	r3,	[sp,	#400]
	add	r2,	r2,	r3
	ldr	r3,	[r2]
	mov	r2,	r0, lsl #2
	ldr	r4,	[sp,	#396]
	add	r2,	r2,	r4
	ldr	r2,	[r2]
	add	r2,	r3,	r2
	mov	r3,	#0
	sub	r2,	r3,	r2
	str	r2,	[r1]
	mov	r1,	#1
	add	r0,	r0,	r1
	b	b50
.ltorg
b46:
	bl	_sysy_stoptime
	mov	r0,	#5
	ldr	r1,	[sp,	#400]
	bl	putarray
	mov	r0,	#0
	add	sp,	sp,	#428
	pop	{pc}
	bx	lr
.ltorg
