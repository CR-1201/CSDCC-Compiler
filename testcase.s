.arch armv7ve

.global	_g_a

.bss
.align 4
_g_a:
	.zero	4
.global	_g_sum

.bss
.align 4
_g_sum:
	.zero	4
.global	_g_count

.bss
.align 4
_g_count:
	.zero	4
.text
.global	main
main:
	push	{lr}
	sub	sp,	sp,	#4
b7:
	mov	r0,	#0
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r0,	[r5]
	movw	r1,	:lower16:_g_count
	movt	r1,	:upper16:_g_count
	ldr	r1,	[r1]
	mov	r0,	#1
	add	r0,	r1,	r0
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r0,	[r5]
	movw	r1,	:lower16:_g_count
	movt	r1,	:upper16:_g_count
	ldr	r1,	[r1]
	movw	r0,	:lower16:_g_a
	movt	r0,	:upper16:_g_a
	str	r1,	[r0]
	movw	r0,	:lower16:_g_sum
	movt	r0,	:upper16:_g_sum
	ldr	r0,	[r0]
	movw	r4,	:lower16:_g_a
	movt	r4,	:upper16:_g_a
	ldr	r4,	[r4]
	add	r0,	r0,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r0,	[r5]
	mov	r0,	#1
	add	r0,	r1,	r0
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r0,	[r5]
	movw	r0,	:lower16:_g_count
	movt	r0,	:upper16:_g_count
	ldr	r0,	[r0]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r0
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r0,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r3,	:lower16:_g_count
	movt	r3,	:upper16:_g_count
	ldr	r3,	[r3]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r3,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r3,	:lower16:_g_count
	movt	r3,	:upper16:_g_count
	ldr	r3,	[r3]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r3,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r0
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r3,	:lower16:_g_count
	movt	r3,	:upper16:_g_count
	ldr	r3,	[r3]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r3,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r3,	:lower16:_g_count
	movt	r3,	:upper16:_g_count
	ldr	r3,	[r3]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r3,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r0
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r3,	:lower16:_g_count
	movt	r3,	:upper16:_g_count
	ldr	r3,	[r3]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r3,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r1,	:lower16:_g_count
	movt	r1,	:upper16:_g_count
	ldr	r1,	[r1]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r1
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r1,	:lower16:_g_count
	movt	r1,	:upper16:_g_count
	ldr	r1,	[r1]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r1
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r2,	r1,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r3,	:lower16:_g_count
	movt	r3,	:upper16:_g_count
	ldr	r3,	[r3]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r3,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r3,	:lower16:_g_count
	movt	r3,	:upper16:_g_count
	ldr	r3,	[r3]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r3,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r1,	:lower16:_g_count
	movt	r1,	:upper16:_g_count
	ldr	r1,	[r1]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r1
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r2,	r1,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r3,	:lower16:_g_sum
	movt	r3,	:upper16:_g_sum
	ldr	r3,	[r3]
	add	r1,	r3,	r1
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r3,	:lower16:_g_count
	movt	r3,	:upper16:_g_count
	ldr	r3,	[r3]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r3,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r1,	:lower16:_g_count
	movt	r1,	:upper16:_g_count
	ldr	r1,	[r1]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r1
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r1,	:lower16:_g_count
	movt	r1,	:upper16:_g_count
	ldr	r1,	[r1]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r1,	:lower16:_g_count
	movt	r1,	:upper16:_g_count
	ldr	r1,	[r1]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r1
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r2,	r1,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r3,	:lower16:_g_sum
	movt	r3,	:upper16:_g_sum
	ldr	r3,	[r3]
	add	r1,	r3,	r1
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r1,	:lower16:_g_count
	movt	r1,	:upper16:_g_count
	ldr	r1,	[r1]
	movw	r3,	:lower16:_g_sum
	movt	r3,	:upper16:_g_sum
	ldr	r3,	[r3]
	add	r3,	r3,	r1
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r3,	[r5]
	movw	r3,	:lower16:_g_sum
	movt	r3,	:upper16:_g_sum
	ldr	r3,	[r3]
	add	r3,	r3,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r3,	[r5]
	movw	r3,	:lower16:_g_sum
	movt	r3,	:upper16:_g_sum
	ldr	r3,	[r3]
	add	r2,	r3,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r1,	:lower16:_g_count
	movt	r1,	:upper16:_g_count
	ldr	r1,	[r1]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r1,	:lower16:_g_count
	movt	r1,	:upper16:_g_count
	ldr	r1,	[r1]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r1
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r1,	:lower16:_g_count
	movt	r1,	:upper16:_g_count
	ldr	r1,	[r1]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r1
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r2,	r1,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r3,	:lower16:_g_count
	movt	r3,	:upper16:_g_count
	ldr	r3,	[r3]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r0
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r3,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r3,	:lower16:_g_count
	movt	r3,	:upper16:_g_count
	ldr	r3,	[r3]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r3,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r1,	:lower16:_g_count
	movt	r1,	:upper16:_g_count
	ldr	r1,	[r1]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r1
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#1
	add	r1,	r2,	r1
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r1,	[r5]
	movw	r1,	:lower16:_g_count
	movt	r1,	:upper16:_g_count
	ldr	r1,	[r1]
	movw	r1,	:lower16:_g_sum
	movt	r1,	:upper16:_g_sum
	ldr	r1,	[r1]
	add	r1,	r1,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r1,	[r5]
	mov	r1,	#0
	b	b14
.ltorg
b14:
	mov	r2,	#3
	cmp	r1,	r2
	blt	b15
	b	b16
.ltorg
b15:
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r0
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	mov	r3,	#1
	add	r2,	r2,	r3
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r3,	:lower16:_g_count
	movt	r3,	:upper16:_g_count
	ldr	r3,	[r3]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r2,	r3,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r4,	:lower16:_g_count
	movt	r4,	:upper16:_g_count
	ldr	r4,	[r4]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	movw	r3,	:lower16:_g_a
	movt	r3,	:upper16:_g_a
	ldr	r3,	[r3]
	add	r2,	r2,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r2,	r4,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r4,	:lower16:_g_sum
	movt	r4,	:upper16:_g_sum
	ldr	r4,	[r4]
	add	r4,	r4,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r4,	[r5]
	mov	r4,	#1
	add	r2,	r2,	r4
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r4,	:lower16:_g_count
	movt	r4,	:upper16:_g_count
	ldr	r4,	[r4]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r2,	r4,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r4,	:lower16:_g_count
	movt	r4,	:upper16:_g_count
	ldr	r4,	[r4]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r2,	r4,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r6,	:lower16:_g_count
	movt	r6,	:upper16:_g_count
	ldr	r6,	[r6]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	cmp	r1,	r2
	beq	b22
	b	b23
.ltorg
b22:
	mov	r2,	#1
	add	r2,	r6,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r4,	:lower16:_g_sum
	movt	r4,	:upper16:_g_sum
	ldr	r4,	[r4]
	add	r4,	r4,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r4,	[r5]
	mov	r4,	#1
	add	r2,	r2,	r4
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r4,	:lower16:_g_count
	movt	r4,	:upper16:_g_count
	ldr	r4,	[r4]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r2,	r4,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r6,	:lower16:_g_count
	movt	r6,	:upper16:_g_count
	ldr	r6,	[r6]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r6
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r2,	r6,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r4,	:lower16:_g_count
	movt	r4,	:upper16:_g_count
	ldr	r4,	[r4]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r2,	r4,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r3,	:lower16:_g_sum
	movt	r3,	:upper16:_g_sum
	ldr	r3,	[r3]
	add	r3,	r3,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r3,	[r5]
	mov	r3,	#1
	add	r2,	r2,	r3
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r3,	:lower16:_g_count
	movt	r3,	:upper16:_g_count
	ldr	r3,	[r3]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r2,	r3,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r2,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r1,	r1,	r2
	b	b14
.ltorg
b23:
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r0,	r2,	r0
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r0,	[r5]
	mov	r0,	#1
	add	r0,	r6,	r0
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r0,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r0,	:lower16:_g_sum
	movt	r0,	:upper16:_g_sum
	ldr	r0,	[r0]
	add	r0,	r0,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r0,	[r5]
	mov	r0,	#1
	add	r0,	r2,	r0
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r0,	[r5]
	movw	r4,	:lower16:_g_count
	movt	r4,	:upper16:_g_count
	ldr	r4,	[r4]
	movw	r0,	:lower16:_g_sum
	movt	r0,	:upper16:_g_sum
	ldr	r0,	[r0]
	add	r0,	r0,	r4
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r0,	[r5]
	movw	r0,	:lower16:_g_sum
	movt	r0,	:upper16:_g_sum
	ldr	r0,	[r0]
	add	r0,	r0,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r0,	[r5]
	movw	r0,	:lower16:_g_sum
	movt	r0,	:upper16:_g_sum
	ldr	r0,	[r0]
	add	r0,	r0,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r0,	[r5]
	movw	r0,	:lower16:_g_sum
	movt	r0,	:upper16:_g_sum
	ldr	r0,	[r0]
	add	r0,	r0,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r0,	[r5]
	mov	r0,	#1
	add	r0,	r4,	r0
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r0,	[r5]
	movw	r0,	:lower16:_g_count
	movt	r0,	:upper16:_g_count
	ldr	r0,	[r0]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r3
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r0,	r0,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r0,	[r5]
	movw	r0,	:lower16:_g_count
	movt	r0,	:upper16:_g_count
	ldr	r0,	[r0]
	movw	r2,	:lower16:_g_sum
	movt	r2,	:upper16:_g_sum
	ldr	r2,	[r2]
	add	r2,	r2,	r0
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r0,	r0,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r0,	[r5]
	movw	r2,	:lower16:_g_count
	movt	r2,	:upper16:_g_count
	ldr	r2,	[r2]
	movw	r0,	:lower16:_g_sum
	movt	r0,	:upper16:_g_sum
	ldr	r0,	[r0]
	add	r0,	r0,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r0,	[r5]
	mov	r0,	#1
	add	r0,	r2,	r0
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r0,	[r5]
	movw	r0,	:lower16:_g_count
	movt	r0,	:upper16:_g_count
	ldr	r0,	[r0]
	movw	r3,	:lower16:_g_sum
	movt	r3,	:upper16:_g_sum
	ldr	r3,	[r3]
	add	r2,	r3,	r2
	movw	r5,	:lower16:_g_sum
	movt	r5,	:upper16:_g_sum
	str	r2,	[r5]
	mov	r2,	#1
	add	r0,	r0,	r2
	movw	r5,	:lower16:_g_count
	movt	r5,	:upper16:_g_count
	str	r0,	[r5]
	movw	r0,	:lower16:_g_count
	movt	r0,	:upper16:_g_count
	ldr	r0,	[r0]
	mov	r2,	#1
	add	r1,	r1,	r2
	b	b14
.ltorg
b16:
	movw	r0,	:lower16:_g_sum
	movt	r0,	:upper16:_g_sum
	ldr	r0,	[r0]
	bl	putint
	mov	r0,	#0
	add	sp,	sp,	#4
	pop	{pc}
	bx	lr
.ltorg
