.arch armv7ve
.arm
.global	_g_data

.section .bss
.align 2
_g_data:
	.zero	2560000
.global	_g_corr

.section .bss
.align 2
_g_corr:
	.zero	2560000
.global	_g_mean

.section .bss
.align 2
_g_mean:
	.zero	3200
.global	_g_stddev

.section .bss
.align 2
_g_stddev:
	.zero	3200
.section .text
.global	main
main:
	push	{lr}
	sub	sp,	sp,	#4
b30:
	movw	r0,	:lower16:_g_data
	movt	r0,	:upper16:_g_data
	bl	getarray
	bl	_sysy_starttime
	mov	r0,	#0
b34:
	mov	r1,	#800
	cmp	r0,	r1
	blt	b35
	b	b39
.ltorg
b35:
	movw	r2,	:lower16:_g_mean
	movt	r2,	:upper16:_g_mean
	add	r1,	r2,	r0, lsl #2
	mov	r2,	#0
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	ldr	r2,	[r3,	r0, lsl #2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r2,	#3200
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	mov	r3,	#6400
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r2,	#9600
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r2,	#12800
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	mov	r3,	#16000
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r2,	#19200
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#22400
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	mov	r3,	#25600
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#28800
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r2,	#32000
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#35200
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	mov	r3,	#38400
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#41600
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r2,	#44800
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#48000
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r4,	#51200
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#54400
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r4,	#57600
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#60800
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	mov	r4,	#64000
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#1664
	movt	r3,	#1
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#4864
	movt	r4,	#1
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#8064
	movt	r4,	#1
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	mov	r4,	#76800
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#14464
	movt	r2,	#1
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#17664
	movt	r4,	#1
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#20864
	movt	r2,	#1
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#24064
	movt	r3,	#1
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#27264
	movt	r3,	#1
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#30464
	movt	r4,	#1
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#33664
	movt	r2,	#1
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	mov	r4,	#102400
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#40064
	movt	r4,	#1
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#43264
	movt	r3,	#1
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#46464
	movt	r4,	#1
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#49664
	movt	r4,	#1
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#52864
	movt	r4,	#1
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#56064
	movt	r3,	#1
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#59264
	movt	r4,	#1
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	mov	r3,	#128000
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#128
	movt	r2,	#2
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#3328
	movt	r4,	#2
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#6528
	movt	r4,	#2
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#9728
	movt	r4,	#2
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#12928
	movt	r4,	#2
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#16128
	movt	r4,	#2
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#19328
	movt	r2,	#2
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	mov	r3,	#153600
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#25728
	movt	r4,	#2
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#28928
	movt	r4,	#2
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#32128
	movt	r4,	#2
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#35328
	movt	r4,	#2
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#38528
	movt	r4,	#2
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#41728
	movt	r2,	#2
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#44928
	movt	r4,	#2
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r4,	#179200
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#51328
	movt	r4,	#2
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#54528
	movt	r3,	#2
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#57728
	movt	r4,	#2
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#60928
	movt	r2,	#2
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#64128
	movt	r2,	#2
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#1792
	movt	r3,	#3
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#4992
	movt	r4,	#3
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	mov	r4,	#204800
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#11392
	movt	r4,	#3
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#14592
	movt	r4,	#3
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#17792
	movt	r3,	#3
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#20992
	movt	r4,	#3
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#24192
	movt	r4,	#3
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#27392
	movt	r4,	#3
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#30592
	movt	r4,	#3
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	mov	r4,	#230400
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#36992
	movt	r4,	#3
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#40192
	movt	r2,	#3
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#43392
	movt	r4,	#3
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#46592
	movt	r4,	#3
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#49792
	movt	r4,	#3
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#52992
	movt	r3,	#3
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#56192
	movt	r4,	#3
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	mov	r2,	#256000
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#62592
	movt	r2,	#3
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#256
	movt	r4,	#4
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#3456
	movt	r4,	#4
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#6656
	movt	r4,	#4
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#9856
	movt	r4,	#4
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#13056
	movt	r4,	#4
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#16256
	movt	r2,	#4
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#19456
	movt	r4,	#4
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#22656
	movt	r4,	#4
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#25856
	movt	r4,	#4
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#29056
	movt	r4,	#4
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#32256
	movt	r4,	#4
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#35456
	movt	r3,	#4
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#38656
	movt	r4,	#4
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#41856
	movt	r3,	#4
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r4,	#307200
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#48256
	movt	r4,	#4
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#51456
	movt	r3,	#4
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#54656
	movt	r4,	#4
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#57856
	movt	r3,	#4
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#61056
	movt	r4,	#4
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#64256
	movt	r4,	#4
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#1920
	movt	r4,	#5
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#5120
	movt	r4,	#5
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#8320
	movt	r4,	#5
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#11520
	movt	r4,	#5
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#14720
	movt	r2,	#5
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#17920
	movt	r4,	#5
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#21120
	movt	r4,	#5
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#24320
	movt	r4,	#5
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#27520
	movt	r3,	#5
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#30720
	movt	r4,	#5
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#33920
	movt	r3,	#5
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#37120
	movt	r4,	#5
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#40320
	movt	r4,	#5
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#43520
	movt	r4,	#5
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#46720
	movt	r4,	#5
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#49920
	movt	r4,	#5
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#53120
	movt	r4,	#5
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#56320
	movt	r2,	#5
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#59520
	movt	r4,	#5
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#62720
	movt	r4,	#5
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#384
	movt	r4,	#6
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#3584
	movt	r4,	#6
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#6784
	movt	r4,	#6
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#9984
	movt	r4,	#6
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#13184
	movt	r4,	#6
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r4,	#409600
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#19584
	movt	r4,	#6
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#22784
	movt	r4,	#6
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#25984
	movt	r2,	#6
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#29184
	movt	r4,	#6
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#32384
	movt	r3,	#6
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#35584
	movt	r2,	#6
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#38784
	movt	r4,	#6
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#41984
	movt	r4,	#6
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#45184
	movt	r4,	#6
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#48384
	movt	r4,	#6
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#51584
	movt	r4,	#6
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#54784
	movt	r2,	#6
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#57984
	movt	r4,	#6
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#61184
	movt	r4,	#6
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#64384
	movt	r4,	#6
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#2048
	movt	r3,	#7
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#5248
	movt	r4,	#7
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#8448
	movt	r4,	#7
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#11648
	movt	r4,	#7
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#14848
	movt	r3,	#7
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#18048
	movt	r3,	#7
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#21248
	movt	r4,	#7
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#24448
	movt	r4,	#7
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#27648
	movt	r4,	#7
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#30848
	movt	r2,	#7
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#34048
	movt	r4,	#7
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#37248
	movt	r4,	#7
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#40448
	movt	r4,	#7
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#43648
	movt	r4,	#7
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#46848
	movt	r4,	#7
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#50048
	movt	r4,	#7
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	mov	r4,	#512000
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#56448
	movt	r4,	#7
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#59648
	movt	r4,	#7
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#62848
	movt	r4,	#7
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#512
	movt	r2,	#8
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#3712
	movt	r2,	#8
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#6912
	movt	r4,	#8
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#10112
	movt	r3,	#8
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#13312
	movt	r3,	#8
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#16512
	movt	r2,	#8
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#19712
	movt	r4,	#8
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#22912
	movt	r2,	#8
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#26112
	movt	r3,	#8
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#29312
	movt	r4,	#8
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#32512
	movt	r3,	#8
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#35712
	movt	r3,	#8
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#38912
	movt	r2,	#8
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#42112
	movt	r3,	#8
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#45312
	movt	r2,	#8
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#48512
	movt	r4,	#8
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#51712
	movt	r3,	#8
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#54912
	movt	r2,	#8
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#58112
	movt	r3,	#8
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#61312
	movt	r2,	#8
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#64512
	movt	r4,	#8
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#2176
	movt	r3,	#9
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#5376
	movt	r4,	#9
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#8576
	movt	r2,	#9
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#11776
	movt	r3,	#9
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#14976
	movt	r3,	#9
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#18176
	movt	r4,	#9
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#21376
	movt	r2,	#9
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r4,	#614400
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#27776
	movt	r4,	#9
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#30976
	movt	r3,	#9
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#34176
	movt	r4,	#9
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#37376
	movt	r2,	#9
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#40576
	movt	r3,	#9
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#43776
	movt	r3,	#9
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#46976
	movt	r3,	#9
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#50176
	movt	r3,	#9
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#53376
	movt	r2,	#9
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#56576
	movt	r2,	#9
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#59776
	movt	r3,	#9
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#62976
	movt	r3,	#9
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#640
	movt	r3,	#10
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#3840
	movt	r4,	#10
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#7040
	movt	r3,	#10
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#10240
	movt	r2,	#10
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#13440
	movt	r2,	#10
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#16640
	movt	r3,	#10
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#19840
	movt	r2,	#10
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#23040
	movt	r4,	#10
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#26240
	movt	r4,	#10
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#29440
	movt	r4,	#10
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#32640
	movt	r3,	#10
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#35840
	movt	r3,	#10
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#39040
	movt	r4,	#10
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#42240
	movt	r3,	#10
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#45440
	movt	r4,	#10
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#48640
	movt	r2,	#10
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#51840
	movt	r2,	#10
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#55040
	movt	r3,	#10
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#58240
	movt	r3,	#10
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r2,	#716800
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#64640
	movt	r4,	#10
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#2304
	movt	r4,	#11
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#5504
	movt	r3,	#11
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#8704
	movt	r3,	#11
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#11904
	movt	r3,	#11
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#15104
	movt	r3,	#11
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#18304
	movt	r4,	#11
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#21504
	movt	r3,	#11
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#24704
	movt	r4,	#11
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#27904
	movt	r3,	#11
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#31104
	movt	r2,	#11
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#34304
	movt	r2,	#11
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#37504
	movt	r3,	#11
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#40704
	movt	r2,	#11
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#43904
	movt	r4,	#11
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#47104
	movt	r3,	#11
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#50304
	movt	r2,	#11
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#53504
	movt	r2,	#11
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#56704
	movt	r3,	#11
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#59904
	movt	r3,	#11
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#63104
	movt	r4,	#11
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#768
	movt	r4,	#12
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#3968
	movt	r4,	#12
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#7168
	movt	r3,	#12
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#10368
	movt	r3,	#12
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#13568
	movt	r4,	#12
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#16768
	movt	r3,	#12
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#19968
	movt	r4,	#12
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#23168
	movt	r3,	#12
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#26368
	movt	r3,	#12
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#29568
	movt	r3,	#12
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r2,	#819200
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#35968
	movt	r2,	#12
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#39168
	movt	r3,	#12
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#42368
	movt	r3,	#12
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#45568
	movt	r3,	#12
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#48768
	movt	r2,	#12
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#51968
	movt	r3,	#12
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#55168
	movt	r2,	#12
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#58368
	movt	r2,	#12
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#61568
	movt	r3,	#12
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#64768
	movt	r4,	#12
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#2432
	movt	r3,	#13
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#5632
	movt	r3,	#13
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#8832
	movt	r2,	#13
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#12032
	movt	r3,	#13
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#15232
	movt	r3,	#13
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#18432
	movt	r4,	#13
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#21632
	movt	r3,	#13
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#24832
	movt	r4,	#13
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#28032
	movt	r2,	#13
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#31232
	movt	r2,	#13
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#34432
	movt	r3,	#13
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#37632
	movt	r3,	#13
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#40832
	movt	r2,	#13
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#44032
	movt	r4,	#13
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#47232
	movt	r2,	#13
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#50432
	movt	r3,	#13
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#53632
	movt	r4,	#13
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#56832
	movt	r2,	#13
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#60032
	movt	r4,	#13
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#63232
	movt	r4,	#13
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#896
	movt	r3,	#14
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r4,	#921600
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#7296
	movt	r3,	#14
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#10496
	movt	r2,	#14
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#13696
	movt	r2,	#14
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#16896
	movt	r3,	#14
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#20096
	movt	r2,	#14
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#23296
	movt	r4,	#14
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#26496
	movt	r3,	#14
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#29696
	movt	r2,	#14
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#32896
	movt	r2,	#14
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#36096
	movt	r3,	#14
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#39296
	movt	r4,	#14
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#42496
	movt	r3,	#14
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#45696
	movt	r4,	#14
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#48896
	movt	r2,	#14
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#52096
	movt	r4,	#14
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#55296
	movt	r3,	#14
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#58496
	movt	r4,	#14
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#61696
	movt	r4,	#14
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#64896
	movt	r4,	#14
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#2560
	movt	r3,	#15
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#5760
	movt	r3,	#15
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#8960
	movt	r3,	#15
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#12160
	movt	r2,	#15
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#15360
	movt	r2,	#15
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#18560
	movt	r3,	#15
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#21760
	movt	r3,	#15
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#24960
	movt	r3,	#15
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#28160
	movt	r4,	#15
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#31360
	movt	r2,	#15
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#34560
	movt	r4,	#15
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#37760
	movt	r3,	#15
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	mov	r3,	#1024000
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#44160
	movt	r4,	#15
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#47360
	movt	r3,	#15
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#50560
	movt	r3,	#15
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#53760
	movt	r2,	#15
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#56960
	movt	r3,	#15
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#60160
	movt	r4,	#15
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#63360
	movt	r4,	#15
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#1024
	movt	r3,	#16
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#4224
	movt	r4,	#16
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#7424
	movt	r2,	#16
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#10624
	movt	r4,	#16
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#13824
	movt	r2,	#16
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#17024
	movt	r3,	#16
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#20224
	movt	r3,	#16
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#23424
	movt	r4,	#16
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#26624
	movt	r2,	#16
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#29824
	movt	r4,	#16
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#33024
	movt	r3,	#16
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#36224
	movt	r4,	#16
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#39424
	movt	r4,	#16
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#42624
	movt	r2,	#16
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#45824
	movt	r4,	#16
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#49024
	movt	r3,	#16
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#52224
	movt	r4,	#16
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#55424
	movt	r4,	#16
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#58624
	movt	r2,	#16
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#61824
	movt	r4,	#16
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#65024
	movt	r4,	#16
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#2688
	movt	r4,	#17
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#5888
	movt	r4,	#17
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#9088
	movt	r2,	#17
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#12288
	movt	r2,	#17
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#15488
	movt	r3,	#17
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#18688
	movt	r2,	#17
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#21888
	movt	r4,	#17
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#25088
	movt	r2,	#17
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#28288
	movt	r4,	#17
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#31488
	movt	r3,	#17
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#34688
	movt	r4,	#17
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#37888
	movt	r4,	#17
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#41088
	movt	r2,	#17
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#44288
	movt	r4,	#17
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#47488
	movt	r3,	#17
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#50688
	movt	r4,	#17
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#53888
	movt	r2,	#17
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#57088
	movt	r2,	#17
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#60288
	movt	r3,	#17
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#63488
	movt	r4,	#17
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#1152
	movt	r4,	#18
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#4352
	movt	r4,	#18
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#7552
	movt	r2,	#18
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#10752
	movt	r4,	#18
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#13952
	movt	r3,	#18
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#17152
	movt	r2,	#18
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#20352
	movt	r4,	#18
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#23552
	movt	r2,	#18
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#26752
	movt	r4,	#18
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#29952
	movt	r3,	#18
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#33152
	movt	r4,	#18
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#36352
	movt	r4,	#18
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#39552
	movt	r4,	#18
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#42752
	movt	r4,	#18
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#45952
	movt	r3,	#18
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	mov	r4,	#1228800
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#52352
	movt	r2,	#18
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#55552
	movt	r2,	#18
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#58752
	movt	r2,	#18
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#61952
	movt	r4,	#18
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#65152
	movt	r3,	#18
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#2816
	movt	r4,	#19
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#6016
	movt	r2,	#19
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#9216
	movt	r4,	#19
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#12416
	movt	r3,	#19
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#15616
	movt	r4,	#19
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#18816
	movt	r4,	#19
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#22016
	movt	r2,	#19
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#25216
	movt	r4,	#19
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#28416
	movt	r2,	#19
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#31616
	movt	r4,	#19
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#34816
	movt	r3,	#19
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#38016
	movt	r4,	#19
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#41216
	movt	r4,	#19
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#44416
	movt	r3,	#19
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#47616
	movt	r4,	#19
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#50816
	movt	r4,	#19
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#54016
	movt	r2,	#19
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#57216
	movt	r2,	#19
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#60416
	movt	r4,	#19
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#63616
	movt	r2,	#19
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#1280
	movt	r4,	#20
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#4480
	movt	r2,	#20
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#7680
	movt	r4,	#20
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#10880
	movt	r3,	#20
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#14080
	movt	r4,	#20
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#17280
	movt	r4,	#20
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#20480
	movt	r3,	#20
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#23680
	movt	r4,	#20
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#26880
	movt	r3,	#20
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#30080
	movt	r4,	#20
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#33280
	movt	r2,	#20
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#36480
	movt	r4,	#20
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#39680
	movt	r3,	#20
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#42880
	movt	r3,	#20
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#46080
	movt	r4,	#20
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#49280
	movt	r4,	#20
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#52480
	movt	r2,	#20
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#55680
	movt	r4,	#20
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#58880
	movt	r4,	#20
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#62080
	movt	r2,	#20
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#65280
	movt	r4,	#20
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#2944
	movt	r4,	#21
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#6144
	movt	r4,	#21
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#9344
	movt	r4,	#21
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#12544
	movt	r2,	#21
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#15744
	movt	r4,	#21
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#18944
	movt	r3,	#21
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#22144
	movt	r4,	#21
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#25344
	movt	r3,	#21
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#28544
	movt	r4,	#21
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#31744
	movt	r2,	#21
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#34944
	movt	r4,	#21
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#38144
	movt	r2,	#21
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#41344
	movt	r3,	#21
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#44544
	movt	r3,	#21
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#47744
	movt	r4,	#21
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#50944
	movt	r2,	#21
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#54144
	movt	r4,	#21
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#57344
	movt	r4,	#21
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#60544
	movt	r3,	#21
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#63744
	movt	r4,	#21
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#1408
	movt	r4,	#22
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#4608
	movt	r4,	#22
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#7808
	movt	r3,	#22
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#11008
	movt	r4,	#22
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#14208
	movt	r3,	#22
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#17408
	movt	r2,	#22
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#20608
	movt	r4,	#22
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#23808
	movt	r3,	#22
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#27008
	movt	r4,	#22
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#30208
	movt	r4,	#22
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#33408
	movt	r4,	#22
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#36608
	movt	r2,	#22
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#39808
	movt	r3,	#22
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#43008
	movt	r2,	#22
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#46208
	movt	r4,	#22
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#49408
	movt	r4,	#22
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#52608
	movt	r4,	#22
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#55808
	movt	r4,	#22
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#59008
	movt	r2,	#22
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#62208
	movt	r4,	#22
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#65408
	movt	r3,	#22
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#3072
	movt	r4,	#23
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#6272
	movt	r3,	#23
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#9472
	movt	r4,	#23
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#12672
	movt	r2,	#23
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#15872
	movt	r2,	#23
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#19072
	movt	r3,	#23
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#22272
	movt	r3,	#23
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#25472
	movt	r4,	#23
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#28672
	movt	r4,	#23
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#31872
	movt	r4,	#23
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#35072
	movt	r3,	#23
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#38272
	movt	r4,	#23
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#41472
	movt	r4,	#23
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#44672
	movt	r4,	#23
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#47872
	movt	r4,	#23
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#51072
	movt	r4,	#23
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#54272
	movt	r4,	#23
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#57472
	movt	r2,	#23
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#60672
	movt	r4,	#23
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#63872
	movt	r3,	#23
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#1536
	movt	r4,	#24
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#4736
	movt	r3,	#24
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#7936
	movt	r4,	#24
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#11136
	movt	r2,	#24
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#14336
	movt	r2,	#24
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#17536
	movt	r2,	#24
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#20736
	movt	r3,	#24
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#23936
	movt	r3,	#24
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#27136
	movt	r4,	#24
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#30336
	movt	r2,	#24
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#33536
	movt	r4,	#24
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#36736
	movt	r3,	#24
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#39936
	movt	r4,	#24
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#43136
	movt	r4,	#24
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#46336
	movt	r2,	#24
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#49536
	movt	r4,	#24
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#52736
	movt	r3,	#24
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#55936
	movt	r4,	#24
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#59136
	movt	r4,	#24
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#62336
	movt	r2,	#24
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r4,	#1638400
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#3200
	movt	r3,	#25
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#6400
	movt	r4,	#25
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#9600
	movt	r4,	#25
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#12800
	movt	r4,	#25
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#16000
	movt	r2,	#25
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#19200
	movt	r3,	#25
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#22400
	movt	r2,	#25
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#25600
	movt	r4,	#25
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#28800
	movt	r2,	#25
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#32000
	movt	r4,	#25
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#35200
	movt	r3,	#25
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#38400
	movt	r4,	#25
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#41600
	movt	r4,	#25
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#44800
	movt	r2,	#25
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#48000
	movt	r4,	#25
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#51200
	movt	r3,	#25
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#54400
	movt	r4,	#25
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#57600
	movt	r4,	#25
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#60800
	movt	r4,	#25
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#64000
	movt	r3,	#25
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#1664
	movt	r3,	#26
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#4864
	movt	r4,	#26
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#8064
	movt	r4,	#26
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#11264
	movt	r4,	#26
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#14464
	movt	r4,	#26
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#17664
	movt	r3,	#26
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#20864
	movt	r2,	#26
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#24064
	movt	r4,	#26
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#27264
	movt	r2,	#26
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#30464
	movt	r4,	#26
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#33664
	movt	r3,	#26
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#36864
	movt	r4,	#26
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#40064
	movt	r4,	#26
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#43264
	movt	r2,	#26
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#46464
	movt	r4,	#26
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#49664
	movt	r3,	#26
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#52864
	movt	r4,	#26
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#56064
	movt	r2,	#26
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#59264
	movt	r2,	#26
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#62464
	movt	r2,	#26
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#128
	movt	r3,	#27
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#3328
	movt	r3,	#27
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#6528
	movt	r4,	#27
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#9728
	movt	r4,	#27
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#12928
	movt	r4,	#27
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#16128
	movt	r3,	#27
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#19328
	movt	r4,	#27
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#22528
	movt	r4,	#27
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#25728
	movt	r2,	#27
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#28928
	movt	r4,	#27
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#32128
	movt	r3,	#27
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#35328
	movt	r4,	#27
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#38528
	movt	r3,	#27
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#41728
	movt	r2,	#27
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#44928
	movt	r4,	#27
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#48128
	movt	r3,	#27
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#51328
	movt	r4,	#27
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#54528
	movt	r4,	#27
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#57728
	movt	r2,	#27
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#60928
	movt	r2,	#27
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#64128
	movt	r3,	#27
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#1792
	movt	r2,	#28
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#4992
	movt	r4,	#28
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#8192
	movt	r4,	#28
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#11392
	movt	r4,	#28
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#14592
	movt	r3,	#28
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#17792
	movt	r4,	#28
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#20992
	movt	r4,	#28
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#24192
	movt	r2,	#28
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#27392
	movt	r4,	#28
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#30592
	movt	r3,	#28
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#33792
	movt	r4,	#28
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#36992
	movt	r2,	#28
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#40192
	movt	r2,	#28
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#43392
	movt	r3,	#28
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#46592
	movt	r3,	#28
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#49792
	movt	r4,	#28
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#52992
	movt	r4,	#28
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#56192
	movt	r2,	#28
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#59392
	movt	r4,	#28
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#62592
	movt	r3,	#28
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#256
	movt	r2,	#29
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#3456
	movt	r4,	#29
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#6656
	movt	r4,	#29
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#9856
	movt	r4,	#29
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#13056
	movt	r4,	#29
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#16256
	movt	r2,	#29
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#19456
	movt	r4,	#29
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#22656
	movt	r3,	#29
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#25856
	movt	r4,	#29
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#29056
	movt	r4,	#29
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#32256
	movt	r4,	#29
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#35456
	movt	r2,	#29
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#38656
	movt	r2,	#29
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#41856
	movt	r2,	#29
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#45056
	movt	r3,	#29
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#48256
	movt	r3,	#29
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#51456
	movt	r4,	#29
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#54656
	movt	r2,	#29
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#57856
	movt	r4,	#29
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#61056
	movt	r3,	#29
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#64256
	movt	r4,	#29
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#1920
	movt	r4,	#30
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#5120
	movt	r4,	#30
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#8320
	movt	r4,	#30
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#11520
	movt	r3,	#30
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#14720
	movt	r4,	#30
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#17920
	movt	r3,	#30
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#21120
	movt	r2,	#30
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#24320
	movt	r4,	#30
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#27520
	movt	r4,	#30
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#30720
	movt	r4,	#30
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#33920
	movt	r4,	#30
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#37120
	movt	r2,	#30
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#40320
	movt	r2,	#30
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#43520
	movt	r3,	#30
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#46720
	movt	r2,	#30
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#49920
	movt	r4,	#30
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#53120
	movt	r4,	#30
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#56320
	movt	r2,	#30
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#59520
	movt	r4,	#30
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#62720
	movt	r2,	#30
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#384
	movt	r4,	#31
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#3584
	movt	r3,	#31
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#6784
	movt	r4,	#31
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#9984
	movt	r3,	#31
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#13184
	movt	r4,	#31
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	mov	r2,	#2048000
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#19584
	movt	r2,	#31
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#22784
	movt	r3,	#31
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#25984
	movt	r4,	#31
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#29184
	movt	r4,	#31
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#32384
	movt	r4,	#31
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#35584
	movt	r2,	#31
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#38784
	movt	r4,	#31
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#41984
	movt	r4,	#31
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#45184
	movt	r4,	#31
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#48384
	movt	r4,	#31
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#51584
	movt	r4,	#31
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#54784
	movt	r4,	#31
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#57984
	movt	r4,	#31
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#61184
	movt	r2,	#31
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#64384
	movt	r4,	#31
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#2048
	movt	r3,	#32
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#5248
	movt	r4,	#32
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#8448
	movt	r3,	#32
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#11648
	movt	r4,	#32
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#14848
	movt	r2,	#32
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#18048
	movt	r2,	#32
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#21248
	movt	r2,	#32
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#24448
	movt	r4,	#32
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#27648
	movt	r3,	#32
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#30848
	movt	r4,	#32
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#34048
	movt	r2,	#32
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#37248
	movt	r4,	#32
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#40448
	movt	r3,	#32
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#43648
	movt	r4,	#32
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#46848
	movt	r4,	#32
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#50048
	movt	r4,	#32
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#53248
	movt	r4,	#32
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#56448
	movt	r3,	#32
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#59648
	movt	r4,	#32
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#62848
	movt	r4,	#32
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#512
	movt	r2,	#33
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#3712
	movt	r4,	#33
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#6912
	movt	r4,	#33
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#10112
	movt	r4,	#33
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#13312
	movt	r4,	#33
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#16512
	movt	r4,	#33
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#19712
	movt	r2,	#33
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#22912
	movt	r3,	#33
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#26112
	movt	r3,	#33
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#29312
	movt	r4,	#33
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#32512
	movt	r2,	#33
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#35712
	movt	r4,	#33
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#38912
	movt	r3,	#33
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#42112
	movt	r4,	#33
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#45312
	movt	r4,	#33
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#48512
	movt	r4,	#33
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#51712
	movt	r4,	#33
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#54912
	movt	r3,	#33
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#58112
	movt	r4,	#33
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#61312
	movt	r4,	#33
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#64512
	movt	r2,	#33
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#2176
	movt	r4,	#34
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#5376
	movt	r3,	#34
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#8576
	movt	r4,	#34
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#11776
	movt	r4,	#34
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#14976
	movt	r2,	#34
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#18176
	movt	r4,	#34
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#21376
	movt	r3,	#34
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#24576
	movt	r2,	#34
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#27776
	movt	r4,	#34
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#30976
	movt	r2,	#34
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#34176
	movt	r4,	#34
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#37376
	movt	r3,	#34
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#40576
	movt	r4,	#34
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#43776
	movt	r4,	#34
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#46976
	movt	r4,	#34
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#50176
	movt	r4,	#34
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#53376
	movt	r3,	#34
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#56576
	movt	r4,	#34
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#59776
	movt	r2,	#34
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#62976
	movt	r2,	#34
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#640
	movt	r3,	#35
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#3840
	movt	r4,	#35
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#7040
	movt	r3,	#35
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#10240
	movt	r4,	#35
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#13440
	movt	r2,	#35
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#16640
	movt	r4,	#35
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#19840
	movt	r3,	#35
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#23040
	movt	r4,	#35
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#26240
	movt	r4,	#35
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#29440
	movt	r2,	#35
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#32640
	movt	r4,	#35
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#35840
	movt	r3,	#35
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#39040
	movt	r4,	#35
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#42240
	movt	r4,	#35
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#45440
	movt	r4,	#35
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#48640
	movt	r4,	#35
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#51840
	movt	r3,	#35
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#55040
	movt	r4,	#35
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#58240
	movt	r4,	#35
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#61440
	movt	r2,	#35
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#64640
	movt	r2,	#35
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#2304
	movt	r4,	#36
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#5504
	movt	r3,	#36
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#8704
	movt	r4,	#36
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#11904
	movt	r2,	#36
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#15104
	movt	r4,	#36
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#18304
	movt	r3,	#36
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#21504
	movt	r4,	#36
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#24704
	movt	r4,	#36
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#27904
	movt	r2,	#36
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#31104
	movt	r4,	#36
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r3,	#34304
	movt	r3,	#36
	ldr	r3,	[r4,	r3]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#37504
	movt	r4,	#36
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#40704
	movt	r3,	#36
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#43904
	movt	r4,	#36
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#47104
	movt	r3,	#36
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#50304
	movt	r3,	#36
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#53504
	movt	r4,	#36
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#56704
	movt	r4,	#36
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#59904
	movt	r2,	#36
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#63104
	movt	r4,	#36
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#768
	movt	r4,	#37
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#3968
	movt	r2,	#37
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#7168
	movt	r4,	#37
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#10368
	movt	r2,	#37
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#13568
	movt	r4,	#37
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#16768
	movt	r3,	#37
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#19968
	movt	r4,	#37
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#23168
	movt	r4,	#37
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#26368
	movt	r3,	#37
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#29568
	movt	r4,	#37
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	mov	r3,	#2457600
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#35968
	movt	r4,	#37
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#39168
	movt	r2,	#37
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#42368
	movt	r4,	#37
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#45568
	movt	r3,	#37
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#48768
	movt	r3,	#37
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#51968
	movt	r3,	#37
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#55168
	movt	r4,	#37
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#58368
	movt	r2,	#37
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#61568
	movt	r4,	#37
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#64768
	movt	r4,	#37
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#2432
	movt	r4,	#38
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#5632
	movt	r4,	#38
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#8832
	movt	r4,	#38
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#12032
	movt	r4,	#38
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#15232
	movt	r4,	#38
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#18432
	movt	r4,	#38
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#21632
	movt	r3,	#38
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#24832
	movt	r2,	#38
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#28032
	movt	r4,	#38
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#31232
	movt	r3,	#38
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#34432
	movt	r4,	#38
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r4,	#37632
	movt	r4,	#38
	ldr	r2,	[r2,	r4]
	add	r2,	r3,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#40832
	movt	r4,	#38
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r3,	r2
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	add	r4,	r4,	r0, lsl #2
	movw	r2,	#44032
	movt	r2,	#38
	ldr	r2,	[r4,	r2]
	add	r2,	r3,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#47232
	movt	r3,	#38
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#50432
	movt	r3,	#38
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#53632
	movt	r4,	#38
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r2,	#56832
	movt	r2,	#38
	ldr	r2,	[r3,	r2]
	add	r2,	r4,	r2
	str	r2,	[r1]
	movw	r3,	:lower16:_g_data
	movt	r3,	:upper16:_g_data
	add	r3,	r3,	r0, lsl #2
	movw	r4,	#60032
	movt	r4,	#38
	ldr	r3,	[r3,	r4]
	add	r2,	r2,	r3
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#63232
	movt	r3,	#38
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r4,	r2
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	add	r2,	r2,	r0, lsl #2
	movw	r3,	#896
	movt	r3,	#39
	ldr	r2,	[r2,	r3]
	add	r2,	r4,	r2
	str	r2,	[r1]
	mov	r3,	#800
	sdiv	r2,	r2,	r3
	str	r2,	[r1]
	mov	r1,	#1
	add	r0,	r0,	r1
	b	b34
.ltorg
b39:
	mov	r0,	#0
b40:
	mov	r1,	#800
	cmp	r0,	r1
	blt	b41
b47:
	mov	r0,	#0
b48:
	mov	r1,	#800
	cmp	r0,	r1
	blt	b49
	b	b53
.ltorg
b49:
	mov	r1,	#0
b50:
	mov	r2,	#800
	cmp	r1,	r2
	blt	b51
	b	b52
.ltorg
b51:
	movw	r2,	:lower16:_g_data
	movt	r2,	:upper16:_g_data
	mov	r3,	#3200
	mla	r2,	r0,	r3,	r2
	add	r2,	r2,	r1, lsl #2
	ldr	r5,	[r2]
	movw	r3,	:lower16:_g_mean
	movt	r3,	:upper16:_g_mean
	ldr	r3,	[r3,	r1, lsl #2]
	sub	r3,	r5,	r3
	str	r3,	[r2]
	movw	r4,	:lower16:_g_stddev
	movt	r4,	:upper16:_g_stddev
	ldr	r4,	[r4,	r1, lsl #2]
	movw	r5,	#50176
	movt	r5,	#9
	mul	r4,	r4,	r5
	sdiv	r3,	r3,	r4
	str	r3,	[r2]
	mov	r2,	#1
	add	r1,	r1,	r2
	b	b50
.ltorg
b52:
	mov	r1,	#1
	add	r0,	r0,	r1
	b	b48
.ltorg
b53:
	mov	r3,	#0
b54:
	movw	r0,	#799
	cmp	r3,	r0
	blt	b55
b62:
	movw	r0,	:lower16:_g_corr
	movt	r0,	:upper16:_g_corr
	movw	r1,	#4092
	movt	r1,	#39
	add	r1,	r0,	r1
	mov	r0,	#1
	str	r0,	[r1]
	bl	_sysy_stoptime
	movw	r1,	:lower16:_g_corr
	movt	r1,	:upper16:_g_corr
	movw	r0,	#50176
	movt	r0,	#9
	bl	putarray
	mov	r0,	#0
	add	sp,	sp,	#4
	pop	{pc}
	bx	lr
.ltorg
b55:
	movw	r0,	:lower16:_g_corr
	movt	r0,	:upper16:_g_corr
	mov	r1,	#3200
	mla	r0,	r3,	r1,	r0
	add	r0,	r0,	r3, lsl #2
	mov	r1,	#1
	str	r1,	[r0]
	mov	r0,	#1
	add	r2,	r3,	r0
	mov	r0,	r2
b56:
	mov	r1,	#800
	cmp	r0,	r1
	blt	b58
b57:
	mov	r3,	r2
	b	b54
.ltorg
b58:
	movw	r1,	:lower16:_g_corr
	movt	r1,	:upper16:_g_corr
	mov	r5,	#3200
	mla	r4,	r3,	r5,	r1
	mov	r5,	r0, lsl #2
	add	r4,	r4,	r0, lsl #2
	mov	r1,	#0
	str	r1,	[r4]
	mov	r1,	#0
b59:
	mov	r5,	#800
	cmp	r1,	r5
	blt	b60
	b	b61
.ltorg
b60:
	ldr	r5,	[r4]
	movw	r6,	:lower16:_g_data
	movt	r6,	:upper16:_g_data
	mov	r7,	#3200
	mla	r6,	r1,	r7,	r6
	ldr	r6,	[r6,	r3, lsl #2]
	movw	r7,	:lower16:_g_data
	movt	r7,	:upper16:_g_data
	mov	r8,	#3200
	mla	r7,	r1,	r8,	r7
	mov	r8,	r0, lsl #2
	ldr	r7,	[r7,	r0, lsl #2]
	mul	r6,	r6,	r7
	add	r5,	r5,	r6
	str	r5,	[r4]
	mov	r5,	#1
	add	r1,	r1,	r5
	b	b59
.ltorg
b61:
	movw	r5,	:lower16:_g_corr
	movt	r5,	:upper16:_g_corr
	mov	r1,	#3200
	mla	r5,	r0,	r1,	r5
	add	r5,	r5,	r3, lsl #2
	ldr	r1,	[r4]
	str	r1,	[r5]
	mov	r1,	#1
	add	r0,	r0,	r1
	b	b56
.ltorg
b41:
	movw	r1,	:lower16:_g_stddev
	movt	r1,	:upper16:_g_stddev
	add	r2,	r1,	r0, lsl #2
	mov	r1,	#0
	str	r1,	[r2]
	movw	r1,	:lower16:_g_mean
	movt	r1,	:upper16:_g_mean
	ldr	r3,	[r1,	r0, lsl #2]
	mov	r1,	#0
b42:
	mov	r4,	#800
	cmp	r1,	r4
	blt	b43
	b	b44
.ltorg
b43:
	ldr	r5,	[r2]
	movw	r4,	:lower16:_g_data
	movt	r4,	:upper16:_g_data
	mov	r6,	#3200
	mla	r4,	r1,	r6,	r4
	mov	r6,	r0, lsl #2
	ldr	r4,	[r4,	r0, lsl #2]
	sub	r4,	r4,	r3
	mul	r4,	r4,	r4
	add	r4,	r5,	r4
	str	r4,	[r2]
	mov	r4,	#1
	add	r1,	r1,	r4
	b	b42
.ltorg
b44:
	ldr	r1,	[r2]
	mov	r3,	#800
	sdiv	r1,	r1,	r3
	str	r1,	[r2]
	mul	r1,	r1,	r1
	str	r1,	[r2]
	mov	r3,	#1
	cmp	r1,	r3
	ble	b45
b46:
	mov	r1,	#1
	add	r0,	r0,	r1
	b	b40
.ltorg
b45:
	mov	r1,	#1
	str	r1,	[r2]
	b	b46
.ltorg
