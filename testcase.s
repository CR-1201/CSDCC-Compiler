.arch armv7ve
.arm
.section .text
.global	main
main:
	push	{lr}
	sub	sp,	sp,	#4
b12:
	bl	_sysy_starttime
	bl	getint
	mov	r1,	#1
	add	r1,	r0,	r1
	mov	r0,	r1, asr #31
	ands	r1,	r1,	#1
	orrne	r1,	r1,	r0, lsl #1
	vmov	s0,	r1
	vcvt.f32.s32	s0,	s0
	vldr	s1,	=0x3F8020C5
	vmul.f32	s1,	s1,	s0
	vldr	s0,	=0x3F8020C5
	vsub.f32	s1,	s1,	s0
	vldr	s0,	=0x0
	vcmp.f32	s1,	s0
	vmrs	APSR_nzcv, fpscr
	beq	b13
	b	b14
.ltorg
b13:
	mov	r0,	#112
	bl	putch
b14:
	bl	_sysy_stoptime
	mov	r0,	#0
	add	sp,	sp,	#4
	pop	{pc}
	bx	lr
.ltorg
