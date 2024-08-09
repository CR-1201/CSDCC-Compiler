.arch armv7ve
.arm
.section .text
.global	main
main:
	push	{lr}
	movw	r5,	#28868
	sub	sp,	sp,	r5
b8:
	add	r5,	sp,	#0
	movw	r0,	#12508
	add	r7,	sp,	r0
	mov	r0,	r7
	mov	r1,	#0
	movw	r2,	#16348
	bl	memset
	mov	r0,	r5
	mov	r1,	#0
	movw	r2,	#12508
	bl	memset
	movw	r0,	#4556
	add	r1,	r7,	r0
	mov	r0,	#4
	add	r1,	r1,	r0
	mov	r0,	#6
	str	r0,	[r1]
	movw	r0,	#4556
	add	r1,	r7,	r0
	mov	r0,	#12
	add	r1,	r1,	r0
	mov	r0,	#7
	str	r0,	[r1]
	movw	r0,	#4556
	add	r1,	r7,	r0
	mov	r0,	#16
	add	r1,	r1,	r0
	mov	r0,	#4
	str	r0,	[r1]
	movw	r0,	#4556
	add	r1,	r7,	r0
	mov	r0,	#28
	add	r1,	r1,	r0
	mov	r0,	#9
	str	r0,	[r1]
	movw	r0,	#4556
	add	r1,	r7,	r0
	mov	r0,	#44
	add	r1,	r1,	r0
	mov	r0,	#11
	str	r0,	[r1]
	movw	r0,	#1416
	add	r1,	r5,	r0
	mov	r0,	#4
	add	r1,	r1,	r0
	mov	r0,	#1
	str	r0,	[r1]
	movw	r0,	#1416
	add	r1,	r5,	r0
	mov	r0,	#8
	add	r1,	r1,	r0
	mov	r0,	#2
	str	r0,	[r1]
	movw	r0,	#1416
	add	r1,	r5,	r0
	mov	r0,	#12
	add	r1,	r1,	r0
	mov	r0,	#3
	str	r0,	[r1]
	movw	r0,	#1416
	add	r1,	r5,	r0
	mov	r0,	#36
	add	r1,	r1,	r0
	mov	r0,	#9
	str	r0,	[r1]
	movw	r0,	#4556
	add	r1,	r7,	r0
	mov	r0,	#4
	add	r0,	r1,	r0
	ldr	r4,	[r0]
	movw	r0,	#4556
	add	r1,	r7,	r0
	mov	r0,	#12
	add	r0,	r1,	r0
	ldr	r6,	[r0]
	movw	r0,	#4556
	add	r7,	r7,	r0
	movw	r0,	#1416
	add	r1,	r5,	r0
	mov	r0,	#12
	add	r0,	r1,	r0
	ldr	r8,	[r0]
	movw	r0,	#1416
	add	r0,	r5,	r0
	ldr	r0,	[r0]
	movw	r12,	#28856
	str	r0,	[sp]
	movw	r0,	#1416
	add	r0,	r5,	r0
	movw	r12,	#28860
	str	r0,	[sp]
	movw	r0,	#8024
	add	r1,	r5,	r0
	mov	r0,	#16
	add	r0,	r1,	r0
	ldr	r9,	[r0]
	movw	r0,	#12036
	add	r1,	r5,	r0
	mov	r0,	#72
	add	r0,	r1,	r0
	ldr	r10,	[r0]
	mov	r11,	#0
	b	b15
.ltorg
b15:
	mov	r11,	r11
	mov	r0,	#10
	cmp	r11,	r0
	blt	b16
	b	b17
.ltorg
b16:
	mov	r0,	#236
	mla	r1,	r4,	r0,	r5
	mov	r0,	r11, lsl #2
	add	r0,	r0,	r1
	ldr	r0,	[r0]
	mov	r0,	r0
	bl	putint
	mov	r0,	#1
	add	r11,	r11,	r0
	mov	r11,	r11
	b	b15
.ltorg
b17:
	mov	r0,	#10
	bl	putch
	mov	r0,	r6, lsl #2
	add	r0,	r0,	r7
	ldr	r0,	[r0]
	mov	r0,	r0
	bl	putint
	mov	r0,	#10
	bl	putch
	mov	r10,	r10
	mov	r9,	r9
	b	b18
.ltorg
b18:
	mov	r9,	r9
	mov	r10,	r10
	mov	r0,	#10
	cmp	r10,	r0
	blt	b19
	b	b20
.ltorg
b19:
	mov	r0,	r10, lsl #2
	movw	r1,	#28860
	ldr	r1,	[sp,	r1]
	add	r1,	r0,	r1
	movw	r2,	#63339
	movt	r2,	#1
	mul	r2,	r9,	r2
	movw	r0,	#18373
	movt	r0,	#36041
	smmul	r0,	r2,	r0
	add	r0,	r0,	r2
	mov	r3,	#2048
	and	r3,	r3,	r0, asr #31
	add	r0,	r0,	r3
	mov	r0,	r0, asr #11
	mov	r0,	r0
	movw	r3,	#3724
	mul	r3,	r0,	r3
	sub	r0,	r2,	r3
	str	r0,	[r1]
	mov	r0,	#1
	add	r10,	r10,	r0
	mov	r0,	#7
	add	r9,	r9,	r0
	mov	r10,	r10
	mov	r9,	r9
	b	b18
.ltorg
b20:
	movw	r0,	#28856
	ldr	r0,	[sp,	r0]
	add	r0,	r8,	r0
	mov	r1,	r0, lsl #1
	add	r4,	r1,	r0
	mov	r4,	r4
	b	b9
.ltorg
b9:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r4,	r0
	bge	b10
	b	b11
.ltorg
b10:
	movw	r0,	#1416
	add	r0,	r5,	r0
	mov	r1,	r4, lsl #2
	add	r0,	r1,	r0
	ldr	r0,	[r0]
	mov	r0,	r0
	bl	putint
	mov	r0,	#32
	bl	putch
	mov	r0,	#1
	sub	r4,	r4,	r0
	mov	r4,	r4
	b	b9
.ltorg
b11:
	mov	r0,	#10
	bl	putch
	mov	r0,	#0
	movw	r5,	#28868
	add	sp,	sp,	r5
	pop	{pc}
	bx	lr
.ltorg
