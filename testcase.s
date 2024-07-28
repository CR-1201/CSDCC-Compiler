.arch armv7ve

.global	_g_a

.bss
.align 4
_g_a:
	.zero	40000000
.global	_g_b

.bss
.align 4
_g_b:
	.zero	40000000
.global	_g_kernelid

.bss
.align 4
_g_kernelid:
	.zero	40000
.text
.global	main
main:
	push	{lr}
	sub	sp,	sp,	#36
b83:
	bl	getint
	mov	r6,	r0
	bl	getint
	mov	r5,	r0
	bl	getint
	mov	r4,	r0
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	mov	r0,	r1
	bl	getarray
	movw	r0,	:lower16:_g_kernelid
	movt	r0,	:upper16:_g_kernelid
	bl	getarray
	str	r0,	[sp,	#4]
	bl	_sysy_starttime
	mov	r0,	#0
	b	b84
.ltorg
b84:
	str	r0,	[sp,	#0]
	ldr	r0,	[sp,	#0]
	ldr	r1,	[sp,	#4]
	cmp	r0,	r1
	blt	b85
	b	b86
.ltorg
b85:
	movw	r0,	:lower16:_g_kernelid
	movt	r0,	:upper16:_g_kernelid
	mov	r2,	#4
	ldr	r1,	[sp,	#0]
	mla	r0,	r1,	r2,	r0
	ldr	r0,	[r0]
	str	r0,	[sp,	#12]
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	:lower16:_g_b
	movt	r0,	:upper16:_g_b
	str	r0,	[sp,	#24]
	mov	r0,	#0
	b	b152
.ltorg
b152:
	str	r0,	[sp,	#8]
	mov	r0,	#0
	b	b154
.ltorg
b154:
	str	r0,	[sp,	#16]
	mov	r0,	#2
	sdiv	r2,	r6,	r0
	ldr	r0,	[sp,	#8]
	sub	r2,	r0,	r2
	mov	r0,	#0
	b	b156
.ltorg
b156:
	str	r2,	[sp,	#20]
	str	r0,	[sp,	#28]
	mov	r0,	#2
	sdiv	r2,	r6,	r0
	ldr	r0,	[sp,	#16]
	sub	r2,	r0,	r2
	ldr	r7,	[sp,	#28]
	b	b158
.ltorg
b158:
	mov	r3,	#0
	ldr	r0,	[sp,	#20]
	cmp	r0,	r3
	blt	b164
	b	b161
.ltorg
b161:
	mov	r0,	#0
	cmp	r2,	r0
	blt	b164
	b	b162
.ltorg
b162:
	ldr	r0,	[sp,	#20]
	cmp	r0,	r5
	bge	b164
	b	b163
.ltorg
b163:
	cmp	r2,	r4
	bge	b164
	b	b220
.ltorg
b220:
	ldr	r0,	[sp,	#20]
	mul	r0,	r0,	r4
	add	r3,	r0,	r2
	mov	r0,	#4
	mla	r0,	r3,	r0,	r1
	ldr	r0,	[r0]
	b	b165
.ltorg
b164:
	mov	r0,	#0
	b	b165
.ltorg
b165:
	str	r0,	[sp,	#32]
	mov	r3,	#0
	ldr	r0,	[sp,	#12]
	cmp	r0,	r3
	beq	b211
	b	b167
.ltorg
b167:
	mov	r0,	#1
	ldr	r3,	[sp,	#12]
	cmp	r3,	r0
	beq	b168
	b	b188
.ltorg
b168:
	mov	r0,	#0
	mov	r3,	#1
	b	b169
.ltorg
b169:
	mov	r8,	#1073741824
	cmp	r3,	r8
	blt	b170
	b	b174
.ltorg
b170:
	sdiv	r8,	r7,	r3
	mov	r9,	#2
	sdiv	r10,	r8,	r9
	mul	r10,	r10,	r9
	sub	r10,	r8,	r10
	ldr	r8,	[sp,	#32]
	sdiv	r9,	r8,	r3
	mov	r11,	#2
	sdiv	r8,	r9,	r11
	mul	r8,	r8,	r11
	sub	r8,	r9,	r8
	cmp	r10,	r8
	beq	b171
	b	b173
.ltorg
b171:
	mov	r8,	#2
	mul	r0,	r0,	r8
	b	b172
.ltorg
b172:
	mov	r8,	#2
	mul	r3,	r3,	r8
	b	b169
.ltorg
b173:
	mov	r8,	#2
	mul	r8,	r0,	r8
	mov	r0,	#1
	add	r0,	r8,	r0
	b	b172
.ltorg
b174:
	b	b175
.ltorg
b188:
	mov	r0,	#2
	ldr	r3,	[sp,	#12]
	cmp	r3,	r0
	beq	b189
	b	b192
.ltorg
b189:
	ldr	r0,	[sp,	#32]
	cmp	r7,	r0
	bgt	b190
	b	b191
.ltorg
b190:
	mov	r0,	r7
	b	b175
.ltorg
b191:
	ldr	r0,	[sp,	#32]
	b	b175
.ltorg
b192:
	mov	r0,	#3
	ldr	r3,	[sp,	#12]
	cmp	r3,	r0
	beq	b203
	b	b193
.ltorg
b203:
	mov	r0,	#0
	mov	r3,	#1
	b	b204
.ltorg
b204:
	mov	r8,	#1073741824
	cmp	r3,	r8
	blt	b205
	b	b210
.ltorg
b205:
	sdiv	r10,	r7,	r3
	mov	r8,	#2
	sdiv	r9,	r10,	r8
	mul	r9,	r9,	r8
	sub	r9,	r10,	r9
	mov	r8,	#1
	cmp	r9,	r8
	beq	b206
	b	b208
.ltorg
b206:
	mov	r8,	#2
	mul	r8,	r0,	r8
	mov	r0,	#1
	add	r0,	r8,	r0
	b	b207
.ltorg
b207:
	mov	r8,	#2
	mul	r3,	r3,	r8
	b	b204
.ltorg
b208:
	ldr	r8,	[sp,	#32]
	sdiv	r8,	r8,	r3
	mov	r10,	#2
	sdiv	r9,	r8,	r10
	mul	r9,	r9,	r10
	sub	r9,	r8,	r9
	mov	r8,	#1
	cmp	r9,	r8
	beq	b206
	b	b209
.ltorg
b209:
	mov	r8,	#2
	mul	r0,	r0,	r8
	b	b207
.ltorg
b210:
	b	b175
.ltorg
b193:
	mov	r3,	#4
	ldr	r0,	[sp,	#12]
	cmp	r0,	r3
	beq	b195
	b	b194
.ltorg
b194:
	mov	r0,	#0
	b	b175
.ltorg
b195:
	mov	r0,	#0
	mov	r3,	#1
	b	b196
.ltorg
b196:
	mov	r8,	#1073741824
	cmp	r3,	r8
	blt	b197
	b	b202
.ltorg
b202:
	b	b175
.ltorg
b197:
	sdiv	r10,	r7,	r3
	mov	r9,	#2
	sdiv	r8,	r10,	r9
	mul	r8,	r8,	r9
	sub	r8,	r10,	r8
	mov	r9,	#1
	cmp	r8,	r9
	beq	b200
	b	b198
.ltorg
b198:
	mov	r8,	#2
	mul	r0,	r0,	r8
	b	b199
.ltorg
b199:
	mov	r8,	#2
	mul	r3,	r3,	r8
	b	b196
.ltorg
b200:
	ldr	r8,	[sp,	#32]
	sdiv	r8,	r8,	r3
	mov	r9,	#2
	sdiv	r10,	r8,	r9
	mul	r10,	r10,	r9
	sub	r10,	r8,	r10
	mov	r8,	#1
	cmp	r10,	r8
	beq	b201
	b	b198
.ltorg
b201:
	mov	r8,	#2
	mul	r8,	r0,	r8
	mov	r0,	#1
	add	r0,	r8,	r0
	b	b199
.ltorg
b175:
	mov	r3,	#1
	add	r2,	r2,	r3
	mov	r3,	#2
	sdiv	r7,	r6,	r3
	ldr	r3,	[sp,	#16]
	add	r3,	r3,	r7
	cmp	r2,	r3
	bge	b176
	b	b187
.ltorg
b187:
	mov	r7,	r0
	b	b158
.ltorg
b176:
	mov	r3,	#1
	ldr	r2,	[sp,	#20]
	add	r2,	r2,	r3
	mov	r3,	#2
	sdiv	r7,	r6,	r3
	ldr	r3,	[sp,	#8]
	add	r3,	r3,	r7
	cmp	r2,	r3
	bge	b178
	b	b186
.ltorg
b186:
	b	b156
.ltorg
b178:
	ldr	r2,	[sp,	#8]
	mul	r3,	r2,	r4
	ldr	r2,	[sp,	#16]
	add	r3,	r3,	r2
	mov	r7,	#4
	ldr	r2,	[sp,	#24]
	mla	r2,	r3,	r7,	r2
	str	r0,	[r2]
	mov	r2,	#1
	ldr	r0,	[sp,	#16]
	add	r0,	r0,	r2
	cmp	r0,	r4
	bge	b180
	b	b185
.ltorg
b185:
	b	b154
.ltorg
b180:
	mov	r2,	#1
	ldr	r0,	[sp,	#8]
	add	r0,	r0,	r2
	cmp	r0,	r5
	bge	b182
	b	b184
.ltorg
b182:
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	movw	r0,	:lower16:_g_b
	movt	r0,	:upper16:_g_b
	str	r0,	[sp,	#24]
	mul	r3,	r5,	r4
	mov	r0,	#0
	b	b105
.ltorg
b105:
	cmp	r0,	r3
	blt	b106
	b	b107
.ltorg
b106:
	mov	r2,	#4
	mla	r7,	r0,	r2,	r1
	mov	r8,	#4
	ldr	r2,	[sp,	#24]
	mla	r2,	r0,	r8,	r2
	ldr	r2,	[r2]
	str	r2,	[r7]
	mov	r2,	#1
	add	r0,	r0,	r2
	b	b105
.ltorg
b107:
	mov	r1,	#1
	ldr	r0,	[sp,	#0]
	add	r0,	r0,	r1
	b	b84
.ltorg
b184:
	b	b152
.ltorg
b211:
	ldr	r0,	[sp,	#32]
	add	r0,	r7,	r0
	b	b213
.ltorg
b213:
	mov	r3,	#1073741824
	cmp	r0,	r3
	bgt	b214
	b	b215
.ltorg
b214:
	mov	r3,	#1073741824
	sub	r0,	r0,	r3
	b	b213
.ltorg
b215:
	b	b216
.ltorg
b216:
	mov	r3,	#0
	cmp	r0,	r3
	blt	b219
	b	b217
.ltorg
b217:
	b	b175
.ltorg
b219:
	mov	r3,	#1073741824
	add	r0,	r0,	r3
	b	b216
.ltorg
b86:
	bl	_sysy_stoptime
	mul	r0,	r5,	r4
	movw	r1,	:lower16:_g_a
	movt	r1,	:upper16:_g_a
	bl	putarray
	mov	r0,	#0
	add	sp,	sp,	#36
	pop	{pc}
	bx	lr
.ltorg
