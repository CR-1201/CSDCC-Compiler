.arch armv7ve

.global	_g_a

.bss
.align 4
_g_a:
	.zero	4000000
.global	_g_b

.bss
.align 4
_g_b:
	.zero	4000000
.global	_g_c

.bss
.align 4
_g_c:
	.zero	4000000
.text
.global	main
main:
	push	{lr}
	sub	sp,	sp,	#4
b0:
	mov	r4,	#0
	b	b1
.ltorg
b1:
	mov	r0,	#1000
	cmp	r4,	r0
	blt	b2
	b	b3
.ltorg
b2:
	movw	r5,	:lower16:_g_a
	movt	r5,	:upper16:_g_a
	mov	r0,	#4000
	mla	r0,	r4,	r0,	r5
	bl	getarray
	mov	r1,	#1000
	cmp	r0,	r1
	bne	b4
	b	b5
.ltorg
b4:
	b	b46
.ltorg
b5:
	mov	r0,	#1
	add	r4,	r4,	r0
	b	b1
.ltorg
b3:
	bl	_sysy_starttime
	mov	r0,	#0
	b	b7
.ltorg
b7:
	mov	r1,	#1000
	cmp	r0,	r1
	blt	b8
	b	b9
.ltorg
b8:
	mov	r1,	#0
	b	b10
.ltorg
b10:
	mov	r2,	#1000
	cmp	r1,	r2
	blt	b11
	b	b12
.ltorg
b11:
	movw	r5,	:lower16:_g_a
	movt	r5,	:upper16:_g_a
	mov	r2,	#4000
	mla	r3,	r1,	r2,	r5
	mov	r2,	#4
	mla	r3,	r0,	r2,	r3
	ldr	r4,	[r3]
	movw	r6,	:lower16:_g_b
	movt	r6,	:upper16:_g_b
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r6
	mov	r3,	#4
	mla	r2,	r1,	r3,	r2
	str	r4,	[r2]
	mov	r2,	#1
	add	r1,	r1,	r2
	b	b10
.ltorg
b12:
	mov	r1,	#1
	add	r0,	r0,	r1
	b	b7
.ltorg
b9:
	mov	r0,	#0
	b	b13
.ltorg
b13:
	mov	r1,	#1000
	cmp	r0,	r1
	blt	b14
	b	b15
.ltorg
b14:
	mov	r1,	#0
	b	b16
.ltorg
b16:
	mov	r2,	#1000
	cmp	r1,	r2
	blt	b17
	b	b18
.ltorg
b17:
	mov	r2,	#0
	mov	r3,	#0
	b	b19
.ltorg
b19:
	mov	r4,	#1000
	cmp	r2,	r4
	blt	b20
	b	b21
.ltorg
b20:
	movw	r5,	:lower16:_g_a
	movt	r5,	:upper16:_g_a
	mov	r6,	#4000
	mla	r4,	r0,	r6,	r5
	mov	r6,	#4
	mla	r4,	r2,	r6,	r4
	ldr	r5,	[r4]
	movw	r6,	:lower16:_g_b
	movt	r6,	:upper16:_g_b
	mov	r4,	#4000
	mla	r6,	r2,	r4,	r6
	mov	r4,	#4
	mla	r6,	r1,	r4,	r6
	ldr	r4,	[r6]
	mul	r4,	r5,	r4
	add	r3,	r3,	r4
	mov	r4,	#1
	add	r2,	r2,	r4
	b	b19
.ltorg
b21:
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r4,	r0,	r2,	r5
	mov	r2,	#4
	mla	r4,	r1,	r2,	r4
	str	r3,	[r4]
	mov	r2,	#1
	add	r1,	r1,	r2
	b	b16
.ltorg
b18:
	mov	r1,	#1
	add	r0,	r0,	r1
	b	b13
.ltorg
b15:
	mov	r0,	#0
	b	b22
.ltorg
b22:
	mov	r1,	#1000
	cmp	r0,	r1
	blt	b23
	b	b24
.ltorg
b24:
	mov	r0,	#0
	b	b33
.ltorg
b33:
	mov	r1,	#1000
	cmp	r0,	r1
	blt	b34
	b	b35
.ltorg
b34:
	mov	r1,	#0
	b	b36
.ltorg
b36:
	mov	r2,	#1000
	cmp	r1,	r2
	blt	b37
	b	b38
.ltorg
b37:
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r1,	r3,	r5
	mov	r3,	#4
	mla	r2,	r0,	r3,	r2
	ldr	r3,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r4,	r0,	r2,	r5
	mov	r2,	#4
	mla	r4,	r1,	r2,	r4
	mov	r2,	#0
	sub	r2,	r2,	r3
	str	r2,	[r4]
	mov	r2,	#1
	add	r1,	r1,	r2
	b	b36
.ltorg
b38:
	mov	r1,	#1
	add	r0,	r0,	r1
	b	b33
.ltorg
b35:
	mov	r0,	#0
	mov	r4,	#0
	b	b39
.ltorg
b39:
	mov	r1,	#1000
	cmp	r0,	r1
	blt	b40
	b	b41
.ltorg
b40:
	mov	r1,	#0
	b	b42
.ltorg
b42:
	mov	r2,	#1000
	cmp	r1,	r2
	blt	b43
	b	b44
.ltorg
b43:
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#4
	mla	r3,	r1,	r2,	r3
	ldr	r2,	[r3]
	add	r4,	r4,	r2
	mov	r2,	#1
	add	r1,	r1,	r2
	b	b42
.ltorg
b44:
	mov	r1,	#1
	add	r0,	r0,	r1
	b	b39
.ltorg
b41:
	bl	_sysy_stoptime
	mov	r0,	r4
	bl	putint
	mov	r0,	#0
	b	b46
.ltorg
b23:
	mov	r2,	#0
	mvn	r1,	#-2147483648
	b	b25
.ltorg
b25:
	mov	r3,	#1000
	cmp	r2,	r3
	blt	b26
	b	b27
.ltorg
b26:
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r4,	r0,	r3,	r5
	mov	r3,	#4
	mla	r4,	r2,	r3,	r4
	ldr	r3,	[r4]
	cmp	r3,	r1
	blt	b28
	b	b29
.ltorg
b28:
	ldr	r1,	[r4]
	b	b29
.ltorg
b29:
	mov	r3,	#1
	add	r2,	r2,	r3
	b	b25
.ltorg
b27:
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r2,	r0,	r2,	r5
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#4
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#8
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#12
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#16
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#20
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#24
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#28
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#32
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#36
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#40
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#44
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#48
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#52
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#56
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#60
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#64
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#68
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#72
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#76
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#80
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#84
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#88
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#92
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#96
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#100
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#104
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#108
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#112
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#116
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#120
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#124
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#128
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#132
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#136
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#140
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#144
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#148
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#152
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#156
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#160
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#164
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#168
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#172
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#176
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#180
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#184
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#188
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#192
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#196
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#200
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#204
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#208
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#212
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#216
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#220
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#224
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#228
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#232
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#236
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#240
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#244
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#248
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#252
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#256
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#260
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#264
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#268
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#272
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#276
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#280
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#284
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#288
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#292
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#296
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#300
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#304
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#308
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#312
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#316
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#320
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#324
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#328
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#332
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#336
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#340
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#344
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#348
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#352
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#356
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#360
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#364
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#368
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#372
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#376
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#380
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#384
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#388
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#392
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#396
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#400
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#404
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#408
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#412
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#416
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#420
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#424
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#428
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#432
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#436
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#440
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#444
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#448
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#452
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#456
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#460
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#464
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#468
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#472
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#476
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#480
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#484
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#488
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#492
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#496
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#500
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#504
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#508
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#512
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#516
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#520
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#524
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#528
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#532
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#536
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#540
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#544
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#548
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#552
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#556
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#560
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#564
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#568
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#572
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#576
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#580
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#584
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#588
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#592
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#596
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#600
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#604
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#608
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#612
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#616
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#620
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#624
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#628
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#632
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#636
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#640
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#644
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#648
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#652
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#656
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#660
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#664
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#668
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#672
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#676
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#680
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#684
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#688
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#692
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#696
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#700
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#704
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#708
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#712
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#716
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#720
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#724
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#728
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#732
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#736
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#740
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#744
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#748
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#752
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#756
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#760
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#764
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#768
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#772
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#776
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#780
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#784
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#788
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#792
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#796
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#800
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#804
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#808
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#812
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#816
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#820
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#824
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#828
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#832
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#836
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#840
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#844
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#848
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#852
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#856
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#860
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#864
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#868
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#872
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#876
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#880
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#884
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#888
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#892
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#896
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#900
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#904
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#908
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#912
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#916
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#920
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#924
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#928
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#932
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#936
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#940
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#944
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#948
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#952
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#956
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#960
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#964
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#968
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#972
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#976
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#980
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#984
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#988
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#992
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#996
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1000
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1004
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1008
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1012
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1016
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1020
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1024
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1028
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1032
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1036
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1040
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1044
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1048
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1052
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1056
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1060
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1064
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1068
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1072
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1076
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1080
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1084
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1088
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1092
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1096
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1100
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1104
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1108
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1112
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1116
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1120
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1124
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1128
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1132
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1136
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1140
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1144
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1148
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1152
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1156
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1160
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1164
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1168
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1172
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1176
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1180
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1184
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1188
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1192
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1196
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1200
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1204
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1208
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1212
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1216
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1220
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1224
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1228
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1232
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1236
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1240
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1244
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1248
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1252
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1256
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1260
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1264
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1268
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1272
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1276
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1280
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1284
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1288
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1292
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1296
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1300
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1304
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1308
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1312
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1316
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1320
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1324
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1328
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1332
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1336
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1340
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1344
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1348
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1352
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1356
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1360
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1364
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1368
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1372
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1376
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1380
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1384
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1388
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1392
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1396
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1400
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1404
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1408
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1412
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1416
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1420
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1424
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1428
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1432
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1436
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1440
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1444
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1448
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1452
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1456
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1460
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1464
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1468
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1472
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1476
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1480
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1484
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1488
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1492
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1496
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1500
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1504
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1508
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1512
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1516
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1520
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1524
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1528
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1532
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1536
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1540
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1544
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1548
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1552
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1556
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1560
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1564
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1568
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1572
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1576
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1580
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1584
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1588
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1592
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1596
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1600
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1604
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1608
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1612
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1616
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1620
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1624
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1628
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1632
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1636
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1640
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1644
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1648
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1652
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1656
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1660
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1664
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1668
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1672
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1676
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1680
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1684
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1688
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1692
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1696
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1700
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1704
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1708
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1712
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1716
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1720
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1724
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1728
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1732
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1736
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1740
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1744
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1748
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1752
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1756
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1760
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1764
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1768
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1772
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1776
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1780
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1784
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1788
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1792
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1796
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1800
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1804
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1808
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1812
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1816
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1820
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1824
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1828
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1832
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1836
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1840
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1844
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1848
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1852
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1856
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1860
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1864
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1868
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1872
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1876
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1880
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1884
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1888
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1892
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1896
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1900
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1904
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1908
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1912
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1916
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1920
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1924
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1928
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1932
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1936
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1940
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1944
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1948
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1952
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1956
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1960
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1964
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#1968
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1972
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1976
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1980
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#1984
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1988
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#1992
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#1996
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2000
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2004
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2008
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2012
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2016
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2020
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2024
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2028
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2032
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2036
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2040
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2044
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2048
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2052
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2056
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2060
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2064
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2068
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2072
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2076
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2080
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2084
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2088
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2092
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2096
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2100
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2104
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2108
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2112
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2116
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2120
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2124
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2128
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2132
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2136
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2140
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2144
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2148
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2152
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2156
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2160
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2164
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2168
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2172
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2176
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2180
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2184
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2188
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2192
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2196
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2200
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2204
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2208
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2212
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2216
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2220
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2224
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2228
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2232
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2236
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2240
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2244
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2248
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2252
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2256
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2260
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2264
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2268
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2272
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2276
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2280
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2284
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2288
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2292
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2296
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2300
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2304
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2308
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2312
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2316
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2320
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2324
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2328
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2332
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2336
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2340
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2344
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2348
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2352
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2356
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2360
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2364
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2368
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2372
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2376
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2380
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2384
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2388
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2392
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2396
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2400
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2404
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2408
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2412
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2416
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2420
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2424
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2428
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2432
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2436
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2440
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2444
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2448
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2452
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2456
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2460
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2464
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2468
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2472
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2476
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2480
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2484
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2488
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2492
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2496
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2500
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2504
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2508
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2512
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2516
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2520
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2524
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2528
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2532
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2536
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2540
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2544
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2548
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2552
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2556
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2560
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2564
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2568
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2572
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2576
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2580
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2584
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2588
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2592
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2596
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2600
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2604
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2608
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2612
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2616
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2620
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2624
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2628
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2632
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2636
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2640
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2644
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2648
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2652
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2656
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2660
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2664
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2668
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2672
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2676
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2680
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2684
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2688
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2692
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2696
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2700
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2704
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2708
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2712
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2716
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2720
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2724
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2728
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2732
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2736
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2740
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2744
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2748
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2752
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2756
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2760
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2764
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2768
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2772
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2776
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2780
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2784
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2788
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2792
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2796
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2800
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2804
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2808
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2812
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2816
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2820
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2824
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2828
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2832
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2836
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2840
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2844
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2848
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2852
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2856
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2860
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2864
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2868
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2872
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2876
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2880
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2884
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2888
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2892
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2896
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2900
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2904
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2908
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2912
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2916
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2920
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2924
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2928
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2932
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2936
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2940
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2944
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2948
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2952
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2956
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#2960
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2964
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2968
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2972
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2976
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2980
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2984
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#2988
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#2992
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#2996
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3000
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3004
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3008
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3012
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3016
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3020
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3024
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3028
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3032
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3036
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3040
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3044
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3048
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3052
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3056
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3060
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3064
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3068
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3072
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3076
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3080
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3084
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3088
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3092
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3096
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3100
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3104
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3108
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3112
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3116
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3120
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3124
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3128
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3132
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3136
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3140
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3144
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3148
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3152
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3156
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3160
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3164
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3168
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3172
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3176
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3180
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3184
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3188
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3192
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3196
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3200
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3204
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3208
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3212
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3216
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3220
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3224
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3228
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3232
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3236
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3240
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3244
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3248
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3252
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3256
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3260
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3264
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3268
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3272
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3276
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3280
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3284
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3288
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3292
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3296
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3300
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3304
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3308
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3312
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3316
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3320
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3324
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3328
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3332
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3336
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3340
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3344
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3348
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3352
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3356
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3360
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3364
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3368
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3372
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3376
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3380
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3384
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3388
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3392
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3396
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3400
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3404
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3408
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3412
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3416
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3420
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3424
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3428
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3432
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3436
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3440
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3444
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3448
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3452
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3456
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3460
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3464
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3468
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3472
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3476
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3480
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3484
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3488
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3492
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3496
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3500
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3504
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3508
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3512
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3516
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3520
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3524
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3528
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3532
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3536
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3540
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3544
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3548
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3552
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3556
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3560
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3564
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3568
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3572
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3576
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3580
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3584
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3588
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3592
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3596
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3600
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3604
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3608
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3612
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3616
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3620
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3624
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3628
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3632
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3636
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3640
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3644
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3648
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3652
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3656
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3660
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3664
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3668
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3672
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3676
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3680
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3684
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3688
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3692
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3696
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3700
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3704
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3708
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3712
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3716
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3720
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3724
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3728
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3732
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3736
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3740
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3744
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3748
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3752
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3756
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3760
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3764
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3768
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3772
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3776
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3780
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3784
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3788
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3792
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3796
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3800
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3804
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3808
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3812
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3816
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3820
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3824
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3828
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3832
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3836
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3840
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3844
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3848
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3852
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3856
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3860
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3864
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3868
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3872
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3876
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3880
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3884
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3888
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3892
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3896
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3900
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3904
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3908
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3912
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3916
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3920
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3924
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3928
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3932
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3936
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3940
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3944
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3948
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3952
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3956
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3960
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3964
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	mov	r2,	#3968
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3972
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r2,	#4000
	mla	r3,	r0,	r2,	r5
	movw	r2,	#3976
	add	r3,	r3,	r2
	str	r1,	[r3]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3980
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	mov	r3,	#3984
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3988
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3992
	add	r2,	r2,	r3
	str	r1,	[r2]
	movw	r5,	:lower16:_g_c
	movt	r5,	:upper16:_g_c
	mov	r3,	#4000
	mla	r2,	r0,	r3,	r5
	movw	r3,	#3996
	add	r2,	r2,	r3
	str	r1,	[r2]
	mov	r1,	#1
	add	r0,	r0,	r1
	b	b22
.ltorg
b46:
	add	sp,	sp,	#4
	pop	{pc}
	bx	lr
.ltorg
