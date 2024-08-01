.arch armv7ve

.global	_g_image

.bss
.align 4
_g_image:
	.zero	4194304
.global	_g_width

.bss
.align 4
_g_width:
	.zero	4
.global	_g_height

.bss
.align 4
_g_height:
	.zero	4
.text
.global	my_sin_impl
my_sin_impl:
	push	{lr}
	sub	sp,	sp,	#4
b7:
	vldr	s1,	=0x0
	vcmp.f32	s0,	s1
	vmrs	APSR_nzcv, fpscr
	bgt	b62
	b	b63
.ltorg
b60:
	vldr	s2,	=0x358637BD
	vcmp.f32	s1,	s2
	vmrs	APSR_nzcv, fpscr
	ble	b8
	b	b9
.ltorg
b8:
	add	sp,	sp,	#4
	pop	{pc}
	bx	lr
.ltorg
b9:
	vldr	s1,	=0x40400000
	vdiv.f32	s0,	s0,	s1
	bl	my_sin_impl
	vldr	s1,	=0x40400000
	vmul.f32	s2,	s0,	s1
	vldr	s1,	=0x40800000
	vmul.f32	s1,	s0,	s1
	vmul.f32	s1,	s1,	s0
	vmul.f32	s0,	s1,	s0
	vsub.f32	s0,	s2,	s0
	add	sp,	sp,	#4
	pop	{pc}
	bx	lr
.ltorg
b62:
	vmov	s1,	s0
	b	b60
.ltorg
b63:
	vldr	s1,	=0x0
	vsub.f32	s1,	s1,	s0
	b	b60
.ltorg
.global	my_sin
my_sin:
	push	{lr}
	sub	sp,	sp,	#4
b12:
	vldr	s1,	=0x40C90FDB
	vcmp.f32	s0,	s1
	vmrs	APSR_nzcv, fpscr
	bgt	b13
	b	b15
.ltorg
b13:
	vldr	s1,	=0x40C90FDB
	vdiv.f32	s1,	s0,	s1
	vcvt.s32.f32	s1,	s1
	vmov	r0,	s1
	vmov	s1,	r0
	vcvt.f32.s32	s1,	s1
	vldr	s2,	=0x40C90FDB
	vmul.f32	s1,	s1,	s2
	vsub.f32	s0,	s0,	s1
	b	b14
.ltorg
b14:
	vldr	s1,	=0x40490FDB
	vcmp.f32	s0,	s1
	vmrs	APSR_nzcv, fpscr
	bgt	b16
	b	b17
.ltorg
b16:
	vldr	s1,	=0x40C90FDB
	vsub.f32	s0,	s0,	s1
	b	b17
.ltorg
b17:
	vldr	s1,	=0xC0490FDB
	vcmp.f32	s0,	s1
	vmrs	APSR_nzcv, fpscr
	blt	b18
	b	b19
.ltorg
b18:
	vldr	s1,	=0x40C90FDB
	vadd.f32	s0,	s0,	s1
	b	b19
.ltorg
b19:
	bl	my_sin_impl
	add	sp,	sp,	#4
	pop	{pc}
	bx	lr
.ltorg
b15:
	vldr	s1,	=0xC0C90FDB
	vcmp.f32	s0,	s1
	vmrs	APSR_nzcv, fpscr
	blt	b13
	b	b14
.ltorg
.global	my_cos
my_cos:
	push	{lr}
	sub	sp,	sp,	#4
b21:
	vldr	s1,	=0x3FC90FDB
	vadd.f32	s0,	s0,	s1
	bl	my_sin
	add	sp,	sp,	#4
	pop	{pc}
	bx	lr
.ltorg
.global	rotate
rotate:
	push	{r4,r5,r6,lr}
	vpush	{s16,s17}
b40:
	mov	r4,	r1
	mov	r5,	r0
	vmov	s16,	s0
	vmov	s0,	s16
	bl	my_sin
	vmov	s17,	s0
	vmov	s0,	s16
	bl	my_cos
	movw	r6,	:lower16:_g_width
	movt	r6,	:upper16:_g_width
	ldr	r6,	[r6]
	movw	r1,	:lower16:_g_height
	movt	r1,	:upper16:_g_height
	ldr	r1,	[r1]
	mov	r0,	#2
	sdiv	r2,	r6,	r0
	sub	r5,	r5,	r2
	vmov	s1,	r5
	vcvt.f32.s32	s1,	s1
	vmul.f32	s2,	s1,	s0
	mov	r0,	#2
	sdiv	r3,	r1,	r0
	sub	r1,	r4,	r3
	vmov	s1,	r1
	vcvt.f32.s32	s1,	s1
	vmul.f32	s1,	s1,	s17
	vsub.f32	s1,	s2,	s1
	vmov	s2,	r2
	vcvt.f32.s32	s2,	s2
	vadd.f32	s1,	s1,	s2
	vcvt.s32.f32	s1,	s1
	vmov	r2,	s1
	mov	r0,	#0
	cmp	r2,	r0
	blt	b41
	b	b45
.ltorg
b41:
	mov	r0,	#0
	vpop	{s16,s17}
	pop	{r4,r5,r6,pc}
	bx	lr
.ltorg
b45:
	cmp	r2,	r6
	bge	b41
	b	b44
.ltorg
b44:
	vmov	s1,	r5
	vcvt.f32.s32	s1,	s1
	vmul.f32	s1,	s1,	s17
	vmov	s2,	r1
	vcvt.f32.s32	s2,	s2
	vmul.f32	s0,	s2,	s0
	vadd.f32	s1,	s1,	s0
	vmov	s0,	r3
	vcvt.f32.s32	s0,	s0
	vadd.f32	s0,	s1,	s0
	vcvt.s32.f32	s0,	s0
	vmov	r1,	s0
	mov	r0,	#0
	cmp	r1,	r0
	blt	b41
	b	b43
.ltorg
b43:
	movw	r0,	:lower16:_g_height
	movt	r0,	:upper16:_g_height
	ldr	r0,	[r0]
	cmp	r1,	r0
	bge	b41
	b	b42
.ltorg
b42:
	movw	r0,	:lower16:_g_width
	movt	r0,	:upper16:_g_width
	ldr	r0,	[r0]
	mul	r0,	r1,	r0
	add	r1,	r0,	r2
	movw	r0,	:lower16:_g_image
	movt	r0,	:upper16:_g_image
	mov	r2,	#4
	mla	r0,	r1,	r2,	r0
	ldr	r0,	[r0]
	vpop	{s16,s17}
	pop	{r4,r5,r6,pc}
	bx	lr
.ltorg
.global	write_pgm
write_pgm:
	push	{r4,r5,r6,r7,lr}
	vpush	{s16}
b48:
	vmov	s16,	s0
	mov	r0,	#80
	bl	putch
	mov	r0,	#50
	bl	putch
	mov	r0,	#10
	bl	putch
	movw	r0,	:lower16:_g_width
	movt	r0,	:upper16:_g_width
	ldr	r0,	[r0]
	bl	putint
	mov	r0,	#32
	bl	putch
	movw	r0,	:lower16:_g_height
	movt	r0,	:upper16:_g_height
	ldr	r0,	[r0]
	bl	putint
	mov	r0,	#32
	bl	putch
	mov	r0,	#255
	bl	putint
	mov	r0,	#10
	bl	putch
	movw	r7,	:lower16:_g_height
	movt	r7,	:upper16:_g_height
	ldr	r7,	[r7]
	movw	r6,	:lower16:_g_width
	movt	r6,	:upper16:_g_width
	ldr	r6,	[r6]
	mov	r5,	#0
	b	b49
.ltorg
b49:
	cmp	r5,	r7
	blt	b50
	b	b51
.ltorg
b50:
	mov	r4,	#0
	b	b52
.ltorg
b52:
	cmp	r4,	r6
	blt	b53
	b	b54
.ltorg
b53:
	mov	r0,	r4
	mov	r1,	r5
	vmov	s0,	s16
	bl	rotate
	bl	putint
	mov	r0,	#32
	bl	putch
	mov	r0,	#1
	add	r4,	r4,	r0
	b	b52
.ltorg
b54:
	mov	r0,	#10
	bl	putch
	mov	r0,	#1
	add	r5,	r5,	r0
	b	b49
.ltorg
b51:
	vpop	{s16}
	pop	{r4,r5,r6,r7,pc}
	bx	lr
.ltorg
.global	main
main:
	push	{lr}
	sub	sp,	sp,	#4
b55:
	bl	getfloat
	vmov	s16,	s0
	bl	getch
	bl	getch
	mov	r1,	#80
	cmp	r0,	r1
	bne	b68
	b	b69
.ltorg
b66:
	mov	r1,	#0
	cmp	r0,	r1
	blt	b56
	b	b57
.ltorg
b56:
	mvn	r0,	#0
	add	sp,	sp,	#4
	pop	{pc}
	bx	lr
.ltorg
b57:
	vmov	s0,	s16
	bl	write_pgm
	mov	r0,	#0
	add	sp,	sp,	#4
	pop	{pc}
	bx	lr
.ltorg
b68:
	mvn	r0,	#0
	b	b66
.ltorg
b69:
	bl	getch
	mov	r1,	#50
	cmp	r0,	r1
	bne	b68
	b	b70
.ltorg
b70:
	bl	getint
	movw	r1,	:lower16:_g_width
	movt	r1,	:upper16:_g_width
	str	r0,	[r1]
	bl	getint
	movw	r1,	:lower16:_g_height
	movt	r1,	:upper16:_g_height
	str	r0,	[r1]
	movw	r1,	:lower16:_g_width
	movt	r1,	:upper16:_g_width
	ldr	r1,	[r1]
	mov	r0,	#1024
	cmp	r1,	r0
	bgt	b73
	b	b71
.ltorg
b71:
	movw	r0,	:lower16:_g_height
	movt	r0,	:upper16:_g_height
	ldr	r0,	[r0]
	mov	r1,	#1024
	cmp	r0,	r1
	bgt	b73
	b	b72
.ltorg
b72:
	bl	getint
	mov	r1,	#255
	cmp	r0,	r1
	bne	b73
	b	b74
.ltorg
b74:
	movw	r7,	:lower16:_g_height
	movt	r7,	:upper16:_g_height
	ldr	r7,	[r7]
	movw	r6,	:lower16:_g_width
	movt	r6,	:upper16:_g_width
	ldr	r6,	[r6]
	mov	r4,	#0
	b	b75
.ltorg
b75:
	cmp	r4,	r7
	blt	b76
	b	b80
.ltorg
b80:
	mov	r0,	#0
	b	b66
.ltorg
b76:
	mul	r8,	r4,	r6
	mov	r5,	#0
	b	b77
.ltorg
b77:
	cmp	r5,	r6
	blt	b78
	b	b79
.ltorg
b78:
	bl	getint
	add	r2,	r8,	r5
	movw	r1,	:lower16:_g_image
	movt	r1,	:upper16:_g_image
	mov	r3,	#4
	mla	r1,	r2,	r3,	r1
	str	r0,	[r1]
	mov	r0,	#1
	add	r5,	r5,	r0
	b	b77
.ltorg
b79:
	mov	r0,	#1
	add	r4,	r4,	r0
	b	b75
.ltorg
b73:
	mvn	r0,	#0
	b	b66
.ltorg
