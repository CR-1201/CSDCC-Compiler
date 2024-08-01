.arch armv7ve

.text
.global	main
main:
	push	{lr}
	sub	sp,	sp,	#4
b0:
	mov	r0,	#0
	add	sp,	sp,	#4
	pop	{pc}
	bx	lr
.ltorg
