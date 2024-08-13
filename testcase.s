.arch armv7ve
.arm
.section .text
.global	fib
fib:
	push	{r4,r5,r6,r7,r8,r9,r10,r11,lr}
	movw	r5,	#3828
	sub	sp,	sp,	r5
b0:
	mov	r0,	r0
	str	r0,	[sp,	#528]
	mov	r1,	#2
	ldr	r0,	[sp,	#528]
	cmp	r0,	r1
	ble	b1
	b	b2
.ltorg
b1:
	mov	r0,	#1
	movw	r5,	#3828
	add	sp,	sp,	r5
	pop	{r4,r5,r6,r7,r8,r9,r10,r11,pc}
	bx	lr
.ltorg
b2:
	b	b37
.ltorg
b37:
	mov	r5,	#0
	b	b38
.ltorg
b38:
	mov	r5,	r5
	b	b39
.ltorg
b39:
	mov	r6,	#1
	b	b41
.ltorg
b41:
	mov	r6,	r6
	b	b42
.ltorg
b42:
	mov	r10,	#1
	b	b44
.ltorg
b44:
	mov	r10,	r10
	b	b45
.ltorg
b45:
	mov	r3,	#1
	b	b47
.ltorg
b47:
	mov	r3,	r3
	b	b48
.ltorg
b48:
	mov	r4,	#1
	b	b50
.ltorg
b50:
	mov	r4,	r4
	b	b51
.ltorg
b51:
	mov	r8,	#1
	b	b53
.ltorg
b53:
	mov	r8,	r8
	b	b54
.ltorg
b54:
	mov	r9,	#1
	b	b56
.ltorg
b56:
	mov	r9,	r9
	b	b57
.ltorg
b57:
	mov	r2,	#1
	b	b59
.ltorg
b59:
	mov	r2,	r2
	b	b60
.ltorg
b60:
	mov	r7,	#1
	b	b62
.ltorg
b62:
	mov	r7,	r7
	b	b63
.ltorg
b63:
	mov	r0,	#1
	b	b65
.ltorg
b65:
	mov	r0,	r0
	str	r0,	[sp,	#872]
	b	b66
.ltorg
b66:
	mov	r0,	#1
	b	b68
.ltorg
b68:
	mov	r0,	r0
	str	r0,	[sp,	#876]
	b	b69
.ltorg
b69:
	mov	r0,	#1
	b	b71
.ltorg
b71:
	mov	r0,	r0
	str	r0,	[sp,	#880]
	b	b72
.ltorg
b72:
	mov	r0,	#1
	b	b74
.ltorg
b74:
	mov	r0,	r0
	str	r0,	[sp,	#884]
	b	b75
.ltorg
b75:
	mov	r11,	#1
	b	b77
.ltorg
b77:
	mov	r11,	r11
	b	b78
.ltorg
b78:
	mov	r1,	#1
	b	b80
.ltorg
b80:
	mov	r1,	r1
	b	b81
.ltorg
b81:
	mov	r0,	#1
	b	b83
.ltorg
b83:
	mov	r0,	r0
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r1
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r11
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#884]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#880]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#876]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#872]
	add	r0,	r1,	r0
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r7
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r2
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r9
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r8
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r4
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r3
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r10
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r6
	mov	r0,	r0, lsl #1
	add	r7,	r0,	r5
	mov	r0,	r7, asr #31
	ands	r9,	r7,	#1
	orrne	r9,	r9,	r0, lsl #1
	mov	r0,	#0
	cmp	r9,	r0
	mov	r9,	r9
	blt	b84
	b	b85
.ltorg
b84:
	mov	r0,	#0
	sub	r9,	r0,	r9
	mov	r9,	r9
	b	b85
.ltorg
b85:
	mov	r9,	r9
	mov	r0,	r7, asr #31
	add	r0,	r7,	r0, lsr #31
	mov	r1,	r0, asr #1
	mov	r0,	r1, asr #31
	ands	r4,	r1,	#1
	orrne	r4,	r4,	r0, lsl #1
	mov	r0,	#0
	cmp	r4,	r0
	mov	r4,	r4
	blt	b86
	b	b87
.ltorg
b86:
	mov	r0,	#0
	sub	r4,	r0,	r4
	mov	r4,	r4
	b	b87
.ltorg
b87:
	mov	r4,	r4
	mov	r0,	r7, asr #31
	add	r0,	r7,	r0, lsr #30
	mov	r1,	r0, asr #2
	mov	r0,	r1, asr #31
	ands	r1,	r1,	#1
	orrne	r1,	r1,	r0, lsl #1
	mov	r0,	#0
	cmp	r1,	r0
	mov	r1,	r1
	blt	b88
	b	b89
.ltorg
b88:
	mov	r0,	#0
	sub	r1,	r0,	r1
	mov	r1,	r1
	b	b89
.ltorg
b89:
	mov	r1,	r1
	mov	r0,	r7, asr #31
	add	r0,	r7,	r0, lsr #29
	mov	r2,	r0, asr #3
	mov	r0,	r2, asr #31
	ands	r6,	r2,	#1
	orrne	r6,	r6,	r0, lsl #1
	mov	r0,	#0
	cmp	r6,	r0
	mov	r6,	r6
	blt	b90
	b	b91
.ltorg
b90:
	mov	r0,	#0
	sub	r6,	r0,	r6
	mov	r6,	r6
	b	b91
.ltorg
b91:
	mov	r6,	r6
	mov	r0,	r7, asr #31
	add	r0,	r7,	r0, lsr #28
	mov	r2,	r0, asr #4
	mov	r0,	r2, asr #31
	ands	r5,	r2,	#1
	orrne	r5,	r5,	r0, lsl #1
	mov	r0,	#0
	cmp	r5,	r0
	mov	r5,	r5
	blt	b92
	b	b93
.ltorg
b92:
	mov	r0,	#0
	sub	r5,	r0,	r5
	mov	r5,	r5
	b	b93
.ltorg
b93:
	mov	r5,	r5
	mov	r0,	r7, asr #31
	add	r0,	r7,	r0, lsr #27
	mov	r2,	r0, asr #5
	mov	r0,	r2, asr #31
	ands	r3,	r2,	#1
	orrne	r3,	r3,	r0, lsl #1
	mov	r0,	#0
	cmp	r3,	r0
	mov	r3,	r3
	blt	b94
	b	b95
.ltorg
b94:
	mov	r0,	#0
	sub	r3,	r0,	r3
	mov	r3,	r3
	b	b95
.ltorg
b95:
	mov	r3,	r3
	mov	r0,	r7, asr #31
	add	r0,	r7,	r0, lsr #26
	mov	r0,	r0, asr #6
	mov	r8,	r0, asr #31
	ands	r2,	r0,	#1
	orrne	r2,	r2,	r8, lsl #1
	mov	r0,	#0
	cmp	r2,	r0
	mov	r2,	r2
	blt	b96
	b	b97
.ltorg
b96:
	mov	r0,	#0
	sub	r2,	r0,	r2
	mov	r2,	r2
	b	b97
.ltorg
b97:
	mov	r2,	r2
	mov	r0,	r7, asr #31
	add	r0,	r7,	r0, lsr #25
	mov	r0,	r0, asr #7
	mov	r8,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r8, lsl #1
	mov	r8,	#0
	cmp	r0,	r8
	mov	r0,	r0
	blt	b98
	b	b99
.ltorg
b98:
	mov	r8,	#0
	sub	r0,	r8,	r0
	mov	r0,	r0
	b	b99
.ltorg
b99:
	mov	r0,	r0
	str	r0,	[sp,	#572]
	mov	r0,	r7, asr #31
	add	r0,	r7,	r0, lsr #24
	mov	r0,	r0, asr #8
	mov	r8,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r8, lsl #1
	mov	r8,	#0
	cmp	r0,	r8
	mov	r0,	r0
	blt	b100
	b	b101
.ltorg
b100:
	mov	r8,	#0
	sub	r0,	r8,	r0
	mov	r0,	r0
	b	b101
.ltorg
b101:
	mov	r0,	r0
	str	r0,	[sp,	#564]
	mov	r0,	r7, asr #31
	add	r0,	r7,	r0, lsr #23
	mov	r0,	r0, asr #9
	mov	r8,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r8, lsl #1
	mov	r8,	#0
	cmp	r0,	r8
	mov	r0,	r0
	blt	b102
	b	b103
.ltorg
b102:
	mov	r8,	#0
	sub	r0,	r8,	r0
	mov	r0,	r0
	b	b103
.ltorg
b103:
	mov	r0,	r0
	str	r0,	[sp,	#432]
	mov	r0,	r7, asr #31
	add	r0,	r7,	r0, lsr #22
	mov	r0,	r0, asr #10
	mov	r8,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r8, lsl #1
	mov	r8,	#0
	cmp	r0,	r8
	mov	r0,	r0
	blt	b104
	b	b105
.ltorg
b104:
	mov	r8,	#0
	sub	r0,	r8,	r0
	mov	r0,	r0
	b	b105
.ltorg
b105:
	mov	r0,	r0
	str	r0,	[sp,	#392]
	mov	r0,	r7, asr #31
	add	r0,	r7,	r0, lsr #21
	mov	r0,	r0, asr #11
	mov	r8,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r8, lsl #1
	mov	r8,	#0
	cmp	r0,	r8
	mov	r0,	r0
	blt	b106
	b	b107
.ltorg
b106:
	mov	r8,	#0
	sub	r0,	r8,	r0
	mov	r0,	r0
	b	b107
.ltorg
b107:
	mov	r0,	r0
	str	r0,	[sp,	#360]
	mov	r0,	r7, asr #31
	add	r0,	r7,	r0, lsr #20
	mov	r0,	r0, asr #12
	mov	r8,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r8, lsl #1
	mov	r8,	#0
	cmp	r0,	r8
	mov	r0,	r0
	blt	b108
	b	b109
.ltorg
b108:
	mov	r8,	#0
	sub	r0,	r8,	r0
	mov	r0,	r0
	b	b109
.ltorg
b109:
	mov	r0,	r0
	str	r0,	[sp,	#320]
	mov	r0,	r7, asr #31
	add	r0,	r7,	r0, lsr #19
	mov	r0,	r0, asr #13
	mov	r8,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r8, lsl #1
	mov	r8,	#0
	cmp	r0,	r8
	mov	r0,	r0
	blt	b110
	b	b111
.ltorg
b110:
	mov	r8,	#0
	sub	r0,	r8,	r0
	mov	r0,	r0
	b	b111
.ltorg
b111:
	mov	r0,	r0
	str	r0,	[sp,	#312]
	mov	r0,	r7, asr #31
	add	r0,	r7,	r0, lsr #18
	mov	r0,	r0, asr #14
	mov	r8,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r8, lsl #1
	mov	r8,	#0
	cmp	r0,	r8
	mov	r0,	r0
	blt	b112
	b	b113
.ltorg
b112:
	mov	r8,	#0
	sub	r0,	r8,	r0
	mov	r0,	r0
	b	b113
.ltorg
b113:
	mov	r0,	r0
	str	r0,	[sp,	#276]
	mov	r0,	r7, asr #31
	add	r0,	r7,	r0, lsr #17
	mov	r0,	r0, asr #15
	mov	r7,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r7, lsl #1
	mov	r7,	#0
	cmp	r0,	r7
	mov	r0,	r0
	blt	b114
	b	b115
.ltorg
b114:
	mov	r7,	#0
	sub	r0,	r7,	r0
	mov	r0,	r0
	b	b115
.ltorg
b115:
	mov	r0,	r0
	str	r0,	[sp,	#180]
	mov	r0,	#0
	cmp	r9,	r0
	bne	b148
	b	b151
.ltorg
b148:
	mov	r7,	#1
	b	b150
.ltorg
b150:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r9,	r0
	bne	b155
	b	b153
.ltorg
b153:
	mov	r0,	#0
	b	b154
.ltorg
b154:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r0,	r8
	moveq	r8,	#1
	movne	r8,	#0
	mov	r0,	#0
	cmp	r8,	r0
	bne	b156
	b	b157
.ltorg
b156:
	mov	r0,	#1
	b	b158
.ltorg
b157:
	mov	r0,	#0
	b	b158
.ltorg
b158:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r7,	r8
	bne	b162
	b	b160
.ltorg
b160:
	mov	r7,	#0
	b	b161
.ltorg
b161:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r7,	r0
	bne	b163
	b	b166
.ltorg
b163:
	mov	r8,	#1
	b	b165
.ltorg
b165:
	mov	r8,	r8
	mov	r0,	#0
	cmp	r7,	r0
	bne	b170
	b	b168
.ltorg
b168:
	b	b171
.ltorg
b171:
	mov	r0,	#1
	b	b173
.ltorg
b173:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r8,	r10
	bne	b177
	b	b175
.ltorg
b175:
	mov	r8,	#0
	b	b176
.ltorg
b176:
	mov	r8,	r8
	mov	r0,	#0
	cmp	r9,	r0
	bne	b181
	b	b179
.ltorg
b179:
	mov	r0,	#0
	b	b180
.ltorg
b180:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r7,	r9
	bne	b185
	b	b183
.ltorg
b185:
	b	b183
.ltorg
b183:
	mov	r7,	#0
	cmp	r0,	r7
	bne	b186
	b	b189
.ltorg
b189:
	b	b187
.ltorg
b187:
	mov	r0,	#0
	b	b188
.ltorg
b186:
	mov	r0,	#1
	b	b188
.ltorg
b188:
	mov	r0,	r0
	str	r0,	[sp,	#820]
	mov	r0,	#0
	cmp	r4,	r0
	bne	b190
	b	b193
.ltorg
b192:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r4,	r0
	bne	b197
	b	b195
.ltorg
b195:
	mov	r0,	#0
	b	b196
.ltorg
b196:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r0,	#1
	movne	r0,	#0
	mov	r9,	#0
	cmp	r0,	r9
	bne	b198
	b	b199
.ltorg
b198:
	mov	r0,	#1
	b	b200
.ltorg
b199:
	mov	r0,	#0
	b	b200
.ltorg
b200:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r7,	r9
	bne	b204
	b	b202
.ltorg
b202:
	mov	r7,	#0
	b	b203
.ltorg
b203:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r7,	r0
	bne	b205
	b	b208
.ltorg
b205:
	mov	r9,	#1
	b	b207
.ltorg
b207:
	mov	r9,	r9
	mov	r0,	#0
	cmp	r7,	r0
	bne	b212
	b	b210
.ltorg
b210:
	mov	r0,	#0
	b	b211
.ltorg
b211:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r0,	#1
	movne	r0,	#0
	mov	r10,	#0
	cmp	r0,	r10
	bne	b213
	b	b214
.ltorg
b213:
	mov	r0,	#1
	b	b215
.ltorg
b214:
	mov	r0,	#0
	b	b215
.ltorg
b215:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r9,	r10
	bne	b219
	b	b217
.ltorg
b217:
	mov	r0,	#0
	b	b218
.ltorg
b218:
	mov	r0,	r0
	str	r0,	[sp,	#960]
	mov	r0,	#0
	cmp	r4,	r0
	bne	b223
	b	b221
.ltorg
b221:
	mov	r4,	#0
	b	b222
.ltorg
b222:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r7,	r0
	bne	b227
	b	b225
.ltorg
b225:
	mov	r0,	#0
	b	b226
.ltorg
b226:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r4,	r7
	bne	b228
	b	b231
.ltorg
b228:
	mov	r7,	#1
	b	b230
.ltorg
b230:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r1,	r0
	bne	b232
	b	b235
.ltorg
b232:
	mov	r4,	#1
	b	b234
.ltorg
b234:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r1,	r0
	bne	b239
	b	b237
.ltorg
b237:
	mov	r0,	#0
	b	b238
.ltorg
b238:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r9,	#1
	movne	r9,	#0
	mov	r0,	#0
	cmp	r9,	r0
	bne	b240
	b	b241
.ltorg
b240:
	mov	r0,	#1
	b	b242
.ltorg
b241:
	mov	r0,	#0
	b	b242
.ltorg
b242:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r4,	r9
	bne	b246
	b	b244
.ltorg
b244:
	mov	r9,	#0
	b	b245
.ltorg
b245:
	mov	r9,	r9
	mov	r0,	#0
	cmp	r9,	r0
	bne	b247
	b	b250
.ltorg
b247:
	mov	r4,	#1
	b	b249
.ltorg
b249:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r9,	r0
	bne	b254
	b	b252
.ltorg
b252:
	mov	r0,	#0
	b	b253
.ltorg
b253:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r0,	#1
	movne	r0,	#0
	mov	r10,	#0
	cmp	r0,	r10
	bne	b255
	b	b256
.ltorg
b255:
	mov	r0,	#1
	b	b257
.ltorg
b256:
	mov	r0,	#0
	b	b257
.ltorg
b257:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r4,	r10
	bne	b261
	b	b259
.ltorg
b259:
	mov	r4,	#0
	b	b260
.ltorg
b260:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r1,	r0
	bne	b265
	b	b263
.ltorg
b263:
	mov	r1,	#0
	b	b264
.ltorg
b264:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r9,	r0
	bne	b269
	b	b267
.ltorg
b267:
	mov	r0,	#0
	b	b268
.ltorg
b268:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r1,	r7
	bne	b270
	b	b273
.ltorg
b270:
	mov	r9,	#1
	b	b272
.ltorg
b272:
	mov	r9,	r9
	mov	r0,	#0
	cmp	r6,	r0
	bne	b274
	b	b277
.ltorg
b274:
	mov	r1,	#1
	b	b276
.ltorg
b276:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r6,	r0
	bne	b281
	b	b279
.ltorg
b279:
	mov	r0,	#0
	b	b280
.ltorg
b280:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r0,	r7
	moveq	r0,	#1
	movne	r0,	#0
	mov	r7,	#0
	cmp	r0,	r7
	bne	b282
	b	b283
.ltorg
b282:
	mov	r0,	#1
	b	b284
.ltorg
b283:
	mov	r0,	#0
	b	b284
.ltorg
b284:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r1,	r7
	bne	b288
	b	b286
.ltorg
b286:
	mov	r7,	#0
	b	b287
.ltorg
b287:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r7,	r0
	bne	b289
	b	b292
.ltorg
b289:
	mov	r1,	#1
	b	b291
.ltorg
b291:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r7,	r0
	bne	b296
	b	b294
.ltorg
b294:
	mov	r0,	#0
	b	b295
.ltorg
b295:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r0,	#1
	movne	r0,	#0
	mov	r10,	#0
	cmp	r0,	r10
	bne	b297
	b	b298
.ltorg
b297:
	mov	r0,	#1
	b	b299
.ltorg
b298:
	mov	r0,	#0
	b	b299
.ltorg
b299:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r1,	r10
	bne	b303
	b	b301
.ltorg
b301:
	mov	r1,	#0
	b	b302
.ltorg
b302:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r6,	r0
	bne	b307
	b	b305
.ltorg
b305:
	mov	r6,	#0
	b	b306
.ltorg
b306:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r7,	r0
	bne	b311
	b	b309
.ltorg
b309:
	mov	r0,	#0
	b	b310
.ltorg
b310:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r6,	r7
	bne	b312
	b	b315
.ltorg
b312:
	mov	r7,	#1
	b	b314
.ltorg
b314:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r5,	r0
	bne	b316
	b	b319
.ltorg
b318:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r5,	r0
	bne	b323
	b	b321
.ltorg
b321:
	mov	r0,	#0
	b	b322
.ltorg
b322:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r0,	#1
	movne	r0,	#0
	mov	r9,	#0
	cmp	r0,	r9
	bne	b324
	b	b325
.ltorg
b324:
	mov	r0,	#1
	b	b326
.ltorg
b325:
	mov	r0,	#0
	b	b326
.ltorg
b326:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r6,	r9
	bne	b330
	b	b328
.ltorg
b329:
	mov	r9,	r9
	mov	r0,	#0
	cmp	r9,	r0
	bne	b331
	b	b334
.ltorg
b333:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r9,	r0
	bne	b338
	b	b336
.ltorg
b336:
	mov	r0,	#0
	b	b337
.ltorg
b337:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r0,	#1
	movne	r0,	#0
	mov	r10,	#0
	cmp	r0,	r10
	bne	b339
	b	b340
.ltorg
b339:
	mov	r0,	#1
	b	b341
.ltorg
b340:
	mov	r0,	#0
	b	b341
.ltorg
b341:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r6,	r10
	bne	b345
	b	b343
.ltorg
b343:
	mov	r6,	#0
	b	b344
.ltorg
b344:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r5,	r0
	bne	b349
	b	b347
.ltorg
b347:
	mov	r5,	#0
	b	b348
.ltorg
b348:
	mov	r5,	r5
	mov	r0,	#0
	cmp	r9,	r0
	bne	b353
	b	b351
.ltorg
b351:
	mov	r0,	#0
	b	b352
.ltorg
b352:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r5,	r7
	bne	b354
	b	b357
.ltorg
b354:
	mov	r9,	#1
	b	b356
.ltorg
b356:
	mov	r9,	r9
	mov	r0,	#0
	cmp	r3,	r0
	bne	b358
	b	b361
.ltorg
b358:
	mov	r5,	#1
	b	b360
.ltorg
b360:
	mov	r5,	r5
	mov	r0,	#0
	cmp	r3,	r0
	bne	b365
	b	b363
.ltorg
b363:
	mov	r0,	#0
	b	b364
.ltorg
b364:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r0,	r7
	moveq	r0,	#1
	movne	r0,	#0
	mov	r7,	#0
	cmp	r0,	r7
	bne	b366
	b	b367
.ltorg
b366:
	mov	r0,	#1
	b	b368
.ltorg
b367:
	mov	r0,	#0
	b	b368
.ltorg
b368:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r5,	r7
	bne	b372
	b	b370
.ltorg
b370:
	mov	r7,	#0
	b	b371
.ltorg
b371:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r7,	r0
	bne	b373
	b	b376
.ltorg
b373:
	mov	r5,	#1
	b	b375
.ltorg
b375:
	mov	r5,	r5
	mov	r0,	#0
	cmp	r7,	r0
	bne	b380
	b	b378
.ltorg
b378:
	mov	r0,	#0
	b	b379
.ltorg
b379:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r0,	#1
	movne	r0,	#0
	mov	r10,	#0
	cmp	r0,	r10
	bne	b381
	b	b382
.ltorg
b381:
	mov	r0,	#1
	b	b383
.ltorg
b382:
	mov	r0,	#0
	b	b383
.ltorg
b383:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r5,	r10
	bne	b387
	b	b385
.ltorg
b385:
	mov	r5,	#0
	b	b386
.ltorg
b386:
	mov	r5,	r5
	mov	r0,	#0
	cmp	r3,	r0
	bne	b391
	b	b389
.ltorg
b389:
	mov	r3,	#0
	b	b390
.ltorg
b390:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r7,	r0
	bne	b395
	b	b393
.ltorg
b393:
	mov	r0,	#0
	b	b394
.ltorg
b394:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r3,	r7
	bne	b396
	b	b399
.ltorg
b396:
	mov	r7,	#1
	b	b398
.ltorg
b398:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r2,	r0
	bne	b400
	b	b403
.ltorg
b400:
	mov	r3,	#1
	b	b402
.ltorg
b402:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r2,	r0
	bne	b407
	b	b405
.ltorg
b405:
	mov	r0,	#0
	b	b406
.ltorg
b406:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r0,	#1
	movne	r0,	#0
	mov	r9,	#0
	cmp	r0,	r9
	bne	b408
	b	b409
.ltorg
b408:
	mov	r0,	#1
	b	b410
.ltorg
b409:
	mov	r0,	#0
	b	b410
.ltorg
b410:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r3,	r9
	bne	b414
	b	b412
.ltorg
b412:
	mov	r9,	#0
	b	b413
.ltorg
b413:
	mov	r9,	r9
	mov	r0,	#0
	cmp	r9,	r0
	bne	b415
	b	b418
.ltorg
b415:
	mov	r3,	#1
	b	b417
.ltorg
b417:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r9,	r0
	bne	b422
	b	b420
.ltorg
b420:
	mov	r0,	#0
	b	b421
.ltorg
b421:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r0,	#1
	movne	r0,	#0
	mov	r10,	#0
	cmp	r0,	r10
	bne	b423
	b	b424
.ltorg
b423:
	mov	r0,	#1
	b	b425
.ltorg
b424:
	mov	r0,	#0
	b	b425
.ltorg
b425:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r3,	r10
	bne	b429
	b	b427
.ltorg
b427:
	mov	r3,	#0
	b	b428
.ltorg
b428:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r2,	r0
	bne	b433
	b	b431
.ltorg
b431:
	mov	r2,	#0
	b	b432
.ltorg
b432:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r9,	r0
	bne	b437
	b	b435
.ltorg
b435:
	mov	r0,	#0
	b	b436
.ltorg
b436:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r2,	r7
	bne	b438
	b	b441
.ltorg
b438:
	mov	r0,	#1
	b	b440
.ltorg
b440:
	mov	r0,	r0
	mov	r2,	#0
	ldr	r7,	[sp,	#572]
	cmp	r7,	r2
	bne	b442
	b	b445
.ltorg
b445:
	b	b443
.ltorg
b443:
	mov	r7,	#0
	b	b444
.ltorg
b442:
	mov	r7,	#1
	b	b444
.ltorg
b444:
	mov	r7,	r7
	mov	r2,	#0
	ldr	r9,	[sp,	#572]
	cmp	r9,	r2
	bne	b449
	b	b447
.ltorg
b449:
	b	b447
.ltorg
b447:
	mov	r2,	#0
	b	b448
.ltorg
b448:
	mov	r2,	r2
	mov	r9,	#0
	cmp	r2,	r9
	moveq	r2,	#1
	movne	r2,	#0
	mov	r9,	#0
	cmp	r2,	r9
	bne	b450
	b	b451
.ltorg
b451:
	mov	r2,	#0
	b	b452
.ltorg
b452:
	mov	r2,	r2
	mov	r9,	#0
	cmp	r7,	r9
	bne	b456
	b	b454
.ltorg
b456:
	mov	r7,	#0
	cmp	r2,	r7
	bne	b453
	b	b454
.ltorg
b453:
	mov	r9,	#1
	b	b455
.ltorg
b454:
	mov	r9,	#0
	b	b455
.ltorg
b455:
	mov	r9,	r9
	mov	r2,	#0
	cmp	r9,	r2
	bne	b457
	b	b460
.ltorg
b459:
	mov	r7,	r7
	mov	r2,	#0
	cmp	r9,	r2
	bne	b464
	b	b462
.ltorg
b462:
	mov	r2,	#0
	b	b463
.ltorg
b463:
	mov	r2,	r2
	mov	r10,	#0
	cmp	r2,	r10
	moveq	r2,	#1
	movne	r2,	#0
	mov	r10,	#0
	cmp	r2,	r10
	bne	b465
	b	b466
.ltorg
b465:
	mov	r2,	#1
	b	b467
.ltorg
b466:
	mov	r2,	#0
	b	b467
.ltorg
b467:
	mov	r2,	r2
	mov	r10,	#0
	cmp	r7,	r10
	bne	b471
	b	b469
.ltorg
b470:
	mov	r2,	r2
	mov	r7,	#0
	ldr	r10,	[sp,	#572]
	cmp	r10,	r7
	bne	b475
	b	b473
.ltorg
b473:
	mov	r7,	#0
	b	b474
.ltorg
b474:
	mov	r7,	r7
	mov	r10,	#0
	cmp	r9,	r10
	bne	b479
	b	b477
.ltorg
b477:
	mov	r0,	#0
	b	b478
.ltorg
b478:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r7,	r9
	bne	b480
	b	b483
.ltorg
b480:
	mov	r0,	#1
	b	b482
.ltorg
b482:
	mov	r0,	r0
	mov	r7,	#0
	ldr	r9,	[sp,	#564]
	cmp	r9,	r7
	bne	b484
	b	b487
.ltorg
b484:
	mov	r9,	#1
	b	b486
.ltorg
b486:
	mov	r9,	r9
	mov	r7,	#0
	ldr	r10,	[sp,	#564]
	cmp	r10,	r7
	bne	b491
	b	b489
.ltorg
b489:
	mov	r7,	#0
	b	b490
.ltorg
b490:
	mov	r7,	r7
	mov	r10,	#0
	cmp	r7,	r10
	moveq	r7,	#1
	movne	r7,	#0
	mov	r10,	#0
	cmp	r7,	r10
	bne	b492
	b	b493
.ltorg
b492:
	mov	r7,	#1
	b	b494
.ltorg
b493:
	mov	r7,	#0
	b	b494
.ltorg
b494:
	mov	r7,	r7
	mov	r10,	#0
	cmp	r9,	r10
	bne	b498
	b	b496
.ltorg
b496:
	mov	r7,	#0
	b	b497
.ltorg
b497:
	mov	r7,	r7
	str	r7,	[sp,	#556]
	mov	r7,	#0
	ldr	r9,	[sp,	#556]
	cmp	r9,	r7
	bne	b499
	b	b502
.ltorg
b499:
	mov	r9,	#1
	b	b501
.ltorg
b501:
	mov	r9,	r9
	mov	r7,	#0
	ldr	r10,	[sp,	#556]
	cmp	r10,	r7
	bne	b506
	b	b504
.ltorg
b504:
	mov	r7,	#0
	b	b505
.ltorg
b505:
	mov	r7,	r7
	mov	r10,	#0
	cmp	r7,	r10
	moveq	r7,	#1
	movne	r7,	#0
	mov	r10,	#0
	cmp	r7,	r10
	bne	b507
	b	b508
.ltorg
b507:
	mov	r7,	#1
	b	b509
.ltorg
b508:
	mov	r7,	#0
	b	b509
.ltorg
b509:
	mov	r7,	r7
	mov	r10,	#0
	cmp	r9,	r10
	bne	b513
	b	b511
.ltorg
b511:
	mov	r7,	#0
	b	b512
.ltorg
b512:
	mov	r7,	r7
	mov	r9,	#0
	ldr	r10,	[sp,	#564]
	cmp	r10,	r9
	bne	b517
	b	b515
.ltorg
b515:
	mov	r9,	#0
	b	b516
.ltorg
b516:
	mov	r9,	r9
	mov	r10,	#0
	ldr	r11,	[sp,	#556]
	cmp	r11,	r10
	bne	b521
	b	b519
.ltorg
b519:
	mov	r0,	#0
	b	b520
.ltorg
b520:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r9,	r10
	bne	b522
	b	b525
.ltorg
b522:
	mov	r10,	#1
	b	b524
.ltorg
b524:
	mov	r10,	r10
	mov	r0,	#0
	ldr	r9,	[sp,	#432]
	cmp	r9,	r0
	bne	b526
	b	b529
.ltorg
b526:
	mov	r9,	#1
	b	b528
.ltorg
b528:
	mov	r9,	r9
	mov	r0,	#0
	ldr	r11,	[sp,	#432]
	cmp	r11,	r0
	bne	b533
	b	b531
.ltorg
b531:
	mov	r0,	#0
	b	b532
.ltorg
b532:
	mov	r0,	r0
	str	r0,	[sp,	#436]
	mov	r0,	#0
	ldr	r11,	[sp,	#436]
	cmp	r11,	r0
	moveq	r0,	#1
	movne	r0,	#0
	mov	r11,	#0
	str	r11,	[sp,	#440]
	ldr	r11,	[sp,	#440]
	cmp	r0,	r11
	bne	b534
	b	b535
.ltorg
b534:
	mov	r0,	#1
	b	b536
.ltorg
b535:
	mov	r0,	#0
	b	b536
.ltorg
b536:
	mov	r0,	r0
	mov	r11,	#0
	str	r11,	[sp,	#404]
	ldr	r11,	[sp,	#404]
	cmp	r9,	r11
	bne	b540
	b	b538
.ltorg
b538:
	mov	r0,	#0
	b	b539
.ltorg
b539:
	mov	r0,	r0
	str	r0,	[sp,	#408]
	mov	r0,	#0
	ldr	r9,	[sp,	#408]
	cmp	r9,	r0
	bne	b541
	b	b544
.ltorg
b541:
	mov	r0,	#1
	b	b543
.ltorg
b543:
	mov	r0,	r0
	str	r0,	[sp,	#420]
	mov	r0,	#0
	ldr	r9,	[sp,	#408]
	cmp	r9,	r0
	bne	b548
	b	b546
.ltorg
b546:
	mov	r0,	#0
	b	b547
.ltorg
b547:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r0,	#1
	movne	r0,	#0
	mov	r9,	#0
	cmp	r0,	r9
	bne	b549
	b	b550
.ltorg
b549:
	mov	r0,	#1
	b	b551
.ltorg
b550:
	mov	r0,	#0
	b	b551
.ltorg
b551:
	mov	r0,	r0
	mov	r9,	#0
	ldr	r11,	[sp,	#420]
	cmp	r11,	r9
	bne	b555
	b	b553
.ltorg
b553:
	mov	r0,	#0
	b	b554
.ltorg
b554:
	mov	r0,	r0
	str	r0,	[sp,	#88]
	mov	r0,	#0
	ldr	r9,	[sp,	#432]
	cmp	r9,	r0
	bne	b559
	b	b557
.ltorg
b557:
	mov	r9,	#0
	b	b558
.ltorg
b558:
	mov	r9,	r9
	mov	r0,	#0
	ldr	r11,	[sp,	#408]
	cmp	r11,	r0
	bne	b563
	b	b561
.ltorg
b561:
	mov	r0,	#0
	b	b562
.ltorg
b562:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r9,	r10
	bne	b564
	b	b567
.ltorg
b564:
	mov	r0,	#1
	b	b566
.ltorg
b566:
	mov	r0,	r0
	str	r0,	[sp,	#400]
	mov	r0,	#0
	ldr	r9,	[sp,	#392]
	cmp	r9,	r0
	bne	b568
	b	b571
.ltorg
b568:
	mov	r9,	#1
	b	b570
.ltorg
b570:
	mov	r9,	r9
	mov	r0,	#0
	ldr	r10,	[sp,	#392]
	cmp	r10,	r0
	bne	b575
	b	b573
.ltorg
b575:
	b	b573
.ltorg
b573:
	mov	r0,	#0
	b	b574
.ltorg
b574:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r0,	#1
	movne	r0,	#0
	mov	r10,	#0
	cmp	r0,	r10
	bne	b576
	b	b577
.ltorg
b578:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r9,	r10
	bne	b582
	b	b580
.ltorg
b580:
	mov	r0,	#0
	b	b581
.ltorg
b581:
	mov	r0,	r0
	str	r0,	[sp,	#396]
	mov	r0,	#0
	ldr	r9,	[sp,	#396]
	cmp	r9,	r0
	bne	b583
	b	b586
.ltorg
b586:
	mov	r0,	#0
	ldr	r9,	[sp,	#400]
	cmp	r9,	r0
	bne	b583
	b	b584
.ltorg
b584:
	mov	r9,	#0
	b	b585
.ltorg
b583:
	mov	r9,	#1
	b	b585
.ltorg
b585:
	mov	r9,	r9
	mov	r0,	#0
	ldr	r10,	[sp,	#396]
	cmp	r10,	r0
	bne	b590
	b	b588
.ltorg
b589:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r0,	#1
	movne	r0,	#0
	mov	r10,	#0
	cmp	r0,	r10
	bne	b591
	b	b592
.ltorg
b592:
	mov	r0,	#0
	b	b593
.ltorg
b593:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r9,	r10
	bne	b597
	b	b595
.ltorg
b597:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b594
	b	b595
.ltorg
b594:
	mov	r0,	#1
	b	b596
.ltorg
b595:
	mov	r0,	#0
	b	b596
.ltorg
b596:
	mov	r0,	r0
	str	r0,	[sp,	#84]
	mov	r0,	#0
	ldr	r9,	[sp,	#392]
	cmp	r9,	r0
	bne	b601
	b	b599
.ltorg
b601:
	b	b599
.ltorg
b599:
	mov	r9,	#0
	b	b600
.ltorg
b600:
	mov	r9,	r9
	mov	r0,	#0
	ldr	r10,	[sp,	#396]
	cmp	r10,	r0
	bne	b605
	b	b603
.ltorg
b603:
	mov	r0,	#0
	b	b604
.ltorg
b604:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r9,	r10
	bne	b606
	b	b609
.ltorg
b608:
	mov	r9,	r9
	mov	r0,	#0
	ldr	r10,	[sp,	#360]
	cmp	r10,	r0
	bne	b610
	b	b613
.ltorg
b610:
	mov	r0,	#1
	b	b612
.ltorg
b612:
	mov	r0,	r0
	str	r0,	[sp,	#376]
	mov	r0,	#0
	ldr	r10,	[sp,	#360]
	cmp	r10,	r0
	bne	b617
	b	b615
.ltorg
b615:
	mov	r0,	#0
	b	b616
.ltorg
b616:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r0,	#1
	movne	r0,	#0
	mov	r10,	#0
	cmp	r0,	r10
	bne	b618
	b	b619
.ltorg
b618:
	mov	r0,	#1
	b	b620
.ltorg
b619:
	mov	r0,	#0
	b	b620
.ltorg
b620:
	mov	r0,	r0
	mov	r10,	#0
	ldr	r11,	[sp,	#376]
	cmp	r11,	r10
	bne	b624
	b	b622
.ltorg
b622:
	mov	r0,	#0
	b	b623
.ltorg
b623:
	mov	r0,	r0
	str	r0,	[sp,	#372]
	mov	r0,	#0
	ldr	r10,	[sp,	#372]
	cmp	r10,	r0
	bne	b625
	b	b628
.ltorg
b625:
	mov	r0,	#1
	b	b627
.ltorg
b627:
	mov	r0,	r0
	str	r0,	[sp,	#332]
	mov	r0,	#0
	ldr	r10,	[sp,	#372]
	cmp	r10,	r0
	bne	b632
	b	b630
.ltorg
b630:
	mov	r0,	#0
	b	b631
.ltorg
b631:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r0,	#1
	movne	r0,	#0
	mov	r10,	#0
	cmp	r0,	r10
	bne	b633
	b	b634
.ltorg
b633:
	mov	r0,	#1
	b	b635
.ltorg
b634:
	mov	r0,	#0
	b	b635
.ltorg
b635:
	mov	r0,	r0
	mov	r10,	#0
	ldr	r11,	[sp,	#332]
	cmp	r11,	r10
	bne	b639
	b	b637
.ltorg
b637:
	mov	r0,	#0
	b	b638
.ltorg
b638:
	mov	r0,	r0
	str	r0,	[sp,	#80]
	mov	r0,	#0
	ldr	r10,	[sp,	#360]
	cmp	r10,	r0
	bne	b643
	b	b641
.ltorg
b641:
	mov	r0,	#0
	b	b642
.ltorg
b642:
	mov	r0,	r0
	str	r0,	[sp,	#336]
	mov	r0,	#0
	ldr	r10,	[sp,	#372]
	cmp	r10,	r0
	bne	b647
	b	b645
.ltorg
b645:
	mov	r0,	#0
	b	b646
.ltorg
b646:
	mov	r0,	r0
	mov	r9,	#0
	ldr	r10,	[sp,	#336]
	cmp	r10,	r9
	bne	b648
	b	b651
.ltorg
b648:
	mov	r10,	#1
	b	b650
.ltorg
b650:
	mov	r10,	r10
	mov	r0,	#0
	ldr	r9,	[sp,	#320]
	cmp	r9,	r0
	bne	b652
	b	b655
.ltorg
b652:
	mov	r0,	#1
	b	b654
.ltorg
b654:
	mov	r0,	r0
	str	r0,	[sp,	#324]
	mov	r0,	#0
	ldr	r9,	[sp,	#320]
	cmp	r9,	r0
	bne	b659
	b	b657
.ltorg
b657:
	mov	r0,	#0
	b	b658
.ltorg
b658:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r0,	#1
	movne	r0,	#0
	mov	r9,	#0
	cmp	r0,	r9
	bne	b660
	b	b661
.ltorg
b660:
	mov	r0,	#1
	b	b662
.ltorg
b661:
	mov	r0,	#0
	b	b662
.ltorg
b662:
	mov	r0,	r0
	mov	r9,	#0
	ldr	r11,	[sp,	#324]
	cmp	r11,	r9
	bne	b666
	b	b664
.ltorg
b664:
	mov	r0,	#0
	b	b665
.ltorg
b665:
	mov	r0,	r0
	str	r0,	[sp,	#328]
	mov	r0,	#0
	ldr	r9,	[sp,	#328]
	cmp	r9,	r0
	bne	b667
	b	b670
.ltorg
b667:
	mov	r0,	#1
	b	b669
.ltorg
b669:
	mov	r0,	r0
	str	r0,	[sp,	#304]
	mov	r0,	#0
	ldr	r9,	[sp,	#328]
	cmp	r9,	r0
	bne	b674
	b	b672
.ltorg
b672:
	mov	r0,	#0
	b	b673
.ltorg
b673:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r0,	#1
	movne	r0,	#0
	mov	r9,	#0
	cmp	r0,	r9
	bne	b675
	b	b676
.ltorg
b675:
	mov	r0,	#1
	b	b677
.ltorg
b676:
	mov	r0,	#0
	b	b677
.ltorg
b677:
	mov	r0,	r0
	mov	r9,	#0
	ldr	r11,	[sp,	#304]
	cmp	r11,	r9
	bne	b681
	b	b679
.ltorg
b679:
	mov	r0,	#0
	b	b680
.ltorg
b680:
	mov	r0,	r0
	str	r0,	[sp,	#76]
	mov	r0,	#0
	ldr	r9,	[sp,	#320]
	cmp	r9,	r0
	bne	b685
	b	b683
.ltorg
b683:
	mov	r9,	#0
	b	b684
.ltorg
b684:
	mov	r9,	r9
	mov	r0,	#0
	ldr	r11,	[sp,	#328]
	cmp	r11,	r0
	bne	b689
	b	b687
.ltorg
b687:
	mov	r0,	#0
	b	b688
.ltorg
b688:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r9,	r10
	bne	b690
	b	b693
.ltorg
b690:
	mov	r0,	#1
	b	b692
.ltorg
b692:
	mov	r0,	r0
	str	r0,	[sp,	#292]
	mov	r0,	#0
	ldr	r9,	[sp,	#312]
	cmp	r9,	r0
	bne	b694
	b	b697
.ltorg
b694:
	mov	r9,	#1
	b	b696
.ltorg
b696:
	mov	r9,	r9
	mov	r0,	#0
	ldr	r10,	[sp,	#312]
	cmp	r10,	r0
	bne	b701
	b	b699
.ltorg
b699:
	mov	r0,	#0
	b	b700
.ltorg
b700:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r0,	#1
	movne	r0,	#0
	mov	r10,	#0
	cmp	r0,	r10
	bne	b702
	b	b703
.ltorg
b702:
	mov	r0,	#1
	b	b704
.ltorg
b703:
	mov	r0,	#0
	b	b704
.ltorg
b704:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r9,	r10
	bne	b708
	b	b706
.ltorg
b706:
	mov	r10,	#0
	b	b707
.ltorg
b707:
	mov	r10,	r10
	mov	r0,	#0
	cmp	r10,	r0
	bne	b709
	b	b712
.ltorg
b709:
	mov	r0,	#1
	b	b711
.ltorg
b711:
	mov	r0,	r0
	str	r0,	[sp,	#296]
	mov	r0,	#0
	cmp	r10,	r0
	bne	b716
	b	b714
.ltorg
b716:
	mov	r0,	#0
	ldr	r9,	[sp,	#292]
	cmp	r9,	r0
	bne	b713
	b	b714
.ltorg
b713:
	mov	r0,	#1
	b	b715
.ltorg
b714:
	mov	r0,	#0
	b	b715
.ltorg
b715:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r0,	#1
	movne	r0,	#0
	mov	r9,	#0
	cmp	r0,	r9
	bne	b717
	b	b718
.ltorg
b719:
	mov	r0,	r0
	mov	r9,	#0
	ldr	r11,	[sp,	#296]
	cmp	r11,	r9
	bne	b723
	b	b721
.ltorg
b721:
	mov	r0,	#0
	b	b722
.ltorg
b722:
	mov	r0,	r0
	str	r0,	[sp,	#72]
	mov	r0,	#0
	ldr	r9,	[sp,	#312]
	cmp	r9,	r0
	bne	b727
	b	b725
.ltorg
b727:
	b	b725
.ltorg
b725:
	mov	r9,	#0
	b	b726
.ltorg
b726:
	mov	r9,	r9
	mov	r0,	#0
	cmp	r10,	r0
	bne	b731
	b	b729
.ltorg
b730:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r9,	r10
	bne	b732
	b	b735
.ltorg
b734:
	mov	r9,	r9
	mov	r0,	#0
	ldr	r10,	[sp,	#276]
	cmp	r10,	r0
	bne	b736
	b	b739
.ltorg
b736:
	mov	r0,	#1
	b	b738
.ltorg
b738:
	mov	r0,	r0
	str	r0,	[sp,	#288]
	mov	r0,	#0
	ldr	r10,	[sp,	#276]
	cmp	r10,	r0
	bne	b743
	b	b741
.ltorg
b741:
	mov	r0,	#0
	b	b742
.ltorg
b742:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r0,	#1
	movne	r0,	#0
	mov	r10,	#0
	cmp	r0,	r10
	bne	b744
	b	b745
.ltorg
b744:
	mov	r0,	#1
	b	b746
.ltorg
b745:
	mov	r0,	#0
	b	b746
.ltorg
b746:
	mov	r0,	r0
	mov	r10,	#0
	ldr	r11,	[sp,	#288]
	cmp	r11,	r10
	bne	b750
	b	b748
.ltorg
b748:
	mov	r0,	#0
	b	b749
.ltorg
b749:
	mov	r0,	r0
	str	r0,	[sp,	#200]
	mov	r10,	#0
	ldr	r0,	[sp,	#200]
	cmp	r0,	r10
	bne	b751
	b	b754
.ltorg
b751:
	mov	r10,	#1
	b	b753
.ltorg
b753:
	mov	r10,	r10
	mov	r11,	#0
	ldr	r0,	[sp,	#200]
	cmp	r0,	r11
	bne	b758
	b	b756
.ltorg
b756:
	mov	r0,	#0
	b	b757
.ltorg
b757:
	mov	r0,	r0
	str	r0,	[sp,	#204]
	mov	r11,	#0
	ldr	r0,	[sp,	#204]
	cmp	r0,	r11
	moveq	r0,	#1
	movne	r0,	#0
	mov	r11,	#0
	str	r11,	[sp,	#212]
	ldr	r11,	[sp,	#212]
	cmp	r0,	r11
	bne	b759
	b	b760
.ltorg
b759:
	mov	r0,	#1
	b	b761
.ltorg
b760:
	mov	r0,	#0
	b	b761
.ltorg
b761:
	mov	r0,	r0
	mov	r11,	#0
	str	r11,	[sp,	#176]
	ldr	r11,	[sp,	#176]
	cmp	r10,	r11
	bne	b765
	b	b763
.ltorg
b763:
	mov	r0,	#0
	b	b764
.ltorg
b764:
	mov	r0,	r0
	str	r0,	[sp,	#964]
	mov	r0,	#0
	ldr	r10,	[sp,	#276]
	cmp	r10,	r0
	bne	b769
	b	b767
.ltorg
b767:
	mov	r0,	#0
	b	b768
.ltorg
b768:
	mov	r0,	r0
	str	r0,	[sp,	#172]
	mov	r10,	#0
	ldr	r0,	[sp,	#200]
	cmp	r0,	r10
	bne	b773
	b	b771
.ltorg
b771:
	mov	r0,	#0
	b	b772
.ltorg
b772:
	mov	r0,	r0
	mov	r10,	#0
	ldr	r9,	[sp,	#172]
	cmp	r9,	r10
	bne	b774
	b	b777
.ltorg
b774:
	mov	r10,	#1
	b	b776
.ltorg
b776:
	mov	r10,	r10
	mov	r9,	#0
	ldr	r0,	[sp,	#180]
	cmp	r0,	r9
	bne	b778
	b	b781
.ltorg
b778:
	mov	r0,	#1
	b	b780
.ltorg
b780:
	mov	r0,	r0
	str	r0,	[sp,	#96]
	mov	r9,	#0
	ldr	r0,	[sp,	#180]
	cmp	r0,	r9
	bne	b785
	b	b783
.ltorg
b783:
	mov	r0,	#0
	b	b784
.ltorg
b784:
	mov	r0,	r0
	mov	r9,	#0
	str	r9,	[sp,	#184]
	ldr	r9,	[sp,	#184]
	cmp	r0,	r9
	moveq	r9,	#1
	movne	r9,	#0
	mov	r0,	#0
	str	r0,	[sp,	#188]
	ldr	r0,	[sp,	#188]
	cmp	r9,	r0
	bne	b786
	b	b787
.ltorg
b786:
	mov	r0,	#1
	b	b788
.ltorg
b787:
	mov	r0,	#0
	b	b788
.ltorg
b788:
	mov	r0,	r0
	mov	r9,	#0
	str	r9,	[sp,	#92]
	ldr	r11,	[sp,	#92]
	ldr	r9,	[sp,	#96]
	cmp	r9,	r11
	bne	b792
	b	b790
.ltorg
b790:
	mov	r0,	#0
	b	b791
.ltorg
b791:
	mov	r0,	r0
	str	r0,	[sp,	#100]
	mov	r9,	#0
	ldr	r0,	[sp,	#100]
	cmp	r0,	r9
	bne	b793
	b	b796
.ltorg
b793:
	mov	r0,	#1
	b	b795
.ltorg
b795:
	mov	r0,	r0
	str	r0,	[sp,	#140]
	mov	r9,	#0
	ldr	r0,	[sp,	#100]
	cmp	r0,	r9
	bne	b800
	b	b798
.ltorg
b798:
	mov	r0,	#0
	b	b799
.ltorg
b799:
	mov	r0,	r0
	mov	r9,	#0
	str	r9,	[sp,	#124]
	ldr	r9,	[sp,	#124]
	cmp	r0,	r9
	moveq	r9,	#1
	movne	r9,	#0
	mov	r0,	#0
	str	r0,	[sp,	#136]
	ldr	r0,	[sp,	#136]
	cmp	r9,	r0
	bne	b801
	b	b802
.ltorg
b801:
	mov	r0,	#1
	b	b803
.ltorg
b802:
	mov	r0,	#0
	b	b803
.ltorg
b803:
	mov	r0,	r0
	mov	r9,	#0
	str	r9,	[sp,	#144]
	ldr	r11,	[sp,	#140]
	ldr	r9,	[sp,	#144]
	cmp	r11,	r9
	bne	b807
	b	b805
.ltorg
b805:
	mov	r9,	#0
	b	b806
.ltorg
b806:
	mov	r9,	r9
	mov	r0,	#0
	str	r0,	[sp,	#152]
	ldr	r11,	[sp,	#152]
	ldr	r0,	[sp,	#180]
	cmp	r0,	r11
	bne	b811
	b	b809
.ltorg
b809:
	mov	r0,	#0
	b	b810
.ltorg
b810:
	mov	r0,	r0
	str	r0,	[sp,	#164]
	mov	r0,	#0
	str	r0,	[sp,	#160]
	ldr	r0,	[sp,	#100]
	ldr	r11,	[sp,	#160]
	cmp	r0,	r11
	bne	b815
	b	b813
.ltorg
b813:
	mov	r0,	#0
	b	b814
.ltorg
b814:
	mov	r0,	r0
	mov	r10,	#0
	str	r10,	[sp,	#52]
	ldr	r10,	[sp,	#52]
	ldr	r11,	[sp,	#164]
	cmp	r11,	r10
	bne	b816
	b	b819
.ltorg
b816:
	b	b818
.ltorg
b818:
	mov	r0,	r9, lsl #1
	ldr	r9,	[sp,	#964]
	add	r0,	r0,	r9
	mov	r9,	r0, lsl #1
	ldr	r0,	[sp,	#72]
	add	r0,	r9,	r0
	mov	r9,	r0, lsl #1
	ldr	r0,	[sp,	#76]
	add	r0,	r9,	r0
	mov	r9,	r0, lsl #1
	ldr	r0,	[sp,	#80]
	add	r0,	r9,	r0
	mov	r9,	r0, lsl #1
	ldr	r0,	[sp,	#84]
	add	r0,	r9,	r0
	mov	r9,	r0, lsl #1
	ldr	r0,	[sp,	#88]
	add	r0,	r9,	r0
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r7
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r2
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r3
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r5
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r6
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r1
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r4
	mov	r0,	r0, lsl #1
	ldr	r1,	[sp,	#960]
	add	r0,	r0,	r1
	mov	r0,	r0, lsl #1
	add	r3,	r0,	r8
	ldr	r0,	[sp,	#528]
	mov	r1,	r0, asr #31
	ldr	r0,	[sp,	#528]
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b820
	b	b821
.ltorg
b820:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b821
.ltorg
b821:
	mov	r0,	r0
	str	r0,	[sp,	#452]
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r1,	[sp,	#528]
	add	r0,	r1,	r0, lsr #31
	mov	r1,	r0, asr #1
	mov	r0,	r1, asr #31
	ands	r8,	r1,	#1
	orrne	r8,	r8,	r0, lsl #1
	mov	r0,	#0
	cmp	r8,	r0
	mov	r8,	r8
	blt	b822
	b	b823
.ltorg
b822:
	mov	r0,	#0
	sub	r8,	r0,	r8
	mov	r8,	r8
	b	b823
.ltorg
b823:
	mov	r8,	r8
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r1,	[sp,	#528]
	add	r0,	r1,	r0, lsr #30
	mov	r0,	r0, asr #2
	mov	r1,	r0, asr #31
	ands	r7,	r0,	#1
	orrne	r7,	r7,	r1, lsl #1
	mov	r0,	#0
	cmp	r7,	r0
	mov	r7,	r7
	blt	b824
	b	b825
.ltorg
b824:
	mov	r0,	#0
	sub	r7,	r0,	r7
	mov	r7,	r7
	b	b825
.ltorg
b825:
	mov	r7,	r7
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r1,	[sp,	#528]
	add	r0,	r1,	r0, lsr #29
	mov	r0,	r0, asr #3
	mov	r1,	r0, asr #31
	ands	r6,	r0,	#1
	orrne	r6,	r6,	r1, lsl #1
	mov	r0,	#0
	cmp	r6,	r0
	mov	r6,	r6
	blt	b826
	b	b827
.ltorg
b826:
	mov	r0,	#0
	sub	r6,	r0,	r6
	mov	r6,	r6
	b	b827
.ltorg
b827:
	mov	r6,	r6
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r1,	[sp,	#528]
	add	r0,	r1,	r0, lsr #28
	mov	r0,	r0, asr #4
	mov	r1,	r0, asr #31
	ands	r2,	r0,	#1
	orrne	r2,	r2,	r1, lsl #1
	mov	r0,	#0
	cmp	r2,	r0
	mov	r2,	r2
	blt	b828
	b	b829
.ltorg
b828:
	mov	r0,	#0
	sub	r2,	r0,	r2
	mov	r2,	r2
	b	b829
.ltorg
b829:
	mov	r2,	r2
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r1,	[sp,	#528]
	add	r0,	r1,	r0, lsr #27
	mov	r0,	r0, asr #5
	mov	r4,	r0, asr #31
	ands	r1,	r0,	#1
	orrne	r1,	r1,	r4, lsl #1
	mov	r0,	#0
	cmp	r1,	r0
	mov	r1,	r1
	blt	b830
	b	b831
.ltorg
b830:
	mov	r0,	#0
	sub	r1,	r0,	r1
	mov	r1,	r1
	b	b831
.ltorg
b831:
	mov	r1,	r1
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r4,	[sp,	#528]
	add	r0,	r4,	r0, lsr #26
	mov	r0,	r0, asr #6
	mov	r4,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r4, lsl #1
	mov	r4,	#0
	cmp	r0,	r4
	mov	r0,	r0
	blt	b832
	b	b833
.ltorg
b832:
	mov	r4,	#0
	sub	r0,	r4,	r0
	mov	r0,	r0
	b	b833
.ltorg
b833:
	mov	r0,	r0
	str	r0,	[sp,	#768]
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r4,	[sp,	#528]
	add	r0,	r4,	r0, lsr #25
	mov	r0,	r0, asr #7
	mov	r4,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r4, lsl #1
	mov	r4,	#0
	cmp	r0,	r4
	mov	r0,	r0
	blt	b834
	b	b835
.ltorg
b834:
	mov	r4,	#0
	sub	r0,	r4,	r0
	mov	r0,	r0
	b	b835
.ltorg
b835:
	mov	r0,	r0
	str	r0,	[sp,	#772]
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r4,	[sp,	#528]
	add	r0,	r4,	r0, lsr #24
	mov	r0,	r0, asr #8
	mov	r4,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r4, lsl #1
	mov	r4,	#0
	cmp	r0,	r4
	mov	r0,	r0
	blt	b836
	b	b837
.ltorg
b836:
	mov	r4,	#0
	sub	r0,	r4,	r0
	mov	r0,	r0
	b	b837
.ltorg
b837:
	mov	r0,	r0
	str	r0,	[sp,	#800]
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r4,	[sp,	#528]
	add	r0,	r4,	r0, lsr #23
	mov	r0,	r0, asr #9
	mov	r4,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r4, lsl #1
	mov	r4,	#0
	cmp	r0,	r4
	mov	r0,	r0
	blt	b838
	b	b839
.ltorg
b838:
	mov	r4,	#0
	sub	r0,	r4,	r0
	mov	r0,	r0
	b	b839
.ltorg
b839:
	mov	r0,	r0
	str	r0,	[sp,	#844]
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r4,	[sp,	#528]
	add	r0,	r4,	r0, lsr #22
	mov	r0,	r0, asr #10
	mov	r4,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r4, lsl #1
	mov	r4,	#0
	cmp	r0,	r4
	mov	r0,	r0
	blt	b840
	b	b841
.ltorg
b840:
	mov	r4,	#0
	sub	r0,	r4,	r0
	mov	r0,	r0
	b	b841
.ltorg
b841:
	mov	r0,	r0
	str	r0,	[sp,	#824]
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r4,	[sp,	#528]
	add	r0,	r4,	r0, lsr #21
	mov	r0,	r0, asr #11
	mov	r4,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r4, lsl #1
	mov	r4,	#0
	cmp	r0,	r4
	mov	r0,	r0
	blt	b842
	b	b843
.ltorg
b842:
	mov	r4,	#0
	sub	r0,	r4,	r0
	mov	r0,	r0
	b	b843
.ltorg
b843:
	mov	r0,	r0
	str	r0,	[sp,	#852]
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r4,	[sp,	#528]
	add	r0,	r4,	r0, lsr #20
	mov	r0,	r0, asr #12
	mov	r4,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r4, lsl #1
	mov	r4,	#0
	cmp	r0,	r4
	mov	r0,	r0
	blt	b844
	b	b845
.ltorg
b844:
	mov	r4,	#0
	sub	r0,	r4,	r0
	mov	r0,	r0
	b	b845
.ltorg
b845:
	mov	r0,	r0
	str	r0,	[sp,	#544]
	ldr	r0,	[sp,	#528]
	mov	r4,	r0, asr #31
	ldr	r0,	[sp,	#528]
	add	r0,	r0,	r4, lsr #19
	mov	r0,	r0, asr #13
	mov	r4,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r4, lsl #1
	mov	r4,	#0
	cmp	r0,	r4
	mov	r0,	r0
	blt	b846
	b	b847
.ltorg
b846:
	mov	r4,	#0
	sub	r0,	r4,	r0
	mov	r0,	r0
	b	b847
.ltorg
b847:
	mov	r0,	r0
	str	r0,	[sp,	#476]
	ldr	r0,	[sp,	#528]
	mov	r4,	r0, asr #31
	ldr	r0,	[sp,	#528]
	add	r0,	r0,	r4, lsr #18
	mov	r0,	r0, asr #14
	mov	r4,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r4, lsl #1
	mov	r4,	#0
	cmp	r0,	r4
	mov	r0,	r0
	blt	b848
	b	b849
.ltorg
b848:
	mov	r4,	#0
	sub	r0,	r4,	r0
	mov	r0,	r0
	b	b849
.ltorg
b849:
	mov	r0,	r0
	str	r0,	[sp,	#500]
	ldr	r0,	[sp,	#528]
	mov	r4,	r0, asr #31
	ldr	r0,	[sp,	#528]
	add	r0,	r0,	r4, lsr #17
	mov	r0,	r0, asr #15
	mov	r4,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r4, lsl #1
	mov	r4,	#0
	cmp	r0,	r4
	mov	r0,	r0
	blt	b850
	b	b851
.ltorg
b850:
	mov	r4,	#0
	sub	r0,	r4,	r0
	mov	r0,	r0
	b	b851
.ltorg
b851:
	mov	r0,	r0
	str	r0,	[sp,	#692]
	mov	r0,	r3, asr #31
	ands	r5,	r3,	#1
	orrne	r5,	r5,	r0, lsl #1
	mov	r0,	#0
	cmp	r5,	r0
	mov	r5,	r5
	blt	b852
	b	b853
.ltorg
b852:
	mov	r0,	#0
	sub	r5,	r0,	r5
	mov	r5,	r5
	b	b853
.ltorg
b853:
	mov	r5,	r5
	mov	r0,	r3, asr #31
	add	r0,	r3,	r0, lsr #31
	mov	r4,	r0, asr #1
	mov	r0,	r4, asr #31
	ands	r9,	r4,	#1
	orrne	r9,	r9,	r0, lsl #1
	mov	r0,	#0
	cmp	r9,	r0
	mov	r9,	r9
	blt	b854
	b	b855
.ltorg
b854:
	mov	r0,	#0
	sub	r9,	r0,	r9
	mov	r9,	r9
	b	b855
.ltorg
b855:
	mov	r9,	r9
	mov	r0,	r3, asr #31
	add	r0,	r3,	r0, lsr #30
	mov	r0,	r0, asr #2
	mov	r10,	r0, asr #31
	ands	r4,	r0,	#1
	orrne	r4,	r4,	r10, lsl #1
	mov	r0,	#0
	cmp	r4,	r0
	mov	r4,	r4
	blt	b856
	b	b857
.ltorg
b856:
	mov	r0,	#0
	sub	r4,	r0,	r4
	mov	r4,	r4
	b	b857
.ltorg
b857:
	mov	r4,	r4
	mov	r0,	r3, asr #31
	add	r0,	r3,	r0, lsr #29
	mov	r0,	r0, asr #3
	mov	r10,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r10, lsl #1
	mov	r10,	#0
	cmp	r0,	r10
	mov	r0,	r0
	blt	b858
	b	b859
.ltorg
b858:
	mov	r10,	#0
	sub	r0,	r10,	r0
	mov	r0,	r0
	b	b859
.ltorg
b859:
	mov	r0,	r0
	str	r0,	[sp,	#364]
	mov	r0,	r3, asr #31
	add	r0,	r3,	r0, lsr #28
	mov	r0,	r0, asr #4
	mov	r10,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r10, lsl #1
	mov	r10,	#0
	cmp	r0,	r10
	mov	r0,	r0
	blt	b860
	b	b861
.ltorg
b860:
	mov	r10,	#0
	sub	r0,	r10,	r0
	mov	r0,	r0
	b	b861
.ltorg
b861:
	mov	r0,	r0
	str	r0,	[sp,	#380]
	mov	r0,	r3, asr #31
	add	r0,	r3,	r0, lsr #27
	mov	r0,	r0, asr #5
	mov	r10,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r10, lsl #1
	mov	r10,	#0
	cmp	r0,	r10
	mov	r0,	r0
	blt	b862
	b	b863
.ltorg
b863:
	mov	r0,	r0
	str	r0,	[sp,	#972]
	mov	r0,	r3, asr #31
	add	r0,	r3,	r0, lsr #26
	mov	r0,	r0, asr #6
	mov	r10,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r10, lsl #1
	mov	r10,	#0
	cmp	r0,	r10
	mov	r0,	r0
	blt	b864
	b	b865
.ltorg
b864:
	mov	r10,	#0
	sub	r0,	r10,	r0
	mov	r0,	r0
	b	b865
.ltorg
b865:
	mov	r0,	r0
	str	r0,	[sp,	#460]
	mov	r0,	r3, asr #31
	add	r0,	r3,	r0, lsr #25
	mov	r0,	r0, asr #7
	mov	r10,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r10, lsl #1
	mov	r10,	#0
	cmp	r0,	r10
	mov	r0,	r0
	blt	b866
	b	b867
.ltorg
b866:
	mov	r10,	#0
	sub	r0,	r10,	r0
	mov	r0,	r0
	b	b867
.ltorg
b867:
	mov	r0,	r0
	str	r0,	[sp,	#428]
	mov	r0,	r3, asr #31
	add	r0,	r3,	r0, lsr #24
	mov	r0,	r0, asr #8
	mov	r10,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r10, lsl #1
	mov	r10,	#0
	cmp	r0,	r10
	mov	r0,	r0
	blt	b868
	b	b869
.ltorg
b868:
	mov	r10,	#0
	sub	r0,	r10,	r0
	mov	r0,	r0
	b	b869
.ltorg
b869:
	mov	r0,	r0
	str	r0,	[sp,	#316]
	mov	r0,	r3, asr #31
	add	r0,	r3,	r0, lsr #23
	mov	r0,	r0, asr #9
	mov	r10,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r10, lsl #1
	mov	r10,	#0
	cmp	r0,	r10
	mov	r0,	r0
	blt	b870
	b	b871
.ltorg
b870:
	mov	r10,	#0
	sub	r0,	r10,	r0
	mov	r0,	r0
	b	b871
.ltorg
b871:
	mov	r0,	r0
	str	r0,	[sp,	#272]
	mov	r0,	r3, asr #31
	add	r0,	r3,	r0, lsr #22
	mov	r0,	r0, asr #10
	mov	r10,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r10, lsl #1
	mov	r10,	#0
	cmp	r0,	r10
	mov	r0,	r0
	blt	b872
	b	b873
.ltorg
b872:
	mov	r10,	#0
	sub	r0,	r10,	r0
	mov	r0,	r0
	b	b873
.ltorg
b873:
	mov	r0,	r0
	str	r0,	[sp,	#284]
	mov	r0,	r3, asr #31
	add	r0,	r3,	r0, lsr #21
	mov	r0,	r0, asr #11
	mov	r10,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r10, lsl #1
	mov	r10,	#0
	cmp	r0,	r10
	mov	r0,	r0
	blt	b874
	b	b875
.ltorg
b874:
	mov	r10,	#0
	sub	r0,	r10,	r0
	mov	r0,	r0
	b	b875
.ltorg
b875:
	mov	r0,	r0
	str	r0,	[sp,	#340]
	mov	r0,	r3, asr #31
	add	r0,	r3,	r0, lsr #20
	mov	r0,	r0, asr #12
	mov	r10,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r10, lsl #1
	mov	r10,	#0
	cmp	r0,	r10
	mov	r0,	r0
	blt	b876
	b	b877
.ltorg
b876:
	mov	r10,	#0
	sub	r0,	r10,	r0
	mov	r0,	r0
	b	b877
.ltorg
b877:
	mov	r0,	r0
	str	r0,	[sp,	#252]
	mov	r0,	r3, asr #31
	add	r0,	r3,	r0, lsr #19
	mov	r0,	r0, asr #13
	mov	r10,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r10, lsl #1
	mov	r10,	#0
	cmp	r0,	r10
	mov	r0,	r0
	blt	b878
	b	b879
.ltorg
b879:
	mov	r0,	r0
	str	r0,	[sp,	#744]
	mov	r0,	r3, asr #31
	add	r0,	r3,	r0, lsr #18
	mov	r0,	r0, asr #14
	mov	r10,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r10, lsl #1
	mov	r10,	#0
	cmp	r0,	r10
	mov	r0,	r0
	blt	b880
	b	b881
.ltorg
b880:
	mov	r10,	#0
	sub	r0,	r10,	r0
	mov	r0,	r0
	b	b881
.ltorg
b881:
	mov	r0,	r0
	str	r0,	[sp,	#720]
	mov	r0,	r3, asr #31
	add	r0,	r3,	r0, lsr #17
	mov	r0,	r0, asr #15
	mov	r3,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r3, lsl #1
	mov	r3,	#0
	cmp	r0,	r3
	mov	r0,	r0
	blt	b882
	b	b883
.ltorg
b882:
	mov	r3,	#0
	sub	r0,	r3,	r0
	mov	r0,	r0
	b	b883
.ltorg
b883:
	mov	r0,	r0
	str	r0,	[sp,	#696]
	mov	r3,	#0
	ldr	r0,	[sp,	#452]
	cmp	r0,	r3
	bne	b884
	b	b887
.ltorg
b884:
	mov	r3,	#1
	b	b886
.ltorg
b886:
	mov	r3,	r3
	mov	r10,	#0
	ldr	r0,	[sp,	#452]
	cmp	r0,	r10
	bne	b891
	b	b889
.ltorg
b889:
	mov	r0,	#0
	b	b890
.ltorg
b890:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r10,	#1
	movne	r10,	#0
	mov	r0,	#0
	cmp	r10,	r0
	bne	b892
	b	b893
.ltorg
b892:
	mov	r0,	#1
	b	b894
.ltorg
b893:
	mov	r0,	#0
	b	b894
.ltorg
b894:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r3,	r10
	bne	b898
	b	b896
.ltorg
b896:
	mov	r0,	#0
	b	b897
.ltorg
b897:
	mov	r0,	r0
	str	r0,	[sp,	#384]
	mov	r3,	#0
	ldr	r0,	[sp,	#384]
	cmp	r0,	r3
	bne	b899
	b	b902
.ltorg
b899:
	mov	r3,	#1
	b	b901
.ltorg
b901:
	mov	r3,	r3
	mov	r10,	#0
	ldr	r0,	[sp,	#384]
	cmp	r0,	r10
	bne	b906
	b	b904
.ltorg
b904:
	b	b907
.ltorg
b907:
	mov	r0,	#1
	b	b909
.ltorg
b909:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r3,	r10
	bne	b913
	b	b911
.ltorg
b911:
	mov	r0,	#0
	b	b912
.ltorg
b912:
	mov	r0,	r0
	str	r0,	[sp,	#248]
	mov	r0,	#0
	ldr	r3,	[sp,	#452]
	cmp	r3,	r0
	bne	b917
	b	b915
.ltorg
b915:
	mov	r0,	#0
	b	b916
.ltorg
b916:
	mov	r0,	r0
	mov	r3,	#0
	ldr	r5,	[sp,	#384]
	cmp	r5,	r3
	bne	b921
	b	b919
.ltorg
b919:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b922
	b	b925
.ltorg
b922:
	mov	r0,	#1
	b	b924
.ltorg
b924:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r8,	r3
	bne	b926
	b	b929
.ltorg
b926:
	mov	r5,	#1
	b	b928
.ltorg
b928:
	mov	r5,	r5
	mov	r3,	#0
	cmp	r8,	r3
	bne	b933
	b	b931
.ltorg
b931:
	mov	r3,	#0
	b	b932
.ltorg
b932:
	mov	r3,	r3
	mov	r10,	#0
	cmp	r3,	r10
	moveq	r3,	#1
	movne	r3,	#0
	mov	r10,	#0
	cmp	r3,	r10
	bne	b934
	b	b935
.ltorg
b934:
	mov	r3,	#1
	b	b936
.ltorg
b935:
	mov	r3,	#0
	b	b936
.ltorg
b936:
	mov	r3,	r3
	mov	r10,	#0
	cmp	r5,	r10
	bne	b940
	b	b938
.ltorg
b938:
	mov	r10,	#0
	b	b939
.ltorg
b939:
	mov	r10,	r10
	mov	r3,	#0
	cmp	r10,	r3
	bne	b941
	b	b944
.ltorg
b941:
	mov	r5,	#1
	b	b943
.ltorg
b943:
	mov	r5,	r5
	mov	r3,	#0
	cmp	r10,	r3
	bne	b948
	b	b946
.ltorg
b946:
	mov	r3,	#0
	b	b947
.ltorg
b947:
	mov	r3,	r3
	mov	r11,	#0
	str	r11,	[sp,	#240]
	ldr	r11,	[sp,	#240]
	cmp	r3,	r11
	moveq	r3,	#1
	movne	r3,	#0
	mov	r11,	#0
	str	r11,	[sp,	#244]
	ldr	r11,	[sp,	#244]
	cmp	r3,	r11
	bne	b949
	b	b950
.ltorg
b949:
	mov	r3,	#1
	b	b951
.ltorg
b950:
	mov	r3,	#0
	b	b951
.ltorg
b951:
	mov	r3,	r3
	mov	r11,	#0
	str	r11,	[sp,	#236]
	ldr	r11,	[sp,	#236]
	cmp	r5,	r11
	bne	b955
	b	b953
.ltorg
b953:
	mov	r3,	#0
	b	b954
.ltorg
b954:
	mov	r3,	r3
	mov	r5,	#0
	cmp	r8,	r5
	bne	b959
	b	b957
.ltorg
b957:
	mov	r5,	#0
	b	b958
.ltorg
b958:
	mov	r5,	r5
	mov	r8,	#0
	cmp	r10,	r8
	bne	b963
	b	b961
.ltorg
b961:
	mov	r0,	#0
	b	b962
.ltorg
b962:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r5,	r8
	bne	b964
	b	b967
.ltorg
b964:
	mov	r8,	#1
	b	b966
.ltorg
b966:
	mov	r8,	r8
	mov	r0,	#0
	cmp	r7,	r0
	bne	b968
	b	b971
.ltorg
b968:
	mov	r5,	#1
	b	b970
.ltorg
b970:
	mov	r5,	r5
	mov	r0,	#0
	cmp	r7,	r0
	bne	b975
	b	b973
.ltorg
b975:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b972
	b	b973
.ltorg
b972:
	mov	r0,	#1
	b	b974
.ltorg
b973:
	mov	r0,	#0
	b	b974
.ltorg
b974:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r9,	#1
	movne	r9,	#0
	mov	r0,	#0
	cmp	r9,	r0
	bne	b976
	b	b977
.ltorg
b978:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r5,	r9
	bne	b982
	b	b980
.ltorg
b980:
	mov	r0,	#0
	b	b981
.ltorg
b981:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r0,	r5
	bne	b983
	b	b986
.ltorg
b986:
	mov	r5,	#0
	cmp	r8,	r5
	bne	b983
	b	b984
.ltorg
b984:
	mov	r9,	#0
	b	b985
.ltorg
b983:
	mov	r9,	#1
	b	b985
.ltorg
b985:
	mov	r9,	r9
	mov	r5,	#0
	cmp	r0,	r5
	bne	b990
	b	b988
.ltorg
b989:
	mov	r5,	r5
	mov	r10,	#0
	cmp	r5,	r10
	moveq	r10,	#1
	movne	r10,	#0
	mov	r5,	#0
	cmp	r10,	r5
	bne	b991
	b	b992
.ltorg
b992:
	mov	r5,	#0
	b	b993
.ltorg
b993:
	mov	r5,	r5
	mov	r10,	#0
	cmp	r9,	r10
	bne	b997
	b	b995
.ltorg
b997:
	mov	r9,	#0
	cmp	r5,	r9
	bne	b994
	b	b995
.ltorg
b994:
	mov	r5,	#1
	b	b996
.ltorg
b995:
	mov	r5,	#0
	b	b996
.ltorg
b996:
	mov	r5,	r5
	mov	r9,	#0
	cmp	r7,	r9
	bne	b1001
	b	b999
.ltorg
b1000:
	mov	r4,	r4
	mov	r7,	#0
	cmp	r0,	r7
	bne	b1005
	b	b1003
.ltorg
b1003:
	mov	r0,	#0
	b	b1004
.ltorg
b1004:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r4,	r7
	bne	b1006
	b	b1009
.ltorg
b1008:
	mov	r8,	r8
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1010
	b	b1013
.ltorg
b1010:
	mov	r4,	#1
	b	b1012
.ltorg
b1012:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1017
	b	b1015
.ltorg
b1015:
	mov	r0,	#0
	b	b1016
.ltorg
b1016:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r0,	r7
	moveq	r0,	#1
	movne	r0,	#0
	mov	r7,	#0
	cmp	r0,	r7
	bne	b1018
	b	b1019
.ltorg
b1018:
	mov	r0,	#1
	b	b1020
.ltorg
b1019:
	mov	r0,	#0
	b	b1020
.ltorg
b1020:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r4,	r7
	bne	b1024
	b	b1022
.ltorg
b1022:
	mov	r7,	#0
	b	b1023
.ltorg
b1023:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1025
	b	b1028
.ltorg
b1025:
	mov	r4,	#1
	b	b1027
.ltorg
b1027:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1032
	b	b1030
.ltorg
b1030:
	mov	r0,	#0
	b	b1031
.ltorg
b1031:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r9,	#1
	movne	r9,	#0
	mov	r0,	#0
	cmp	r9,	r0
	bne	b1033
	b	b1034
.ltorg
b1033:
	mov	r0,	#1
	b	b1035
.ltorg
b1034:
	mov	r0,	#0
	b	b1035
.ltorg
b1035:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r4,	r9
	bne	b1039
	b	b1037
.ltorg
b1037:
	mov	r0,	#0
	b	b1038
.ltorg
b1038:
	mov	r0,	r0
	str	r0,	[sp,	#648]
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1043
	b	b1041
.ltorg
b1041:
	mov	r4,	#0
	b	b1042
.ltorg
b1042:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1047
	b	b1045
.ltorg
b1045:
	mov	r0,	#0
	b	b1046
.ltorg
b1046:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r4,	r6
	bne	b1048
	b	b1051
.ltorg
b1048:
	mov	r6,	#1
	b	b1050
.ltorg
b1050:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r2,	r0
	bne	b1052
	b	b1055
.ltorg
b1052:
	mov	r4,	#1
	b	b1054
.ltorg
b1054:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r2,	r0
	bne	b1059
	b	b1057
.ltorg
b1057:
	mov	r0,	#0
	b	b1058
.ltorg
b1058:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r0,	r7
	moveq	r7,	#1
	movne	r7,	#0
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1060
	b	b1061
.ltorg
b1060:
	mov	r0,	#1
	b	b1062
.ltorg
b1061:
	mov	r0,	#0
	b	b1062
.ltorg
b1062:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r4,	r7
	bne	b1066
	b	b1064
.ltorg
b1064:
	mov	r4,	#0
	b	b1065
.ltorg
b1065:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1067
	b	b1070
.ltorg
b1067:
	mov	r7,	#1
	b	b1069
.ltorg
b1069:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1074
	b	b1072
.ltorg
b1072:
	mov	r0,	#0
	b	b1073
.ltorg
b1073:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r0,	r8
	moveq	r8,	#1
	movne	r8,	#0
	mov	r0,	#0
	cmp	r8,	r0
	bne	b1075
	b	b1076
.ltorg
b1075:
	mov	r0,	#1
	b	b1077
.ltorg
b1076:
	mov	r0,	#0
	b	b1077
.ltorg
b1077:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r7,	r8
	bne	b1081
	b	b1079
.ltorg
b1079:
	mov	r0,	#0
	b	b1080
.ltorg
b1080:
	mov	r0,	r0
	str	r0,	[sp,	#660]
	mov	r0,	#0
	cmp	r2,	r0
	bne	b1085
	b	b1083
.ltorg
b1083:
	mov	r2,	#0
	b	b1084
.ltorg
b1084:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1089
	b	b1087
.ltorg
b1087:
	mov	r0,	#0
	b	b1088
.ltorg
b1088:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r2,	r4
	bne	b1090
	b	b1093
.ltorg
b1090:
	mov	r4,	#1
	b	b1092
.ltorg
b1092:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r1,	r0
	bne	b1094
	b	b1097
.ltorg
b1094:
	mov	r2,	#1
	b	b1096
.ltorg
b1096:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r1,	r0
	bne	b1101
	b	b1099
.ltorg
b1099:
	mov	r0,	#0
	b	b1100
.ltorg
b1100:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r0,	r6
	moveq	r6,	#1
	movne	r6,	#0
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1102
	b	b1103
.ltorg
b1102:
	mov	r0,	#1
	b	b1104
.ltorg
b1103:
	mov	r0,	#0
	b	b1104
.ltorg
b1104:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r2,	r6
	bne	b1108
	b	b1106
.ltorg
b1106:
	mov	r2,	#0
	b	b1107
.ltorg
b1107:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r2,	r0
	bne	b1109
	b	b1112
.ltorg
b1109:
	mov	r6,	#1
	b	b1111
.ltorg
b1111:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r2,	r0
	bne	b1116
	b	b1114
.ltorg
b1116:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1113
	b	b1114
.ltorg
b1113:
	mov	r0,	#1
	b	b1115
.ltorg
b1114:
	mov	r0,	#0
	b	b1115
.ltorg
b1115:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r0,	r7
	moveq	r7,	#1
	movne	r7,	#0
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1117
	b	b1118
.ltorg
b1119:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r6,	r7
	bne	b1123
	b	b1121
.ltorg
b1121:
	mov	r0,	#0
	b	b1122
.ltorg
b1122:
	mov	r0,	r0
	str	r0,	[sp,	#656]
	mov	r0,	#0
	cmp	r1,	r0
	bne	b1127
	b	b1125
.ltorg
b1127:
	mov	r1,	#0
	ldr	r0,	[sp,	#972]
	cmp	r0,	r1
	bne	b1124
	b	b1125
.ltorg
b1124:
	mov	r1,	#1
	b	b1126
.ltorg
b1125:
	mov	r1,	#0
	b	b1126
.ltorg
b1126:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r2,	r0
	bne	b1131
	b	b1129
.ltorg
b1130:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r1,	r2
	bne	b1132
	b	b1135
.ltorg
b1134:
	mov	r6,	r6
	mov	r0,	#0
	ldr	r1,	[sp,	#768]
	cmp	r1,	r0
	bne	b1136
	b	b1139
.ltorg
b1136:
	mov	r1,	#1
	b	b1138
.ltorg
b1138:
	mov	r1,	r1
	mov	r0,	#0
	ldr	r2,	[sp,	#768]
	cmp	r2,	r0
	bne	b1143
	b	b1141
.ltorg
b1141:
	mov	r0,	#0
	b	b1142
.ltorg
b1142:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r0,	r2
	moveq	r2,	#1
	movne	r2,	#0
	mov	r0,	#0
	cmp	r2,	r0
	bne	b1144
	b	b1145
.ltorg
b1144:
	mov	r0,	#1
	b	b1146
.ltorg
b1145:
	mov	r0,	#0
	b	b1146
.ltorg
b1146:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r1,	r2
	bne	b1150
	b	b1148
.ltorg
b1148:
	mov	r4,	#0
	b	b1149
.ltorg
b1149:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1151
	b	b1154
.ltorg
b1151:
	mov	r1,	#1
	b	b1153
.ltorg
b1153:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1158
	b	b1156
.ltorg
b1156:
	mov	r0,	#0
	b	b1157
.ltorg
b1157:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r0,	r2
	moveq	r2,	#1
	movne	r2,	#0
	mov	r0,	#0
	cmp	r2,	r0
	bne	b1159
	b	b1160
.ltorg
b1159:
	mov	r0,	#1
	b	b1161
.ltorg
b1160:
	mov	r0,	#0
	b	b1161
.ltorg
b1161:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r1,	r2
	bne	b1165
	b	b1163
.ltorg
b1163:
	mov	r1,	#0
	b	b1164
.ltorg
b1164:
	mov	r1,	r1
	mov	r0,	#0
	ldr	r2,	[sp,	#768]
	cmp	r2,	r0
	bne	b1169
	b	b1167
.ltorg
b1167:
	mov	r2,	#0
	b	b1168
.ltorg
b1168:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1173
	b	b1171
.ltorg
b1171:
	mov	r0,	#0
	b	b1172
.ltorg
b1172:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r2,	r4
	bne	b1174
	b	b1177
.ltorg
b1174:
	mov	r6,	#1
	b	b1176
.ltorg
b1176:
	mov	r6,	r6
	mov	r0,	#0
	ldr	r2,	[sp,	#772]
	cmp	r2,	r0
	bne	b1178
	b	b1181
.ltorg
b1178:
	mov	r2,	#1
	b	b1180
.ltorg
b1180:
	mov	r2,	r2
	mov	r0,	#0
	ldr	r4,	[sp,	#772]
	cmp	r4,	r0
	bne	b1185
	b	b1183
.ltorg
b1183:
	mov	r0,	#0
	b	b1184
.ltorg
b1184:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r4,	#1
	movne	r4,	#0
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1186
	b	b1187
.ltorg
b1186:
	mov	r0,	#1
	b	b1188
.ltorg
b1187:
	mov	r0,	#0
	b	b1188
.ltorg
b1188:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r2,	r4
	bne	b1192
	b	b1190
.ltorg
b1190:
	mov	r4,	#0
	b	b1191
.ltorg
b1191:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1193
	b	b1196
.ltorg
b1193:
	mov	r2,	#1
	b	b1195
.ltorg
b1195:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1200
	b	b1198
.ltorg
b1198:
	mov	r0,	#0
	b	b1199
.ltorg
b1199:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r0,	r7
	moveq	r7,	#1
	movne	r7,	#0
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1201
	b	b1202
.ltorg
b1201:
	mov	r0,	#1
	b	b1203
.ltorg
b1202:
	mov	r0,	#0
	b	b1203
.ltorg
b1203:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r2,	r7
	bne	b1207
	b	b1205
.ltorg
b1205:
	mov	r9,	#0
	b	b1206
.ltorg
b1206:
	mov	r9,	r9
	mov	r0,	#0
	ldr	r2,	[sp,	#772]
	cmp	r2,	r0
	bne	b1211
	b	b1209
.ltorg
b1209:
	mov	r2,	#0
	b	b1210
.ltorg
b1210:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1215
	b	b1213
.ltorg
b1213:
	mov	r0,	#0
	b	b1214
.ltorg
b1214:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r2,	r4
	bne	b1216
	b	b1219
.ltorg
b1216:
	mov	r4,	#1
	b	b1218
.ltorg
b1218:
	mov	r4,	r4
	mov	r2,	#0
	ldr	r0,	[sp,	#800]
	cmp	r0,	r2
	bne	b1220
	b	b1223
.ltorg
b1220:
	mov	r2,	#1
	b	b1222
.ltorg
b1222:
	mov	r2,	r2
	mov	r6,	#0
	ldr	r0,	[sp,	#800]
	cmp	r0,	r6
	bne	b1227
	b	b1225
.ltorg
b1225:
	mov	r0,	#0
	b	b1226
.ltorg
b1226:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r0,	r6
	moveq	r6,	#1
	movne	r6,	#0
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1228
	b	b1229
.ltorg
b1228:
	mov	r0,	#1
	b	b1230
.ltorg
b1229:
	mov	r0,	#0
	b	b1230
.ltorg
b1230:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r2,	r6
	bne	b1234
	b	b1232
.ltorg
b1232:
	mov	r6,	#0
	b	b1233
.ltorg
b1233:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1235
	b	b1238
.ltorg
b1235:
	mov	r2,	#1
	b	b1237
.ltorg
b1237:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1242
	b	b1240
.ltorg
b1240:
	mov	r0,	#0
	b	b1241
.ltorg
b1241:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r0,	r7
	moveq	r0,	#1
	movne	r0,	#0
	mov	r7,	#0
	cmp	r0,	r7
	bne	b1243
	b	b1244
.ltorg
b1243:
	mov	r0,	#1
	b	b1245
.ltorg
b1244:
	mov	r0,	#0
	b	b1245
.ltorg
b1245:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r2,	r7
	bne	b1249
	b	b1247
.ltorg
b1247:
	mov	r10,	#0
	b	b1248
.ltorg
b1248:
	mov	r10,	r10
	mov	r2,	#0
	ldr	r0,	[sp,	#800]
	cmp	r0,	r2
	bne	b1253
	b	b1251
.ltorg
b1251:
	mov	r2,	#0
	b	b1252
.ltorg
b1252:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1257
	b	b1255
.ltorg
b1257:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1254
	b	b1255
.ltorg
b1254:
	mov	r0,	#1
	b	b1256
.ltorg
b1255:
	mov	r0,	#0
	b	b1256
.ltorg
b1256:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r2,	r4
	bne	b1258
	b	b1261
.ltorg
b1261:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1258
	b	b1259
.ltorg
b1259:
	mov	r6,	#0
	b	b1260
.ltorg
b1258:
	mov	r6,	#1
	b	b1260
.ltorg
b1260:
	mov	r6,	r6
	mov	r2,	#0
	ldr	r0,	[sp,	#844]
	cmp	r0,	r2
	bne	b1262
	b	b1265
.ltorg
b1264:
	mov	r2,	r2
	mov	r4,	#0
	ldr	r0,	[sp,	#844]
	cmp	r0,	r4
	bne	b1269
	b	b1267
.ltorg
b1267:
	mov	r0,	#0
	b	b1268
.ltorg
b1268:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r4,	#1
	movne	r4,	#0
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1270
	b	b1271
.ltorg
b1270:
	mov	r0,	#1
	b	b1272
.ltorg
b1271:
	mov	r0,	#0
	b	b1272
.ltorg
b1272:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r2,	r4
	bne	b1276
	b	b1274
.ltorg
b1274:
	mov	r4,	#0
	b	b1275
.ltorg
b1275:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1277
	b	b1280
.ltorg
b1277:
	mov	r2,	#1
	b	b1279
.ltorg
b1279:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1284
	b	b1282
.ltorg
b1282:
	mov	r0,	#0
	b	b1283
.ltorg
b1283:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r0,	r7
	moveq	r7,	#1
	movne	r7,	#0
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1285
	b	b1286
.ltorg
b1285:
	mov	r0,	#1
	b	b1287
.ltorg
b1286:
	mov	r0,	#0
	b	b1287
.ltorg
b1287:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r2,	r7
	bne	b1291
	b	b1289
.ltorg
b1289:
	mov	r7,	#0
	b	b1290
.ltorg
b1290:
	mov	r7,	r7
	mov	r2,	#0
	ldr	r0,	[sp,	#844]
	cmp	r0,	r2
	bne	b1295
	b	b1293
.ltorg
b1293:
	mov	r2,	#0
	b	b1294
.ltorg
b1294:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1299
	b	b1297
.ltorg
b1297:
	mov	r0,	#0
	b	b1298
.ltorg
b1298:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r2,	r4
	bne	b1300
	b	b1303
.ltorg
b1300:
	mov	r4,	#1
	b	b1302
.ltorg
b1302:
	mov	r4,	r4
	mov	r2,	#0
	ldr	r0,	[sp,	#824]
	cmp	r0,	r2
	bne	b1304
	b	b1307
.ltorg
b1304:
	mov	r2,	#1
	b	b1306
.ltorg
b1306:
	mov	r2,	r2
	mov	r6,	#0
	ldr	r0,	[sp,	#824]
	cmp	r0,	r6
	bne	b1311
	b	b1309
.ltorg
b1309:
	mov	r0,	#0
	b	b1310
.ltorg
b1310:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r0,	r6
	moveq	r6,	#1
	movne	r6,	#0
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1312
	b	b1313
.ltorg
b1312:
	mov	r0,	#1
	b	b1314
.ltorg
b1313:
	mov	r0,	#0
	b	b1314
.ltorg
b1314:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r2,	r6
	bne	b1318
	b	b1316
.ltorg
b1316:
	mov	r0,	#0
	b	b1317
.ltorg
b1317:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1319
	b	b1322
.ltorg
b1319:
	mov	r6,	#1
	b	b1321
.ltorg
b1321:
	mov	r6,	r6
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1326
	b	b1324
.ltorg
b1324:
	mov	r2,	#0
	b	b1325
.ltorg
b1325:
	mov	r2,	r2
	mov	r8,	#0
	cmp	r2,	r8
	moveq	r8,	#1
	movne	r8,	#0
	mov	r2,	#0
	cmp	r8,	r2
	bne	b1327
	b	b1328
.ltorg
b1327:
	mov	r2,	#1
	b	b1329
.ltorg
b1328:
	mov	r2,	#0
	b	b1329
.ltorg
b1329:
	mov	r2,	r2
	mov	r8,	#0
	cmp	r6,	r8
	bne	b1333
	b	b1331
.ltorg
b1331:
	mov	r6,	#0
	b	b1332
.ltorg
b1332:
	mov	r6,	r6
	mov	r8,	#0
	ldr	r2,	[sp,	#824]
	cmp	r2,	r8
	bne	b1337
	b	b1335
.ltorg
b1335:
	mov	r2,	#0
	b	b1336
.ltorg
b1336:
	mov	r2,	r2
	mov	r8,	#0
	cmp	r0,	r8
	bne	b1341
	b	b1339
.ltorg
b1339:
	mov	r0,	#0
	b	b1340
.ltorg
b1340:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r2,	r4
	bne	b1342
	b	b1345
.ltorg
b1342:
	mov	r4,	#1
	b	b1344
.ltorg
b1344:
	mov	r4,	r4
	mov	r2,	#0
	ldr	r0,	[sp,	#852]
	cmp	r0,	r2
	bne	b1346
	b	b1349
.ltorg
b1346:
	mov	r2,	#1
	b	b1348
.ltorg
b1348:
	mov	r2,	r2
	mov	r8,	#0
	ldr	r0,	[sp,	#852]
	cmp	r0,	r8
	bne	b1353
	b	b1351
.ltorg
b1351:
	mov	r0,	#0
	b	b1352
.ltorg
b1352:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r0,	r8
	moveq	r0,	#1
	movne	r0,	#0
	mov	r8,	#0
	cmp	r0,	r8
	bne	b1354
	b	b1355
.ltorg
b1354:
	mov	r0,	#1
	b	b1356
.ltorg
b1355:
	mov	r0,	#0
	b	b1356
.ltorg
b1356:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r2,	r8
	bne	b1360
	b	b1358
.ltorg
b1358:
	mov	r8,	#0
	b	b1359
.ltorg
b1359:
	mov	r8,	r8
	mov	r0,	#0
	cmp	r8,	r0
	bne	b1361
	b	b1364
.ltorg
b1361:
	mov	r2,	#1
	b	b1363
.ltorg
b1363:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r8,	r0
	bne	b1368
	b	b1366
.ltorg
b1366:
	mov	r0,	#0
	b	b1367
.ltorg
b1367:
	mov	r0,	r0
	mov	r11,	#0
	cmp	r0,	r11
	moveq	r0,	#1
	movne	r0,	#0
	mov	r11,	#0
	cmp	r0,	r11
	bne	b1369
	b	b1370
.ltorg
b1369:
	mov	r0,	#1
	b	b1371
.ltorg
b1370:
	mov	r0,	#0
	b	b1371
.ltorg
b1371:
	mov	r0,	r0
	mov	r11,	#0
	cmp	r2,	r11
	bne	b1375
	b	b1373
.ltorg
b1373:
	mov	r0,	#0
	b	b1374
.ltorg
b1374:
	mov	r0,	r0
	str	r0,	[sp,	#612]
	mov	r0,	#0
	ldr	r2,	[sp,	#852]
	cmp	r2,	r0
	bne	b1379
	b	b1377
.ltorg
b1377:
	mov	r2,	#0
	b	b1378
.ltorg
b1378:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r8,	r0
	bne	b1383
	b	b1381
.ltorg
b1381:
	mov	r0,	#0
	b	b1382
.ltorg
b1382:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r2,	r4
	bne	b1384
	b	b1387
.ltorg
b1384:
	mov	r0,	#1
	b	b1386
.ltorg
b1386:
	mov	r0,	r0
	str	r0,	[sp,	#736]
	mov	r0,	#0
	ldr	r2,	[sp,	#544]
	cmp	r2,	r0
	bne	b1388
	b	b1391
.ltorg
b1390:
	mov	r2,	r2
	mov	r0,	#0
	ldr	r4,	[sp,	#544]
	cmp	r4,	r0
	bne	b1395
	b	b1393
.ltorg
b1393:
	mov	r0,	#0
	b	b1394
.ltorg
b1394:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r0,	#1
	movne	r0,	#0
	mov	r4,	#0
	cmp	r0,	r4
	bne	b1396
	b	b1397
.ltorg
b1396:
	mov	r0,	#1
	b	b1398
.ltorg
b1397:
	mov	r0,	#0
	b	b1398
.ltorg
b1398:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r2,	r4
	bne	b1402
	b	b1400
.ltorg
b1401:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1403
	b	b1406
.ltorg
b1405:
	mov	r4,	r4
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1410
	b	b1408
.ltorg
b1408:
	mov	r2,	#0
	b	b1409
.ltorg
b1409:
	mov	r2,	r2
	mov	r8,	#0
	cmp	r2,	r8
	moveq	r8,	#1
	movne	r8,	#0
	mov	r2,	#0
	cmp	r8,	r2
	bne	b1411
	b	b1412
.ltorg
b1411:
	mov	r2,	#1
	b	b1413
.ltorg
b1412:
	mov	r2,	#0
	b	b1413
.ltorg
b1413:
	mov	r2,	r2
	mov	r8,	#0
	cmp	r4,	r8
	bne	b1417
	b	b1415
.ltorg
b1415:
	mov	r8,	#0
	b	b1416
.ltorg
b1416:
	mov	r8,	r8
	mov	r2,	#0
	ldr	r4,	[sp,	#544]
	cmp	r4,	r2
	bne	b1421
	b	b1419
.ltorg
b1419:
	mov	r2,	#0
	b	b1420
.ltorg
b1420:
	mov	r2,	r2
	mov	r4,	#0
	cmp	r0,	r4
	bne	b1425
	b	b1423
.ltorg
b1423:
	mov	r0,	#0
	b	b1424
.ltorg
b1424:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r2,	r4
	bne	b1426
	b	b1429
.ltorg
b1426:
	mov	r0,	#1
	b	b1428
.ltorg
b1428:
	mov	r0,	r0
	str	r0,	[sp,	#740]
	mov	r0,	#0
	ldr	r2,	[sp,	#476]
	cmp	r2,	r0
	bne	b1430
	b	b1433
.ltorg
b1430:
	mov	r2,	#1
	b	b1432
.ltorg
b1432:
	mov	r2,	r2
	mov	r0,	#0
	ldr	r4,	[sp,	#476]
	cmp	r4,	r0
	bne	b1437
	b	b1435
.ltorg
b1435:
	mov	r0,	#0
	b	b1436
.ltorg
b1436:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r4,	#1
	movne	r4,	#0
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1438
	b	b1439
.ltorg
b1438:
	mov	r0,	#1
	b	b1440
.ltorg
b1439:
	mov	r0,	#0
	b	b1440
.ltorg
b1440:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r2,	r4
	bne	b1444
	b	b1442
.ltorg
b1442:
	mov	r0,	#0
	b	b1443
.ltorg
b1443:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1445
	b	b1448
.ltorg
b1445:
	mov	r4,	#1
	b	b1447
.ltorg
b1447:
	mov	r4,	r4
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1452
	b	b1450
.ltorg
b1450:
	mov	r2,	#0
	b	b1451
.ltorg
b1451:
	mov	r2,	r2
	mov	r11,	#0
	cmp	r2,	r11
	moveq	r11,	#1
	movne	r11,	#0
	mov	r2,	#0
	cmp	r11,	r2
	bne	b1453
	b	b1454
.ltorg
b1453:
	mov	r2,	#1
	b	b1455
.ltorg
b1454:
	mov	r2,	#0
	b	b1455
.ltorg
b1455:
	mov	r2,	r2
	mov	r11,	#0
	cmp	r4,	r11
	bne	b1459
	b	b1457
.ltorg
b1457:
	mov	r2,	#0
	b	b1458
.ltorg
b1458:
	mov	r2,	r2
	mov	r4,	#0
	ldr	r11,	[sp,	#476]
	cmp	r11,	r4
	bne	b1463
	b	b1461
.ltorg
b1461:
	mov	r4,	#0
	b	b1462
.ltorg
b1462:
	mov	r4,	r4
	mov	r11,	#0
	cmp	r0,	r11
	bne	b1467
	b	b1465
.ltorg
b1465:
	mov	r0,	#0
	b	b1466
.ltorg
b1466:
	mov	r0,	r0
	mov	r11,	#0
	cmp	r4,	r11
	bne	b1468
	b	b1471
.ltorg
b1468:
	mov	r0,	#1
	b	b1470
.ltorg
b1470:
	mov	r0,	r0
	str	r0,	[sp,	#716]
	mov	r0,	#0
	ldr	r4,	[sp,	#500]
	cmp	r4,	r0
	bne	b1472
	b	b1475
.ltorg
b1472:
	mov	r4,	#1
	b	b1474
.ltorg
b1474:
	mov	r4,	r4
	mov	r0,	#0
	ldr	r11,	[sp,	#500]
	cmp	r11,	r0
	bne	b1479
	b	b1477
.ltorg
b1477:
	mov	r0,	#0
	b	b1478
.ltorg
b1478:
	mov	r0,	r0
	mov	r11,	#0
	cmp	r0,	r11
	moveq	r0,	#1
	movne	r0,	#0
	mov	r11,	#0
	cmp	r0,	r11
	bne	b1480
	b	b1481
.ltorg
b1480:
	mov	r0,	#1
	b	b1482
.ltorg
b1481:
	mov	r0,	#0
	b	b1482
.ltorg
b1482:
	mov	r0,	r0
	mov	r11,	#0
	cmp	r4,	r11
	bne	b1486
	b	b1484
.ltorg
b1484:
	mov	r0,	#0
	b	b1485
.ltorg
b1485:
	mov	r0,	r0
	str	r0,	[sp,	#2136]
	mov	r0,	#0
	ldr	r4,	[sp,	#2136]
	cmp	r4,	r0
	bne	b1487
	b	b1490
.ltorg
b1487:
	mov	r0,	#1
	b	b1489
.ltorg
b1489:
	mov	r0,	r0
	str	r0,	[sp,	#700]
	mov	r0,	#0
	ldr	r4,	[sp,	#2136]
	cmp	r4,	r0
	bne	b1494
	b	b1492
.ltorg
b1492:
	mov	r0,	#0
	b	b1493
.ltorg
b1493:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r4,	#1
	movne	r4,	#0
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1495
	b	b1496
.ltorg
b1495:
	mov	r0,	#1
	b	b1497
.ltorg
b1496:
	mov	r0,	#0
	b	b1497
.ltorg
b1497:
	mov	r0,	r0
	str	r0,	[sp,	#1048]
	mov	r0,	#0
	ldr	r4,	[sp,	#700]
	cmp	r4,	r0
	bne	b1501
	b	b1499
.ltorg
b1499:
	mov	r4,	#0
	b	b1500
.ltorg
b1500:
	mov	r4,	r4
	mov	r0,	#0
	str	r0,	[sp,	#1040]
	ldr	r0,	[sp,	#500]
	ldr	r11,	[sp,	#1040]
	str	r11,	[sp,	#1924]
	ldr	r11,	[sp,	#1924]
	str	r11,	[sp,	#1380]
	ldr	r11,	[sp,	#1380]
	str	r11,	[sp,	#1920]
	ldr	r11,	[sp,	#1920]
	cmp	r0,	r11
	bne	b1505
	b	b1503
.ltorg
b1503:
	mov	r0,	#0
	b	b1504
.ltorg
b1504:
	mov	r0,	r0
	str	r0,	[sp,	#1036]
	mov	r0,	#0
	str	r0,	[sp,	#704]
	ldr	r0,	[sp,	#704]
	ldr	r11,	[sp,	#2136]
	cmp	r11,	r0
	bne	b1509
	b	b1507
.ltorg
b1507:
	mov	r0,	#0
	b	b1508
.ltorg
b1508:
	mov	r0,	r0
	str	r0,	[sp,	#712]
	mov	r0,	#0
	ldr	r11,	[sp,	#1036]
	cmp	r11,	r0
	bne	b1510
	b	b1513
.ltorg
b1510:
	mov	r0,	#1
	b	b1512
.ltorg
b1512:
	mov	r0,	r0
	str	r0,	[sp,	#732]
	mov	r0,	#0
	ldr	r11,	[sp,	#692]
	cmp	r11,	r0
	bne	b1514
	b	b1517
.ltorg
b1517:
	mov	r0,	#0
	ldr	r11,	[sp,	#696]
	cmp	r11,	r0
	bne	b1514
	b	b1515
.ltorg
b1515:
	mov	r0,	#0
	b	b1516
.ltorg
b1514:
	mov	r0,	#1
	b	b1516
.ltorg
b1516:
	mov	r0,	r0
	str	r0,	[sp,	#688]
	mov	r0,	#0
	ldr	r11,	[sp,	#692]
	cmp	r11,	r0
	bne	b1521
	b	b1519
.ltorg
b1520:
	mov	r0,	r0
	mov	r11,	#0
	cmp	r0,	r11
	moveq	r11,	#1
	movne	r11,	#0
	mov	r0,	#0
	cmp	r11,	r0
	bne	b1522
	b	b1523
.ltorg
b1523:
	mov	r0,	#0
	b	b1524
.ltorg
b1524:
	mov	r0,	r0
	str	r0,	[sp,	#2140]
	mov	r0,	#0
	str	r0,	[sp,	#1032]
	ldr	r0,	[sp,	#688]
	ldr	r11,	[sp,	#1032]
	str	r11,	[sp,	#1908]
	ldr	r11,	[sp,	#1908]
	str	r11,	[sp,	#1368]
	ldr	r11,	[sp,	#1368]
	str	r11,	[sp,	#1904]
	ldr	r11,	[sp,	#1904]
	cmp	r0,	r11
	bne	b1528
	b	b1526
.ltorg
b1528:
	mov	r0,	#0
	ldr	r11,	[sp,	#2140]
	cmp	r11,	r0
	bne	b1525
	b	b1526
.ltorg
b1525:
	mov	r0,	#1
	b	b1527
.ltorg
b1526:
	mov	r0,	#0
	b	b1527
.ltorg
b1527:
	mov	r0,	r0
	str	r0,	[sp,	#680]
	mov	r0,	#0
	ldr	r11,	[sp,	#680]
	cmp	r11,	r0
	bne	b1529
	b	b1532
.ltorg
b1531:
	mov	r0,	r0
	str	r0,	[sp,	#2132]
	mov	r0,	#0
	str	r0,	[sp,	#1024]
	ldr	r0,	[sp,	#680]
	ldr	r11,	[sp,	#1024]
	str	r11,	[sp,	#1872]
	ldr	r11,	[sp,	#1872]
	str	r11,	[sp,	#1388]
	ldr	r11,	[sp,	#1388]
	str	r11,	[sp,	#1868]
	ldr	r11,	[sp,	#1868]
	cmp	r0,	r11
	bne	b1536
	b	b1534
.ltorg
b1534:
	mov	r0,	#0
	b	b1535
.ltorg
b1535:
	mov	r0,	r0
	str	r0,	[sp,	#1028]
	mov	r0,	#0
	str	r0,	[sp,	#676]
	ldr	r0,	[sp,	#676]
	ldr	r11,	[sp,	#1028]
	str	r11,	[sp,	#1900]
	ldr	r11,	[sp,	#1900]
	str	r11,	[sp,	#1372]
	ldr	r11,	[sp,	#1372]
	str	r11,	[sp,	#1896]
	ldr	r11,	[sp,	#1896]
	cmp	r11,	r0
	moveq	r0,	#1
	str	r0,	[sp,	#672]
	movne	r0,	#0
	str	r0,	[sp,	#672]
	mov	r0,	#0
	str	r0,	[sp,	#1020]
	ldr	r0,	[sp,	#672]
	ldr	r11,	[sp,	#1020]
	str	r11,	[sp,	#1864]
	ldr	r11,	[sp,	#1864]
	str	r11,	[sp,	#1392]
	ldr	r11,	[sp,	#1392]
	str	r11,	[sp,	#1860]
	ldr	r11,	[sp,	#1860]
	cmp	r0,	r11
	bne	b1537
	b	b1538
.ltorg
b1537:
	mov	r0,	#1
	b	b1539
.ltorg
b1538:
	mov	r0,	#0
	b	b1539
.ltorg
b1539:
	mov	r0,	r0
	str	r0,	[sp,	#724]
	mov	r0,	#0
	ldr	r11,	[sp,	#2132]
	cmp	r11,	r0
	bne	b1543
	b	b1541
.ltorg
b1542:
	mov	r0,	r0
	str	r0,	[sp,	#2128]
	mov	r0,	#0
	str	r0,	[sp,	#1012]
	ldr	r0,	[sp,	#692]
	ldr	r11,	[sp,	#1012]
	str	r11,	[sp,	#1888]
	ldr	r11,	[sp,	#1888]
	str	r11,	[sp,	#1400]
	ldr	r11,	[sp,	#1400]
	str	r11,	[sp,	#1884]
	ldr	r11,	[sp,	#1884]
	cmp	r0,	r11
	bne	b1547
	b	b1545
.ltorg
b1545:
	mov	r0,	#0
	b	b1546
.ltorg
b1546:
	mov	r0,	r0
	str	r0,	[sp,	#616]
	mov	r0,	#0
	str	r0,	[sp,	#1016]
	ldr	r0,	[sp,	#680]
	ldr	r11,	[sp,	#1016]
	str	r11,	[sp,	#1856]
	ldr	r11,	[sp,	#1856]
	str	r11,	[sp,	#1396]
	ldr	r11,	[sp,	#1396]
	str	r11,	[sp,	#1852]
	ldr	r11,	[sp,	#1852]
	cmp	r0,	r11
	bne	b1551
	b	b1549
.ltorg
b1549:
	mov	r0,	#0
	b	b1550
.ltorg
b1550:
	mov	r0,	r0
	str	r0,	[sp,	#728]
	mov	r0,	#0
	str	r0,	[sp,	#1008]
	ldr	r0,	[sp,	#616]
	ldr	r11,	[sp,	#1008]
	str	r11,	[sp,	#1880]
	ldr	r11,	[sp,	#1880]
	str	r11,	[sp,	#1384]
	ldr	r11,	[sp,	#1384]
	str	r11,	[sp,	#1876]
	ldr	r11,	[sp,	#1876]
	cmp	r0,	r11
	bne	b1552
	b	b1555
.ltorg
b1552:
	b	b1554
.ltorg
b1554:
	ldr	r0,	[sp,	#2128]
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r4
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r2
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r8
	mov	r0,	r0, lsl #1
	ldr	r2,	[sp,	#612]
	add	r0,	r0,	r2
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r6
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r7
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r10
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r9
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r1
	mov	r0,	r0, lsl #1
	ldr	r1,	[sp,	#656]
	add	r0,	r0,	r1
	mov	r0,	r0, lsl #1
	ldr	r1,	[sp,	#660]
	add	r0,	r0,	r1
	mov	r0,	r0, lsl #1
	ldr	r1,	[sp,	#648]
	add	r0,	r0,	r1
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r5
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r3
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#248]
	add	r0,	r1,	r0
	mov	r0,	r0
	bl	fib
	mov	r0,	r0
	str	r0,	[sp,	#232]
	b	b1588
.ltorg
b1588:
	mov	r4,	#1
	b	b1590
.ltorg
b1590:
	mov	r4,	r4
	b	b1592
.ltorg
b1592:
	mov	r11,	#0
	b	b1593
.ltorg
b1593:
	mov	r11,	r11
	b	b1594
.ltorg
b1594:
	mov	r0,	#1
	b	b1596
.ltorg
b1596:
	mov	r0,	r0
	str	r0,	[sp,	#256]
	b	b1597
.ltorg
b1597:
	mov	r1,	#1
	b	b1599
.ltorg
b1599:
	mov	r1,	r1
	b	b1600
.ltorg
b1600:
	mov	r3,	#1
	b	b1602
.ltorg
b1602:
	mov	r3,	r3
	b	b1603
.ltorg
b1603:
	mov	r9,	#1
	b	b1605
.ltorg
b1605:
	mov	r9,	r9
	b	b1606
.ltorg
b1606:
	mov	r0,	#1
	b	b1608
.ltorg
b1608:
	mov	r0,	r0
	str	r0,	[sp,	#268]
	b	b1609
.ltorg
b1609:
	mov	r0,	#1
	b	b1611
.ltorg
b1611:
	mov	r0,	r0
	str	r0,	[sp,	#264]
	b	b1612
.ltorg
b1612:
	mov	r0,	#1
	b	b1614
.ltorg
b1614:
	mov	r0,	r0
	str	r0,	[sp,	#260]
	b	b1615
.ltorg
b1615:
	mov	r7,	#1
	b	b1617
.ltorg
b1617:
	mov	r7,	r7
	b	b1618
.ltorg
b1618:
	mov	r8,	#1
	b	b1620
.ltorg
b1620:
	mov	r8,	r8
	b	b1621
.ltorg
b1621:
	mov	r5,	#1
	b	b1623
.ltorg
b1623:
	mov	r5,	r5
	b	b1624
.ltorg
b1624:
	mov	r10,	#1
	b	b1626
.ltorg
b1626:
	mov	r10,	r10
	b	b1627
.ltorg
b1627:
	mov	r6,	#1
	b	b1629
.ltorg
b1629:
	mov	r6,	r6
	b	b1630
.ltorg
b1630:
	mov	r2,	#1
	b	b1632
.ltorg
b1632:
	mov	r2,	r2
	b	b1633
.ltorg
b1633:
	mov	r0,	#1
	b	b1635
.ltorg
b1635:
	mov	r0,	r0
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r2
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r6
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r10
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r5
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r8
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r7
	mov	r0,	r0, lsl #1
	ldr	r2,	[sp,	#260]
	add	r0,	r0,	r2
	mov	r0,	r0, lsl #1
	ldr	r2,	[sp,	#264]
	add	r0,	r0,	r2
	mov	r0,	r0, lsl #1
	ldr	r2,	[sp,	#268]
	add	r0,	r0,	r2
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r9
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r3
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r1
	mov	r0,	r0, lsl #1
	ldr	r1,	[sp,	#256]
	add	r0,	r0,	r1
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r11
	mov	r0,	r0, lsl #1
	add	r1,	r0,	r4
	mov	r0,	r1, asr #31
	ands	r7,	r1,	#1
	orrne	r7,	r7,	r0, lsl #1
	mov	r0,	#0
	cmp	r7,	r0
	mov	r7,	r7
	blt	b1636
	b	b1637
.ltorg
b1636:
	mov	r0,	#0
	sub	r7,	r0,	r7
	mov	r7,	r7
	b	b1637
.ltorg
b1637:
	mov	r7,	r7
	mov	r0,	r1, asr #31
	add	r0,	r1,	r0, lsr #31
	mov	r2,	r0, asr #1
	mov	r0,	r2, asr #31
	ands	r5,	r2,	#1
	orrne	r5,	r5,	r0, lsl #1
	mov	r0,	#0
	cmp	r5,	r0
	mov	r5,	r5
	blt	b1638
	b	b1639
.ltorg
b1638:
	mov	r0,	#0
	sub	r5,	r0,	r5
	mov	r5,	r5
	b	b1639
.ltorg
b1639:
	mov	r5,	r5
	mov	r0,	r1, asr #31
	add	r0,	r1,	r0, lsr #30
	mov	r2,	r0, asr #2
	mov	r0,	r2, asr #31
	ands	r4,	r2,	#1
	orrne	r4,	r4,	r0, lsl #1
	mov	r0,	#0
	cmp	r4,	r0
	mov	r4,	r4
	blt	b1640
	b	b1641
.ltorg
b1640:
	mov	r0,	#0
	sub	r4,	r0,	r4
	mov	r4,	r4
	b	b1641
.ltorg
b1641:
	mov	r4,	r4
	mov	r0,	r1, asr #31
	add	r0,	r1,	r0, lsr #29
	mov	r2,	r0, asr #3
	mov	r0,	r2, asr #31
	ands	r3,	r2,	#1
	orrne	r3,	r3,	r0, lsl #1
	mov	r0,	#0
	cmp	r3,	r0
	mov	r3,	r3
	blt	b1642
	b	b1643
.ltorg
b1642:
	mov	r0,	#0
	sub	r3,	r0,	r3
	mov	r3,	r3
	b	b1643
.ltorg
b1643:
	mov	r3,	r3
	mov	r0,	r1, asr #31
	add	r0,	r1,	r0, lsr #28
	mov	r0,	r0, asr #4
	mov	r2,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r2, lsl #1
	mov	r2,	#0
	cmp	r0,	r2
	mov	r0,	r0
	blt	b1644
	b	b1645
.ltorg
b1644:
	mov	r2,	#0
	sub	r0,	r2,	r0
	mov	r0,	r0
	b	b1645
.ltorg
b1645:
	mov	r0,	r0
	str	r0,	[sp,	#592]
	mov	r0,	r1, asr #31
	add	r0,	r1,	r0, lsr #27
	mov	r0,	r0, asr #5
	mov	r2,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r2, lsl #1
	mov	r2,	#0
	cmp	r0,	r2
	mov	r0,	r0
	blt	b1646
	b	b1647
.ltorg
b1646:
	mov	r2,	#0
	sub	r0,	r2,	r0
	mov	r0,	r0
	b	b1647
.ltorg
b1647:
	mov	r0,	r0
	str	r0,	[sp,	#568]
	mov	r0,	r1, asr #31
	add	r0,	r1,	r0, lsr #26
	mov	r0,	r0, asr #6
	mov	r2,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r2, lsl #1
	mov	r2,	#0
	cmp	r0,	r2
	mov	r0,	r0
	blt	b1648
	b	b1649
.ltorg
b1648:
	mov	r2,	#0
	sub	r0,	r2,	r0
	mov	r0,	r0
	b	b1649
.ltorg
b1649:
	mov	r0,	r0
	str	r0,	[sp,	#752]
	mov	r0,	r1, asr #31
	add	r0,	r1,	r0, lsr #25
	mov	r0,	r0, asr #7
	mov	r2,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r2, lsl #1
	mov	r2,	#0
	cmp	r0,	r2
	mov	r0,	r0
	blt	b1650
	b	b1651
.ltorg
b1650:
	mov	r2,	#0
	sub	r0,	r2,	r0
	mov	r0,	r0
	b	b1651
.ltorg
b1651:
	mov	r0,	r0
	str	r0,	[sp,	#760]
	mov	r0,	r1, asr #31
	add	r0,	r1,	r0, lsr #24
	mov	r0,	r0, asr #8
	mov	r2,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r2, lsl #1
	mov	r2,	#0
	cmp	r0,	r2
	mov	r0,	r0
	blt	b1652
	b	b1653
.ltorg
b1652:
	mov	r2,	#0
	sub	r0,	r2,	r0
	mov	r0,	r0
	b	b1653
.ltorg
b1653:
	mov	r0,	r0
	str	r0,	[sp,	#756]
	mov	r0,	r1, asr #31
	add	r0,	r1,	r0, lsr #23
	mov	r0,	r0, asr #9
	mov	r2,	r0, asr #31
	ands	r10,	r0,	#1
	orrne	r10,	r10,	r2, lsl #1
	mov	r0,	#0
	cmp	r10,	r0
	mov	r10,	r10
	blt	b1654
	b	b1655
.ltorg
b1654:
	mov	r0,	#0
	sub	r10,	r0,	r10
	mov	r10,	r10
	b	b1655
.ltorg
b1655:
	mov	r10,	r10
	mov	r0,	r1, asr #31
	add	r0,	r1,	r0, lsr #22
	mov	r0,	r0, asr #10
	mov	r2,	r0, asr #31
	ands	r9,	r0,	#1
	orrne	r9,	r9,	r2, lsl #1
	mov	r0,	#0
	cmp	r9,	r0
	mov	r9,	r9
	blt	b1656
	b	b1657
.ltorg
b1656:
	mov	r0,	#0
	sub	r9,	r0,	r9
	mov	r9,	r9
	b	b1657
.ltorg
b1657:
	mov	r9,	r9
	mov	r0,	r1, asr #31
	add	r0,	r1,	r0, lsr #21
	mov	r2,	r0, asr #11
	mov	r0,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r0, lsl #1
	mov	r0,	#0
	cmp	r2,	r0
	mov	r2,	r2
	blt	b1658
	b	b1659
.ltorg
b1658:
	mov	r0,	#0
	sub	r2,	r0,	r2
	mov	r2,	r2
	b	b1659
.ltorg
b1659:
	mov	r2,	r2
	mov	r0,	r1, asr #31
	add	r0,	r1,	r0, lsr #20
	mov	r0,	r0, asr #12
	mov	r6,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r6, lsl #1
	mov	r6,	#0
	cmp	r0,	r6
	mov	r0,	r0
	blt	b1660
	b	b1661
.ltorg
b1660:
	mov	r6,	#0
	sub	r0,	r6,	r0
	mov	r0,	r0
	b	b1661
.ltorg
b1661:
	mov	r0,	r0
	str	r0,	[sp,	#348]
	mov	r0,	r1, asr #31
	add	r0,	r1,	r0, lsr #19
	mov	r0,	r0, asr #13
	mov	r6,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r6, lsl #1
	mov	r6,	#0
	cmp	r0,	r6
	mov	r0,	r0
	blt	b1662
	b	b1663
.ltorg
b1662:
	mov	r6,	#0
	sub	r0,	r6,	r0
	mov	r0,	r0
	b	b1663
.ltorg
b1663:
	mov	r0,	r0
	str	r0,	[sp,	#448]
	mov	r0,	r1, asr #31
	add	r0,	r1,	r0, lsr #18
	mov	r0,	r0, asr #14
	mov	r6,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r6, lsl #1
	mov	r6,	#0
	cmp	r0,	r6
	mov	r0,	r0
	blt	b1664
	b	b1665
.ltorg
b1664:
	mov	r6,	#0
	sub	r0,	r6,	r0
	mov	r0,	r0
	b	b1665
.ltorg
b1665:
	mov	r0,	r0
	str	r0,	[sp,	#456]
	mov	r0,	r1, asr #31
	add	r0,	r1,	r0, lsr #17
	mov	r1,	r0, asr #15
	mov	r0,	r1, asr #31
	ands	r1,	r1,	#1
	orrne	r1,	r1,	r0, lsl #1
	mov	r0,	#0
	cmp	r1,	r0
	mov	r1,	r1
	blt	b1666
	b	b1667
.ltorg
b1666:
	mov	r0,	#0
	sub	r1,	r0,	r1
	mov	r1,	r1
	b	b1667
.ltorg
b1667:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1700
	b	b1703
.ltorg
b1700:
	mov	r6,	#1
	b	b1702
.ltorg
b1702:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1707
	b	b1705
.ltorg
b1705:
	mov	r0,	#0
	b	b1706
.ltorg
b1706:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r0,	r8
	moveq	r8,	#1
	movne	r8,	#0
	mov	r0,	#0
	cmp	r8,	r0
	bne	b1708
	b	b1709
.ltorg
b1708:
	mov	r0,	#1
	b	b1710
.ltorg
b1709:
	mov	r0,	#0
	b	b1710
.ltorg
b1710:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r6,	r8
	bne	b1714
	b	b1712
.ltorg
b1712:
	mov	r6,	#0
	b	b1713
.ltorg
b1713:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1715
	b	b1718
.ltorg
b1715:
	mov	r8,	#1
	b	b1717
.ltorg
b1717:
	mov	r8,	r8
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1722
	b	b1720
.ltorg
b1720:
	b	b1723
.ltorg
b1723:
	mov	r0,	#1
	b	b1725
.ltorg
b1725:
	mov	r0,	r0
	mov	r11,	#0
	cmp	r8,	r11
	bne	b1729
	b	b1727
.ltorg
b1727:
	mov	r0,	#0
	b	b1728
.ltorg
b1728:
	mov	r0,	r0
	str	r0,	[sp,	#36]
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1733
	b	b1731
.ltorg
b1731:
	mov	r0,	#0
	b	b1732
.ltorg
b1732:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r6,	r7
	bne	b1737
	b	b1735
.ltorg
b1735:
	mov	r6,	#0
	cmp	r0,	r6
	bne	b1738
	b	b1741
.ltorg
b1738:
	mov	r6,	#1
	b	b1740
.ltorg
b1740:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r5,	r0
	bne	b1742
	b	b1745
.ltorg
b1742:
	mov	r7,	#1
	b	b1744
.ltorg
b1744:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r5,	r0
	bne	b1749
	b	b1747
.ltorg
b1747:
	mov	r0,	#0
	b	b1748
.ltorg
b1748:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r0,	r8
	moveq	r8,	#1
	movne	r8,	#0
	mov	r0,	#0
	cmp	r8,	r0
	bne	b1750
	b	b1751
.ltorg
b1750:
	mov	r0,	#1
	b	b1752
.ltorg
b1751:
	mov	r0,	#0
	b	b1752
.ltorg
b1752:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r7,	r8
	bne	b1756
	b	b1754
.ltorg
b1754:
	mov	r7,	#0
	b	b1755
.ltorg
b1755:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1757
	b	b1760
.ltorg
b1757:
	mov	r8,	#1
	b	b1759
.ltorg
b1759:
	mov	r8,	r8
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1764
	b	b1762
.ltorg
b1764:
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1761
	b	b1762
.ltorg
b1761:
	mov	r0,	#1
	b	b1763
.ltorg
b1762:
	mov	r0,	#0
	b	b1763
.ltorg
b1763:
	mov	r0,	r0
	mov	r11,	#0
	cmp	r0,	r11
	moveq	r0,	#1
	movne	r0,	#0
	mov	r11,	#0
	cmp	r0,	r11
	bne	b1765
	b	b1766
.ltorg
b1767:
	mov	r0,	r0
	mov	r11,	#0
	cmp	r8,	r11
	bne	b1771
	b	b1769
.ltorg
b1769:
	mov	r0,	#0
	b	b1770
.ltorg
b1770:
	mov	r0,	r0
	str	r0,	[sp,	#32]
	mov	r0,	#0
	cmp	r5,	r0
	bne	b1775
	b	b1773
.ltorg
b1775:
	b	b1773
.ltorg
b1773:
	mov	r5,	#0
	b	b1774
.ltorg
b1774:
	mov	r5,	r5
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1779
	b	b1777
.ltorg
b1778:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r5,	r6
	bne	b1780
	b	b1783
.ltorg
b1782:
	mov	r5,	r5
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1784
	b	b1787
.ltorg
b1784:
	mov	r6,	#1
	b	b1786
.ltorg
b1786:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1791
	b	b1789
.ltorg
b1789:
	mov	r0,	#0
	b	b1790
.ltorg
b1790:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r0,	r7
	moveq	r7,	#1
	movne	r7,	#0
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1792
	b	b1793
.ltorg
b1792:
	mov	r0,	#1
	b	b1794
.ltorg
b1793:
	mov	r0,	#0
	b	b1794
.ltorg
b1794:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r6,	r7
	bne	b1798
	b	b1796
.ltorg
b1796:
	mov	r6,	#0
	b	b1797
.ltorg
b1797:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1799
	b	b1802
.ltorg
b1799:
	mov	r7,	#1
	b	b1801
.ltorg
b1801:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1806
	b	b1804
.ltorg
b1804:
	mov	r0,	#0
	b	b1805
.ltorg
b1805:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r0,	r8
	moveq	r8,	#1
	movne	r8,	#0
	mov	r0,	#0
	cmp	r8,	r0
	bne	b1807
	b	b1808
.ltorg
b1807:
	mov	r0,	#1
	b	b1809
.ltorg
b1808:
	mov	r0,	#0
	b	b1809
.ltorg
b1809:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r7,	r8
	bne	b1813
	b	b1811
.ltorg
b1811:
	mov	r0,	#0
	b	b1812
.ltorg
b1812:
	mov	r0,	r0
	str	r0,	[sp,	#48]
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1817
	b	b1815
.ltorg
b1815:
	mov	r4,	#0
	b	b1816
.ltorg
b1816:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1821
	b	b1819
.ltorg
b1819:
	mov	r0,	#0
	b	b1820
.ltorg
b1820:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r4,	r5
	bne	b1822
	b	b1825
.ltorg
b1822:
	mov	r4,	#1
	b	b1824
.ltorg
b1824:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r3,	r0
	bne	b1826
	b	b1829
.ltorg
b1826:
	mov	r5,	#1
	b	b1828
.ltorg
b1828:
	mov	r5,	r5
	mov	r0,	#0
	cmp	r3,	r0
	bne	b1833
	b	b1831
.ltorg
b1831:
	mov	r0,	#0
	b	b1832
.ltorg
b1832:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r0,	r6
	moveq	r0,	#1
	movne	r0,	#0
	mov	r6,	#0
	cmp	r0,	r6
	bne	b1834
	b	b1835
.ltorg
b1834:
	mov	r0,	#1
	b	b1836
.ltorg
b1835:
	mov	r0,	#0
	b	b1836
.ltorg
b1836:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r5,	r6
	bne	b1840
	b	b1838
.ltorg
b1838:
	mov	r5,	#0
	b	b1839
.ltorg
b1839:
	mov	r5,	r5
	mov	r0,	#0
	cmp	r5,	r0
	bne	b1841
	b	b1844
.ltorg
b1841:
	mov	r6,	#1
	b	b1843
.ltorg
b1843:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r5,	r0
	bne	b1848
	b	b1846
.ltorg
b1846:
	mov	r0,	#0
	b	b1847
.ltorg
b1847:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r0,	r7
	moveq	r0,	#1
	movne	r0,	#0
	mov	r7,	#0
	cmp	r0,	r7
	bne	b1849
	b	b1850
.ltorg
b1849:
	mov	r0,	#1
	b	b1851
.ltorg
b1850:
	mov	r0,	#0
	b	b1851
.ltorg
b1851:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r6,	r7
	bne	b1855
	b	b1853
.ltorg
b1853:
	mov	r0,	#0
	b	b1854
.ltorg
b1854:
	mov	r0,	r0
	str	r0,	[sp,	#44]
	mov	r0,	#0
	cmp	r3,	r0
	bne	b1859
	b	b1857
.ltorg
b1857:
	mov	r3,	#0
	b	b1858
.ltorg
b1858:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r5,	r0
	bne	b1863
	b	b1861
.ltorg
b1861:
	mov	r0,	#0
	b	b1862
.ltorg
b1862:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r3,	r4
	bne	b1864
	b	b1867
.ltorg
b1864:
	mov	r4,	#1
	b	b1866
.ltorg
b1866:
	mov	r4,	r4
	mov	r3,	#0
	ldr	r0,	[sp,	#592]
	cmp	r0,	r3
	bne	b1868
	b	b1871
.ltorg
b1868:
	mov	r3,	#1
	b	b1870
.ltorg
b1870:
	mov	r3,	r3
	mov	r5,	#0
	ldr	r0,	[sp,	#592]
	cmp	r0,	r5
	bne	b1875
	b	b1873
.ltorg
b1873:
	mov	r0,	#0
	b	b1874
.ltorg
b1874:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r0,	r5
	moveq	r0,	#1
	movne	r0,	#0
	mov	r5,	#0
	cmp	r0,	r5
	bne	b1876
	b	b1877
.ltorg
b1876:
	mov	r0,	#1
	b	b1878
.ltorg
b1877:
	mov	r0,	#0
	b	b1878
.ltorg
b1878:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r3,	r5
	bne	b1882
	b	b1880
.ltorg
b1880:
	mov	r5,	#0
	b	b1881
.ltorg
b1881:
	mov	r5,	r5
	mov	r0,	#0
	cmp	r5,	r0
	bne	b1883
	b	b1886
.ltorg
b1883:
	mov	r3,	#1
	b	b1885
.ltorg
b1885:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r5,	r0
	bne	b1890
	b	b1888
.ltorg
b1888:
	mov	r0,	#0
	b	b1889
.ltorg
b1889:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r0,	r6
	moveq	r0,	#1
	movne	r0,	#0
	mov	r6,	#0
	cmp	r0,	r6
	bne	b1891
	b	b1892
.ltorg
b1891:
	mov	r0,	#1
	b	b1893
.ltorg
b1892:
	mov	r0,	#0
	b	b1893
.ltorg
b1893:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r3,	r6
	bne	b1897
	b	b1895
.ltorg
b1895:
	mov	r0,	#0
	b	b1896
.ltorg
b1896:
	mov	r0,	r0
	str	r0,	[sp,	#40]
	mov	r3,	#0
	ldr	r0,	[sp,	#592]
	cmp	r0,	r3
	bne	b1901
	b	b1899
.ltorg
b1899:
	mov	r3,	#0
	b	b1900
.ltorg
b1900:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r5,	r0
	bne	b1905
	b	b1903
.ltorg
b1905:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1902
	b	b1903
.ltorg
b1902:
	mov	r0,	#1
	b	b1904
.ltorg
b1903:
	mov	r0,	#0
	b	b1904
.ltorg
b1904:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r3,	r4
	bne	b1906
	b	b1909
.ltorg
b1909:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b1906
	b	b1907
.ltorg
b1907:
	mov	r5,	#0
	b	b1908
.ltorg
b1906:
	mov	r5,	#1
	b	b1908
.ltorg
b1908:
	mov	r5,	r5
	mov	r3,	#0
	ldr	r0,	[sp,	#568]
	cmp	r0,	r3
	bne	b1910
	b	b1913
.ltorg
b1912:
	mov	r3,	r3
	mov	r4,	#0
	ldr	r0,	[sp,	#568]
	cmp	r0,	r4
	bne	b1917
	b	b1915
.ltorg
b1915:
	mov	r0,	#0
	b	b1916
.ltorg
b1916:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r0,	#1
	movne	r0,	#0
	mov	r4,	#0
	cmp	r0,	r4
	bne	b1918
	b	b1919
.ltorg
b1918:
	mov	r0,	#1
	b	b1920
.ltorg
b1919:
	mov	r0,	#0
	b	b1920
.ltorg
b1920:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r3,	r4
	bne	b1924
	b	b1922
.ltorg
b1922:
	mov	r4,	#0
	b	b1923
.ltorg
b1923:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1925
	b	b1928
.ltorg
b1925:
	mov	r3,	#1
	b	b1927
.ltorg
b1927:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1932
	b	b1930
.ltorg
b1930:
	mov	r0,	#0
	b	b1931
.ltorg
b1931:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r0,	r6
	moveq	r0,	#1
	movne	r0,	#0
	mov	r6,	#0
	cmp	r0,	r6
	bne	b1933
	b	b1934
.ltorg
b1933:
	mov	r0,	#1
	b	b1935
.ltorg
b1934:
	mov	r0,	#0
	b	b1935
.ltorg
b1935:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r3,	r6
	bne	b1939
	b	b1937
.ltorg
b1937:
	mov	r6,	#0
	b	b1938
.ltorg
b1938:
	mov	r6,	r6
	mov	r3,	#0
	ldr	r0,	[sp,	#568]
	cmp	r0,	r3
	bne	b1943
	b	b1941
.ltorg
b1941:
	mov	r3,	#0
	b	b1942
.ltorg
b1942:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1947
	b	b1945
.ltorg
b1945:
	mov	r0,	#0
	b	b1946
.ltorg
b1946:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r3,	r4
	bne	b1948
	b	b1951
.ltorg
b1948:
	mov	r4,	#1
	b	b1950
.ltorg
b1950:
	mov	r4,	r4
	mov	r3,	#0
	ldr	r0,	[sp,	#752]
	cmp	r0,	r3
	bne	b1952
	b	b1955
.ltorg
b1952:
	mov	r3,	#1
	b	b1954
.ltorg
b1954:
	mov	r3,	r3
	mov	r5,	#0
	ldr	r0,	[sp,	#752]
	cmp	r0,	r5
	bne	b1959
	b	b1957
.ltorg
b1957:
	mov	r0,	#0
	b	b1958
.ltorg
b1958:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r0,	r5
	moveq	r0,	#1
	movne	r0,	#0
	mov	r5,	#0
	cmp	r0,	r5
	bne	b1960
	b	b1961
.ltorg
b1960:
	mov	r0,	#1
	b	b1962
.ltorg
b1961:
	mov	r0,	#0
	b	b1962
.ltorg
b1962:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r3,	r5
	bne	b1966
	b	b1964
.ltorg
b1964:
	mov	r7,	#0
	b	b1965
.ltorg
b1965:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1967
	b	b1970
.ltorg
b1967:
	mov	r3,	#1
	b	b1969
.ltorg
b1969:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1974
	b	b1972
.ltorg
b1972:
	mov	r0,	#0
	b	b1973
.ltorg
b1973:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r0,	r5
	moveq	r0,	#1
	movne	r0,	#0
	mov	r5,	#0
	cmp	r0,	r5
	bne	b1975
	b	b1976
.ltorg
b1975:
	mov	r0,	#1
	b	b1977
.ltorg
b1976:
	mov	r0,	#0
	b	b1977
.ltorg
b1977:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r3,	r5
	bne	b1981
	b	b1979
.ltorg
b1979:
	mov	r5,	#0
	b	b1980
.ltorg
b1980:
	mov	r5,	r5
	mov	r3,	#0
	ldr	r0,	[sp,	#752]
	cmp	r0,	r3
	bne	b1985
	b	b1983
.ltorg
b1983:
	mov	r3,	#0
	b	b1984
.ltorg
b1984:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r7,	r0
	bne	b1989
	b	b1987
.ltorg
b1987:
	mov	r0,	#0
	b	b1988
.ltorg
b1988:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r3,	r4
	bne	b1990
	b	b1993
.ltorg
b1990:
	mov	r7,	#1
	b	b1992
.ltorg
b1992:
	mov	r7,	r7
	mov	r3,	#0
	ldr	r0,	[sp,	#760]
	cmp	r0,	r3
	bne	b1994
	b	b1997
.ltorg
b1994:
	mov	r3,	#1
	b	b1996
.ltorg
b1996:
	mov	r3,	r3
	mov	r4,	#0
	ldr	r0,	[sp,	#760]
	cmp	r0,	r4
	bne	b2001
	b	b1999
.ltorg
b1999:
	mov	r0,	#0
	b	b2000
.ltorg
b2000:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r0,	#1
	movne	r0,	#0
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2002
	b	b2003
.ltorg
b2002:
	mov	r0,	#1
	b	b2004
.ltorg
b2003:
	mov	r0,	#0
	b	b2004
.ltorg
b2004:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r3,	r4
	bne	b2008
	b	b2006
.ltorg
b2006:
	mov	r0,	#0
	b	b2007
.ltorg
b2007:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r0,	r3
	bne	b2009
	b	b2012
.ltorg
b2009:
	mov	r4,	#1
	b	b2011
.ltorg
b2011:
	mov	r4,	r4
	mov	r3,	#0
	cmp	r0,	r3
	bne	b2016
	b	b2014
.ltorg
b2014:
	mov	r3,	#0
	b	b2015
.ltorg
b2015:
	mov	r3,	r3
	mov	r8,	#0
	cmp	r3,	r8
	moveq	r3,	#1
	movne	r3,	#0
	mov	r8,	#0
	cmp	r3,	r8
	bne	b2017
	b	b2018
.ltorg
b2017:
	mov	r3,	#1
	b	b2019
.ltorg
b2018:
	mov	r3,	#0
	b	b2019
.ltorg
b2019:
	mov	r3,	r3
	mov	r8,	#0
	cmp	r4,	r8
	bne	b2023
	b	b2021
.ltorg
b2021:
	mov	r3,	#0
	b	b2022
.ltorg
b2022:
	mov	r3,	r3
	mov	r8,	#0
	ldr	r4,	[sp,	#760]
	cmp	r4,	r8
	bne	b2027
	b	b2025
.ltorg
b2025:
	mov	r4,	#0
	b	b2026
.ltorg
b2026:
	mov	r4,	r4
	mov	r8,	#0
	cmp	r0,	r8
	bne	b2031
	b	b2029
.ltorg
b2029:
	mov	r0,	#0
	b	b2030
.ltorg
b2030:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r4,	r7
	bne	b2032
	b	b2035
.ltorg
b2032:
	mov	r7,	#1
	b	b2034
.ltorg
b2034:
	mov	r7,	r7
	mov	r4,	#0
	ldr	r0,	[sp,	#756]
	cmp	r0,	r4
	bne	b2036
	b	b2039
.ltorg
b2038:
	mov	r4,	r4
	mov	r8,	#0
	ldr	r0,	[sp,	#756]
	cmp	r0,	r8
	bne	b2043
	b	b2041
.ltorg
b2041:
	mov	r0,	#0
	b	b2042
.ltorg
b2042:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r0,	r8
	moveq	r0,	#1
	movne	r0,	#0
	mov	r8,	#0
	cmp	r0,	r8
	bne	b2044
	b	b2045
.ltorg
b2044:
	mov	r0,	#1
	b	b2046
.ltorg
b2045:
	mov	r0,	#0
	b	b2046
.ltorg
b2046:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r4,	r8
	bne	b2050
	b	b2048
.ltorg
b2049:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2051
	b	b2054
.ltorg
b2053:
	mov	r8,	r8
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2058
	b	b2056
.ltorg
b2056:
	mov	r4,	#0
	b	b2057
.ltorg
b2057:
	mov	r4,	r4
	mov	r11,	#0
	cmp	r4,	r11
	moveq	r4,	#1
	movne	r4,	#0
	mov	r11,	#0
	cmp	r4,	r11
	bne	b2059
	b	b2060
.ltorg
b2059:
	mov	r4,	#1
	b	b2061
.ltorg
b2060:
	mov	r4,	#0
	b	b2061
.ltorg
b2061:
	mov	r4,	r4
	mov	r11,	#0
	cmp	r8,	r11
	bne	b2065
	b	b2063
.ltorg
b2063:
	mov	r8,	#0
	b	b2064
.ltorg
b2064:
	mov	r8,	r8
	mov	r11,	#0
	ldr	r4,	[sp,	#756]
	cmp	r4,	r11
	bne	b2069
	b	b2067
.ltorg
b2067:
	mov	r4,	#0
	b	b2068
.ltorg
b2068:
	mov	r4,	r4
	mov	r11,	#0
	cmp	r0,	r11
	bne	b2073
	b	b2071
.ltorg
b2071:
	mov	r0,	#0
	b	b2072
.ltorg
b2072:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r4,	r7
	bne	b2074
	b	b2077
.ltorg
b2074:
	mov	r0,	#1
	b	b2076
.ltorg
b2076:
	mov	r0,	r0
	str	r0,	[sp,	#508]
	mov	r0,	#0
	cmp	r10,	r0
	bne	b2078
	b	b2081
.ltorg
b2078:
	mov	r4,	#1
	b	b2080
.ltorg
b2080:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r10,	r0
	bne	b2085
	b	b2083
.ltorg
b2083:
	mov	r0,	#0
	b	b2084
.ltorg
b2084:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r0,	r7
	moveq	r0,	#1
	movne	r0,	#0
	mov	r7,	#0
	cmp	r0,	r7
	bne	b2086
	b	b2087
.ltorg
b2086:
	mov	r0,	#1
	b	b2088
.ltorg
b2087:
	mov	r0,	#0
	b	b2088
.ltorg
b2088:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r4,	r7
	bne	b2092
	b	b2090
.ltorg
b2090:
	mov	r0,	#0
	b	b2091
.ltorg
b2091:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2093
	b	b2096
.ltorg
b2093:
	mov	r7,	#1
	b	b2095
.ltorg
b2095:
	mov	r7,	r7
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2100
	b	b2098
.ltorg
b2098:
	mov	r4,	#0
	b	b2099
.ltorg
b2099:
	mov	r4,	r4
	mov	r11,	#0
	cmp	r4,	r11
	moveq	r11,	#1
	movne	r11,	#0
	mov	r4,	#0
	cmp	r11,	r4
	bne	b2101
	b	b2102
.ltorg
b2101:
	mov	r4,	#1
	b	b2103
.ltorg
b2102:
	mov	r4,	#0
	b	b2103
.ltorg
b2103:
	mov	r4,	r4
	mov	r11,	#0
	cmp	r7,	r11
	bne	b2107
	b	b2105
.ltorg
b2105:
	mov	r7,	#0
	b	b2106
.ltorg
b2106:
	mov	r7,	r7
	mov	r4,	#0
	cmp	r10,	r4
	bne	b2111
	b	b2109
.ltorg
b2109:
	mov	r4,	#0
	b	b2110
.ltorg
b2110:
	mov	r4,	r4
	mov	r10,	#0
	cmp	r0,	r10
	bne	b2115
	b	b2113
.ltorg
b2113:
	mov	r0,	#0
	b	b2114
.ltorg
b2114:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r4,	r10
	bne	b2116
	b	b2119
.ltorg
b2116:
	mov	r0,	#1
	b	b2118
.ltorg
b2118:
	mov	r0,	r0
	str	r0,	[sp,	#524]
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2120
	b	b2123
.ltorg
b2120:
	mov	r4,	#1
	b	b2122
.ltorg
b2122:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2127
	b	b2125
.ltorg
b2125:
	mov	r0,	#0
	b	b2126
.ltorg
b2126:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r10,	#1
	movne	r10,	#0
	mov	r0,	#0
	cmp	r10,	r0
	bne	b2128
	b	b2129
.ltorg
b2128:
	mov	r0,	#1
	b	b2130
.ltorg
b2129:
	mov	r0,	#0
	b	b2130
.ltorg
b2130:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r4,	r10
	bne	b2134
	b	b2132
.ltorg
b2132:
	mov	r0,	#0
	b	b2133
.ltorg
b2133:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2135
	b	b2138
.ltorg
b2135:
	mov	r10,	#1
	b	b2137
.ltorg
b2137:
	mov	r10,	r10
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2142
	b	b2140
.ltorg
b2140:
	mov	r4,	#0
	b	b2141
.ltorg
b2141:
	mov	r4,	r4
	mov	r11,	#0
	cmp	r4,	r11
	moveq	r4,	#1
	movne	r4,	#0
	mov	r11,	#0
	cmp	r4,	r11
	bne	b2143
	b	b2144
.ltorg
b2143:
	mov	r4,	#1
	b	b2145
.ltorg
b2144:
	mov	r4,	#0
	b	b2145
.ltorg
b2145:
	mov	r4,	r4
	mov	r11,	#0
	cmp	r10,	r11
	bne	b2149
	b	b2147
.ltorg
b2147:
	mov	r4,	#0
	b	b2148
.ltorg
b2148:
	mov	r4,	r4
	mov	r10,	#0
	cmp	r9,	r10
	bne	b2153
	b	b2151
.ltorg
b2151:
	mov	r9,	#0
	b	b2152
.ltorg
b2152:
	mov	r9,	r9
	mov	r10,	#0
	cmp	r0,	r10
	bne	b2157
	b	b2155
.ltorg
b2155:
	mov	r0,	#0
	b	b2156
.ltorg
b2156:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r9,	r10
	bne	b2158
	b	b2161
.ltorg
b2158:
	mov	r0,	#1
	b	b2160
.ltorg
b2160:
	mov	r0,	r0
	str	r0,	[sp,	#532]
	mov	r0,	#0
	cmp	r2,	r0
	bne	b2162
	b	b2165
.ltorg
b2165:
	b	b2163
.ltorg
b2163:
	mov	r9,	#0
	b	b2164
.ltorg
b2162:
	mov	r9,	#1
	b	b2164
.ltorg
b2164:
	mov	r9,	r9
	mov	r0,	#0
	cmp	r2,	r0
	bne	b2169
	b	b2167
.ltorg
b2169:
	b	b2167
.ltorg
b2167:
	mov	r0,	#0
	b	b2168
.ltorg
b2168:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r0,	#1
	movne	r0,	#0
	mov	r10,	#0
	cmp	r0,	r10
	bne	b2170
	b	b2171
.ltorg
b2171:
	mov	r0,	#0
	b	b2172
.ltorg
b2172:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r9,	r10
	bne	b2176
	b	b2174
.ltorg
b2176:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b2173
	b	b2174
.ltorg
b2173:
	mov	r9,	#1
	b	b2175
.ltorg
b2174:
	mov	r9,	#0
	b	b2175
.ltorg
b2175:
	mov	r9,	r9
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2177
	b	b2180
.ltorg
b2179:
	mov	r10,	r10
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2184
	b	b2182
.ltorg
b2182:
	mov	r0,	#0
	b	b2183
.ltorg
b2183:
	mov	r0,	r0
	mov	r11,	#0
	cmp	r0,	r11
	moveq	r11,	#1
	movne	r11,	#0
	mov	r0,	#0
	cmp	r11,	r0
	bne	b2185
	b	b2186
.ltorg
b2185:
	mov	r0,	#1
	b	b2187
.ltorg
b2186:
	mov	r0,	#0
	b	b2187
.ltorg
b2187:
	mov	r0,	r0
	mov	r11,	#0
	cmp	r10,	r11
	bne	b2191
	b	b2189
.ltorg
b2190:
	mov	r0,	r0
	str	r0,	[sp,	#3536]
	mov	r0,	#0
	cmp	r2,	r0
	bne	b2195
	b	b2193
.ltorg
b2193:
	mov	r2,	#0
	b	b2194
.ltorg
b2194:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2199
	b	b2197
.ltorg
b2197:
	mov	r0,	#0
	b	b2198
.ltorg
b2198:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r2,	r9
	bne	b2200
	b	b2203
.ltorg
b2200:
	mov	r0,	#1
	b	b2202
.ltorg
b2202:
	mov	r0,	r0
	str	r0,	[sp,	#868]
	mov	r2,	#0
	ldr	r0,	[sp,	#348]
	cmp	r0,	r2
	bne	b2204
	b	b2207
.ltorg
b2204:
	mov	r2,	#1
	b	b2206
.ltorg
b2206:
	mov	r2,	r2
	mov	r9,	#0
	ldr	r0,	[sp,	#348]
	cmp	r0,	r9
	bne	b2211
	b	b2209
.ltorg
b2209:
	mov	r0,	#0
	b	b2210
.ltorg
b2210:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r9,	#1
	movne	r9,	#0
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2212
	b	b2213
.ltorg
b2212:
	mov	r0,	#1
	b	b2214
.ltorg
b2213:
	mov	r0,	#0
	b	b2214
.ltorg
b2214:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r2,	r9
	bne	b2218
	b	b2216
.ltorg
b2216:
	mov	r9,	#0
	b	b2217
.ltorg
b2217:
	mov	r9,	r9
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2219
	b	b2222
.ltorg
b2219:
	mov	r2,	#1
	b	b2221
.ltorg
b2221:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2226
	b	b2224
.ltorg
b2224:
	mov	r0,	#0
	b	b2225
.ltorg
b2225:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r0,	#1
	movne	r0,	#0
	mov	r10,	#0
	cmp	r0,	r10
	bne	b2227
	b	b2228
.ltorg
b2227:
	mov	r0,	#1
	b	b2229
.ltorg
b2228:
	mov	r0,	#0
	b	b2229
.ltorg
b2229:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r2,	r10
	bne	b2233
	b	b2231
.ltorg
b2231:
	mov	r0,	#0
	b	b2232
.ltorg
b2232:
	mov	r0,	r0
	str	r0,	[sp,	#28]
	mov	r2,	#0
	ldr	r0,	[sp,	#348]
	cmp	r0,	r2
	bne	b2237
	b	b2235
.ltorg
b2235:
	mov	r2,	#0
	b	b2236
.ltorg
b2236:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2241
	b	b2239
.ltorg
b2239:
	mov	r0,	#0
	b	b2240
.ltorg
b2240:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r2,	r9
	bne	b2242
	b	b2245
.ltorg
b2242:
	mov	r0,	#1
	b	b2244
.ltorg
b2244:
	mov	r0,	r0
	str	r0,	[sp,	#888]
	mov	r2,	#0
	ldr	r0,	[sp,	#448]
	cmp	r0,	r2
	bne	b2246
	b	b2249
.ltorg
b2246:
	mov	r2,	#1
	b	b2248
.ltorg
b2248:
	mov	r2,	r2
	mov	r9,	#0
	ldr	r0,	[sp,	#448]
	cmp	r0,	r9
	bne	b2253
	b	b2251
.ltorg
b2251:
	mov	r0,	#0
	b	b2252
.ltorg
b2252:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r0,	#1
	movne	r0,	#0
	mov	r9,	#0
	cmp	r0,	r9
	bne	b2254
	b	b2255
.ltorg
b2254:
	mov	r0,	#1
	b	b2256
.ltorg
b2255:
	mov	r0,	#0
	b	b2256
.ltorg
b2256:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r2,	r9
	bne	b2260
	b	b2258
.ltorg
b2258:
	mov	r9,	#0
	b	b2259
.ltorg
b2259:
	mov	r9,	r9
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2261
	b	b2264
.ltorg
b2261:
	mov	r2,	#1
	b	b2263
.ltorg
b2263:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2268
	b	b2266
.ltorg
b2266:
	mov	r0,	#0
	b	b2267
.ltorg
b2267:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r0,	#1
	movne	r0,	#0
	mov	r10,	#0
	cmp	r0,	r10
	bne	b2269
	b	b2270
.ltorg
b2269:
	mov	r0,	#1
	b	b2271
.ltorg
b2270:
	mov	r0,	#0
	b	b2271
.ltorg
b2271:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r2,	r10
	bne	b2275
	b	b2273
.ltorg
b2273:
	mov	r0,	#0
	b	b2274
.ltorg
b2274:
	mov	r0,	r0
	str	r0,	[sp,	#24]
	mov	r2,	#0
	ldr	r0,	[sp,	#448]
	cmp	r0,	r2
	bne	b2279
	b	b2277
.ltorg
b2277:
	mov	r2,	#0
	b	b2278
.ltorg
b2278:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2283
	b	b2281
.ltorg
b2281:
	mov	r0,	#0
	b	b2282
.ltorg
b2282:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r2,	r9
	bne	b2284
	b	b2287
.ltorg
b2284:
	mov	r10,	#1
	b	b2286
.ltorg
b2286:
	mov	r10,	r10
	mov	r2,	#0
	ldr	r0,	[sp,	#456]
	cmp	r0,	r2
	bne	b2288
	b	b2291
.ltorg
b2288:
	mov	r2,	#1
	b	b2290
.ltorg
b2290:
	mov	r2,	r2
	mov	r9,	#0
	ldr	r0,	[sp,	#456]
	cmp	r0,	r9
	bne	b2295
	b	b2293
.ltorg
b2295:
	b	b2293
.ltorg
b2293:
	mov	r0,	#0
	b	b2294
.ltorg
b2294:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r9,	#1
	movne	r9,	#0
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2296
	b	b2297
.ltorg
b2298:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r2,	r9
	bne	b2302
	b	b2300
.ltorg
b2300:
	mov	r9,	#0
	b	b2301
.ltorg
b2301:
	mov	r9,	r9
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2303
	b	b2306
.ltorg
b2306:
	mov	r0,	#0
	cmp	r10,	r0
	bne	b2303
	b	b2304
.ltorg
b2304:
	mov	r2,	#0
	b	b2305
.ltorg
b2303:
	mov	r2,	#1
	b	b2305
.ltorg
b2305:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2310
	b	b2308
.ltorg
b2309:
	mov	r0,	r0
	str	r0,	[sp]
	mov	r0,	#0
	ldr	r11,	[sp]
	str	r11,	[sp,	#2784]
	ldr	r11,	[sp,	#2784]
	str	r11,	[sp,	#2016]
	ldr	r11,	[sp,	#2016]
	str	r11,	[sp,	#2788]
	ldr	r11,	[sp,	#2788]
	str	r11,	[sp,	#2004]
	ldr	r11,	[sp,	#2004]
	str	r11,	[sp,	#2776]
	ldr	r11,	[sp,	#2776]
	str	r11,	[sp,	#2024]
	ldr	r11,	[sp,	#2024]
	str	r11,	[sp,	#2780]
	ldr	r11,	[sp,	#2780]
	str	r11,	[sp,	#1336]
	ldr	r11,	[sp,	#1336]
	str	r11,	[sp,	#3000]
	ldr	r11,	[sp,	#3000]
	str	r11,	[sp,	#2064]
	ldr	r11,	[sp,	#2064]
	str	r11,	[sp,	#2988]
	ldr	r11,	[sp,	#2988]
	str	r11,	[sp,	#2000]
	ldr	r11,	[sp,	#2000]
	str	r11,	[sp,	#2992]
	ldr	r11,	[sp,	#2992]
	str	r11,	[sp,	#2068]
	ldr	r11,	[sp,	#2068]
	str	r11,	[sp,	#2980]
	ldr	r11,	[sp,	#2980]
	str	r11,	[sp,	#936]
	ldr	r11,	[sp,	#936]
	str	r11,	[sp,	#2928]
	ldr	r11,	[sp,	#2928]
	str	r11,	[sp,	#2080]
	ldr	r11,	[sp,	#2080]
	str	r11,	[sp,	#2932]
	ldr	r11,	[sp,	#2932]
	str	r11,	[sp,	#1972]
	ldr	r11,	[sp,	#1972]
	str	r11,	[sp,	#2984]
	ldr	r11,	[sp,	#2984]
	str	r11,	[sp,	#2072]
	ldr	r11,	[sp,	#2072]
	str	r11,	[sp,	#2972]
	ldr	r11,	[sp,	#2972]
	str	r11,	[sp,	#1332]
	ldr	r11,	[sp,	#1332]
	str	r11,	[sp,	#2768]
	ldr	r11,	[sp,	#2768]
	str	r11,	[sp,	#2028]
	ldr	r11,	[sp,	#2028]
	str	r11,	[sp,	#2772]
	ldr	r11,	[sp,	#2772]
	str	r11,	[sp,	#2008]
	ldr	r11,	[sp,	#2008]
	str	r11,	[sp,	#2744]
	ldr	r11,	[sp,	#2744]
	str	r11,	[sp,	#2020]
	ldr	r11,	[sp,	#2020]
	str	r11,	[sp,	#2748]
	ldr	r11,	[sp,	#2748]
	cmp	r11,	r0
	moveq	r0,	#1
	movne	r0,	#0
	mov	r11,	#0
	str	r11,	[sp,	#2592]
	ldr	r11,	[sp,	#2592]
	str	r11,	[sp,	#2428]
	ldr	r11,	[sp,	#2428]
	str	r11,	[sp,	#2596]
	ldr	r11,	[sp,	#2596]
	str	r11,	[sp,	#1672]
	ldr	r11,	[sp,	#1672]
	str	r11,	[sp,	#2616]
	ldr	r11,	[sp,	#2616]
	str	r11,	[sp,	#2416]
	ldr	r11,	[sp,	#2416]
	str	r11,	[sp,	#2620]
	ldr	r11,	[sp,	#2620]
	str	r11,	[sp,	#1424]
	ldr	r11,	[sp,	#1424]
	str	r11,	[sp,	#2644]
	ldr	r11,	[sp,	#2644]
	str	r11,	[sp,	#2400]
	ldr	r11,	[sp,	#2400]
	str	r11,	[sp,	#2632]
	ldr	r11,	[sp,	#2632]
	str	r11,	[sp,	#1668]
	ldr	r11,	[sp,	#1668]
	str	r11,	[sp,	#2600]
	ldr	r11,	[sp,	#2600]
	str	r11,	[sp,	#2424]
	ldr	r11,	[sp,	#2424]
	str	r11,	[sp,	#2604]
	ldr	r11,	[sp,	#2604]
	str	r11,	[sp,	#932]
	ldr	r11,	[sp,	#932]
	str	r11,	[sp,	#2664]
	ldr	r11,	[sp,	#2664]
	str	r11,	[sp,	#2384]
	ldr	r11,	[sp,	#2384]
	str	r11,	[sp,	#2668]
	ldr	r11,	[sp,	#2668]
	str	r11,	[sp,	#1696]
	ldr	r11,	[sp,	#1696]
	str	r11,	[sp,	#2696]
	ldr	r11,	[sp,	#2696]
	str	r11,	[sp,	#2388]
	ldr	r11,	[sp,	#2388]
	str	r11,	[sp,	#2700]
	ldr	r11,	[sp,	#2700]
	str	r11,	[sp,	#1420]
	ldr	r11,	[sp,	#1420]
	str	r11,	[sp,	#2552]
	ldr	r11,	[sp,	#2552]
	str	r11,	[sp,	#2296]
	ldr	r11,	[sp,	#2296]
	str	r11,	[sp,	#2556]
	ldr	r11,	[sp,	#2556]
	str	r11,	[sp,	#1728]
	ldr	r11,	[sp,	#1728]
	str	r11,	[sp,	#2584]
	ldr	r11,	[sp,	#2584]
	str	r11,	[sp,	#2300]
	ldr	r11,	[sp,	#2300]
	str	r11,	[sp,	#2588]
	ldr	r11,	[sp,	#2588]
	str	r11,	[sp,	#4]
	ldr	r11,	[sp,	#4]
	str	r11,	[sp,	#2660]
	ldr	r11,	[sp,	#2660]
	str	r11,	[sp,	#2412]
	ldr	r11,	[sp,	#2412]
	str	r11,	[sp,	#2652]
	ldr	r11,	[sp,	#2652]
	str	r11,	[sp,	#1680]
	ldr	r11,	[sp,	#1680]
	str	r11,	[sp,	#2636]
	ldr	r11,	[sp,	#2636]
	str	r11,	[sp,	#2404]
	ldr	r11,	[sp,	#2404]
	str	r11,	[sp,	#2624]
	ldr	r11,	[sp,	#2624]
	str	r11,	[sp,	#1432]
	ldr	r11,	[sp,	#1432]
	str	r11,	[sp,	#2608]
	ldr	r11,	[sp,	#2608]
	str	r11,	[sp,	#2420]
	ldr	r11,	[sp,	#2420]
	str	r11,	[sp,	#2612]
	ldr	r11,	[sp,	#2612]
	str	r11,	[sp,	#1676]
	ldr	r11,	[sp,	#1676]
	str	r11,	[sp,	#2628]
	ldr	r11,	[sp,	#2628]
	str	r11,	[sp,	#2408]
	ldr	r11,	[sp,	#2408]
	str	r11,	[sp,	#2656]
	ldr	r11,	[sp,	#2656]
	str	r11,	[sp,	#928]
	ldr	r11,	[sp,	#928]
	str	r11,	[sp,	#2444]
	ldr	r11,	[sp,	#2444]
	str	r11,	[sp,	#2360]
	ldr	r11,	[sp,	#2360]
	str	r11,	[sp,	#2432]
	ldr	r11,	[sp,	#2432]
	str	r11,	[sp,	#1688]
	ldr	r11,	[sp,	#1688]
	str	r11,	[sp,	#2436]
	ldr	r11,	[sp,	#2436]
	str	r11,	[sp,	#2364]
	ldr	r11,	[sp,	#2364]
	str	r11,	[sp,	#2464]
	ldr	r11,	[sp,	#2464]
	str	r11,	[sp,	#1428]
	ldr	r11,	[sp,	#1428]
	str	r11,	[sp,	#2468]
	ldr	r11,	[sp,	#2468]
	str	r11,	[sp,	#2368]
	ldr	r11,	[sp,	#2368]
	str	r11,	[sp,	#2456]
	ldr	r11,	[sp,	#2456]
	str	r11,	[sp,	#1684]
	ldr	r11,	[sp,	#1684]
	str	r11,	[sp,	#2460]
	ldr	r11,	[sp,	#2460]
	str	r11,	[sp,	#2372]
	ldr	r11,	[sp,	#2372]
	str	r11,	[sp,	#2452]
	ldr	r11,	[sp,	#2452]
	cmp	r0,	r11
	bne	b2311
	b	b2312
.ltorg
b2312:
	mov	r0,	#0
	b	b2313
.ltorg
b2313:
	mov	r0,	r0
	mov	r11,	#0
	str	r11,	[sp,	#2496]
	ldr	r11,	[sp,	#2496]
	str	r11,	[sp,	#2348]
	ldr	r11,	[sp,	#2348]
	str	r11,	[sp,	#2500]
	ldr	r11,	[sp,	#2500]
	str	r11,	[sp,	#1720]
	ldr	r11,	[sp,	#1720]
	str	r11,	[sp,	#2472]
	ldr	r11,	[sp,	#2472]
	str	r11,	[sp,	#2340]
	ldr	r11,	[sp,	#2340]
	str	r11,	[sp,	#2476]
	ldr	r11,	[sp,	#2476]
	str	r11,	[sp,	#1408]
	ldr	r11,	[sp,	#1408]
	str	r11,	[sp,	#2448]
	ldr	r11,	[sp,	#2448]
	str	r11,	[sp,	#2356]
	ldr	r11,	[sp,	#2356]
	str	r11,	[sp,	#2440]
	ldr	r11,	[sp,	#2440]
	str	r11,	[sp,	#1716]
	ldr	r11,	[sp,	#1716]
	str	r11,	[sp,	#2504]
	ldr	r11,	[sp,	#2504]
	str	r11,	[sp,	#2344]
	ldr	r11,	[sp,	#2344]
	str	r11,	[sp,	#2508]
	ldr	r11,	[sp,	#2508]
	str	r11,	[sp,	#924]
	ldr	r11,	[sp,	#924]
	str	r11,	[sp,	#2688]
	ldr	r11,	[sp,	#2688]
	str	r11,	[sp,	#2392]
	ldr	r11,	[sp,	#2392]
	str	r11,	[sp,	#2692]
	ldr	r11,	[sp,	#2692]
	str	r11,	[sp,	#1692]
	ldr	r11,	[sp,	#1692]
	str	r11,	[sp,	#2648]
	ldr	r11,	[sp,	#2648]
	str	r11,	[sp,	#2396]
	ldr	r11,	[sp,	#2396]
	str	r11,	[sp,	#2640]
	ldr	r11,	[sp,	#2640]
	str	r11,	[sp,	#1404]
	ldr	r11,	[sp,	#1404]
	str	r11,	[sp,	#2576]
	ldr	r11,	[sp,	#2576]
	str	r11,	[sp,	#2304]
	ldr	r11,	[sp,	#2304]
	str	r11,	[sp,	#2580]
	ldr	r11,	[sp,	#2580]
	str	r11,	[sp,	#1724]
	ldr	r11,	[sp,	#1724]
	str	r11,	[sp,	#2568]
	ldr	r11,	[sp,	#2568]
	str	r11,	[sp,	#2308]
	ldr	r11,	[sp,	#2308]
	str	r11,	[sp,	#2572]
	ldr	r11,	[sp,	#2572]
	str	r11,	[sp,	#20]
	ldr	r11,	[sp,	#20]
	str	r11,	[sp,	#2480]
	ldr	r11,	[sp,	#2480]
	str	r11,	[sp,	#2336]
	ldr	r11,	[sp,	#2336]
	str	r11,	[sp,	#2484]
	ldr	r11,	[sp,	#2484]
	str	r11,	[sp,	#1704]
	ldr	r11,	[sp,	#1704]
	str	r11,	[sp,	#2540]
	ldr	r11,	[sp,	#2540]
	str	r11,	[sp,	#2328]
	ldr	r11,	[sp,	#2328]
	str	r11,	[sp,	#2528]
	ldr	r11,	[sp,	#2528]
	str	r11,	[sp,	#1416]
	ldr	r11,	[sp,	#1416]
	str	r11,	[sp,	#2680]
	ldr	r11,	[sp,	#2680]
	str	r11,	[sp,	#2376]
	ldr	r11,	[sp,	#2376]
	str	r11,	[sp,	#2684]
	ldr	r11,	[sp,	#2684]
	str	r11,	[sp,	#1700]
	ldr	r11,	[sp,	#1700]
	str	r11,	[sp,	#2672]
	ldr	r11,	[sp,	#2672]
	str	r11,	[sp,	#2380]
	ldr	r11,	[sp,	#2380]
	str	r11,	[sp,	#2676]
	ldr	r11,	[sp,	#2676]
	str	r11,	[sp,	#920]
	ldr	r11,	[sp,	#920]
	str	r11,	[sp,	#2548]
	ldr	r11,	[sp,	#2548]
	str	r11,	[sp,	#2324]
	ldr	r11,	[sp,	#2324]
	str	r11,	[sp,	#2536]
	ldr	r11,	[sp,	#2536]
	str	r11,	[sp,	#1712]
	ldr	r11,	[sp,	#1712]
	str	r11,	[sp,	#2488]
	ldr	r11,	[sp,	#2488]
	str	r11,	[sp,	#2352]
	ldr	r11,	[sp,	#2352]
	str	r11,	[sp,	#2492]
	ldr	r11,	[sp,	#2492]
	str	r11,	[sp,	#1412]
	ldr	r11,	[sp,	#1412]
	str	r11,	[sp,	#2532]
	ldr	r11,	[sp,	#2532]
	str	r11,	[sp,	#2332]
	ldr	r11,	[sp,	#2332]
	str	r11,	[sp,	#2524]
	ldr	r11,	[sp,	#2524]
	str	r11,	[sp,	#1708]
	ldr	r11,	[sp,	#1708]
	str	r11,	[sp,	#2516]
	ldr	r11,	[sp,	#2516]
	str	r11,	[sp,	#2320]
	ldr	r11,	[sp,	#2320]
	str	r11,	[sp,	#2544]
	ldr	r11,	[sp,	#2544]
	cmp	r2,	r11
	bne	b2317
	b	b2315
.ltorg
b2317:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b2314
	b	b2315
.ltorg
b2314:
	mov	r0,	#1
	b	b2316
.ltorg
b2315:
	mov	r0,	#0
	b	b2316
.ltorg
b2316:
	mov	r0,	r0
	str	r0,	[sp,	#916]
	mov	r0,	#0
	ldr	r2,	[sp,	#456]
	cmp	r2,	r0
	bne	b2321
	b	b2319
.ltorg
b2321:
	b	b2319
.ltorg
b2319:
	mov	r2,	#0
	b	b2320
.ltorg
b2320:
	mov	r2,	r2
	mov	r0,	#0
	str	r0,	[sp,	#16]
	ldr	r0,	[sp,	#16]
	cmp	r9,	r0
	bne	b2325
	b	b2323
.ltorg
b2323:
	mov	r0,	#0
	b	b2324
.ltorg
b2324:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r2,	r9
	bne	b2326
	b	b2329
.ltorg
b2328:
	mov	r0,	r0
	str	r0,	[sp,	#344]
	mov	r0,	#0
	cmp	r1,	r0
	bne	b2330
	b	b2333
.ltorg
b2330:
	mov	r2,	#1
	b	b2332
.ltorg
b2332:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r1,	r0
	bne	b2337
	b	b2335
.ltorg
b2335:
	mov	r0,	#0
	b	b2336
.ltorg
b2336:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r0,	#1
	movne	r0,	#0
	mov	r9,	#0
	cmp	r0,	r9
	bne	b2338
	b	b2339
.ltorg
b2338:
	mov	r0,	#1
	b	b2340
.ltorg
b2339:
	mov	r0,	#0
	b	b2340
.ltorg
b2340:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r2,	r9
	bne	b2344
	b	b2342
.ltorg
b2342:
	mov	r9,	#0
	b	b2343
.ltorg
b2343:
	mov	r9,	r9
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2345
	b	b2348
.ltorg
b2345:
	mov	r2,	#1
	b	b2347
.ltorg
b2347:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2352
	b	b2350
.ltorg
b2350:
	mov	r0,	#0
	b	b2351
.ltorg
b2351:
	mov	r0,	r0
	str	r0,	[sp,	#8]
	mov	r10,	#0
	ldr	r0,	[sp,	#8]
	cmp	r0,	r10
	moveq	r0,	#1
	str	r0,	[sp,	#12]
	movne	r0,	#0
	str	r0,	[sp,	#12]
	mov	r10,	#0
	ldr	r0,	[sp,	#12]
	cmp	r0,	r10
	bne	b2353
	b	b2354
.ltorg
b2353:
	mov	r0,	#1
	b	b2355
.ltorg
b2354:
	mov	r0,	#0
	b	b2355
.ltorg
b2355:
	mov	r0,	r0
	str	r0,	[sp,	#864]
	mov	r0,	#0
	cmp	r2,	r0
	bne	b2359
	b	b2357
.ltorg
b2357:
	mov	r2,	#0
	b	b2358
.ltorg
b2358:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r1,	r0
	bne	b2363
	b	b2361
.ltorg
b2361:
	mov	r1,	#0
	b	b2362
.ltorg
b2362:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r9,	r0
	bne	b2367
	b	b2365
.ltorg
b2365:
	mov	r0,	#0
	b	b2366
.ltorg
b2366:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2368
	b	b2371
.ltorg
b2368:
	b	b2370
.ltorg
b2370:
	mov	r1,	r2, lsl #1
	ldr	r0,	[sp,	#916]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#24]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#28]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#3536]
	add	r0,	r1,	r0
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r4
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r7
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r8
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r3
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r5
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r6
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#40]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#44]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#48]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#32]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#36]
	add	r9,	r1,	r0
	ldr	r0,	[sp,	#528]
	mov	r1,	r0, asr #31
	ldr	r0,	[sp,	#528]
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2372
	b	b2373
.ltorg
b2372:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2373
.ltorg
b2373:
	mov	r0,	r0
	str	r0,	[sp,	#856]
	ldr	r0,	[sp,	#528]
	mov	r1,	r0, asr #31
	ldr	r0,	[sp,	#528]
	add	r0,	r0,	r1, lsr #31
	mov	r0,	r0, asr #1
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2374
	b	b2375
.ltorg
b2374:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2375
.ltorg
b2375:
	mov	r0,	r0
	str	r0,	[sp,	#560]
	ldr	r0,	[sp,	#528]
	mov	r1,	r0, asr #31
	ldr	r0,	[sp,	#528]
	add	r0,	r0,	r1, lsr #30
	mov	r0,	r0, asr #2
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2376
	b	b2377
.ltorg
b2376:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2377
.ltorg
b2377:
	mov	r0,	r0
	str	r0,	[sp,	#536]
	ldr	r0,	[sp,	#528]
	mov	r1,	r0, asr #31
	ldr	r0,	[sp,	#528]
	add	r0,	r0,	r1, lsr #29
	mov	r0,	r0, asr #3
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2378
	b	b2379
.ltorg
b2378:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2379
.ltorg
b2379:
	mov	r0,	r0
	str	r0,	[sp,	#464]
	ldr	r0,	[sp,	#528]
	mov	r1,	r0, asr #31
	ldr	r0,	[sp,	#528]
	add	r0,	r0,	r1, lsr #28
	mov	r0,	r0, asr #4
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2380
	b	b2381
.ltorg
b2380:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2381
.ltorg
b2381:
	mov	r0,	r0
	str	r0,	[sp,	#664]
	ldr	r0,	[sp,	#528]
	mov	r1,	r0, asr #31
	ldr	r0,	[sp,	#528]
	add	r0,	r0,	r1, lsr #27
	mov	r0,	r0, asr #5
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2382
	b	b2383
.ltorg
b2382:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2383
.ltorg
b2383:
	mov	r0,	r0
	str	r0,	[sp,	#684]
	ldr	r0,	[sp,	#528]
	mov	r1,	r0, asr #31
	ldr	r0,	[sp,	#528]
	add	r0,	r0,	r1, lsr #26
	mov	r1,	r0, asr #6
	mov	r0,	r1, asr #31
	ands	r7,	r1,	#1
	orrne	r7,	r7,	r0, lsl #1
	mov	r0,	#0
	cmp	r7,	r0
	mov	r7,	r7
	blt	b2384
	b	b2385
.ltorg
b2384:
	mov	r0,	#0
	sub	r7,	r0,	r7
	mov	r7,	r7
	b	b2385
.ltorg
b2385:
	mov	r7,	r7
	ldr	r0,	[sp,	#528]
	mov	r1,	r0, asr #31
	ldr	r0,	[sp,	#528]
	add	r0,	r0,	r1, lsr #25
	mov	r1,	r0, asr #7
	mov	r0,	r1, asr #31
	ands	r6,	r1,	#1
	orrne	r6,	r6,	r0, lsl #1
	mov	r0,	#0
	cmp	r6,	r0
	mov	r6,	r6
	blt	b2386
	b	b2387
.ltorg
b2386:
	mov	r0,	#0
	sub	r6,	r0,	r6
	mov	r6,	r6
	b	b2387
.ltorg
b2387:
	mov	r6,	r6
	ldr	r0,	[sp,	#528]
	mov	r1,	r0, asr #31
	ldr	r0,	[sp,	#528]
	add	r0,	r0,	r1, lsr #24
	mov	r0,	r0, asr #8
	mov	r1,	r0, asr #31
	ands	r4,	r0,	#1
	orrne	r4,	r4,	r1, lsl #1
	mov	r0,	#0
	cmp	r4,	r0
	mov	r4,	r4
	blt	b2388
	b	b2389
.ltorg
b2388:
	mov	r0,	#0
	sub	r4,	r0,	r4
	mov	r4,	r4
	b	b2389
.ltorg
b2389:
	mov	r4,	r4
	ldr	r0,	[sp,	#528]
	mov	r1,	r0, asr #31
	ldr	r0,	[sp,	#528]
	add	r0,	r0,	r1, lsr #23
	mov	r0,	r0, asr #9
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2390
	b	b2391
.ltorg
b2390:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2391
.ltorg
b2391:
	mov	r0,	r0
	str	r0,	[sp,	#816]
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r1,	[sp,	#528]
	add	r0,	r1,	r0, lsr #22
	mov	r0,	r0, asr #10
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2392
	b	b2393
.ltorg
b2392:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2393
.ltorg
b2393:
	mov	r0,	r0
	str	r0,	[sp,	#788]
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r1,	[sp,	#528]
	add	r0,	r1,	r0, lsr #21
	mov	r0,	r0, asr #11
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2394
	b	b2395
.ltorg
b2394:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2395
.ltorg
b2395:
	mov	r0,	r0
	str	r0,	[sp,	#792]
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r1,	[sp,	#528]
	add	r0,	r1,	r0, lsr #20
	mov	r0,	r0, asr #12
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2396
	b	b2397
.ltorg
b2396:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2397
.ltorg
b2397:
	mov	r0,	r0
	str	r0,	[sp,	#892]
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r1,	[sp,	#528]
	add	r0,	r1,	r0, lsr #19
	mov	r0,	r0, asr #13
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2398
	b	b2399
.ltorg
b2398:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2399
.ltorg
b2399:
	mov	r0,	r0
	str	r0,	[sp,	#904]
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r1,	[sp,	#528]
	add	r0,	r1,	r0, lsr #18
	mov	r0,	r0, asr #14
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2400
	b	b2401
.ltorg
b2400:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2401
.ltorg
b2401:
	mov	r0,	r0
	str	r0,	[sp,	#488]
	ldr	r0,	[sp,	#528]
	mov	r0,	r0, asr #31
	ldr	r1,	[sp,	#528]
	add	r0,	r1,	r0, lsr #17
	mov	r0,	r0, asr #15
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2402
	b	b2403
.ltorg
b2402:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2403
.ltorg
b2403:
	mov	r0,	r0
	str	r0,	[sp,	#576]
	mov	r1,	r9, asr #31
	ands	r0,	r9,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2404
	b	b2405
.ltorg
b2404:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2405
.ltorg
b2405:
	mov	r0,	r0
	str	r0,	[sp,	#2012]
	mov	r0,	r9, asr #31
	add	r0,	r9,	r0, lsr #31
	mov	r0,	r0, asr #1
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2406
	b	b2407
.ltorg
b2406:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2407
.ltorg
b2407:
	mov	r0,	r0
	str	r0,	[sp,	#352]
	mov	r0,	r9, asr #31
	add	r0,	r9,	r0, lsr #30
	mov	r0,	r0, asr #2
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2408
	b	b2409
.ltorg
b2408:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2409
.ltorg
b2409:
	mov	r0,	r0
	str	r0,	[sp,	#3684]
	mov	r0,	r9, asr #31
	add	r0,	r9,	r0, lsr #29
	mov	r0,	r0, asr #3
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2410
	b	b2411
.ltorg
b2410:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2411
.ltorg
b2411:
	mov	r0,	r0
	str	r0,	[sp,	#468]
	mov	r0,	r9, asr #31
	add	r0,	r9,	r0, lsr #28
	mov	r1,	r0, asr #4
	mov	r0,	r1, asr #31
	ands	r8,	r1,	#1
	orrne	r8,	r8,	r0, lsl #1
	mov	r0,	#0
	cmp	r8,	r0
	mov	r8,	r8
	blt	b2412
	b	b2413
.ltorg
b2412:
	mov	r0,	#0
	sub	r8,	r0,	r8
	mov	r8,	r8
	b	b2413
.ltorg
b2413:
	mov	r8,	r8
	mov	r0,	r9, asr #31
	add	r0,	r9,	r0, lsr #27
	mov	r0,	r0, asr #5
	mov	r1,	r0, asr #31
	ands	r3,	r0,	#1
	orrne	r3,	r3,	r1, lsl #1
	mov	r0,	#0
	cmp	r3,	r0
	mov	r3,	r3
	blt	b2414
	b	b2415
.ltorg
b2414:
	mov	r0,	#0
	sub	r3,	r0,	r3
	mov	r3,	r3
	b	b2415
.ltorg
b2415:
	mov	r3,	r3
	mov	r0,	r9, asr #31
	add	r0,	r9,	r0, lsr #26
	mov	r1,	r0, asr #6
	mov	r0,	r1, asr #31
	ands	r2,	r1,	#1
	orrne	r2,	r2,	r0, lsl #1
	mov	r0,	#0
	cmp	r2,	r0
	mov	r2,	r2
	blt	b2416
	b	b2417
.ltorg
b2416:
	mov	r0,	#0
	sub	r2,	r0,	r2
	mov	r2,	r2
	b	b2417
.ltorg
b2417:
	mov	r2,	r2
	mov	r0,	r9, asr #31
	add	r0,	r9,	r0, lsr #25
	mov	r0,	r0, asr #7
	mov	r1,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r1, lsl #1
	mov	r1,	#0
	cmp	r0,	r1
	mov	r0,	r0
	blt	b2418
	b	b2419
.ltorg
b2419:
	mov	r0,	r0
	mov	r1,	r9, asr #31
	add	r1,	r9,	r1, lsr #24
	mov	r1,	r1, asr #8
	mov	r10,	r1, asr #31
	ands	r5,	r1,	#1
	orrne	r5,	r5,	r10, lsl #1
	mov	r1,	#0
	cmp	r5,	r1
	mov	r5,	r5
	blt	b2420
	b	b2421
.ltorg
b2420:
	mov	r1,	#0
	sub	r5,	r1,	r5
	mov	r5,	r5
	b	b2421
.ltorg
b2421:
	mov	r5,	r5
	mov	r1,	r9, asr #31
	add	r1,	r9,	r1, lsr #23
	mov	r1,	r1, asr #9
	str	r1,	[sp,	#860]
	ldr	r1,	[sp,	#860]
	mov	r1,	r1, asr #31
	str	r1,	[sp,	#1136]
	ldr	r1,	[sp,	#860]
	ands	r1,	r1,	#1
	ldr	r10,	[sp,	#1136]
	str	r10,	[sp,	#1504]
	ldr	r10,	[sp,	#1504]
	str	r10,	[sp,	#1212]
	ldr	r10,	[sp,	#1212]
	str	r10,	[sp,	#1500]
	ldr	r10,	[sp,	#1500]
	orrne	r1,	r1,	r10, lsl #1
	mov	r10,	#0
	str	r10,	[sp,	#1512]
	ldr	r10,	[sp,	#1512]
	str	r10,	[sp,	#1208]
	ldr	r10,	[sp,	#1208]
	str	r10,	[sp,	#1508]
	ldr	r10,	[sp,	#1508]
	str	r10,	[sp,	#1140]
	ldr	r10,	[sp,	#1140]
	str	r10,	[sp,	#1480]
	ldr	r10,	[sp,	#1480]
	str	r10,	[sp,	#1204]
	ldr	r10,	[sp,	#1204]
	str	r10,	[sp,	#1476]
	ldr	r10,	[sp,	#1476]
	cmp	r1,	r10
	mov	r1,	r1
	blt	b2422
	b	b2423
.ltorg
b2422:
	mov	r10,	#0
	str	r10,	[sp,	#1560]
	ldr	r10,	[sp,	#1560]
	str	r10,	[sp,	#1176]
	ldr	r10,	[sp,	#1176]
	str	r10,	[sp,	#1556]
	ldr	r10,	[sp,	#1556]
	str	r10,	[sp,	#1144]
	ldr	r10,	[sp,	#1144]
	str	r10,	[sp,	#1568]
	ldr	r10,	[sp,	#1568]
	str	r10,	[sp,	#1172]
	ldr	r10,	[sp,	#1172]
	str	r10,	[sp,	#1564]
	ldr	r10,	[sp,	#1564]
	sub	r1,	r10,	r1
	mov	r1,	r1
	b	b2423
.ltorg
b2423:
	mov	r1,	r1
	str	r1,	[sp,	#804]
	mov	r1,	r9, asr #31
	add	r1,	r9,	r1, lsr #22
	mov	r1,	r1, asr #10
	str	r1,	[sp,	#1116]
	ldr	r1,	[sp,	#1116]
	mov	r1,	r1, asr #31
	str	r1,	[sp,	#840]
	ldr	r1,	[sp,	#1116]
	ands	r1,	r1,	#1
	ldr	r10,	[sp,	#840]
	str	r10,	[sp,	#1652]
	ldr	r10,	[sp,	#1652]
	str	r10,	[sp,	#1148]
	ldr	r10,	[sp,	#1148]
	str	r10,	[sp,	#1648]
	ldr	r10,	[sp,	#1648]
	str	r10,	[sp,	#1072]
	ldr	r10,	[sp,	#1072]
	str	r10,	[sp,	#1576]
	ldr	r10,	[sp,	#1576]
	str	r10,	[sp,	#1168]
	ldr	r10,	[sp,	#1168]
	str	r10,	[sp,	#1572]
	ldr	r10,	[sp,	#1572]
	orrne	r1,	r1,	r10, lsl #1
	mov	r10,	#0
	str	r10,	[sp,	#1460]
	ldr	r10,	[sp,	#1460]
	str	r10,	[sp,	#1236]
	ldr	r10,	[sp,	#1236]
	str	r10,	[sp,	#1456]
	ldr	r10,	[sp,	#1456]
	str	r10,	[sp,	#1120]
	ldr	r10,	[sp,	#1120]
	str	r10,	[sp,	#1468]
	ldr	r10,	[sp,	#1468]
	str	r10,	[sp,	#1232]
	ldr	r10,	[sp,	#1232]
	str	r10,	[sp,	#1464]
	ldr	r10,	[sp,	#1464]
	cmp	r1,	r10
	mov	r1,	r1
	blt	b2424
	b	b2425
.ltorg
b2424:
	mov	r10,	#0
	str	r10,	[sp,	#1520]
	ldr	r10,	[sp,	#1520]
	str	r10,	[sp,	#1200]
	ldr	r10,	[sp,	#1200]
	str	r10,	[sp,	#1552]
	ldr	r10,	[sp,	#1552]
	str	r10,	[sp,	#1124]
	ldr	r10,	[sp,	#1124]
	str	r10,	[sp,	#1528]
	ldr	r10,	[sp,	#1528]
	str	r10,	[sp,	#1196]
	ldr	r10,	[sp,	#1196]
	str	r10,	[sp,	#1524]
	ldr	r10,	[sp,	#1524]
	sub	r1,	r10,	r1
	mov	r1,	r1
	b	b2425
.ltorg
b2425:
	mov	r1,	r1
	str	r1,	[sp,	#748]
	mov	r1,	r9, asr #31
	add	r1,	r9,	r1, lsr #21
	mov	r1,	r1, asr #11
	str	r1,	[sp,	#848]
	ldr	r1,	[sp,	#848]
	mov	r1,	r1, asr #31
	str	r1,	[sp,	#1112]
	ldr	r1,	[sp,	#848]
	ands	r1,	r1,	#1
	ldr	r10,	[sp,	#1112]
	str	r10,	[sp,	#1496]
	ldr	r10,	[sp,	#1496]
	str	r10,	[sp,	#1216]
	ldr	r10,	[sp,	#1216]
	str	r10,	[sp,	#1492]
	ldr	r10,	[sp,	#1492]
	orrne	r1,	r1,	r10, lsl #1
	mov	r10,	#0
	str	r10,	[sp,	#1624]
	ldr	r10,	[sp,	#1624]
	str	r10,	[sp,	#1256]
	ldr	r10,	[sp,	#1256]
	str	r10,	[sp,	#1620]
	ldr	r10,	[sp,	#1620]
	str	r10,	[sp,	#1104]
	ldr	r10,	[sp,	#1104]
	str	r10,	[sp,	#1436]
	ldr	r10,	[sp,	#1436]
	str	r10,	[sp,	#1228]
	ldr	r10,	[sp,	#1228]
	str	r10,	[sp,	#1472]
	ldr	r10,	[sp,	#1472]
	cmp	r1,	r10
	mov	r1,	r1
	blt	b2426
	b	b2427
.ltorg
b2426:
	mov	r10,	#0
	str	r10,	[sp,	#1444]
	ldr	r10,	[sp,	#1444]
	str	r10,	[sp,	#1224]
	ldr	r10,	[sp,	#1224]
	str	r10,	[sp,	#1440]
	ldr	r10,	[sp,	#1440]
	str	r10,	[sp,	#1108]
	ldr	r10,	[sp,	#1108]
	str	r10,	[sp,	#1488]
	ldr	r10,	[sp,	#1488]
	str	r10,	[sp,	#1220]
	ldr	r10,	[sp,	#1220]
	str	r10,	[sp,	#1484]
	ldr	r10,	[sp,	#1484]
	sub	r1,	r10,	r1
	mov	r1,	r1
	b	b2427
.ltorg
b2427:
	mov	r1,	r1
	str	r1,	[sp,	#620]
	mov	r1,	r9, asr #31
	add	r1,	r9,	r1, lsr #20
	mov	r1,	r1, asr #12
	str	r1,	[sp,	#836]
	ldr	r1,	[sp,	#836]
	mov	r1,	r1, asr #31
	str	r1,	[sp,	#1096]
	ldr	r1,	[sp,	#836]
	ands	r1,	r1,	#1
	ldr	r10,	[sp,	#1096]
	str	r10,	[sp,	#1848]
	ldr	r10,	[sp,	#1848]
	str	r10,	[sp,	#1268]
	ldr	r10,	[sp,	#1268]
	str	r10,	[sp,	#1844]
	ldr	r10,	[sp,	#1844]
	orrne	r1,	r1,	r10, lsl #1
	mov	r10,	#0
	str	r10,	[sp,	#1816]
	ldr	r10,	[sp,	#1816]
	str	r10,	[sp,	#1264]
	ldr	r10,	[sp,	#1264]
	str	r10,	[sp,	#1812]
	ldr	r10,	[sp,	#1812]
	str	r10,	[sp,	#1100]
	ldr	r10,	[sp,	#1100]
	str	r10,	[sp,	#1616]
	ldr	r10,	[sp,	#1616]
	str	r10,	[sp,	#1260]
	ldr	r10,	[sp,	#1260]
	str	r10,	[sp,	#1612]
	ldr	r10,	[sp,	#1612]
	cmp	r1,	r10
	mov	r1,	r1
	blt	b2428
	b	b2429
.ltorg
b2428:
	mov	r10,	#0
	str	r10,	[sp,	#1452]
	ldr	r10,	[sp,	#1452]
	str	r10,	[sp,	#1240]
	ldr	r10,	[sp,	#1240]
	str	r10,	[sp,	#1448]
	ldr	r10,	[sp,	#1448]
	str	r10,	[sp,	#1092]
	ldr	r10,	[sp,	#1092]
	str	r10,	[sp,	#1840]
	ldr	r10,	[sp,	#1840]
	str	r10,	[sp,	#1272]
	ldr	r10,	[sp,	#1272]
	str	r10,	[sp,	#1836]
	ldr	r10,	[sp,	#1836]
	sub	r1,	r10,	r1
	mov	r1,	r1
	b	b2429
.ltorg
b2429:
	mov	r1,	r1
	str	r1,	[sp,	#652]
	mov	r1,	r9, asr #31
	add	r1,	r9,	r1, lsr #19
	mov	r1,	r1, asr #13
	str	r1,	[sp,	#832]
	ldr	r1,	[sp,	#832]
	mov	r1,	r1, asr #31
	str	r1,	[sp,	#1080]
	ldr	r1,	[sp,	#832]
	ands	r1,	r1,	#1
	ldr	r10,	[sp,	#1080]
	str	r10,	[sp,	#1584]
	ldr	r10,	[sp,	#1584]
	str	r10,	[sp,	#1164]
	ldr	r10,	[sp,	#1164]
	str	r10,	[sp,	#1580]
	ldr	r10,	[sp,	#1580]
	orrne	r1,	r1,	r10, lsl #1
	mov	r10,	#0
	str	r10,	[sp,	#1660]
	ldr	r10,	[sp,	#1660]
	str	r10,	[sp,	#1160]
	ldr	r10,	[sp,	#1160]
	str	r10,	[sp,	#1656]
	ldr	r10,	[sp,	#1656]
	str	r10,	[sp,	#1084]
	ldr	r10,	[sp,	#1084]
	str	r10,	[sp,	#1632]
	ldr	r10,	[sp,	#1632]
	str	r10,	[sp,	#1252]
	ldr	r10,	[sp,	#1252]
	str	r10,	[sp,	#1628]
	ldr	r10,	[sp,	#1628]
	cmp	r1,	r10
	mov	r1,	r1
	blt	b2430
	b	b2431
.ltorg
b2430:
	mov	r10,	#0
	str	r10,	[sp,	#1600]
	ldr	r10,	[sp,	#1600]
	str	r10,	[sp,	#1248]
	ldr	r10,	[sp,	#1248]
	str	r10,	[sp,	#1596]
	ldr	r10,	[sp,	#1596]
	str	r10,	[sp,	#1088]
	ldr	r10,	[sp,	#1088]
	str	r10,	[sp,	#1608]
	ldr	r10,	[sp,	#1608]
	str	r10,	[sp,	#1244]
	ldr	r10,	[sp,	#1244]
	str	r10,	[sp,	#1604]
	ldr	r10,	[sp,	#1604]
	sub	r1,	r10,	r1
	mov	r1,	r1
	b	b2431
.ltorg
b2431:
	mov	r1,	r1
	str	r1,	[sp,	#608]
	mov	r1,	r9, asr #31
	add	r1,	r9,	r1, lsr #18
	mov	r1,	r1, asr #14
	str	r1,	[sp,	#1076]
	ldr	r1,	[sp,	#1076]
	mov	r1,	r1, asr #31
	str	r1,	[sp,	#828]
	ldr	r1,	[sp,	#1076]
	ands	r1,	r1,	#1
	ldr	r10,	[sp,	#828]
	str	r10,	[sp,	#1636]
	ldr	r10,	[sp,	#1636]
	str	r10,	[sp,	#1156]
	ldr	r10,	[sp,	#1156]
	str	r10,	[sp,	#1664]
	ldr	r10,	[sp,	#1664]
	str	r10,	[sp,	#1068]
	ldr	r10,	[sp,	#1068]
	str	r10,	[sp,	#1644]
	ldr	r10,	[sp,	#1644]
	str	r10,	[sp,	#1152]
	ldr	r10,	[sp,	#1152]
	str	r10,	[sp,	#1640]
	ldr	r10,	[sp,	#1640]
	orrne	r1,	r1,	r10, lsl #1
	mov	r10,	#0
	str	r10,	[sp,	#1536]
	ldr	r10,	[sp,	#1536]
	str	r10,	[sp,	#1192]
	ldr	r10,	[sp,	#1192]
	str	r10,	[sp,	#1532]
	ldr	r10,	[sp,	#1532]
	str	r10,	[sp,	#1128]
	ldr	r10,	[sp,	#1128]
	str	r10,	[sp,	#1544]
	ldr	r10,	[sp,	#1544]
	str	r10,	[sp,	#1188]
	ldr	r10,	[sp,	#1188]
	str	r10,	[sp,	#1540]
	ldr	r10,	[sp,	#1540]
	cmp	r1,	r10
	mov	r1,	r1
	blt	b2432
	b	b2433
.ltorg
b2432:
	mov	r10,	#0
	str	r10,	[sp,	#1516]
	ldr	r10,	[sp,	#1516]
	str	r10,	[sp,	#1184]
	ldr	r10,	[sp,	#1184]
	str	r10,	[sp,	#1548]
	ldr	r10,	[sp,	#1548]
	str	r10,	[sp,	#1132]
	ldr	r10,	[sp,	#1132]
	str	r10,	[sp,	#1592]
	ldr	r10,	[sp,	#1592]
	str	r10,	[sp,	#1180]
	ldr	r10,	[sp,	#1180]
	str	r10,	[sp,	#1588]
	ldr	r10,	[sp,	#1588]
	sub	r1,	r10,	r1
	mov	r1,	r1
	b	b2433
.ltorg
b2433:
	mov	r1,	r1
	str	r1,	[sp,	#596]
	mov	r1,	r9, asr #31
	add	r1,	r9,	r1, lsr #17
	mov	r1,	r1, asr #15
	mov	r9,	r1, asr #31
	ands	r1,	r1,	#1
	orrne	r1,	r1,	r9, lsl #1
	mov	r9,	#0
	cmp	r1,	r9
	mov	r1,	r1
	blt	b2434
	b	b2435
.ltorg
b2435:
	mov	r1,	r1
	str	r1,	[sp,	#580]
	mov	r9,	#0
	ldr	r1,	[sp,	#856]
	cmp	r1,	r9
	bne	b2436
	b	b2439
.ltorg
b2438:
	mov	r1,	r1
	str	r1,	[sp,	#520]
	mov	r9,	#0
	ldr	r1,	[sp,	#856]
	cmp	r1,	r9
	bne	b2443
	b	b2441
.ltorg
b2441:
	mov	r1,	#0
	b	b2442
.ltorg
b2442:
	mov	r1,	r1
	mov	r9,	#0
	cmp	r1,	r9
	moveq	r9,	#1
	movne	r9,	#0
	mov	r1,	#0
	cmp	r9,	r1
	bne	b2444
	b	b2445
.ltorg
b2444:
	mov	r1,	#1
	b	b2446
.ltorg
b2445:
	mov	r1,	#0
	b	b2446
.ltorg
b2446:
	mov	r1,	r1
	mov	r9,	#0
	str	r9,	[sp,	#988]
	ldr	r9,	[sp,	#520]
	ldr	r10,	[sp,	#988]
	str	r10,	[sp,	#1832]
	ldr	r10,	[sp,	#1832]
	str	r10,	[sp,	#1276]
	ldr	r10,	[sp,	#1276]
	str	r10,	[sp,	#1828]
	ldr	r10,	[sp,	#1828]
	cmp	r9,	r10
	bne	b2450
	b	b2448
.ltorg
b2449:
	mov	r1,	r1
	str	r1,	[sp,	#512]
	mov	r1,	#0
	ldr	r9,	[sp,	#512]
	cmp	r9,	r1
	bne	b2451
	b	b2454
.ltorg
b2453:
	mov	r1,	r1
	str	r1,	[sp,	#984]
	mov	r1,	#0
	ldr	r9,	[sp,	#512]
	cmp	r9,	r1
	bne	b2458
	b	b2456
.ltorg
b2456:
	b	b2459
.ltorg
b2459:
	mov	r1,	#1
	b	b2461
.ltorg
b2461:
	mov	r1,	r1
	mov	r9,	#0
	str	r9,	[sp,	#516]
	ldr	r9,	[sp,	#516]
	ldr	r10,	[sp,	#984]
	str	r10,	[sp,	#1744]
	ldr	r10,	[sp,	#1744]
	str	r10,	[sp,	#1304]
	ldr	r10,	[sp,	#1304]
	str	r10,	[sp,	#1740]
	ldr	r10,	[sp,	#1740]
	cmp	r10,	r9
	bne	b2465
	b	b2463
.ltorg
b2463:
	mov	r1,	#0
	b	b2464
.ltorg
b2464:
	mov	r1,	r1
	str	r1,	[sp,	#628]
	mov	r1,	#0
	ldr	r9,	[sp,	#856]
	cmp	r9,	r1
	bne	b2469
	b	b2467
.ltorg
b2467:
	mov	r1,	#0
	b	b2468
.ltorg
b2468:
	mov	r1,	r1
	mov	r9,	#0
	ldr	r10,	[sp,	#512]
	cmp	r10,	r9
	bne	b2473
	b	b2471
.ltorg
b2471:
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2474
	b	b2477
.ltorg
b2474:
	mov	r10,	#1
	b	b2476
.ltorg
b2476:
	mov	r10,	r10
	mov	r1,	#0
	ldr	r9,	[sp,	#560]
	cmp	r9,	r1
	bne	b2478
	b	b2481
.ltorg
b2478:
	mov	r1,	#1
	b	b2480
.ltorg
b2480:
	mov	r1,	r1
	str	r1,	[sp,	#548]
	mov	r1,	#0
	ldr	r9,	[sp,	#560]
	cmp	r9,	r1
	bne	b2485
	b	b2483
.ltorg
b2483:
	mov	r1,	#0
	b	b2484
.ltorg
b2484:
	mov	r1,	r1
	mov	r9,	#0
	cmp	r1,	r9
	moveq	r1,	#1
	movne	r1,	#0
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2486
	b	b2487
.ltorg
b2486:
	mov	r1,	#1
	b	b2488
.ltorg
b2487:
	mov	r1,	#0
	b	b2488
.ltorg
b2488:
	mov	r1,	r1
	mov	r9,	#0
	str	r9,	[sp,	#1000]
	ldr	r9,	[sp,	#548]
	ldr	r11,	[sp,	#1000]
	str	r11,	[sp,	#2824]
	ldr	r11,	[sp,	#2824]
	str	r11,	[sp,	#2240]
	ldr	r11,	[sp,	#2240]
	str	r11,	[sp,	#2828]
	ldr	r11,	[sp,	#2828]
	str	r11,	[sp,	#1780]
	ldr	r11,	[sp,	#1780]
	str	r11,	[sp,	#2816]
	ldr	r11,	[sp,	#2816]
	str	r11,	[sp,	#2244]
	ldr	r11,	[sp,	#2244]
	str	r11,	[sp,	#2820]
	ldr	r11,	[sp,	#2820]
	str	r11,	[sp,	#1284]
	ldr	r11,	[sp,	#1284]
	str	r11,	[sp,	#3008]
	ldr	r11,	[sp,	#3008]
	str	r11,	[sp,	#2208]
	ldr	r11,	[sp,	#2208]
	str	r11,	[sp,	#3012]
	ldr	r11,	[sp,	#3012]
	str	r11,	[sp,	#1776]
	ldr	r11,	[sp,	#1776]
	str	r11,	[sp,	#3040]
	ldr	r11,	[sp,	#3040]
	str	r11,	[sp,	#2212]
	ldr	r11,	[sp,	#2212]
	str	r11,	[sp,	#3044]
	ldr	r11,	[sp,	#3044]
	cmp	r9,	r11
	bne	b2492
	b	b2490
.ltorg
b2490:
	mov	r1,	#0
	b	b2491
.ltorg
b2491:
	mov	r1,	r1
	str	r1,	[sp,	#552]
	mov	r1,	#0
	ldr	r9,	[sp,	#552]
	cmp	r9,	r1
	bne	b2493
	b	b2496
.ltorg
b2493:
	mov	r1,	#1
	b	b2495
.ltorg
b2495:
	mov	r1,	r1
	str	r1,	[sp,	#540]
	mov	r1,	#0
	ldr	r9,	[sp,	#552]
	cmp	r9,	r1
	bne	b2500
	b	b2498
.ltorg
b2498:
	mov	r1,	#0
	b	b2499
.ltorg
b2499:
	mov	r1,	r1
	mov	r9,	#0
	cmp	r1,	r9
	moveq	r1,	#1
	movne	r1,	#0
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2501
	b	b2502
.ltorg
b2501:
	mov	r1,	#1
	b	b2503
.ltorg
b2502:
	mov	r1,	#0
	b	b2503
.ltorg
b2503:
	mov	r1,	r1
	mov	r9,	#0
	str	r9,	[sp,	#996]
	ldr	r9,	[sp,	#540]
	ldr	r11,	[sp,	#996]
	str	r11,	[sp,	#2832]
	ldr	r11,	[sp,	#2832]
	str	r11,	[sp,	#2216]
	ldr	r11,	[sp,	#2216]
	str	r11,	[sp,	#2860]
	ldr	r11,	[sp,	#2860]
	str	r11,	[sp,	#1772]
	ldr	r11,	[sp,	#1772]
	str	r11,	[sp,	#2864]
	ldr	r11,	[sp,	#2864]
	str	r11,	[sp,	#2220]
	ldr	r11,	[sp,	#2220]
	str	r11,	[sp,	#2852]
	ldr	r11,	[sp,	#2852]
	str	r11,	[sp,	#1288]
	ldr	r11,	[sp,	#1288]
	str	r11,	[sp,	#3096]
	ldr	r11,	[sp,	#3096]
	str	r11,	[sp,	#2160]
	ldr	r11,	[sp,	#2160]
	str	r11,	[sp,	#3100]
	ldr	r11,	[sp,	#3100]
	str	r11,	[sp,	#1808]
	ldr	r11,	[sp,	#1808]
	str	r11,	[sp,	#3088]
	ldr	r11,	[sp,	#3088]
	str	r11,	[sp,	#2164]
	ldr	r11,	[sp,	#2164]
	str	r11,	[sp,	#3092]
	ldr	r11,	[sp,	#3092]
	cmp	r9,	r11
	bne	b2507
	b	b2505
.ltorg
b2505:
	mov	r1,	#0
	b	b2506
.ltorg
b2506:
	mov	r1,	r1
	str	r1,	[sp,	#624]
	mov	r1,	#0
	ldr	r9,	[sp,	#560]
	cmp	r9,	r1
	bne	b2511
	b	b2509
.ltorg
b2509:
	mov	r9,	#0
	b	b2510
.ltorg
b2510:
	mov	r9,	r9
	mov	r1,	#0
	str	r1,	[sp,	#992]
	ldr	r1,	[sp,	#552]
	ldr	r11,	[sp,	#992]
	str	r11,	[sp,	#3128]
	ldr	r11,	[sp,	#3128]
	str	r11,	[sp,	#2144]
	ldr	r11,	[sp,	#2144]
	str	r11,	[sp,	#3144]
	ldr	r11,	[sp,	#3144]
	str	r11,	[sp,	#1804]
	ldr	r11,	[sp,	#1804]
	str	r11,	[sp,	#3148]
	ldr	r11,	[sp,	#3148]
	str	r11,	[sp,	#2148]
	ldr	r11,	[sp,	#2148]
	str	r11,	[sp,	#3136]
	ldr	r11,	[sp,	#3136]
	str	r11,	[sp,	#1292]
	ldr	r11,	[sp,	#1292]
	str	r11,	[sp,	#3072]
	ldr	r11,	[sp,	#3072]
	str	r11,	[sp,	#2176]
	ldr	r11,	[sp,	#2176]
	str	r11,	[sp,	#3064]
	ldr	r11,	[sp,	#3064]
	str	r11,	[sp,	#1800]
	ldr	r11,	[sp,	#1800]
	str	r11,	[sp,	#3016]
	ldr	r11,	[sp,	#3016]
	str	r11,	[sp,	#2204]
	ldr	r11,	[sp,	#2204]
	str	r11,	[sp,	#3020]
	ldr	r11,	[sp,	#3020]
	cmp	r1,	r11
	bne	b2515
	b	b2513
.ltorg
b2513:
	mov	r1,	#0
	b	b2514
.ltorg
b2514:
	mov	r1,	r1
	mov	r10,	#0
	cmp	r9,	r10
	bne	b2516
	b	b2519
.ltorg
b2516:
	mov	r10,	#1
	b	b2518
.ltorg
b2518:
	mov	r10,	r10
	mov	r1,	#0
	ldr	r9,	[sp,	#536]
	cmp	r9,	r1
	bne	b2520
	b	b2523
.ltorg
b2520:
	mov	r1,	#1
	b	b2522
.ltorg
b2522:
	mov	r1,	r1
	str	r1,	[sp,	#484]
	mov	r1,	#0
	ldr	r9,	[sp,	#536]
	cmp	r9,	r1
	bne	b2527
	b	b2525
.ltorg
b2525:
	mov	r1,	#0
	b	b2526
.ltorg
b2526:
	mov	r1,	r1
	mov	r9,	#0
	cmp	r1,	r9
	moveq	r1,	#1
	movne	r1,	#0
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2528
	b	b2529
.ltorg
b2528:
	mov	r1,	#1
	b	b2530
.ltorg
b2529:
	mov	r1,	#0
	b	b2530
.ltorg
b2530:
	mov	r1,	r1
	mov	r9,	#0
	str	r9,	[sp,	#980]
	ldr	r9,	[sp,	#484]
	ldr	r11,	[sp,	#980]
	str	r11,	[sp,	#3060]
	ldr	r11,	[sp,	#3060]
	str	r11,	[sp,	#2184]
	ldr	r11,	[sp,	#2184]
	str	r11,	[sp,	#3048]
	ldr	r11,	[sp,	#3048]
	str	r11,	[sp,	#1796]
	ldr	r11,	[sp,	#1796]
	str	r11,	[sp,	#3112]
	ldr	r11,	[sp,	#3112]
	str	r11,	[sp,	#2172]
	ldr	r11,	[sp,	#2172]
	str	r11,	[sp,	#3116]
	ldr	r11,	[sp,	#3116]
	str	r11,	[sp,	#1296]
	ldr	r11,	[sp,	#1296]
	str	r11,	[sp,	#3084]
	ldr	r11,	[sp,	#3084]
	str	r11,	[sp,	#2192]
	ldr	r11,	[sp,	#2192]
	str	r11,	[sp,	#3076]
	ldr	r11,	[sp,	#3076]
	str	r11,	[sp,	#1792]
	ldr	r11,	[sp,	#1792]
	str	r11,	[sp,	#3068]
	ldr	r11,	[sp,	#3068]
	str	r11,	[sp,	#2180]
	ldr	r11,	[sp,	#2180]
	str	r11,	[sp,	#3056]
	ldr	r11,	[sp,	#3056]
	cmp	r9,	r11
	bne	b2534
	b	b2532
.ltorg
b2532:
	mov	r1,	#0
	b	b2533
.ltorg
b2533:
	mov	r1,	r1
	str	r1,	[sp,	#480]
	mov	r1,	#0
	ldr	r9,	[sp,	#480]
	cmp	r9,	r1
	bne	b2535
	b	b2538
.ltorg
b2535:
	mov	r1,	#1
	b	b2537
.ltorg
b2537:
	mov	r1,	r1
	str	r1,	[sp,	#472]
	mov	r1,	#0
	ldr	r9,	[sp,	#480]
	cmp	r9,	r1
	bne	b2542
	b	b2540
.ltorg
b2540:
	mov	r1,	#0
	b	b2541
.ltorg
b2541:
	mov	r1,	r1
	mov	r9,	#0
	cmp	r1,	r9
	moveq	r1,	#1
	movne	r1,	#0
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2543
	b	b2544
.ltorg
b2543:
	mov	r1,	#1
	b	b2545
.ltorg
b2544:
	mov	r1,	#0
	b	b2545
.ltorg
b2545:
	mov	r1,	r1
	mov	r9,	#0
	str	r9,	[sp,	#976]
	ldr	r9,	[sp,	#472]
	ldr	r11,	[sp,	#976]
	str	r11,	[sp,	#3024]
	ldr	r11,	[sp,	#3024]
	str	r11,	[sp,	#2200]
	ldr	r11,	[sp,	#2200]
	str	r11,	[sp,	#3028]
	ldr	r11,	[sp,	#3028]
	str	r11,	[sp,	#1788]
	ldr	r11,	[sp,	#1788]
	str	r11,	[sp,	#3052]
	ldr	r11,	[sp,	#3052]
	str	r11,	[sp,	#2188]
	ldr	r11,	[sp,	#2188]
	str	r11,	[sp,	#3080]
	ldr	r11,	[sp,	#3080]
	str	r11,	[sp,	#1300]
	ldr	r11,	[sp,	#1300]
	str	r11,	[sp,	#3120]
	ldr	r11,	[sp,	#3120]
	str	r11,	[sp,	#2168]
	ldr	r11,	[sp,	#2168]
	str	r11,	[sp,	#3124]
	ldr	r11,	[sp,	#3124]
	str	r11,	[sp,	#1784]
	ldr	r11,	[sp,	#1784]
	str	r11,	[sp,	#3032]
	ldr	r11,	[sp,	#3032]
	str	r11,	[sp,	#2196]
	ldr	r11,	[sp,	#2196]
	str	r11,	[sp,	#3036]
	ldr	r11,	[sp,	#3036]
	cmp	r9,	r11
	bne	b2549
	b	b2547
.ltorg
b2547:
	mov	r1,	#0
	b	b2548
.ltorg
b2548:
	mov	r1,	r1
	str	r1,	[sp,	#632]
	mov	r1,	#0
	ldr	r9,	[sp,	#536]
	cmp	r9,	r1
	bne	b2553
	b	b2551
.ltorg
b2551:
	mov	r9,	#0
	b	b2552
.ltorg
b2552:
	mov	r9,	r9
	mov	r1,	#0
	ldr	r11,	[sp,	#480]
	cmp	r11,	r1
	bne	b2557
	b	b2555
.ltorg
b2555:
	mov	r1,	#0
	b	b2556
.ltorg
b2556:
	mov	r1,	r1
	mov	r10,	#0
	cmp	r9,	r10
	bne	b2558
	b	b2561
.ltorg
b2558:
	mov	r10,	#1
	b	b2560
.ltorg
b2560:
	mov	r10,	r10
	mov	r1,	#0
	ldr	r9,	[sp,	#464]
	cmp	r9,	r1
	bne	b2562
	b	b2565
.ltorg
b2565:
	mov	r1,	#0
	ldr	r9,	[sp,	#468]
	cmp	r9,	r1
	bne	b2562
	b	b2563
.ltorg
b2563:
	mov	r9,	#0
	b	b2564
.ltorg
b2562:
	mov	r9,	#1
	b	b2564
.ltorg
b2564:
	mov	r9,	r9
	mov	r1,	#0
	ldr	r11,	[sp,	#464]
	cmp	r11,	r1
	bne	b2569
	b	b2567
.ltorg
b2568:
	mov	r1,	r1
	mov	r11,	#0
	cmp	r1,	r11
	moveq	r1,	#1
	movne	r1,	#0
	mov	r11,	#0
	cmp	r1,	r11
	bne	b2570
	b	b2571
.ltorg
b2571:
	mov	r1,	#0
	b	b2572
.ltorg
b2572:
	mov	r1,	r1
	mov	r11,	#0
	cmp	r9,	r11
	bne	b2576
	b	b2574
.ltorg
b2576:
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2573
	b	b2574
.ltorg
b2573:
	mov	r1,	#1
	b	b2575
.ltorg
b2574:
	mov	r1,	#0
	b	b2575
.ltorg
b2575:
	mov	r1,	r1
	str	r1,	[sp,	#668]
	mov	r1,	#0
	ldr	r9,	[sp,	#668]
	cmp	r9,	r1
	bne	b2577
	b	b2580
.ltorg
b2579:
	mov	r9,	r9
	mov	r1,	#0
	ldr	r11,	[sp,	#668]
	cmp	r11,	r1
	bne	b2584
	b	b2582
.ltorg
b2582:
	mov	r1,	#0
	b	b2583
.ltorg
b2583:
	mov	r1,	r1
	mov	r11,	#0
	cmp	r1,	r11
	moveq	r1,	#1
	movne	r1,	#0
	mov	r11,	#0
	cmp	r1,	r11
	bne	b2585
	b	b2586
.ltorg
b2585:
	mov	r1,	#1
	b	b2587
.ltorg
b2586:
	mov	r1,	#0
	b	b2587
.ltorg
b2587:
	mov	r1,	r1
	mov	r11,	#0
	cmp	r9,	r11
	bne	b2591
	b	b2589
.ltorg
b2590:
	mov	r1,	r1
	str	r1,	[sp,	#644]
	mov	r1,	#0
	ldr	r9,	[sp,	#464]
	cmp	r9,	r1
	bne	b2595
	b	b2593
.ltorg
b2593:
	mov	r9,	#0
	b	b2594
.ltorg
b2594:
	mov	r9,	r9
	mov	r1,	#0
	ldr	r11,	[sp,	#668]
	cmp	r11,	r1
	bne	b2599
	b	b2597
.ltorg
b2597:
	mov	r1,	#0
	b	b2598
.ltorg
b2598:
	mov	r1,	r1
	mov	r10,	#0
	cmp	r9,	r10
	bne	b2600
	b	b2603
.ltorg
b2600:
	mov	r9,	#1
	b	b2602
.ltorg
b2602:
	mov	r9,	r9
	mov	r1,	#0
	ldr	r10,	[sp,	#664]
	cmp	r10,	r1
	bne	b2604
	b	b2607
.ltorg
b2604:
	mov	r10,	#1
	b	b2606
.ltorg
b2606:
	mov	r10,	r10
	mov	r1,	#0
	ldr	r11,	[sp,	#664]
	cmp	r11,	r1
	bne	b2611
	b	b2609
.ltorg
b2609:
	mov	r1,	#0
	b	b2610
.ltorg
b2610:
	mov	r1,	r1
	mov	r11,	#0
	cmp	r1,	r11
	moveq	r1,	#1
	movne	r1,	#0
	mov	r11,	#0
	cmp	r1,	r11
	bne	b2612
	b	b2613
.ltorg
b2612:
	mov	r1,	#1
	b	b2614
.ltorg
b2613:
	mov	r1,	#0
	b	b2614
.ltorg
b2614:
	mov	r1,	r1
	mov	r11,	#0
	cmp	r10,	r11
	bne	b2618
	b	b2616
.ltorg
b2616:
	mov	r1,	#0
	b	b2617
.ltorg
b2617:
	mov	r1,	r1
	str	r1,	[sp,	#708]
	mov	r1,	#0
	ldr	r10,	[sp,	#708]
	cmp	r10,	r1
	bne	b2619
	b	b2622
.ltorg
b2619:
	mov	r10,	#1
	b	b2621
.ltorg
b2621:
	mov	r10,	r10
	mov	r1,	#0
	ldr	r11,	[sp,	#708]
	cmp	r11,	r1
	bne	b2626
	b	b2624
.ltorg
b2624:
	mov	r1,	#0
	b	b2625
.ltorg
b2625:
	mov	r1,	r1
	mov	r11,	#0
	cmp	r1,	r11
	moveq	r1,	#1
	movne	r1,	#0
	mov	r11,	#0
	cmp	r1,	r11
	bne	b2627
	b	b2628
.ltorg
b2627:
	mov	r1,	#1
	b	b2629
.ltorg
b2628:
	mov	r1,	#0
	b	b2629
.ltorg
b2629:
	mov	r1,	r1
	mov	r11,	#0
	cmp	r10,	r11
	bne	b2633
	b	b2631
.ltorg
b2631:
	mov	r1,	#0
	b	b2632
.ltorg
b2632:
	mov	r1,	r1
	str	r1,	[sp,	#640]
	mov	r1,	#0
	ldr	r10,	[sp,	#664]
	cmp	r10,	r1
	bne	b2637
	b	b2635
.ltorg
b2635:
	mov	r8,	#0
	b	b2636
.ltorg
b2636:
	mov	r8,	r8
	mov	r1,	#0
	ldr	r10,	[sp,	#708]
	cmp	r10,	r1
	bne	b2641
	b	b2639
.ltorg
b2639:
	mov	r1,	#0
	b	b2640
.ltorg
b2640:
	mov	r1,	r1
	mov	r9,	#0
	cmp	r8,	r9
	bne	b2642
	b	b2645
.ltorg
b2642:
	mov	r8,	#1
	b	b2644
.ltorg
b2644:
	mov	r8,	r8
	mov	r1,	#0
	ldr	r9,	[sp,	#684]
	cmp	r9,	r1
	bne	b2646
	b	b2649
.ltorg
b2646:
	mov	r9,	#1
	b	b2648
.ltorg
b2648:
	mov	r9,	r9
	mov	r1,	#0
	ldr	r10,	[sp,	#684]
	cmp	r10,	r1
	bne	b2653
	b	b2651
.ltorg
b2651:
	mov	r1,	#0
	b	b2652
.ltorg
b2652:
	mov	r1,	r1
	mov	r10,	#0
	cmp	r1,	r10
	moveq	r1,	#1
	movne	r1,	#0
	mov	r10,	#0
	cmp	r1,	r10
	bne	b2654
	b	b2655
.ltorg
b2654:
	mov	r1,	#1
	b	b2656
.ltorg
b2655:
	mov	r1,	#0
	b	b2656
.ltorg
b2656:
	mov	r1,	r1
	mov	r10,	#0
	cmp	r9,	r10
	bne	b2660
	b	b2658
.ltorg
b2658:
	mov	r9,	#0
	b	b2659
.ltorg
b2659:
	mov	r9,	r9
	mov	r1,	#0
	cmp	r9,	r1
	bne	b2661
	b	b2664
.ltorg
b2661:
	mov	r10,	#1
	b	b2663
.ltorg
b2663:
	mov	r10,	r10
	mov	r1,	#0
	cmp	r9,	r1
	bne	b2668
	b	b2666
.ltorg
b2666:
	mov	r1,	#0
	b	b2667
.ltorg
b2667:
	mov	r1,	r1
	mov	r11,	#0
	cmp	r1,	r11
	moveq	r11,	#1
	movne	r11,	#0
	mov	r1,	#0
	cmp	r11,	r1
	bne	b2669
	b	b2670
.ltorg
b2669:
	mov	r1,	#1
	b	b2671
.ltorg
b2670:
	mov	r1,	#0
	b	b2671
.ltorg
b2671:
	mov	r1,	r1
	mov	r11,	#0
	cmp	r10,	r11
	bne	b2675
	b	b2673
.ltorg
b2673:
	mov	r1,	#0
	b	b2674
.ltorg
b2674:
	mov	r1,	r1
	str	r1,	[sp,	#636]
	mov	r1,	#0
	ldr	r10,	[sp,	#684]
	cmp	r10,	r1
	bne	b2679
	b	b2677
.ltorg
b2677:
	mov	r3,	#0
	b	b2678
.ltorg
b2678:
	mov	r3,	r3
	mov	r1,	#0
	cmp	r9,	r1
	bne	b2683
	b	b2681
.ltorg
b2681:
	mov	r1,	#0
	b	b2682
.ltorg
b2682:
	mov	r1,	r1
	mov	r8,	#0
	cmp	r3,	r8
	bne	b2684
	b	b2687
.ltorg
b2684:
	mov	r8,	#1
	b	b2686
.ltorg
b2686:
	mov	r8,	r8
	mov	r1,	#0
	cmp	r7,	r1
	bne	b2688
	b	b2691
.ltorg
b2688:
	mov	r3,	#1
	b	b2690
.ltorg
b2690:
	mov	r3,	r3
	mov	r1,	#0
	cmp	r7,	r1
	bne	b2695
	b	b2693
.ltorg
b2695:
	mov	r1,	#0
	cmp	r2,	r1
	bne	b2692
	b	b2693
.ltorg
b2692:
	mov	r1,	#1
	b	b2694
.ltorg
b2693:
	mov	r1,	#0
	b	b2694
.ltorg
b2694:
	mov	r1,	r1
	mov	r9,	#0
	cmp	r1,	r9
	moveq	r1,	#1
	movne	r1,	#0
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2696
	b	b2697
.ltorg
b2698:
	mov	r1,	r1
	mov	r9,	#0
	cmp	r3,	r9
	bne	b2702
	b	b2700
.ltorg
b2700:
	mov	r1,	#0
	b	b2701
.ltorg
b2701:
	mov	r1,	r1
	mov	r3,	#0
	cmp	r1,	r3
	bne	b2703
	b	b2706
.ltorg
b2706:
	mov	r3,	#0
	cmp	r8,	r3
	bne	b2703
	b	b2704
.ltorg
b2704:
	mov	r9,	#0
	b	b2705
.ltorg
b2703:
	mov	r9,	#1
	b	b2705
.ltorg
b2705:
	mov	r9,	r9
	mov	r3,	#0
	cmp	r1,	r3
	bne	b2710
	b	b2708
.ltorg
b2709:
	mov	r3,	r3
	mov	r10,	#0
	cmp	r3,	r10
	moveq	r10,	#1
	movne	r10,	#0
	mov	r3,	#0
	cmp	r10,	r3
	bne	b2711
	b	b2712
.ltorg
b2712:
	mov	r3,	#0
	b	b2713
.ltorg
b2713:
	mov	r3,	r3
	mov	r10,	#0
	cmp	r9,	r10
	bne	b2717
	b	b2715
.ltorg
b2717:
	mov	r9,	#0
	cmp	r3,	r9
	bne	b2714
	b	b2715
.ltorg
b2714:
	mov	r3,	#1
	b	b2716
.ltorg
b2715:
	mov	r3,	#0
	b	b2716
.ltorg
b2716:
	mov	r3,	r3
	mov	r9,	#0
	cmp	r7,	r9
	bne	b2721
	b	b2719
.ltorg
b2720:
	mov	r2,	r2
	mov	r7,	#0
	cmp	r1,	r7
	bne	b2725
	b	b2723
.ltorg
b2723:
	mov	r1,	#0
	b	b2724
.ltorg
b2724:
	mov	r1,	r1
	mov	r7,	#0
	cmp	r2,	r7
	bne	b2726
	b	b2729
.ltorg
b2728:
	mov	r7,	r7
	mov	r1,	#0
	cmp	r6,	r1
	bne	b2730
	b	b2733
.ltorg
b2730:
	mov	r2,	#1
	b	b2732
.ltorg
b2732:
	mov	r2,	r2
	mov	r1,	#0
	cmp	r6,	r1
	bne	b2737
	b	b2735
.ltorg
b2735:
	mov	r1,	#0
	b	b2736
.ltorg
b2736:
	mov	r1,	r1
	mov	r8,	#0
	cmp	r1,	r8
	moveq	r1,	#1
	movne	r1,	#0
	mov	r8,	#0
	cmp	r1,	r8
	bne	b2738
	b	b2739
.ltorg
b2738:
	mov	r1,	#1
	b	b2740
.ltorg
b2739:
	mov	r1,	#0
	b	b2740
.ltorg
b2740:
	mov	r1,	r1
	mov	r8,	#0
	cmp	r2,	r8
	bne	b2744
	b	b2742
.ltorg
b2742:
	mov	r8,	#0
	b	b2743
.ltorg
b2743:
	mov	r8,	r8
	mov	r1,	#0
	cmp	r8,	r1
	bne	b2745
	b	b2748
.ltorg
b2745:
	mov	r2,	#1
	b	b2747
.ltorg
b2747:
	mov	r2,	r2
	mov	r1,	#0
	cmp	r8,	r1
	bne	b2752
	b	b2750
.ltorg
b2750:
	mov	r1,	#0
	b	b2751
.ltorg
b2751:
	mov	r1,	r1
	mov	r9,	#0
	cmp	r1,	r9
	moveq	r1,	#1
	movne	r1,	#0
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2753
	b	b2754
.ltorg
b2753:
	mov	r1,	#1
	b	b2755
.ltorg
b2754:
	mov	r1,	#0
	b	b2755
.ltorg
b2755:
	mov	r1,	r1
	mov	r9,	#0
	cmp	r2,	r9
	bne	b2759
	b	b2757
.ltorg
b2757:
	mov	r2,	#0
	b	b2758
.ltorg
b2758:
	mov	r2,	r2
	mov	r1,	#0
	cmp	r6,	r1
	bne	b2763
	b	b2761
.ltorg
b2761:
	mov	r1,	#0
	b	b2762
.ltorg
b2762:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r8,	r0
	bne	b2767
	b	b2765
.ltorg
b2765:
	mov	r0,	#0
	b	b2766
.ltorg
b2766:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r1,	r6
	bne	b2768
	b	b2771
.ltorg
b2768:
	mov	r7,	#1
	b	b2770
.ltorg
b2770:
	mov	r7,	r7
	mov	r0,	#0
	cmp	r4,	r0
	bne	b2772
	b	b2775
.ltorg
b2772:
	mov	r1,	#1
	b	b2774
.ltorg
b2774:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r4,	r0
	bne	b2779
	b	b2777
.ltorg
b2777:
	mov	r0,	#0
	b	b2778
.ltorg
b2778:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r0,	r6
	moveq	r6,	#1
	movne	r6,	#0
	mov	r0,	#0
	cmp	r6,	r0
	bne	b2780
	b	b2781
.ltorg
b2780:
	mov	r0,	#1
	b	b2782
.ltorg
b2781:
	mov	r0,	#0
	b	b2782
.ltorg
b2782:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r1,	r6
	bne	b2786
	b	b2784
.ltorg
b2784:
	mov	r8,	#0
	b	b2785
.ltorg
b2785:
	mov	r8,	r8
	mov	r0,	#0
	cmp	r8,	r0
	bne	b2787
	b	b2790
.ltorg
b2787:
	mov	r1,	#1
	b	b2789
.ltorg
b2789:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r8,	r0
	bne	b2794
	b	b2792
.ltorg
b2792:
	mov	r0,	#0
	b	b2793
.ltorg
b2793:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r0,	r6
	moveq	r0,	#1
	movne	r0,	#0
	mov	r6,	#0
	cmp	r0,	r6
	bne	b2795
	b	b2796
.ltorg
b2795:
	mov	r0,	#1
	b	b2797
.ltorg
b2796:
	mov	r0,	#0
	b	b2797
.ltorg
b2797:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r1,	r6
	bne	b2801
	b	b2799
.ltorg
b2799:
	mov	r6,	#0
	b	b2800
.ltorg
b2800:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r4,	r0
	bne	b2805
	b	b2803
.ltorg
b2803:
	mov	r1,	#0
	b	b2804
.ltorg
b2804:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r8,	r0
	bne	b2809
	b	b2807
.ltorg
b2807:
	mov	r0,	#0
	b	b2808
.ltorg
b2808:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b2810
	b	b2813
.ltorg
b2810:
	mov	r7,	#1
	b	b2812
.ltorg
b2812:
	mov	r7,	r7
	mov	r1,	#0
	ldr	r0,	[sp,	#816]
	cmp	r0,	r1
	bne	b2814
	b	b2817
.ltorg
b2814:
	mov	r1,	#1
	b	b2816
.ltorg
b2816:
	mov	r1,	r1
	mov	r4,	#0
	ldr	r0,	[sp,	#816]
	cmp	r0,	r4
	bne	b2821
	b	b2819
.ltorg
b2819:
	mov	r0,	#0
	b	b2820
.ltorg
b2820:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r0,	#1
	movne	r0,	#0
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2822
	b	b2823
.ltorg
b2822:
	mov	r0,	#1
	b	b2824
.ltorg
b2823:
	mov	r0,	#0
	b	b2824
.ltorg
b2824:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b2828
	b	b2826
.ltorg
b2826:
	mov	r4,	#0
	b	b2827
.ltorg
b2827:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r4,	r0
	bne	b2829
	b	b2832
.ltorg
b2829:
	mov	r1,	#1
	b	b2831
.ltorg
b2831:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r4,	r0
	bne	b2836
	b	b2834
.ltorg
b2836:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b2833
	b	b2834
.ltorg
b2833:
	mov	r0,	#1
	b	b2835
.ltorg
b2834:
	mov	r0,	#0
	b	b2835
.ltorg
b2835:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r0,	r5
	moveq	r0,	#1
	movne	r0,	#0
	mov	r5,	#0
	cmp	r0,	r5
	bne	b2837
	b	b2838
.ltorg
b2839:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r1,	r5
	bne	b2843
	b	b2841
.ltorg
b2841:
	mov	r5,	#0
	b	b2842
.ltorg
b2842:
	mov	r5,	r5
	mov	r1,	#0
	ldr	r0,	[sp,	#816]
	cmp	r0,	r1
	bne	b2847
	b	b2845
.ltorg
b2847:
	mov	r1,	#0
	ldr	r0,	[sp,	#804]
	cmp	r0,	r1
	bne	b2844
	b	b2845
.ltorg
b2844:
	mov	r1,	#1
	b	b2846
.ltorg
b2845:
	mov	r1,	#0
	b	b2846
.ltorg
b2846:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r4,	r0
	bne	b2851
	b	b2849
.ltorg
b2850:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b2852
	b	b2855
.ltorg
b2854:
	mov	r7,	r7
	mov	r1,	#0
	ldr	r0,	[sp,	#788]
	cmp	r0,	r1
	bne	b2856
	b	b2859
.ltorg
b2856:
	mov	r1,	#1
	b	b2858
.ltorg
b2858:
	mov	r1,	r1
	mov	r4,	#0
	ldr	r0,	[sp,	#788]
	cmp	r0,	r4
	bne	b2863
	b	b2861
.ltorg
b2861:
	mov	r0,	#0
	b	b2862
.ltorg
b2862:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r0,	#1
	movne	r0,	#0
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2864
	b	b2865
.ltorg
b2864:
	mov	r0,	#1
	b	b2866
.ltorg
b2865:
	mov	r0,	#0
	b	b2866
.ltorg
b2866:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b2870
	b	b2868
.ltorg
b2868:
	mov	r4,	#0
	b	b2869
.ltorg
b2869:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r4,	r0
	bne	b2871
	b	b2874
.ltorg
b2871:
	mov	r1,	#1
	b	b2873
.ltorg
b2873:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r4,	r0
	bne	b2878
	b	b2876
.ltorg
b2876:
	mov	r0,	#0
	b	b2877
.ltorg
b2877:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r0,	r8
	moveq	r8,	#1
	movne	r8,	#0
	mov	r0,	#0
	cmp	r8,	r0
	bne	b2879
	b	b2880
.ltorg
b2879:
	mov	r0,	#1
	b	b2881
.ltorg
b2880:
	mov	r0,	#0
	b	b2881
.ltorg
b2881:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r1,	r8
	bne	b2885
	b	b2883
.ltorg
b2883:
	mov	r9,	#0
	b	b2884
.ltorg
b2884:
	mov	r9,	r9
	mov	r1,	#0
	ldr	r0,	[sp,	#788]
	cmp	r0,	r1
	bne	b2889
	b	b2887
.ltorg
b2887:
	mov	r1,	#0
	b	b2888
.ltorg
b2888:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r4,	r0
	bne	b2893
	b	b2891
.ltorg
b2891:
	mov	r0,	#0
	b	b2892
.ltorg
b2892:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b2894
	b	b2897
.ltorg
b2894:
	mov	r7,	#1
	b	b2896
.ltorg
b2896:
	mov	r7,	r7
	mov	r1,	#0
	ldr	r0,	[sp,	#792]
	cmp	r0,	r1
	bne	b2898
	b	b2901
.ltorg
b2898:
	mov	r1,	#1
	b	b2900
.ltorg
b2900:
	mov	r1,	r1
	mov	r4,	#0
	ldr	r0,	[sp,	#792]
	cmp	r0,	r4
	bne	b2905
	b	b2903
.ltorg
b2903:
	mov	r0,	#0
	b	b2904
.ltorg
b2904:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r0,	#1
	movne	r0,	#0
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2906
	b	b2907
.ltorg
b2906:
	mov	r0,	#1
	b	b2908
.ltorg
b2907:
	mov	r0,	#0
	b	b2908
.ltorg
b2908:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b2912
	b	b2910
.ltorg
b2910:
	mov	r4,	#0
	b	b2911
.ltorg
b2911:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r4,	r0
	bne	b2913
	b	b2916
.ltorg
b2913:
	mov	r1,	#1
	b	b2915
.ltorg
b2915:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r4,	r0
	bne	b2920
	b	b2918
.ltorg
b2918:
	mov	r0,	#0
	b	b2919
.ltorg
b2919:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r0,	r8
	moveq	r8,	#1
	movne	r8,	#0
	mov	r0,	#0
	cmp	r8,	r0
	bne	b2921
	b	b2922
.ltorg
b2921:
	mov	r0,	#1
	b	b2923
.ltorg
b2922:
	mov	r0,	#0
	b	b2923
.ltorg
b2923:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r1,	r8
	bne	b2927
	b	b2925
.ltorg
b2925:
	mov	r8,	#0
	b	b2926
.ltorg
b2926:
	mov	r8,	r8
	mov	r1,	#0
	ldr	r0,	[sp,	#792]
	cmp	r0,	r1
	bne	b2931
	b	b2929
.ltorg
b2929:
	mov	r1,	#0
	b	b2930
.ltorg
b2930:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r4,	r0
	bne	b2935
	b	b2933
.ltorg
b2933:
	mov	r0,	#0
	b	b2934
.ltorg
b2934:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b2936
	b	b2939
.ltorg
b2936:
	mov	r0,	#1
	b	b2938
.ltorg
b2938:
	mov	r0,	r0
	mov	r4,	#0
	ldr	r1,	[sp,	#892]
	cmp	r1,	r4
	bne	b2940
	b	b2943
.ltorg
b2940:
	mov	r4,	#1
	b	b2942
.ltorg
b2942:
	mov	r4,	r4
	mov	r7,	#0
	ldr	r1,	[sp,	#892]
	cmp	r1,	r7
	bne	b2947
	b	b2945
.ltorg
b2945:
	mov	r1,	#0
	b	b2946
.ltorg
b2946:
	mov	r1,	r1
	mov	r7,	#0
	cmp	r1,	r7
	moveq	r1,	#1
	movne	r1,	#0
	mov	r7,	#0
	cmp	r1,	r7
	bne	b2948
	b	b2949
.ltorg
b2948:
	mov	r1,	#1
	b	b2950
.ltorg
b2949:
	mov	r1,	#0
	b	b2950
.ltorg
b2950:
	mov	r1,	r1
	mov	r7,	#0
	cmp	r4,	r7
	bne	b2954
	b	b2952
.ltorg
b2952:
	mov	r4,	#0
	b	b2953
.ltorg
b2953:
	mov	r4,	r4
	mov	r1,	#0
	cmp	r4,	r1
	bne	b2955
	b	b2958
.ltorg
b2955:
	mov	r7,	#1
	b	b2957
.ltorg
b2957:
	mov	r7,	r7
	mov	r1,	#0
	cmp	r4,	r1
	bne	b2962
	b	b2960
.ltorg
b2960:
	mov	r1,	#0
	b	b2961
.ltorg
b2961:
	mov	r1,	r1
	mov	r10,	#0
	cmp	r1,	r10
	moveq	r10,	#1
	movne	r10,	#0
	mov	r1,	#0
	cmp	r10,	r1
	bne	b2963
	b	b2964
.ltorg
b2963:
	mov	r1,	#1
	b	b2965
.ltorg
b2964:
	mov	r1,	#0
	b	b2965
.ltorg
b2965:
	mov	r1,	r1
	mov	r10,	#0
	cmp	r7,	r10
	bne	b2969
	b	b2967
.ltorg
b2967:
	mov	r7,	#0
	b	b2968
.ltorg
b2968:
	mov	r7,	r7
	mov	r10,	#0
	ldr	r1,	[sp,	#892]
	cmp	r1,	r10
	bne	b2973
	b	b2971
.ltorg
b2971:
	mov	r1,	#0
	b	b2972
.ltorg
b2972:
	mov	r1,	r1
	mov	r10,	#0
	cmp	r4,	r10
	bne	b2977
	b	b2975
.ltorg
b2977:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2974
	b	b2975
.ltorg
b2974:
	mov	r0,	#1
	b	b2976
.ltorg
b2975:
	mov	r0,	#0
	b	b2976
.ltorg
b2976:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b2978
	b	b2981
.ltorg
b2981:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2978
	b	b2979
.ltorg
b2979:
	mov	r10,	#0
	b	b2980
.ltorg
b2978:
	mov	r10,	#1
	b	b2980
.ltorg
b2980:
	mov	r10,	r10
	mov	r1,	#0
	ldr	r0,	[sp,	#904]
	cmp	r0,	r1
	bne	b2982
	b	b2985
.ltorg
b2984:
	mov	r1,	r1
	mov	r4,	#0
	ldr	r0,	[sp,	#904]
	cmp	r0,	r4
	bne	b2989
	b	b2987
.ltorg
b2987:
	mov	r0,	#0
	b	b2988
.ltorg
b2988:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r0,	#1
	movne	r0,	#0
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2990
	b	b2991
.ltorg
b2990:
	mov	r0,	#1
	b	b2992
.ltorg
b2991:
	mov	r0,	#0
	b	b2992
.ltorg
b2992:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b2996
	b	b2994
.ltorg
b2994:
	mov	r4,	#0
	b	b2995
.ltorg
b2995:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r4,	r0
	bne	b2997
	b	b3000
.ltorg
b2997:
	mov	r1,	#1
	b	b2999
.ltorg
b2999:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r4,	r0
	bne	b3004
	b	b3002
.ltorg
b3002:
	mov	r0,	#0
	b	b3003
.ltorg
b3003:
	mov	r0,	r0
	mov	r11,	#0
	cmp	r0,	r11
	moveq	r11,	#1
	movne	r11,	#0
	mov	r0,	#0
	cmp	r11,	r0
	bne	b3005
	b	b3006
.ltorg
b3005:
	mov	r0,	#1
	b	b3007
.ltorg
b3006:
	mov	r0,	#0
	b	b3007
.ltorg
b3007:
	mov	r0,	r0
	mov	r11,	#0
	cmp	r1,	r11
	bne	b3011
	b	b3009
.ltorg
b3009:
	mov	r0,	#0
	b	b3010
.ltorg
b3010:
	mov	r0,	r0
	str	r0,	[sp,	#588]
	mov	r1,	#0
	ldr	r0,	[sp,	#904]
	cmp	r0,	r1
	bne	b3015
	b	b3013
.ltorg
b3013:
	mov	r1,	#0
	b	b3014
.ltorg
b3014:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r4,	r0
	bne	b3019
	b	b3017
.ltorg
b3017:
	mov	r0,	#0
	b	b3018
.ltorg
b3018:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b3020
	b	b3023
.ltorg
b3020:
	mov	r0,	#1
	b	b3022
.ltorg
b3022:
	mov	r0,	r0
	str	r0,	[sp,	#604]
	mov	r1,	#0
	ldr	r0,	[sp,	#488]
	cmp	r0,	r1
	bne	b3024
	b	b3027
.ltorg
b3024:
	mov	r1,	#1
	b	b3026
.ltorg
b3026:
	mov	r1,	r1
	mov	r4,	#0
	ldr	r0,	[sp,	#488]
	cmp	r0,	r4
	bne	b3031
	b	b3029
.ltorg
b3029:
	mov	r0,	#0
	b	b3030
.ltorg
b3030:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r0,	#1
	movne	r0,	#0
	mov	r4,	#0
	cmp	r0,	r4
	bne	b3032
	b	b3033
.ltorg
b3032:
	mov	r0,	#1
	b	b3034
.ltorg
b3033:
	mov	r0,	#0
	b	b3034
.ltorg
b3034:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b3038
	b	b3036
.ltorg
b3036:
	mov	r4,	#0
	b	b3037
.ltorg
b3037:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r4,	r0
	bne	b3039
	b	b3042
.ltorg
b3039:
	mov	r1,	#1
	b	b3041
.ltorg
b3041:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r4,	r0
	bne	b3046
	b	b3044
.ltorg
b3044:
	mov	r0,	#0
	b	b3045
.ltorg
b3045:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r0,	r10
	moveq	r10,	#1
	movne	r10,	#0
	mov	r0,	#0
	cmp	r10,	r0
	bne	b3047
	b	b3048
.ltorg
b3047:
	mov	r0,	#1
	b	b3049
.ltorg
b3048:
	mov	r0,	#0
	b	b3049
.ltorg
b3049:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r1,	r10
	bne	b3053
	b	b3051
.ltorg
b3051:
	mov	r0,	#0
	b	b3052
.ltorg
b3052:
	mov	r0,	r0
	str	r0,	[sp,	#3816]
	mov	r1,	#0
	ldr	r0,	[sp,	#488]
	cmp	r0,	r1
	bne	b3057
	b	b3055
.ltorg
b3055:
	mov	r1,	#0
	b	b3056
.ltorg
b3056:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r4,	r0
	bne	b3061
	b	b3059
.ltorg
b3059:
	mov	r0,	#0
	b	b3060
.ltorg
b3060:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b3062
	b	b3065
.ltorg
b3062:
	mov	r0,	#1
	b	b3064
.ltorg
b3064:
	mov	r0,	r0
	mov	r4,	#0
	ldr	r1,	[sp,	#576]
	cmp	r1,	r4
	bne	b3066
	b	b3069
.ltorg
b3066:
	mov	r4,	#1
	b	b3068
.ltorg
b3068:
	mov	r4,	r4
	mov	r10,	#0
	ldr	r1,	[sp,	#576]
	cmp	r1,	r10
	bne	b3073
	b	b3071
.ltorg
b3071:
	mov	r1,	#0
	b	b3072
.ltorg
b3072:
	mov	r1,	r1
	mov	r10,	#0
	cmp	r1,	r10
	moveq	r10,	#1
	movne	r10,	#0
	mov	r1,	#0
	cmp	r10,	r1
	bne	b3074
	b	b3075
.ltorg
b3074:
	mov	r1,	#1
	b	b3076
.ltorg
b3075:
	mov	r1,	#0
	b	b3076
.ltorg
b3076:
	mov	r1,	r1
	mov	r10,	#0
	cmp	r4,	r10
	bne	b3080
	b	b3078
.ltorg
b3078:
	mov	r1,	#0
	b	b3079
.ltorg
b3079:
	mov	r1,	r1
	str	r1,	[sp,	#600]
	mov	r4,	#0
	ldr	r1,	[sp,	#600]
	cmp	r1,	r4
	bne	b3081
	b	b3084
.ltorg
b3081:
	mov	r4,	#1
	b	b3083
.ltorg
b3083:
	mov	r4,	r4
	mov	r10,	#0
	ldr	r1,	[sp,	#600]
	cmp	r1,	r10
	bne	b3088
	b	b3086
.ltorg
b3086:
	mov	r1,	#0
	b	b3087
.ltorg
b3087:
	mov	r1,	r1
	mov	r10,	#0
	cmp	r1,	r10
	moveq	r10,	#1
	movne	r10,	#0
	mov	r1,	#0
	cmp	r10,	r1
	bne	b3089
	b	b3090
.ltorg
b3089:
	mov	r1,	#1
	b	b3091
.ltorg
b3090:
	mov	r1,	#0
	b	b3091
.ltorg
b3091:
	mov	r1,	r1
	mov	r10,	#0
	cmp	r4,	r10
	bne	b3095
	b	b3093
.ltorg
b3093:
	mov	r4,	#0
	b	b3094
.ltorg
b3094:
	mov	r4,	r4
	mov	r10,	#0
	ldr	r1,	[sp,	#576]
	cmp	r1,	r10
	bne	b3099
	b	b3097
.ltorg
b3097:
	mov	r1,	#0
	b	b3098
.ltorg
b3098:
	mov	r1,	r1
	mov	r10,	#0
	str	r10,	[sp,	#1004]
	ldr	r10,	[sp,	#600]
	ldr	r11,	[sp,	#1004]
	str	r11,	[sp,	#3176]
	ldr	r11,	[sp,	#3176]
	str	r11,	[sp,	#2284]
	ldr	r11,	[sp,	#2284]
	str	r11,	[sp,	#3164]
	ldr	r11,	[sp,	#3164]
	str	r11,	[sp,	#1824]
	ldr	r11,	[sp,	#1824]
	str	r11,	[sp,	#3184]
	ldr	r11,	[sp,	#3184]
	str	r11,	[sp,	#2280]
	ldr	r11,	[sp,	#2280]
	str	r11,	[sp,	#3172]
	ldr	r11,	[sp,	#3172]
	str	r11,	[sp,	#1280]
	ldr	r11,	[sp,	#1280]
	str	r11,	[sp,	#3140]
	ldr	r11,	[sp,	#3140]
	str	r11,	[sp,	#2152]
	ldr	r11,	[sp,	#2152]
	str	r11,	[sp,	#3132]
	ldr	r11,	[sp,	#3132]
	str	r11,	[sp,	#1820]
	ldr	r11,	[sp,	#1820]
	str	r11,	[sp,	#3104]
	ldr	r11,	[sp,	#3104]
	str	r11,	[sp,	#2156]
	ldr	r11,	[sp,	#2156]
	str	r11,	[sp,	#3108]
	ldr	r11,	[sp,	#3108]
	cmp	r10,	r11
	bne	b3103
	b	b3101
.ltorg
b3101:
	mov	r0,	#0
	b	b3102
.ltorg
b3102:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r1,	r10
	bne	b3104
	b	b3107
.ltorg
b3104:
	b	b3106
.ltorg
b3106:
	mov	r1,	r4, lsl #1
	ldr	r0,	[sp,	#3816]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#588]
	add	r0,	r1,	r0
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r7
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r8
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r9
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r5
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r6
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r2
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r3
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#636]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#640]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#644]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#632]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#624]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#628]
	add	r0,	r1,	r0
	mov	r0,	r0
	bl	fib
	mov	r0,	r0
	ldr	r1,	[sp,	#232]
	mov	r2,	r1, asr #31
	ldr	r1,	[sp,	#232]
	ands	r1,	r1,	#1
	orrne	r1,	r1,	r2, lsl #1
	mov	r2,	#0
	cmp	r1,	r2
	mov	r1,	r1
	blt	b3108
	b	b3109
.ltorg
b3108:
	mov	r2,	#0
	sub	r1,	r2,	r1
	mov	r1,	r1
	b	b3109
.ltorg
b3109:
	mov	r1,	r1
	str	r1,	[sp,	#444]
	ldr	r1,	[sp,	#232]
	mov	r2,	r1, asr #31
	ldr	r1,	[sp,	#232]
	add	r1,	r1,	r2, lsr #31
	mov	r1,	r1, asr #1
	mov	r2,	r1, asr #31
	ands	r6,	r1,	#1
	orrne	r6,	r6,	r2, lsl #1
	mov	r1,	#0
	cmp	r6,	r1
	mov	r6,	r6
	blt	b3110
	b	b3111
.ltorg
b3110:
	mov	r1,	#0
	sub	r6,	r1,	r6
	mov	r6,	r6
	b	b3111
.ltorg
b3111:
	mov	r6,	r6
	ldr	r1,	[sp,	#232]
	mov	r2,	r1, asr #31
	ldr	r1,	[sp,	#232]
	add	r1,	r1,	r2, lsr #30
	mov	r1,	r1, asr #2
	mov	r2,	r1, asr #31
	ands	r1,	r1,	#1
	orrne	r1,	r1,	r2, lsl #1
	mov	r2,	#0
	cmp	r1,	r2
	mov	r1,	r1
	blt	b3112
	b	b3113
.ltorg
b3113:
	mov	r1,	r1
	ldr	r2,	[sp,	#232]
	mov	r3,	r2, asr #31
	ldr	r2,	[sp,	#232]
	add	r2,	r2,	r3, lsr #29
	mov	r2,	r2, asr #3
	mov	r3,	r2, asr #31
	ands	r5,	r2,	#1
	orrne	r5,	r5,	r3, lsl #1
	mov	r2,	#0
	cmp	r5,	r2
	mov	r5,	r5
	blt	b3114
	b	b3115
.ltorg
b3114:
	mov	r2,	#0
	sub	r5,	r2,	r5
	mov	r5,	r5
	b	b3115
.ltorg
b3115:
	mov	r5,	r5
	ldr	r2,	[sp,	#232]
	mov	r3,	r2, asr #31
	ldr	r2,	[sp,	#232]
	add	r2,	r2,	r3, lsr #28
	mov	r2,	r2, asr #4
	mov	r3,	r2, asr #31
	ands	r4,	r2,	#1
	orrne	r4,	r4,	r3, lsl #1
	mov	r2,	#0
	cmp	r4,	r2
	mov	r4,	r4
	blt	b3116
	b	b3117
.ltorg
b3116:
	mov	r2,	#0
	sub	r4,	r2,	r4
	mov	r4,	r4
	b	b3117
.ltorg
b3117:
	mov	r4,	r4
	ldr	r2,	[sp,	#232]
	mov	r3,	r2, asr #31
	ldr	r2,	[sp,	#232]
	add	r2,	r2,	r3, lsr #27
	mov	r3,	r2, asr #5
	mov	r2,	r3, asr #31
	ands	r3,	r3,	#1
	orrne	r3,	r3,	r2, lsl #1
	mov	r2,	#0
	cmp	r3,	r2
	mov	r3,	r3
	blt	b3118
	b	b3119
.ltorg
b3118:
	mov	r2,	#0
	sub	r3,	r2,	r3
	mov	r3,	r3
	b	b3119
.ltorg
b3119:
	mov	r3,	r3
	ldr	r2,	[sp,	#232]
	mov	r7,	r2, asr #31
	ldr	r2,	[sp,	#232]
	add	r2,	r2,	r7, lsr #26
	mov	r2,	r2, asr #6
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3120
	b	b3121
.ltorg
b3120:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3121
.ltorg
b3121:
	mov	r2,	r2
	str	r2,	[sp,	#780]
	ldr	r2,	[sp,	#232]
	mov	r7,	r2, asr #31
	ldr	r2,	[sp,	#232]
	add	r2,	r2,	r7, lsr #25
	mov	r2,	r2, asr #7
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3122
	b	b3123
.ltorg
b3122:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3123
.ltorg
b3123:
	mov	r2,	r2
	str	r2,	[sp,	#776]
	ldr	r2,	[sp,	#232]
	mov	r7,	r2, asr #31
	ldr	r2,	[sp,	#232]
	add	r2,	r2,	r7, lsr #24
	mov	r2,	r2, asr #8
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3124
	b	b3125
.ltorg
b3124:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3125
.ltorg
b3125:
	mov	r2,	r2
	str	r2,	[sp,	#764]
	ldr	r2,	[sp,	#232]
	mov	r7,	r2, asr #31
	ldr	r2,	[sp,	#232]
	add	r2,	r2,	r7, lsr #23
	mov	r2,	r2, asr #9
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3126
	b	b3127
.ltorg
b3126:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3127
.ltorg
b3127:
	mov	r2,	r2
	str	r2,	[sp,	#280]
	ldr	r2,	[sp,	#232]
	mov	r7,	r2, asr #31
	ldr	r2,	[sp,	#232]
	add	r2,	r2,	r7, lsr #22
	mov	r2,	r2, asr #10
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3128
	b	b3129
.ltorg
b3129:
	mov	r2,	r2
	str	r2,	[sp,	#300]
	ldr	r2,	[sp,	#232]
	mov	r7,	r2, asr #31
	ldr	r2,	[sp,	#232]
	add	r2,	r2,	r7, lsr #21
	mov	r2,	r2, asr #11
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3130
	b	b3131
.ltorg
b3130:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3131
.ltorg
b3131:
	mov	r2,	r2
	str	r2,	[sp,	#356]
	ldr	r2,	[sp,	#232]
	mov	r7,	r2, asr #31
	ldr	r2,	[sp,	#232]
	add	r2,	r2,	r7, lsr #20
	mov	r2,	r2, asr #12
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3132
	b	b3133
.ltorg
b3132:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3133
.ltorg
b3133:
	mov	r2,	r2
	str	r2,	[sp,	#388]
	ldr	r2,	[sp,	#232]
	mov	r7,	r2, asr #31
	ldr	r2,	[sp,	#232]
	add	r2,	r2,	r7, lsr #19
	mov	r2,	r2, asr #13
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3134
	b	b3135
.ltorg
b3134:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3135
.ltorg
b3135:
	mov	r2,	r2
	str	r2,	[sp,	#416]
	ldr	r2,	[sp,	#232]
	mov	r7,	r2, asr #31
	ldr	r2,	[sp,	#232]
	add	r2,	r2,	r7, lsr #18
	mov	r2,	r2, asr #14
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3136
	b	b3137
.ltorg
b3136:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3137
.ltorg
b3137:
	mov	r2,	r2
	str	r2,	[sp,	#956]
	ldr	r2,	[sp,	#232]
	mov	r7,	r2, asr #31
	ldr	r2,	[sp,	#232]
	add	r2,	r2,	r7, lsr #17
	mov	r2,	r2, asr #15
	mov	r7,	r2, asr #31
	ands	r10,	r2,	#1
	orrne	r10,	r10,	r7, lsl #1
	mov	r2,	#0
	cmp	r10,	r2
	mov	r10,	r10
	blt	b3138
	b	b3139
.ltorg
b3138:
	mov	r2,	#0
	sub	r10,	r2,	r10
	mov	r10,	r10
	b	b3139
.ltorg
b3139:
	mov	r10,	r10
	mov	r2,	r0, asr #31
	ands	r8,	r0,	#1
	orrne	r8,	r8,	r2, lsl #1
	mov	r2,	#0
	cmp	r8,	r2
	mov	r8,	r8
	blt	b3140
	b	b3141
.ltorg
b3140:
	mov	r2,	#0
	sub	r8,	r2,	r8
	mov	r8,	r8
	b	b3141
.ltorg
b3141:
	mov	r8,	r8
	mov	r2,	r0, asr #31
	add	r2,	r0,	r2, lsr #31
	mov	r2,	r2, asr #1
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3142
	b	b3143
.ltorg
b3142:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3143
.ltorg
b3143:
	mov	r2,	r2
	str	r2,	[sp,	#496]
	mov	r2,	r0, asr #31
	add	r2,	r0,	r2, lsr #30
	mov	r2,	r2, asr #2
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3144
	b	b3145
.ltorg
b3144:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3145
.ltorg
b3145:
	mov	r2,	r2
	str	r2,	[sp,	#504]
	mov	r2,	r0, asr #31
	add	r2,	r0,	r2, lsr #29
	mov	r2,	r2, asr #3
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3146
	b	b3147
.ltorg
b3146:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3147
.ltorg
b3147:
	mov	r2,	r2
	str	r2,	[sp,	#908]
	mov	r2,	r0, asr #31
	add	r2,	r0,	r2, lsr #28
	mov	r2,	r2, asr #4
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3148
	b	b3149
.ltorg
b3148:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3149
.ltorg
b3149:
	mov	r2,	r2
	str	r2,	[sp,	#912]
	mov	r2,	r0, asr #31
	add	r2,	r0,	r2, lsr #27
	mov	r2,	r2, asr #5
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3150
	b	b3151
.ltorg
b3150:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3151
.ltorg
b3151:
	mov	r2,	r2
	str	r2,	[sp,	#896]
	mov	r2,	r0, asr #31
	add	r2,	r0,	r2, lsr #26
	mov	r2,	r2, asr #6
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3152
	b	b3153
.ltorg
b3152:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3153
.ltorg
b3153:
	mov	r2,	r2
	str	r2,	[sp,	#900]
	mov	r2,	r0, asr #31
	add	r2,	r0,	r2, lsr #25
	mov	r2,	r2, asr #7
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3154
	b	b3155
.ltorg
b3154:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3155
.ltorg
b3155:
	mov	r2,	r2
	str	r2,	[sp,	#784]
	mov	r2,	r0, asr #31
	add	r2,	r0,	r2, lsr #24
	mov	r2,	r2, asr #8
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3156
	b	b3157
.ltorg
b3156:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3157
.ltorg
b3157:
	mov	r2,	r2
	str	r2,	[sp,	#808]
	mov	r2,	r0, asr #31
	add	r2,	r0,	r2, lsr #23
	mov	r2,	r2, asr #9
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3158
	b	b3159
.ltorg
b3158:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3159
.ltorg
b3159:
	mov	r2,	r2
	str	r2,	[sp,	#812]
	mov	r2,	r0, asr #31
	add	r2,	r0,	r2, lsr #22
	mov	r2,	r2, asr #10
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3160
	b	b3161
.ltorg
b3160:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3161
.ltorg
b3161:
	mov	r2,	r2
	str	r2,	[sp,	#308]
	mov	r2,	r0, asr #31
	add	r2,	r0,	r2, lsr #21
	mov	r2,	r2, asr #11
	mov	r7,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r7, lsl #1
	mov	r7,	#0
	cmp	r2,	r7
	mov	r2,	r2
	blt	b3162
	b	b3163
.ltorg
b3162:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3163
.ltorg
b3163:
	mov	r2,	r2
	str	r2,	[sp,	#796]
	mov	r2,	r0, asr #31
	add	r2,	r0,	r2, lsr #20
	mov	r2,	r2, asr #12
	mov	r9,	r2, asr #31
	ands	r7,	r2,	#1
	orrne	r7,	r7,	r9, lsl #1
	mov	r2,	#0
	cmp	r7,	r2
	mov	r7,	r7
	blt	b3164
	b	b3165
.ltorg
b3164:
	mov	r2,	#0
	sub	r7,	r2,	r7
	mov	r7,	r7
	b	b3165
.ltorg
b3165:
	mov	r7,	r7
	mov	r2,	r0, asr #31
	add	r2,	r0,	r2, lsr #19
	mov	r2,	r2, asr #13
	mov	r9,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r9, lsl #1
	mov	r9,	#0
	cmp	r2,	r9
	mov	r2,	r2
	blt	b3166
	b	b3167
.ltorg
b3166:
	mov	r9,	#0
	sub	r2,	r9,	r2
	mov	r2,	r2
	b	b3167
.ltorg
b3167:
	mov	r2,	r2
	str	r2,	[sp,	#424]
	mov	r2,	r0, asr #31
	add	r2,	r0,	r2, lsr #18
	mov	r2,	r2, asr #14
	mov	r9,	r2, asr #31
	ands	r2,	r2,	#1
	orrne	r2,	r2,	r9, lsl #1
	mov	r9,	#0
	cmp	r2,	r9
	mov	r2,	r2
	blt	b3168
	b	b3169
.ltorg
b3168:
	mov	r9,	#0
	sub	r2,	r9,	r2
	mov	r2,	r2
	b	b3169
.ltorg
b3169:
	mov	r2,	r2
	str	r2,	[sp,	#192]
	mov	r2,	r0, asr #31
	add	r0,	r0,	r2, lsr #17
	mov	r0,	r0, asr #15
	mov	r2,	r0, asr #31
	ands	r0,	r0,	#1
	orrne	r0,	r0,	r2, lsl #1
	mov	r2,	#0
	cmp	r0,	r2
	mov	r0,	r0
	blt	b3170
	b	b3171
.ltorg
b3170:
	mov	r2,	#0
	sub	r0,	r2,	r0
	mov	r0,	r0
	b	b3171
.ltorg
b3171:
	mov	r0,	r0
	str	r0,	[sp,	#220]
	mov	r2,	#0
	ldr	r0,	[sp,	#444]
	cmp	r0,	r2
	bne	b3172
	b	b3175
.ltorg
b3172:
	mov	r2,	#1
	b	b3174
.ltorg
b3174:
	mov	r2,	r2
	mov	r0,	#0
	ldr	r9,	[sp,	#444]
	cmp	r9,	r0
	bne	b3179
	b	b3177
.ltorg
b3177:
	mov	r0,	#0
	b	b3178
.ltorg
b3178:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r9,	#1
	movne	r9,	#0
	mov	r0,	#0
	cmp	r9,	r0
	bne	b3180
	b	b3181
.ltorg
b3180:
	mov	r0,	#1
	b	b3182
.ltorg
b3181:
	mov	r0,	#0
	b	b3182
.ltorg
b3182:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r2,	r9
	bne	b3186
	b	b3184
.ltorg
b3184:
	mov	r2,	#0
	b	b3185
.ltorg
b3185:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3187
	b	b3190
.ltorg
b3187:
	mov	r9,	#1
	b	b3189
.ltorg
b3189:
	mov	r9,	r9
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3194
	b	b3192
.ltorg
b3194:
	b	b3192
.ltorg
b3192:
	b	b3195
.ltorg
b3195:
	mov	r0,	#1
	b	b3197
.ltorg
b3197:
	mov	r0,	r0
	str	r0,	[sp,	#584]
	mov	r0,	#0
	cmp	r9,	r0
	bne	b3201
	b	b3199
.ltorg
b3199:
	mov	r0,	#0
	b	b3200
.ltorg
b3200:
	mov	r0,	r0
	str	r0,	[sp,	#224]
	mov	r0,	#0
	ldr	r9,	[sp,	#444]
	cmp	r9,	r0
	bne	b3205
	b	b3203
.ltorg
b3205:
	mov	r0,	#0
	cmp	r8,	r0
	bne	b3202
	b	b3203
.ltorg
b3202:
	mov	r0,	#1
	b	b3204
.ltorg
b3203:
	mov	r0,	#0
	b	b3204
.ltorg
b3204:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r2,	r8
	bne	b3209
	b	b3207
.ltorg
b3209:
	b	b3207
.ltorg
b3207:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b3210
	b	b3213
.ltorg
b3212:
	mov	r0,	r0
	str	r0,	[sp,	#492]
	mov	r0,	#0
	cmp	r6,	r0
	bne	b3214
	b	b3217
.ltorg
b3214:
	mov	r2,	#1
	b	b3216
.ltorg
b3216:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r6,	r0
	bne	b3221
	b	b3219
.ltorg
b3219:
	mov	r0,	#0
	b	b3220
.ltorg
b3220:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r0,	r8
	moveq	r0,	#1
	movne	r0,	#0
	mov	r8,	#0
	cmp	r0,	r8
	bne	b3222
	b	b3223
.ltorg
b3222:
	mov	r0,	#1
	b	b3224
.ltorg
b3223:
	mov	r0,	#0
	b	b3224
.ltorg
b3224:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r2,	r8
	bne	b3228
	b	b3226
.ltorg
b3226:
	mov	r8,	#0
	b	b3227
.ltorg
b3227:
	mov	r8,	r8
	mov	r0,	#0
	cmp	r8,	r0
	bne	b3229
	b	b3232
.ltorg
b3229:
	mov	r2,	#1
	b	b3231
.ltorg
b3231:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r8,	r0
	bne	b3236
	b	b3234
.ltorg
b3234:
	mov	r0,	#0
	b	b3235
.ltorg
b3235:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r0,	#1
	movne	r0,	#0
	mov	r9,	#0
	cmp	r0,	r9
	bne	b3237
	b	b3238
.ltorg
b3237:
	mov	r0,	#1
	b	b3239
.ltorg
b3238:
	mov	r0,	#0
	b	b3239
.ltorg
b3239:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r2,	r9
	bne	b3243
	b	b3241
.ltorg
b3241:
	mov	r0,	#0
	b	b3242
.ltorg
b3242:
	mov	r0,	r0
	str	r0,	[sp,	#120]
	mov	r0,	#0
	cmp	r6,	r0
	bne	b3247
	b	b3245
.ltorg
b3245:
	mov	r2,	#0
	b	b3246
.ltorg
b3246:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r8,	r0
	bne	b3251
	b	b3249
.ltorg
b3249:
	mov	r0,	#0
	b	b3250
.ltorg
b3250:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r2,	r6
	bne	b3252
	b	b3255
.ltorg
b3252:
	mov	r2,	#1
	b	b3254
.ltorg
b3254:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r1,	r0
	bne	b3256
	b	b3259
.ltorg
b3256:
	mov	r6,	#1
	b	b3258
.ltorg
b3258:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r1,	r0
	bne	b3263
	b	b3261
.ltorg
b3261:
	mov	r0,	#0
	b	b3262
.ltorg
b3262:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r0,	r8
	moveq	r0,	#1
	movne	r0,	#0
	mov	r8,	#0
	cmp	r0,	r8
	bne	b3264
	b	b3265
.ltorg
b3264:
	mov	r0,	#1
	b	b3266
.ltorg
b3265:
	mov	r0,	#0
	b	b3266
.ltorg
b3266:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r6,	r8
	bne	b3270
	b	b3268
.ltorg
b3268:
	mov	r6,	#0
	b	b3269
.ltorg
b3269:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r6,	r0
	bne	b3271
	b	b3274
.ltorg
b3271:
	mov	r8,	#1
	b	b3273
.ltorg
b3273:
	mov	r8,	r8
	mov	r0,	#0
	cmp	r6,	r0
	bne	b3278
	b	b3276
.ltorg
b3276:
	mov	r0,	#0
	b	b3277
.ltorg
b3277:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r9,	#1
	movne	r9,	#0
	mov	r0,	#0
	cmp	r9,	r0
	bne	b3279
	b	b3280
.ltorg
b3279:
	mov	r0,	#1
	b	b3281
.ltorg
b3280:
	mov	r0,	#0
	b	b3281
.ltorg
b3281:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r8,	r9
	bne	b3285
	b	b3283
.ltorg
b3283:
	mov	r0,	#0
	b	b3284
.ltorg
b3284:
	mov	r0,	r0
	str	r0,	[sp,	#132]
	mov	r0,	#0
	cmp	r1,	r0
	bne	b3289
	b	b3287
.ltorg
b3287:
	mov	r1,	#0
	b	b3288
.ltorg
b3288:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r6,	r0
	bne	b3293
	b	b3291
.ltorg
b3291:
	mov	r0,	#0
	b	b3292
.ltorg
b3292:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r1,	r2
	bne	b3294
	b	b3297
.ltorg
b3294:
	mov	r2,	#1
	b	b3296
.ltorg
b3296:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r5,	r0
	bne	b3298
	b	b3301
.ltorg
b3298:
	mov	r1,	#1
	b	b3300
.ltorg
b3300:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r5,	r0
	bne	b3305
	b	b3303
.ltorg
b3303:
	mov	r0,	#0
	b	b3304
.ltorg
b3304:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r0,	r6
	moveq	r0,	#1
	movne	r0,	#0
	mov	r6,	#0
	cmp	r0,	r6
	bne	b3306
	b	b3307
.ltorg
b3306:
	mov	r0,	#1
	b	b3308
.ltorg
b3307:
	mov	r0,	#0
	b	b3308
.ltorg
b3308:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r1,	r6
	bne	b3312
	b	b3310
.ltorg
b3310:
	mov	r6,	#0
	b	b3311
.ltorg
b3311:
	mov	r6,	r6
	mov	r0,	#0
	cmp	r6,	r0
	bne	b3313
	b	b3316
.ltorg
b3313:
	mov	r1,	#1
	b	b3315
.ltorg
b3315:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r6,	r0
	bne	b3320
	b	b3318
.ltorg
b3318:
	mov	r0,	#0
	b	b3319
.ltorg
b3319:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r0,	r8
	moveq	r0,	#1
	movne	r0,	#0
	mov	r8,	#0
	cmp	r0,	r8
	bne	b3321
	b	b3322
.ltorg
b3321:
	mov	r0,	#1
	b	b3323
.ltorg
b3322:
	mov	r0,	#0
	b	b3323
.ltorg
b3323:
	mov	r0,	r0
	mov	r8,	#0
	cmp	r1,	r8
	bne	b3327
	b	b3325
.ltorg
b3325:
	mov	r0,	#0
	b	b3326
.ltorg
b3326:
	mov	r0,	r0
	str	r0,	[sp,	#128]
	mov	r0,	#0
	cmp	r5,	r0
	bne	b3331
	b	b3329
.ltorg
b3329:
	mov	r1,	#0
	b	b3330
.ltorg
b3330:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r6,	r0
	bne	b3335
	b	b3333
.ltorg
b3335:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3332
	b	b3333
.ltorg
b3332:
	mov	r0,	#1
	b	b3334
.ltorg
b3333:
	mov	r0,	#0
	b	b3334
.ltorg
b3334:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r1,	r2
	bne	b3336
	b	b3339
.ltorg
b3339:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3336
	b	b3337
.ltorg
b3337:
	mov	r5,	#0
	b	b3338
.ltorg
b3336:
	mov	r5,	#1
	b	b3338
.ltorg
b3338:
	mov	r5,	r5
	mov	r0,	#0
	cmp	r4,	r0
	bne	b3340
	b	b3343
.ltorg
b3342:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r4,	r0
	bne	b3347
	b	b3345
.ltorg
b3345:
	mov	r0,	#0
	b	b3346
.ltorg
b3346:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r0,	r2
	moveq	r2,	#1
	movne	r2,	#0
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3348
	b	b3349
.ltorg
b3348:
	mov	r0,	#1
	b	b3350
.ltorg
b3349:
	mov	r0,	#0
	b	b3350
.ltorg
b3350:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r1,	r2
	bne	b3354
	b	b3352
.ltorg
b3352:
	mov	r2,	#0
	b	b3353
.ltorg
b3353:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3355
	b	b3358
.ltorg
b3355:
	mov	r1,	#1
	b	b3357
.ltorg
b3357:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3362
	b	b3360
.ltorg
b3360:
	mov	r0,	#0
	b	b3361
.ltorg
b3361:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r0,	r6
	moveq	r6,	#1
	movne	r6,	#0
	mov	r0,	#0
	cmp	r6,	r0
	bne	b3363
	b	b3364
.ltorg
b3363:
	mov	r0,	#1
	b	b3365
.ltorg
b3364:
	mov	r0,	#0
	b	b3365
.ltorg
b3365:
	mov	r0,	r0
	mov	r6,	#0
	cmp	r1,	r6
	bne	b3369
	b	b3367
.ltorg
b3367:
	mov	r0,	#0
	b	b3368
.ltorg
b3368:
	mov	r0,	r0
	str	r0,	[sp,	#156]
	mov	r0,	#0
	cmp	r4,	r0
	bne	b3373
	b	b3371
.ltorg
b3371:
	mov	r1,	#0
	b	b3372
.ltorg
b3372:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3377
	b	b3375
.ltorg
b3375:
	mov	r0,	#0
	b	b3376
.ltorg
b3376:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r1,	r2
	bne	b3378
	b	b3381
.ltorg
b3378:
	mov	r4,	#1
	b	b3380
.ltorg
b3380:
	mov	r4,	r4
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3382
	b	b3385
.ltorg
b3382:
	mov	r1,	#1
	b	b3384
.ltorg
b3384:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3389
	b	b3387
.ltorg
b3387:
	mov	r0,	#0
	b	b3388
.ltorg
b3388:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r0,	r2
	moveq	r0,	#1
	movne	r0,	#0
	mov	r2,	#0
	cmp	r0,	r2
	bne	b3390
	b	b3391
.ltorg
b3390:
	mov	r0,	#1
	b	b3392
.ltorg
b3391:
	mov	r0,	#0
	b	b3392
.ltorg
b3392:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r1,	r2
	bne	b3396
	b	b3394
.ltorg
b3394:
	mov	r2,	#0
	b	b3395
.ltorg
b3395:
	mov	r2,	r2
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3397
	b	b3400
.ltorg
b3397:
	mov	r1,	#1
	b	b3399
.ltorg
b3399:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3404
	b	b3402
.ltorg
b3402:
	mov	r0,	#0
	b	b3403
.ltorg
b3403:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r0,	r5
	moveq	r0,	#1
	movne	r0,	#0
	mov	r5,	#0
	cmp	r0,	r5
	bne	b3405
	b	b3406
.ltorg
b3405:
	mov	r0,	#1
	b	b3407
.ltorg
b3406:
	mov	r0,	#0
	b	b3407
.ltorg
b3407:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r1,	r5
	bne	b3411
	b	b3409
.ltorg
b3409:
	mov	r0,	#0
	b	b3410
.ltorg
b3410:
	mov	r0,	r0
	str	r0,	[sp,	#148]
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3415
	b	b3413
.ltorg
b3413:
	mov	r1,	#0
	b	b3414
.ltorg
b3414:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3419
	b	b3417
.ltorg
b3417:
	mov	r0,	#0
	b	b3418
.ltorg
b3418:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r1,	r2
	bne	b3420
	b	b3423
.ltorg
b3420:
	mov	r2,	#1
	b	b3422
.ltorg
b3422:
	mov	r2,	r2
	mov	r0,	#0
	ldr	r1,	[sp,	#780]
	cmp	r1,	r0
	bne	b3424
	b	b3427
.ltorg
b3424:
	mov	r1,	#1
	b	b3426
.ltorg
b3426:
	mov	r1,	r1
	mov	r0,	#0
	ldr	r3,	[sp,	#780]
	cmp	r3,	r0
	bne	b3431
	b	b3429
.ltorg
b3429:
	mov	r0,	#0
	b	b3430
.ltorg
b3430:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r0,	r3
	moveq	r0,	#1
	movne	r0,	#0
	mov	r3,	#0
	cmp	r0,	r3
	bne	b3432
	b	b3433
.ltorg
b3432:
	mov	r0,	#1
	b	b3434
.ltorg
b3433:
	mov	r0,	#0
	b	b3434
.ltorg
b3434:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r1,	r3
	bne	b3438
	b	b3436
.ltorg
b3436:
	mov	r3,	#0
	b	b3437
.ltorg
b3437:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3439
	b	b3442
.ltorg
b3439:
	mov	r1,	#1
	b	b3441
.ltorg
b3441:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3446
	b	b3444
.ltorg
b3444:
	mov	r0,	#0
	b	b3445
.ltorg
b3445:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r0,	#1
	movne	r0,	#0
	mov	r4,	#0
	cmp	r0,	r4
	bne	b3447
	b	b3448
.ltorg
b3447:
	mov	r0,	#1
	b	b3449
.ltorg
b3448:
	mov	r0,	#0
	b	b3449
.ltorg
b3449:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b3453
	b	b3451
.ltorg
b3451:
	mov	r0,	#0
	b	b3452
.ltorg
b3452:
	mov	r0,	r0
	str	r0,	[sp,	#168]
	mov	r0,	#0
	ldr	r1,	[sp,	#780]
	cmp	r1,	r0
	bne	b3457
	b	b3455
.ltorg
b3455:
	mov	r1,	#0
	b	b3456
.ltorg
b3456:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3461
	b	b3459
.ltorg
b3459:
	mov	r0,	#0
	b	b3460
.ltorg
b3460:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r1,	r2
	bne	b3462
	b	b3465
.ltorg
b3462:
	mov	r2,	#1
	b	b3464
.ltorg
b3464:
	mov	r2,	r2
	mov	r1,	#0
	ldr	r0,	[sp,	#776]
	cmp	r0,	r1
	bne	b3466
	b	b3469
.ltorg
b3468:
	mov	r1,	r1
	mov	r0,	#0
	ldr	r3,	[sp,	#776]
	cmp	r3,	r0
	bne	b3473
	b	b3471
.ltorg
b3471:
	mov	r0,	#0
	b	b3472
.ltorg
b3472:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r0,	r3
	moveq	r0,	#1
	movne	r0,	#0
	mov	r3,	#0
	cmp	r0,	r3
	bne	b3474
	b	b3475
.ltorg
b3474:
	mov	r0,	#1
	b	b3476
.ltorg
b3475:
	mov	r0,	#0
	b	b3476
.ltorg
b3476:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r1,	r3
	bne	b3480
	b	b3478
.ltorg
b3479:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3481
	b	b3484
.ltorg
b3483:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3488
	b	b3486
.ltorg
b3486:
	mov	r0,	#0
	b	b3487
.ltorg
b3487:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r0,	#1
	movne	r0,	#0
	mov	r4,	#0
	cmp	r0,	r4
	bne	b3489
	b	b3490
.ltorg
b3489:
	mov	r0,	#1
	b	b3491
.ltorg
b3490:
	mov	r0,	#0
	b	b3491
.ltorg
b3491:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b3495
	b	b3493
.ltorg
b3493:
	mov	r8,	#0
	b	b3494
.ltorg
b3494:
	mov	r8,	r8
	mov	r0,	#0
	ldr	r1,	[sp,	#776]
	cmp	r1,	r0
	bne	b3499
	b	b3497
.ltorg
b3497:
	mov	r1,	#0
	b	b3498
.ltorg
b3498:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3503
	b	b3501
.ltorg
b3501:
	mov	r0,	#0
	b	b3502
.ltorg
b3502:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r1,	r2
	bne	b3504
	b	b3507
.ltorg
b3504:
	mov	r2,	#1
	b	b3506
.ltorg
b3506:
	mov	r2,	r2
	mov	r0,	#0
	ldr	r1,	[sp,	#764]
	cmp	r1,	r0
	bne	b3508
	b	b3511
.ltorg
b3508:
	mov	r1,	#1
	b	b3510
.ltorg
b3510:
	mov	r1,	r1
	mov	r0,	#0
	ldr	r3,	[sp,	#764]
	cmp	r3,	r0
	bne	b3515
	b	b3513
.ltorg
b3513:
	mov	r0,	#0
	b	b3514
.ltorg
b3514:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r0,	r3
	moveq	r0,	#1
	movne	r0,	#0
	mov	r3,	#0
	cmp	r0,	r3
	bne	b3516
	b	b3517
.ltorg
b3516:
	mov	r0,	#1
	b	b3518
.ltorg
b3517:
	mov	r0,	#0
	b	b3518
.ltorg
b3518:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r1,	r3
	bne	b3522
	b	b3520
.ltorg
b3520:
	mov	r3,	#0
	b	b3521
.ltorg
b3521:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3523
	b	b3526
.ltorg
b3523:
	mov	r1,	#1
	b	b3525
.ltorg
b3525:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3530
	b	b3528
.ltorg
b3528:
	mov	r0,	#0
	b	b3529
.ltorg
b3529:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r0,	#1
	movne	r0,	#0
	mov	r4,	#0
	cmp	r0,	r4
	bne	b3531
	b	b3532
.ltorg
b3531:
	mov	r0,	#1
	b	b3533
.ltorg
b3532:
	mov	r0,	#0
	b	b3533
.ltorg
b3533:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b3537
	b	b3535
.ltorg
b3535:
	mov	r6,	#0
	b	b3536
.ltorg
b3536:
	mov	r6,	r6
	mov	r0,	#0
	ldr	r1,	[sp,	#764]
	cmp	r1,	r0
	bne	b3541
	b	b3539
.ltorg
b3539:
	mov	r1,	#0
	b	b3540
.ltorg
b3540:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3545
	b	b3543
.ltorg
b3543:
	mov	r0,	#0
	b	b3544
.ltorg
b3544:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r1,	r2
	bne	b3546
	b	b3549
.ltorg
b3546:
	mov	r2,	#1
	b	b3548
.ltorg
b3548:
	mov	r2,	r2
	mov	r0,	#0
	ldr	r1,	[sp,	#280]
	cmp	r1,	r0
	bne	b3550
	b	b3553
.ltorg
b3550:
	mov	r1,	#1
	b	b3552
.ltorg
b3552:
	mov	r1,	r1
	mov	r0,	#0
	ldr	r3,	[sp,	#280]
	cmp	r3,	r0
	bne	b3557
	b	b3555
.ltorg
b3555:
	mov	r0,	#0
	b	b3556
.ltorg
b3556:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r0,	r3
	moveq	r0,	#1
	movne	r0,	#0
	mov	r3,	#0
	cmp	r0,	r3
	bne	b3558
	b	b3559
.ltorg
b3558:
	mov	r0,	#1
	b	b3560
.ltorg
b3559:
	mov	r0,	#0
	b	b3560
.ltorg
b3560:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r1,	r3
	bne	b3564
	b	b3562
.ltorg
b3562:
	mov	r3,	#0
	b	b3563
.ltorg
b3563:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3565
	b	b3568
.ltorg
b3565:
	mov	r1,	#1
	b	b3567
.ltorg
b3567:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3572
	b	b3570
.ltorg
b3570:
	mov	r0,	#0
	b	b3571
.ltorg
b3571:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r0,	r4
	moveq	r0,	#1
	movne	r0,	#0
	mov	r4,	#0
	cmp	r0,	r4
	bne	b3573
	b	b3574
.ltorg
b3573:
	mov	r0,	#1
	b	b3575
.ltorg
b3574:
	mov	r0,	#0
	b	b3575
.ltorg
b3575:
	mov	r0,	r0
	mov	r4,	#0
	cmp	r1,	r4
	bne	b3579
	b	b3577
.ltorg
b3577:
	mov	r4,	#0
	b	b3578
.ltorg
b3578:
	mov	r4,	r4
	mov	r0,	#0
	ldr	r1,	[sp,	#280]
	cmp	r1,	r0
	bne	b3583
	b	b3581
.ltorg
b3581:
	mov	r1,	#0
	b	b3582
.ltorg
b3582:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3587
	b	b3585
.ltorg
b3585:
	mov	r0,	#0
	b	b3586
.ltorg
b3586:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r1,	r2
	bne	b3588
	b	b3591
.ltorg
b3588:
	mov	r5,	#1
	b	b3590
.ltorg
b3590:
	mov	r5,	r5
	mov	r0,	#0
	ldr	r1,	[sp,	#300]
	cmp	r1,	r0
	bne	b3592
	b	b3595
.ltorg
b3595:
	mov	r0,	#0
	ldr	r1,	[sp,	#308]
	cmp	r1,	r0
	bne	b3592
	b	b3593
.ltorg
b3593:
	mov	r1,	#0
	b	b3594
.ltorg
b3592:
	mov	r1,	#1
	b	b3594
.ltorg
b3594:
	mov	r1,	r1
	mov	r0,	#0
	ldr	r2,	[sp,	#300]
	cmp	r2,	r0
	bne	b3599
	b	b3597
.ltorg
b3598:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r0,	r2
	moveq	r0,	#1
	movne	r0,	#0
	mov	r2,	#0
	cmp	r0,	r2
	bne	b3600
	b	b3601
.ltorg
b3601:
	mov	r0,	#0
	b	b3602
.ltorg
b3602:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r1,	r2
	bne	b3606
	b	b3604
.ltorg
b3606:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3603
	b	b3604
.ltorg
b3603:
	mov	r3,	#1
	b	b3605
.ltorg
b3604:
	mov	r3,	#0
	b	b3605
.ltorg
b3605:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3607
	b	b3610
.ltorg
b3609:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3614
	b	b3612
.ltorg
b3612:
	mov	r0,	#0
	b	b3613
.ltorg
b3613:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r0,	r2
	moveq	r0,	#1
	movne	r0,	#0
	mov	r2,	#0
	cmp	r0,	r2
	bne	b3615
	b	b3616
.ltorg
b3615:
	mov	r0,	#1
	b	b3617
.ltorg
b3616:
	mov	r0,	#0
	b	b3617
.ltorg
b3617:
	mov	r0,	r0
	mov	r2,	#0
	cmp	r1,	r2
	bne	b3621
	b	b3619
.ltorg
b3620:
	mov	r2,	r2
	mov	r0,	#0
	ldr	r1,	[sp,	#300]
	cmp	r1,	r0
	bne	b3625
	b	b3623
.ltorg
b3623:
	mov	r1,	#0
	b	b3624
.ltorg
b3624:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3629
	b	b3627
.ltorg
b3627:
	mov	r0,	#0
	b	b3628
.ltorg
b3628:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r1,	r3
	bne	b3630
	b	b3633
.ltorg
b3630:
	mov	r5,	#1
	b	b3632
.ltorg
b3632:
	mov	r5,	r5
	mov	r0,	#0
	ldr	r1,	[sp,	#356]
	cmp	r1,	r0
	bne	b3634
	b	b3637
.ltorg
b3634:
	mov	r1,	#1
	b	b3636
.ltorg
b3636:
	mov	r1,	r1
	mov	r0,	#0
	ldr	r3,	[sp,	#356]
	cmp	r3,	r0
	bne	b3641
	b	b3639
.ltorg
b3639:
	mov	r0,	#0
	b	b3640
.ltorg
b3640:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r0,	r3
	moveq	r0,	#1
	movne	r0,	#0
	mov	r3,	#0
	cmp	r0,	r3
	bne	b3642
	b	b3643
.ltorg
b3642:
	mov	r0,	#1
	b	b3644
.ltorg
b3643:
	mov	r0,	#0
	b	b3644
.ltorg
b3644:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r1,	r3
	bne	b3648
	b	b3646
.ltorg
b3646:
	mov	r3,	#0
	b	b3647
.ltorg
b3647:
	mov	r3,	r3
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3649
	b	b3652
.ltorg
b3649:
	mov	r1,	#1
	b	b3651
.ltorg
b3651:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3656
	b	b3654
.ltorg
b3654:
	mov	r0,	#0
	b	b3655
.ltorg
b3655:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r0,	r9
	moveq	r0,	#1
	movne	r0,	#0
	mov	r9,	#0
	cmp	r0,	r9
	bne	b3657
	b	b3658
.ltorg
b3657:
	mov	r0,	#1
	b	b3659
.ltorg
b3658:
	mov	r0,	#0
	b	b3659
.ltorg
b3659:
	mov	r0,	r0
	mov	r9,	#0
	cmp	r1,	r9
	bne	b3663
	b	b3661
.ltorg
b3661:
	mov	r0,	#0
	b	b3662
.ltorg
b3662:
	mov	r0,	r0
	str	r0,	[sp,	#3820]
	mov	r0,	#0
	ldr	r1,	[sp,	#356]
	cmp	r1,	r0
	bne	b3667
	b	b3665
.ltorg
b3665:
	mov	r1,	#0
	b	b3666
.ltorg
b3666:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3671
	b	b3669
.ltorg
b3669:
	mov	r0,	#0
	b	b3670
.ltorg
b3670:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r1,	r3
	bne	b3672
	b	b3675
.ltorg
b3672:
	mov	r3,	#1
	b	b3674
.ltorg
b3674:
	mov	r3,	r3
	mov	r0,	#0
	ldr	r1,	[sp,	#388]
	cmp	r1,	r0
	bne	b3676
	b	b3679
.ltorg
b3676:
	mov	r1,	#1
	b	b3678
.ltorg
b3678:
	mov	r1,	r1
	mov	r0,	#0
	ldr	r5,	[sp,	#388]
	cmp	r5,	r0
	bne	b3683
	b	b3681
.ltorg
b3681:
	mov	r0,	#0
	b	b3682
.ltorg
b3682:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r0,	r5
	moveq	r0,	#1
	movne	r0,	#0
	mov	r5,	#0
	cmp	r0,	r5
	bne	b3684
	b	b3685
.ltorg
b3684:
	mov	r0,	#1
	b	b3686
.ltorg
b3685:
	mov	r0,	#0
	b	b3686
.ltorg
b3686:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r1,	r5
	bne	b3690
	b	b3688
.ltorg
b3688:
	mov	r0,	#0
	b	b3689
.ltorg
b3689:
	mov	r0,	r0
	str	r0,	[sp,	#368]
	mov	r0,	#0
	ldr	r1,	[sp,	#368]
	cmp	r1,	r0
	bne	b3691
	b	b3694
.ltorg
b3691:
	mov	r1,	#1
	b	b3693
.ltorg
b3693:
	mov	r1,	r1
	mov	r0,	#0
	ldr	r5,	[sp,	#368]
	cmp	r5,	r0
	bne	b3698
	b	b3696
.ltorg
b3696:
	mov	r0,	#0
	b	b3697
.ltorg
b3697:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r0,	r5
	moveq	r5,	#1
	movne	r5,	#0
	mov	r0,	#0
	cmp	r5,	r0
	bne	b3699
	b	b3700
.ltorg
b3699:
	mov	r0,	#1
	b	b3701
.ltorg
b3700:
	mov	r0,	#0
	b	b3701
.ltorg
b3701:
	mov	r0,	r0
	mov	r5,	#0
	cmp	r1,	r5
	bne	b3705
	b	b3703
.ltorg
b3703:
	mov	r5,	#0
	b	b3704
.ltorg
b3704:
	mov	r5,	r5
	mov	r0,	#0
	ldr	r1,	[sp,	#388]
	cmp	r1,	r0
	bne	b3709
	b	b3707
.ltorg
b3707:
	mov	r1,	#0
	b	b3708
.ltorg
b3708:
	mov	r1,	r1
	mov	r0,	#0
	ldr	r7,	[sp,	#368]
	cmp	r7,	r0
	bne	b3713
	b	b3711
.ltorg
b3711:
	mov	r0,	#0
	b	b3712
.ltorg
b3712:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r1,	r3
	bne	b3714
	b	b3717
.ltorg
b3714:
	mov	r7,	#1
	b	b3716
.ltorg
b3716:
	mov	r7,	r7
	mov	r0,	#0
	ldr	r1,	[sp,	#416]
	cmp	r1,	r0
	bne	b3718
	b	b3721
.ltorg
b3718:
	mov	r1,	#1
	b	b3720
.ltorg
b3720:
	mov	r1,	r1
	mov	r0,	#0
	ldr	r3,	[sp,	#416]
	cmp	r3,	r0
	bne	b3725
	b	b3723
.ltorg
b3725:
	mov	r0,	#0
	ldr	r3,	[sp,	#424]
	cmp	r3,	r0
	bne	b3722
	b	b3723
.ltorg
b3722:
	mov	r0,	#1
	b	b3724
.ltorg
b3723:
	mov	r0,	#0
	b	b3724
.ltorg
b3724:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r0,	r3
	moveq	r0,	#1
	movne	r0,	#0
	mov	r3,	#0
	cmp	r0,	r3
	bne	b3726
	b	b3727
.ltorg
b3728:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r1,	r3
	bne	b3732
	b	b3730
.ltorg
b3730:
	mov	r0,	#0
	b	b3731
.ltorg
b3731:
	mov	r0,	r0
	str	r0,	[sp,	#412]
	mov	r0,	#0
	ldr	r1,	[sp,	#412]
	cmp	r1,	r0
	bne	b3733
	b	b3736
.ltorg
b3736:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b3733
	b	b3734
.ltorg
b3734:
	mov	r1,	#0
	b	b3735
.ltorg
b3733:
	mov	r1,	#1
	b	b3735
.ltorg
b3735:
	mov	r1,	r1
	mov	r0,	#0
	ldr	r3,	[sp,	#412]
	cmp	r3,	r0
	bne	b3740
	b	b3738
.ltorg
b3739:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r0,	r3
	moveq	r3,	#1
	movne	r3,	#0
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3741
	b	b3742
.ltorg
b3742:
	mov	r0,	#0
	b	b3743
.ltorg
b3743:
	mov	r0,	r0
	mov	r3,	#0
	cmp	r1,	r3
	bne	b3747
	b	b3745
.ltorg
b3747:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3744
	b	b3745
.ltorg
b3744:
	mov	r3,	#1
	b	b3746
.ltorg
b3745:
	mov	r3,	#0
	b	b3746
.ltorg
b3746:
	mov	r3,	r3
	mov	r0,	#0
	ldr	r1,	[sp,	#416]
	cmp	r1,	r0
	bne	b3751
	b	b3749
.ltorg
b3750:
	mov	r1,	r1
	mov	r0,	#0
	ldr	r9,	[sp,	#412]
	cmp	r9,	r0
	bne	b3755
	b	b3753
.ltorg
b3753:
	mov	r0,	#0
	b	b3754
.ltorg
b3754:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r1,	r7
	bne	b3756
	b	b3759
.ltorg
b3758:
	mov	r0,	r0
	str	r0,	[sp,	#208]
	mov	r0,	#0
	ldr	r1,	[sp,	#956]
	cmp	r1,	r0
	bne	b3760
	b	b3763
.ltorg
b3760:
	mov	r1,	#1
	b	b3762
.ltorg
b3762:
	mov	r1,	r1
	mov	r0,	#0
	ldr	r7,	[sp,	#956]
	cmp	r7,	r0
	bne	b3767
	b	b3765
.ltorg
b3765:
	mov	r0,	#0
	b	b3766
.ltorg
b3766:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r0,	r7
	moveq	r0,	#1
	movne	r0,	#0
	mov	r7,	#0
	cmp	r0,	r7
	bne	b3768
	b	b3769
.ltorg
b3768:
	mov	r0,	#1
	b	b3770
.ltorg
b3769:
	mov	r0,	#0
	b	b3770
.ltorg
b3770:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r1,	r7
	bne	b3774
	b	b3772
.ltorg
b3772:
	mov	r0,	#0
	b	b3773
.ltorg
b3773:
	mov	r0,	r0
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3775
	b	b3778
.ltorg
b3775:
	mov	r7,	#1
	b	b3777
.ltorg
b3777:
	mov	r7,	r7
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3782
	b	b3780
.ltorg
b3780:
	mov	r1,	#0
	b	b3781
.ltorg
b3781:
	mov	r1,	r1
	mov	r9,	#0
	str	r9,	[sp,	#116]
	ldr	r9,	[sp,	#116]
	cmp	r1,	r9
	moveq	r9,	#1
	movne	r9,	#0
	mov	r1,	#0
	str	r1,	[sp,	#108]
	ldr	r1,	[sp,	#108]
	cmp	r9,	r1
	bne	b3783
	b	b3784
.ltorg
b3783:
	mov	r1,	#1
	b	b3785
.ltorg
b3784:
	mov	r1,	#0
	b	b3785
.ltorg
b3785:
	mov	r1,	r1
	str	r1,	[sp,	#196]
	mov	r1,	#0
	cmp	r7,	r1
	bne	b3789
	b	b3787
.ltorg
b3787:
	mov	r9,	#0
	b	b3788
.ltorg
b3788:
	mov	r9,	r9
	mov	r1,	#0
	ldr	r7,	[sp,	#956]
	cmp	r7,	r1
	bne	b3793
	b	b3791
.ltorg
b3791:
	mov	r1,	#0
	b	b3792
.ltorg
b3792:
	mov	r1,	r1
	mov	r7,	#0
	cmp	r0,	r7
	bne	b3797
	b	b3795
.ltorg
b3795:
	mov	r0,	#0
	b	b3796
.ltorg
b3796:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r1,	r7
	bne	b3798
	b	b3801
.ltorg
b3798:
	mov	r0,	#1
	b	b3800
.ltorg
b3800:
	mov	r0,	r0
	str	r0,	[sp,	#228]
	mov	r0,	#0
	cmp	r10,	r0
	bne	b3802
	b	b3805
.ltorg
b3802:
	mov	r1,	#1
	b	b3804
.ltorg
b3804:
	mov	r1,	r1
	mov	r0,	#0
	cmp	r10,	r0
	bne	b3809
	b	b3807
.ltorg
b3807:
	mov	r0,	#0
	b	b3808
.ltorg
b3808:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r0,	r7
	moveq	r7,	#1
	movne	r7,	#0
	mov	r0,	#0
	cmp	r7,	r0
	bne	b3810
	b	b3811
.ltorg
b3810:
	mov	r0,	#1
	b	b3812
.ltorg
b3811:
	mov	r0,	#0
	b	b3812
.ltorg
b3812:
	mov	r0,	r0
	mov	r7,	#0
	cmp	r1,	r7
	bne	b3816
	b	b3814
.ltorg
b3814:
	mov	r0,	#0
	b	b3815
.ltorg
b3815:
	mov	r0,	r0
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3817
	b	b3820
.ltorg
b3817:
	mov	r7,	#1
	b	b3819
.ltorg
b3819:
	mov	r7,	r7
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3824
	b	b3822
.ltorg
b3822:
	mov	r1,	#0
	b	b3823
.ltorg
b3823:
	mov	r1,	r1
	mov	r11,	#0
	str	r11,	[sp,	#3496]
	ldr	r11,	[sp,	#3496]
	str	r11,	[sp,	#2936]
	ldr	r11,	[sp,	#2936]
	str	r11,	[sp,	#3524]
	ldr	r11,	[sp,	#3524]
	str	r11,	[sp,	#2096]
	ldr	r11,	[sp,	#2096]
	str	r11,	[sp,	#3528]
	ldr	r11,	[sp,	#3528]
	str	r11,	[sp,	#2940]
	ldr	r11,	[sp,	#2940]
	str	r11,	[sp,	#3516]
	ldr	r11,	[sp,	#3516]
	str	r11,	[sp,	#1952]
	ldr	r11,	[sp,	#1952]
	str	r11,	[sp,	#3360]
	ldr	r11,	[sp,	#3360]
	str	r11,	[sp,	#2896]
	ldr	r11,	[sp,	#2896]
	str	r11,	[sp,	#3352]
	ldr	r11,	[sp,	#3352]
	str	r11,	[sp,	#2100]
	ldr	r11,	[sp,	#2100]
	str	r11,	[sp,	#3408]
	ldr	r11,	[sp,	#3408]
	str	r11,	[sp,	#2888]
	ldr	r11,	[sp,	#2888]
	str	r11,	[sp,	#3412]
	ldr	r11,	[sp,	#3412]
	str	r11,	[sp,	#1344]
	ldr	r11,	[sp,	#1344]
	str	r11,	[sp,	#3400]
	ldr	r11,	[sp,	#3400]
	str	r11,	[sp,	#2892]
	ldr	r11,	[sp,	#2892]
	str	r11,	[sp,	#3404]
	ldr	r11,	[sp,	#3404]
	str	r11,	[sp,	#2104]
	ldr	r11,	[sp,	#2104]
	str	r11,	[sp,	#3320]
	ldr	r11,	[sp,	#3320]
	str	r11,	[sp,	#2920]
	ldr	r11,	[sp,	#2920]
	str	r11,	[sp,	#3324]
	ldr	r11,	[sp,	#3324]
	str	r11,	[sp,	#1948]
	ldr	r11,	[sp,	#1948]
	str	r11,	[sp,	#3312]
	ldr	r11,	[sp,	#3312]
	str	r11,	[sp,	#2924]
	ldr	r11,	[sp,	#2924]
	str	r11,	[sp,	#3316]
	ldr	r11,	[sp,	#3316]
	str	r11,	[sp,	#2108]
	ldr	r11,	[sp,	#2108]
	str	r11,	[sp,	#3372]
	ldr	r11,	[sp,	#3372]
	str	r11,	[sp,	#2912]
	ldr	r11,	[sp,	#2912]
	str	r11,	[sp,	#3364]
	ldr	r11,	[sp,	#3364]
	str	r11,	[sp,	#952]
	ldr	r11,	[sp,	#952]
	str	r11,	[sp,	#3708]
	ldr	r11,	[sp,	#3708]
	str	r11,	[sp,	#2760]
	ldr	r11,	[sp,	#2760]
	str	r11,	[sp,	#3720]
	ldr	r11,	[sp,	#3720]
	str	r11,	[sp,	#2032]
	ldr	r11,	[sp,	#2032]
	str	r11,	[sp,	#3724]
	ldr	r11,	[sp,	#3724]
	str	r11,	[sp,	#2764]
	ldr	r11,	[sp,	#2764]
	str	r11,	[sp,	#3716]
	ldr	r11,	[sp,	#3716]
	str	r11,	[sp,	#1996]
	ldr	r11,	[sp,	#1996]
	str	r11,	[sp,	#3736]
	ldr	r11,	[sp,	#3736]
	str	r11,	[sp,	#2752]
	ldr	r11,	[sp,	#2752]
	str	r11,	[sp,	#3740]
	ldr	r11,	[sp,	#3740]
	str	r11,	[sp,	#2036]
	ldr	r11,	[sp,	#2036]
	str	r11,	[sp,	#3712]
	ldr	r11,	[sp,	#3712]
	str	r11,	[sp,	#2756]
	ldr	r11,	[sp,	#2756]
	str	r11,	[sp,	#3704]
	ldr	r11,	[sp,	#3704]
	str	r11,	[sp,	#1340]
	ldr	r11,	[sp,	#1340]
	str	r11,	[sp,	#3808]
	ldr	r11,	[sp,	#3808]
	str	r11,	[sp,	#2712]
	ldr	r11,	[sp,	#2712]
	str	r11,	[sp,	#3812]
	ldr	r11,	[sp,	#3812]
	str	r11,	[sp,	#2040]
	ldr	r11,	[sp,	#2040]
	str	r11,	[sp,	#3800]
	ldr	r11,	[sp,	#3800]
	str	r11,	[sp,	#2704]
	ldr	r11,	[sp,	#2704]
	str	r11,	[sp,	#3804]
	ldr	r11,	[sp,	#3804]
	str	r11,	[sp,	#1992]
	ldr	r11,	[sp,	#1992]
	str	r11,	[sp,	#3792]
	ldr	r11,	[sp,	#3792]
	str	r11,	[sp,	#2708]
	ldr	r11,	[sp,	#2708]
	str	r11,	[sp,	#3796]
	ldr	r11,	[sp,	#3796]
	str	r11,	[sp,	#2044]
	ldr	r11,	[sp,	#2044]
	str	r11,	[sp,	#3728]
	ldr	r11,	[sp,	#3728]
	str	r11,	[sp,	#2736]
	ldr	r11,	[sp,	#2736]
	str	r11,	[sp,	#3732]
	ldr	r11,	[sp,	#3732]
	str	r11,	[sp,	#104]
	ldr	r11,	[sp,	#104]
	str	r11,	[sp,	#3420]
	ldr	r11,	[sp,	#3420]
	str	r11,	[sp,	#2856]
	ldr	r11,	[sp,	#2856]
	str	r11,	[sp,	#3416]
	ldr	r11,	[sp,	#3416]
	str	r11,	[sp,	#2224]
	ldr	r11,	[sp,	#2224]
	str	r11,	[sp,	#3244]
	ldr	r11,	[sp,	#3244]
	str	r11,	[sp,	#2844]
	ldr	r11,	[sp,	#2844]
	str	r11,	[sp,	#3232]
	ldr	r11,	[sp,	#3232]
	str	r11,	[sp,	#1768]
	ldr	r11,	[sp,	#1768]
	str	r11,	[sp,	#3236]
	ldr	r11,	[sp,	#3236]
	str	r11,	[sp,	#2848]
	ldr	r11,	[sp,	#2848]
	str	r11,	[sp,	#3260]
	ldr	r11,	[sp,	#3260]
	str	r11,	[sp,	#2228]
	ldr	r11,	[sp,	#2228]
	str	r11,	[sp,	#3256]
	ldr	r11,	[sp,	#3256]
	str	r11,	[sp,	#2836]
	ldr	r11,	[sp,	#2836]
	str	r11,	[sp,	#3248]
	ldr	r11,	[sp,	#3248]
	str	r11,	[sp,	#1312]
	ldr	r11,	[sp,	#1312]
	str	r11,	[sp,	#3252]
	ldr	r11,	[sp,	#3252]
	str	r11,	[sp,	#2840]
	ldr	r11,	[sp,	#2840]
	str	r11,	[sp,	#3240]
	ldr	r11,	[sp,	#3240]
	str	r11,	[sp,	#2232]
	ldr	r11,	[sp,	#2232]
	str	r11,	[sp,	#3436]
	ldr	r11,	[sp,	#3436]
	str	r11,	[sp,	#2868]
	ldr	r11,	[sp,	#2868]
	str	r11,	[sp,	#3428]
	ldr	r11,	[sp,	#3428]
	str	r11,	[sp,	#1764]
	ldr	r11,	[sp,	#1764]
	str	r11,	[sp,	#3304]
	ldr	r11,	[sp,	#3304]
	str	r11,	[sp,	#2792]
	ldr	r11,	[sp,	#2792]
	str	r11,	[sp,	#3308]
	ldr	r11,	[sp,	#3308]
	str	r11,	[sp,	#2236]
	ldr	r11,	[sp,	#2236]
	str	r11,	[sp,	#3280]
	ldr	r11,	[sp,	#3280]
	str	r11,	[sp,	#2796]
	ldr	r11,	[sp,	#2796]
	str	r11,	[sp,	#3272]
	ldr	r11,	[sp,	#3272]
	str	r11,	[sp,	#948]
	ldr	r11,	[sp,	#948]
	str	r11,	[sp,	#3328]
	ldr	r11,	[sp,	#3328]
	str	r11,	[sp,	#2916]
	ldr	r11,	[sp,	#2916]
	str	r11,	[sp,	#3332]
	ldr	r11,	[sp,	#3332]
	str	r11,	[sp,	#2112]
	ldr	r11,	[sp,	#2112]
	str	r11,	[sp,	#3348]
	ldr	r11,	[sp,	#3348]
	str	r11,	[sp,	#2904]
	ldr	r11,	[sp,	#2904]
	str	r11,	[sp,	#3336]
	ldr	r11,	[sp,	#3336]
	str	r11,	[sp,	#1944]
	ldr	r11,	[sp,	#1944]
	str	r11,	[sp,	#3340]
	ldr	r11,	[sp,	#3340]
	str	r11,	[sp,	#2908]
	ldr	r11,	[sp,	#2908]
	str	r11,	[sp,	#3368]
	ldr	r11,	[sp,	#3368]
	str	r11,	[sp,	#2116]
	ldr	r11,	[sp,	#2116]
	str	r11,	[sp,	#3356]
	ldr	r11,	[sp,	#3356]
	str	r11,	[sp,	#2900]
	ldr	r11,	[sp,	#2900]
	str	r11,	[sp,	#3344]
	ldr	r11,	[sp,	#3344]
	str	r11,	[sp,	#1348]
	ldr	r11,	[sp,	#1348]
	str	r11,	[sp,	#3432]
	ldr	r11,	[sp,	#3432]
	str	r11,	[sp,	#2872]
	ldr	r11,	[sp,	#2872]
	str	r11,	[sp,	#3424]
	ldr	r11,	[sp,	#3424]
	str	r11,	[sp,	#2124]
	ldr	r11,	[sp,	#2124]
	str	r11,	[sp,	#3392]
	ldr	r11,	[sp,	#3392]
	str	r11,	[sp,	#2876]
	ldr	r11,	[sp,	#2876]
	str	r11,	[sp,	#3396]
	ldr	r11,	[sp,	#3396]
	str	r11,	[sp,	#1940]
	ldr	r11,	[sp,	#1940]
	str	r11,	[sp,	#3384]
	ldr	r11,	[sp,	#3384]
	str	r11,	[sp,	#2880]
	ldr	r11,	[sp,	#2880]
	str	r11,	[sp,	#3388]
	ldr	r11,	[sp,	#3388]
	str	r11,	[sp,	#2120]
	ldr	r11,	[sp,	#2120]
	str	r11,	[sp,	#3376]
	ldr	r11,	[sp,	#3376]
	str	r11,	[sp,	#2884]
	ldr	r11,	[sp,	#2884]
	str	r11,	[sp,	#3380]
	ldr	r11,	[sp,	#3380]
	cmp	r1,	r11
	moveq	r1,	#1
	movne	r1,	#0
	mov	r11,	#0
	str	r11,	[sp,	#3632]
	ldr	r11,	[sp,	#3632]
	str	r11,	[sp,	#3208]
	ldr	r11,	[sp,	#3208]
	str	r11,	[sp,	#3620]
	ldr	r11,	[sp,	#3620]
	str	r11,	[sp,	#2260]
	ldr	r11,	[sp,	#2260]
	str	r11,	[sp,	#3624]
	ldr	r11,	[sp,	#3624]
	str	r11,	[sp,	#3212]
	ldr	r11,	[sp,	#3212]
	str	r11,	[sp,	#3616]
	ldr	r11,	[sp,	#3616]
	str	r11,	[sp,	#1752]
	ldr	r11,	[sp,	#1752]
	str	r11,	[sp,	#3300]
	ldr	r11,	[sp,	#3300]
	str	r11,	[sp,	#2808]
	ldr	r11,	[sp,	#2808]
	str	r11,	[sp,	#3288]
	ldr	r11,	[sp,	#3288]
	str	r11,	[sp,	#2248]
	ldr	r11,	[sp,	#2248]
	str	r11,	[sp,	#3292]
	ldr	r11,	[sp,	#3292]
	str	r11,	[sp,	#2812]
	ldr	r11,	[sp,	#2812]
	str	r11,	[sp,	#3284]
	ldr	r11,	[sp,	#3284]
	str	r11,	[sp,	#1320]
	ldr	r11,	[sp,	#1320]
	str	r11,	[sp,	#3608]
	ldr	r11,	[sp,	#3608]
	str	r11,	[sp,	#3200]
	ldr	r11,	[sp,	#3200]
	str	r11,	[sp,	#3636]
	ldr	r11,	[sp,	#3636]
	str	r11,	[sp,	#2264]
	ldr	r11,	[sp,	#2264]
	str	r11,	[sp,	#3640]
	ldr	r11,	[sp,	#3640]
	str	r11,	[sp,	#3204]
	ldr	r11,	[sp,	#3204]
	str	r11,	[sp,	#3628]
	ldr	r11,	[sp,	#3628]
	str	r11,	[sp,	#1748]
	ldr	r11,	[sp,	#1748]
	str	r11,	[sp,	#3580]
	ldr	r11,	[sp,	#3580]
	str	r11,	[sp,	#3216]
	ldr	r11,	[sp,	#3216]
	str	r11,	[sp,	#3584]
	ldr	r11,	[sp,	#3584]
	str	r11,	[sp,	#2256]
	ldr	r11,	[sp,	#2256]
	str	r11,	[sp,	#3572]
	ldr	r11,	[sp,	#3572]
	str	r11,	[sp,	#3220]
	ldr	r11,	[sp,	#3220]
	str	r11,	[sp,	#3576]
	ldr	r11,	[sp,	#3576]
	str	r11,	[sp,	#944]
	ldr	r11,	[sp,	#944]
	str	r11,	[sp,	#3564]
	ldr	r11,	[sp,	#3564]
	str	r11,	[sp,	#3152]
	ldr	r11,	[sp,	#3152]
	str	r11,	[sp,	#3568]
	ldr	r11,	[sp,	#3568]
	str	r11,	[sp,	#2276]
	ldr	r11,	[sp,	#2276]
	str	r11,	[sp,	#3660]
	ldr	r11,	[sp,	#3660]
	str	r11,	[sp,	#3180]
	ldr	r11,	[sp,	#3180]
	str	r11,	[sp,	#3664]
	ldr	r11,	[sp,	#3664]
	str	r11,	[sp,	#1760]
	ldr	r11,	[sp,	#1760]
	str	r11,	[sp,	#3644]
	ldr	r11,	[sp,	#3644]
	str	r11,	[sp,	#3192]
	ldr	r11,	[sp,	#3192]
	str	r11,	[sp,	#3648]
	ldr	r11,	[sp,	#3648]
	str	r11,	[sp,	#2268]
	ldr	r11,	[sp,	#2268]
	str	r11,	[sp,	#3612]
	ldr	r11,	[sp,	#3612]
	str	r11,	[sp,	#3196]
	ldr	r11,	[sp,	#3196]
	str	r11,	[sp,	#3604]
	ldr	r11,	[sp,	#3604]
	str	r11,	[sp,	#1316]
	ldr	r11,	[sp,	#1316]
	str	r11,	[sp,	#3276]
	ldr	r11,	[sp,	#3276]
	str	r11,	[sp,	#2800]
	ldr	r11,	[sp,	#2800]
	str	r11,	[sp,	#3264]
	ldr	r11,	[sp,	#3264]
	str	r11,	[sp,	#2252]
	ldr	r11,	[sp,	#2252]
	str	r11,	[sp,	#3268]
	ldr	r11,	[sp,	#3268]
	str	r11,	[sp,	#2804]
	ldr	r11,	[sp,	#2804]
	str	r11,	[sp,	#3296]
	ldr	r11,	[sp,	#3296]
	str	r11,	[sp,	#1756]
	ldr	r11,	[sp,	#1756]
	str	r11,	[sp,	#3596]
	ldr	r11,	[sp,	#3596]
	str	r11,	[sp,	#3224]
	ldr	r11,	[sp,	#3224]
	str	r11,	[sp,	#3600]
	ldr	r11,	[sp,	#3600]
	str	r11,	[sp,	#2272]
	ldr	r11,	[sp,	#2272]
	str	r11,	[sp,	#3588]
	ldr	r11,	[sp,	#3588]
	str	r11,	[sp,	#3228]
	ldr	r11,	[sp,	#3228]
	str	r11,	[sp,	#3592]
	ldr	r11,	[sp,	#3592]
	str	r11,	[sp,	#112]
	ldr	r11,	[sp,	#112]
	str	r11,	[sp,	#3520]
	ldr	r11,	[sp,	#3520]
	str	r11,	[sp,	#2944]
	ldr	r11,	[sp,	#2944]
	str	r11,	[sp,	#3508]
	ldr	r11,	[sp,	#3508]
	str	r11,	[sp,	#2092]
	ldr	r11,	[sp,	#2092]
	str	r11,	[sp,	#3512]
	ldr	r11,	[sp,	#3512]
	str	r11,	[sp,	#2948]
	ldr	r11,	[sp,	#2948]
	str	r11,	[sp,	#3500]
	ldr	r11,	[sp,	#3500]
	str	r11,	[sp,	#1980]
	ldr	r11,	[sp,	#1980]
	str	r11,	[sp,	#3488]
	ldr	r11,	[sp,	#3488]
	str	r11,	[sp,	#2960]
	ldr	r11,	[sp,	#2960]
	str	r11,	[sp,	#3492]
	ldr	r11,	[sp,	#3492]
	str	r11,	[sp,	#2084]
	ldr	r11,	[sp,	#2084]
	str	r11,	[sp,	#3480]
	ldr	r11,	[sp,	#3480]
	str	r11,	[sp,	#2964]
	ldr	r11,	[sp,	#2964]
	str	r11,	[sp,	#3484]
	ldr	r11,	[sp,	#3484]
	str	r11,	[sp,	#1328]
	ldr	r11,	[sp,	#1328]
	str	r11,	[sp,	#3460]
	ldr	r11,	[sp,	#3460]
	str	r11,	[sp,	#2976]
	ldr	r11,	[sp,	#2976]
	str	r11,	[sp,	#3456]
	ldr	r11,	[sp,	#3456]
	str	r11,	[sp,	#2076]
	ldr	r11,	[sp,	#2076]
	str	r11,	[sp,	#3448]
	ldr	r11,	[sp,	#3448]
	str	r11,	[sp,	#3004]
	ldr	r11,	[sp,	#3004]
	str	r11,	[sp,	#3452]
	ldr	r11,	[sp,	#3452]
	str	r11,	[sp,	#1976]
	ldr	r11,	[sp,	#1976]
	str	r11,	[sp,	#3504]
	ldr	r11,	[sp,	#3504]
	str	r11,	[sp,	#2952]
	ldr	r11,	[sp,	#2952]
	str	r11,	[sp,	#3532]
	ldr	r11,	[sp,	#3532]
	str	r11,	[sp,	#2088]
	ldr	r11,	[sp,	#2088]
	str	r11,	[sp,	#3464]
	ldr	r11,	[sp,	#3464]
	str	r11,	[sp,	#2956]
	ldr	r11,	[sp,	#2956]
	str	r11,	[sp,	#3468]
	ldr	r11,	[sp,	#3468]
	str	r11,	[sp,	#940]
	ldr	r11,	[sp,	#940]
	str	r11,	[sp,	#3744]
	ldr	r11,	[sp,	#3744]
	str	r11,	[sp,	#2740]
	ldr	r11,	[sp,	#2740]
	str	r11,	[sp,	#3748]
	ldr	r11,	[sp,	#3748]
	str	r11,	[sp,	#2048]
	ldr	r11,	[sp,	#2048]
	str	r11,	[sp,	#3768]
	ldr	r11,	[sp,	#3768]
	str	r11,	[sp,	#2728]
	ldr	r11,	[sp,	#2728]
	str	r11,	[sp,	#3756]
	ldr	r11,	[sp,	#3756]
	str	r11,	[sp,	#1988]
	ldr	r11,	[sp,	#1988]
	str	r11,	[sp,	#3760]
	ldr	r11,	[sp,	#3760]
	str	r11,	[sp,	#2732]
	ldr	r11,	[sp,	#2732]
	str	r11,	[sp,	#3788]
	ldr	r11,	[sp,	#3788]
	str	r11,	[sp,	#2052]
	ldr	r11,	[sp,	#2052]
	str	r11,	[sp,	#3784]
	ldr	r11,	[sp,	#3784]
	str	r11,	[sp,	#2720]
	ldr	r11,	[sp,	#2720]
	str	r11,	[sp,	#3772]
	ldr	r11,	[sp,	#3772]
	str	r11,	[sp,	#1324]
	ldr	r11,	[sp,	#1324]
	str	r11,	[sp,	#3776]
	ldr	r11,	[sp,	#3776]
	str	r11,	[sp,	#2724]
	ldr	r11,	[sp,	#2724]
	str	r11,	[sp,	#3764]
	ldr	r11,	[sp,	#3764]
	str	r11,	[sp,	#2056]
	ldr	r11,	[sp,	#2056]
	str	r11,	[sp,	#3752]
	ldr	r11,	[sp,	#3752]
	str	r11,	[sp,	#2716]
	ldr	r11,	[sp,	#2716]
	str	r11,	[sp,	#3780]
	ldr	r11,	[sp,	#3780]
	str	r11,	[sp,	#1984]
	ldr	r11,	[sp,	#1984]
	str	r11,	[sp,	#3472]
	ldr	r11,	[sp,	#3472]
	str	r11,	[sp,	#2968]
	ldr	r11,	[sp,	#2968]
	str	r11,	[sp,	#3476]
	ldr	r11,	[sp,	#3476]
	str	r11,	[sp,	#2060]
	ldr	r11,	[sp,	#2060]
	str	r11,	[sp,	#3440]
	ldr	r11,	[sp,	#3440]
	str	r11,	[sp,	#2996]
	ldr	r11,	[sp,	#2996]
	str	r11,	[sp,	#3444]
	ldr	r11,	[sp,	#3444]
	cmp	r1,	r11
	bne	b3825
	b	b3826
.ltorg
b3825:
	mov	r1,	#1
	b	b3827
.ltorg
b3826:
	mov	r1,	#0
	b	b3827
.ltorg
b3827:
	mov	r1,	r1
	str	r1,	[sp,	#216]
	mov	r1,	#0
	cmp	r7,	r1
	bne	b3831
	b	b3829
.ltorg
b3829:
	mov	r7,	#0
	b	b3830
.ltorg
b3830:
	mov	r7,	r7
	mov	r1,	#0
	cmp	r10,	r1
	bne	b3835
	b	b3833
.ltorg
b3833:
	mov	r1,	#0
	b	b3834
.ltorg
b3834:
	mov	r1,	r1
	mov	r10,	#0
	cmp	r0,	r10
	bne	b3839
	b	b3837
.ltorg
b3837:
	mov	r0,	#0
	b	b3838
.ltorg
b3838:
	mov	r0,	r0
	mov	r10,	#0
	cmp	r1,	r10
	bne	b3840
	b	b3843
.ltorg
b3840:
	b	b3842
.ltorg
b3842:
	mov	r0,	r7, lsl #1
	add	r0,	r0,	r9
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r3
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r5
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#3820]
	add	r0,	r1,	r0
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r2
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r4
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r6
	mov	r0,	r0, lsl #1
	add	r0,	r0,	r8
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#168]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#148]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#156]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#128]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#132]
	add	r0,	r1,	r0
	mov	r1,	r0, lsl #1
	ldr	r0,	[sp,	#120]
	add	r0,	r1,	r0
	mov	r0,	r0, lsl #1
	ldr	r1,	[sp,	#224]
	add	r0,	r0,	r1
	mov	r0,	r0
	movw	r5,	#3828
	add	sp,	sp,	r5
	pop	{r4,r5,r6,r7,r8,r9,r10,r11,pc}
	bx	lr
.ltorg
b3843:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3840
	b	b3841
.ltorg
b3841:
	b	b3842
.ltorg
b3839:
	mov	r10,	#0
	ldr	r0,	[sp,	#228]
	cmp	r0,	r10
	bne	b3836
	b	b3837
.ltorg
b3836:
	mov	r0,	#1
	b	b3838
.ltorg
b3835:
	mov	r10,	#0
	ldr	r1,	[sp,	#220]
	cmp	r1,	r10
	bne	b3832
	b	b3833
.ltorg
b3832:
	mov	r1,	#1
	b	b3834
.ltorg
b3831:
	mov	r7,	#0
	ldr	r1,	[sp,	#216]
	cmp	r1,	r7
	bne	b3828
	b	b3829
.ltorg
b3828:
	mov	r7,	#1
	b	b3830
.ltorg
b3824:
	mov	r1,	#0
	str	r1,	[sp,	#968]
	ldr	r1,	[sp,	#228]
	ldr	r11,	[sp,	#968]
	str	r11,	[sp,	#3688]
	ldr	r11,	[sp,	#3688]
	str	r11,	[sp,	#2560]
	ldr	r11,	[sp,	#2560]
	str	r11,	[sp,	#3692]
	ldr	r11,	[sp,	#3692]
	str	r11,	[sp,	#2312]
	ldr	r11,	[sp,	#2312]
	str	r11,	[sp,	#3696]
	ldr	r11,	[sp,	#3696]
	str	r11,	[sp,	#2564]
	ldr	r11,	[sp,	#2564]
	str	r11,	[sp,	#3700]
	ldr	r11,	[sp,	#3700]
	str	r11,	[sp,	#1736]
	ldr	r11,	[sp,	#1736]
	str	r11,	[sp,	#3668]
	ldr	r11,	[sp,	#3668]
	str	r11,	[sp,	#2520]
	ldr	r11,	[sp,	#2520]
	str	r11,	[sp,	#3672]
	ldr	r11,	[sp,	#3672]
	str	r11,	[sp,	#2316]
	ldr	r11,	[sp,	#2316]
	str	r11,	[sp,	#3676]
	ldr	r11,	[sp,	#3676]
	str	r11,	[sp,	#2512]
	ldr	r11,	[sp,	#2512]
	str	r11,	[sp,	#3680]
	ldr	r11,	[sp,	#3680]
	str	r11,	[sp,	#1308]
	ldr	r11,	[sp,	#1308]
	str	r11,	[sp,	#3548]
	ldr	r11,	[sp,	#3548]
	str	r11,	[sp,	#3168]
	ldr	r11,	[sp,	#3168]
	str	r11,	[sp,	#3544]
	ldr	r11,	[sp,	#3544]
	str	r11,	[sp,	#2288]
	ldr	r11,	[sp,	#2288]
	str	r11,	[sp,	#3540]
	ldr	r11,	[sp,	#3540]
	str	r11,	[sp,	#3156]
	ldr	r11,	[sp,	#3156]
	str	r11,	[sp,	#3556]
	ldr	r11,	[sp,	#3556]
	str	r11,	[sp,	#1732]
	ldr	r11,	[sp,	#1732]
	str	r11,	[sp,	#3560]
	ldr	r11,	[sp,	#3560]
	str	r11,	[sp,	#3160]
	ldr	r11,	[sp,	#3160]
	str	r11,	[sp,	#3552]
	ldr	r11,	[sp,	#3552]
	str	r11,	[sp,	#2292]
	ldr	r11,	[sp,	#2292]
	str	r11,	[sp,	#3652]
	ldr	r11,	[sp,	#3652]
	str	r11,	[sp,	#3188]
	ldr	r11,	[sp,	#3188]
	str	r11,	[sp,	#3656]
	ldr	r11,	[sp,	#3656]
	cmp	r1,	r11
	bne	b3821
	b	b3822
.ltorg
b3821:
	mov	r1,	#1
	b	b3823
.ltorg
b3820:
	mov	r7,	#0
	ldr	r1,	[sp,	#228]
	cmp	r1,	r7
	bne	b3817
	b	b3818
.ltorg
b3818:
	mov	r7,	#0
	b	b3819
.ltorg
b3816:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3813
	b	b3814
.ltorg
b3813:
	mov	r0,	#1
	b	b3815
.ltorg
b3809:
	mov	r7,	#0
	ldr	r0,	[sp,	#220]
	cmp	r0,	r7
	bne	b3806
	b	b3807
.ltorg
b3806:
	mov	r0,	#1
	b	b3808
.ltorg
b3805:
	mov	r1,	#0
	ldr	r0,	[sp,	#220]
	cmp	r0,	r1
	bne	b3802
	b	b3803
.ltorg
b3803:
	mov	r1,	#0
	b	b3804
.ltorg
b3801:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3798
	b	b3799
.ltorg
b3799:
	mov	r0,	#0
	b	b3800
.ltorg
b3797:
	mov	r7,	#0
	ldr	r0,	[sp,	#208]
	cmp	r0,	r7
	bne	b3794
	b	b3795
.ltorg
b3794:
	mov	r0,	#1
	b	b3796
.ltorg
b3793:
	mov	r7,	#0
	ldr	r1,	[sp,	#192]
	cmp	r1,	r7
	bne	b3790
	b	b3791
.ltorg
b3790:
	mov	r1,	#1
	b	b3792
.ltorg
b3789:
	mov	r7,	#0
	ldr	r1,	[sp,	#196]
	cmp	r1,	r7
	bne	b3786
	b	b3787
.ltorg
b3786:
	mov	r9,	#1
	b	b3788
.ltorg
b3782:
	mov	r9,	#0
	ldr	r1,	[sp,	#208]
	cmp	r1,	r9
	bne	b3779
	b	b3780
.ltorg
b3779:
	mov	r1,	#1
	b	b3781
.ltorg
b3778:
	mov	r7,	#0
	ldr	r1,	[sp,	#208]
	cmp	r1,	r7
	bne	b3775
	b	b3776
.ltorg
b3776:
	mov	r7,	#0
	b	b3777
.ltorg
b3774:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3771
	b	b3772
.ltorg
b3771:
	mov	r0,	#1
	b	b3773
.ltorg
b3767:
	mov	r7,	#0
	ldr	r0,	[sp,	#192]
	cmp	r0,	r7
	bne	b3764
	b	b3765
.ltorg
b3764:
	mov	r0,	#1
	b	b3766
.ltorg
b3763:
	mov	r1,	#0
	ldr	r0,	[sp,	#192]
	cmp	r0,	r1
	bne	b3760
	b	b3761
.ltorg
b3761:
	mov	r1,	#0
	b	b3762
.ltorg
b3759:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3756
	b	b3757
.ltorg
b3757:
	mov	r0,	#0
	b	b3758
.ltorg
b3756:
	mov	r0,	#1
	b	b3758
.ltorg
b3755:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b3752
	b	b3753
.ltorg
b3752:
	mov	r0,	#1
	b	b3754
.ltorg
b3751:
	mov	r0,	#0
	ldr	r1,	[sp,	#424]
	cmp	r1,	r0
	bne	b3748
	b	b3749
.ltorg
b3748:
	mov	r1,	#1
	b	b3750
.ltorg
b3749:
	mov	r1,	#0
	b	b3750
.ltorg
b3741:
	mov	r0,	#1
	b	b3743
.ltorg
b3740:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b3737
	b	b3738
.ltorg
b3737:
	mov	r0,	#1
	b	b3739
.ltorg
b3738:
	mov	r0,	#0
	b	b3739
.ltorg
b3732:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3729
	b	b3730
.ltorg
b3729:
	mov	r0,	#1
	b	b3731
.ltorg
b3726:
	mov	r0,	#1
	b	b3728
.ltorg
b3727:
	mov	r0,	#0
	b	b3728
.ltorg
b3721:
	mov	r0,	#0
	ldr	r1,	[sp,	#424]
	cmp	r1,	r0
	bne	b3718
	b	b3719
.ltorg
b3719:
	mov	r1,	#0
	b	b3720
.ltorg
b3717:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3714
	b	b3715
.ltorg
b3715:
	mov	r7,	#0
	b	b3716
.ltorg
b3713:
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3710
	b	b3711
.ltorg
b3710:
	mov	r0,	#1
	b	b3712
.ltorg
b3709:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b3706
	b	b3707
.ltorg
b3706:
	mov	r1,	#1
	b	b3708
.ltorg
b3705:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3702
	b	b3703
.ltorg
b3702:
	mov	r5,	#1
	b	b3704
.ltorg
b3698:
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3695
	b	b3696
.ltorg
b3695:
	mov	r0,	#1
	b	b3697
.ltorg
b3694:
	mov	r0,	#0
	cmp	r3,	r0
	bne	b3691
	b	b3692
.ltorg
b3692:
	mov	r1,	#0
	b	b3693
.ltorg
b3690:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3687
	b	b3688
.ltorg
b3687:
	mov	r0,	#1
	b	b3689
.ltorg
b3683:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b3680
	b	b3681
.ltorg
b3680:
	mov	r0,	#1
	b	b3682
.ltorg
b3679:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b3676
	b	b3677
.ltorg
b3677:
	mov	r1,	#0
	b	b3678
.ltorg
b3675:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3672
	b	b3673
.ltorg
b3673:
	mov	r3,	#0
	b	b3674
.ltorg
b3671:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b3668
	b	b3669
.ltorg
b3668:
	mov	r0,	#1
	b	b3670
.ltorg
b3667:
	mov	r1,	#0
	ldr	r0,	[sp,	#796]
	cmp	r0,	r1
	bne	b3664
	b	b3665
.ltorg
b3664:
	mov	r1,	#1
	b	b3666
.ltorg
b3663:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3660
	b	b3661
.ltorg
b3660:
	mov	r0,	#1
	b	b3662
.ltorg
b3656:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b3653
	b	b3654
.ltorg
b3653:
	mov	r0,	#1
	b	b3655
.ltorg
b3652:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b3649
	b	b3650
.ltorg
b3650:
	mov	r1,	#0
	b	b3651
.ltorg
b3648:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3645
	b	b3646
.ltorg
b3645:
	mov	r3,	#1
	b	b3647
.ltorg
b3641:
	mov	r3,	#0
	ldr	r0,	[sp,	#796]
	cmp	r0,	r3
	bne	b3638
	b	b3639
.ltorg
b3638:
	mov	r0,	#1
	b	b3640
.ltorg
b3637:
	mov	r1,	#0
	ldr	r0,	[sp,	#796]
	cmp	r0,	r1
	bne	b3634
	b	b3635
.ltorg
b3635:
	mov	r1,	#0
	b	b3636
.ltorg
b3633:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3630
	b	b3631
.ltorg
b3631:
	mov	r5,	#0
	b	b3632
.ltorg
b3629:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b3626
	b	b3627
.ltorg
b3626:
	mov	r0,	#1
	b	b3628
.ltorg
b3625:
	mov	r1,	#0
	ldr	r0,	[sp,	#308]
	cmp	r0,	r1
	bne	b3622
	b	b3623
.ltorg
b3622:
	mov	r1,	#1
	b	b3624
.ltorg
b3621:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3618
	b	b3619
.ltorg
b3618:
	mov	r2,	#1
	b	b3620
.ltorg
b3619:
	mov	r2,	#0
	b	b3620
.ltorg
b3614:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b3611
	b	b3612
.ltorg
b3611:
	mov	r0,	#1
	b	b3613
.ltorg
b3610:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b3607
	b	b3608
.ltorg
b3608:
	mov	r1,	#0
	b	b3609
.ltorg
b3607:
	mov	r1,	#1
	b	b3609
.ltorg
b3600:
	mov	r0,	#1
	b	b3602
.ltorg
b3599:
	mov	r2,	#0
	ldr	r0,	[sp,	#308]
	cmp	r0,	r2
	bne	b3596
	b	b3597
.ltorg
b3596:
	mov	r0,	#1
	b	b3598
.ltorg
b3597:
	mov	r0,	#0
	b	b3598
.ltorg
b3591:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3588
	b	b3589
.ltorg
b3589:
	mov	r5,	#0
	b	b3590
.ltorg
b3587:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3584
	b	b3585
.ltorg
b3584:
	mov	r0,	#1
	b	b3586
.ltorg
b3583:
	mov	r1,	#0
	ldr	r0,	[sp,	#812]
	cmp	r0,	r1
	bne	b3580
	b	b3581
.ltorg
b3580:
	mov	r1,	#1
	b	b3582
.ltorg
b3579:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3576
	b	b3577
.ltorg
b3576:
	mov	r4,	#1
	b	b3578
.ltorg
b3572:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3569
	b	b3570
.ltorg
b3569:
	mov	r0,	#1
	b	b3571
.ltorg
b3568:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3565
	b	b3566
.ltorg
b3566:
	mov	r1,	#0
	b	b3567
.ltorg
b3564:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3561
	b	b3562
.ltorg
b3561:
	mov	r3,	#1
	b	b3563
.ltorg
b3557:
	mov	r3,	#0
	ldr	r0,	[sp,	#812]
	cmp	r0,	r3
	bne	b3554
	b	b3555
.ltorg
b3554:
	mov	r0,	#1
	b	b3556
.ltorg
b3553:
	mov	r1,	#0
	ldr	r0,	[sp,	#812]
	cmp	r0,	r1
	bne	b3550
	b	b3551
.ltorg
b3551:
	mov	r1,	#0
	b	b3552
.ltorg
b3549:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3546
	b	b3547
.ltorg
b3547:
	mov	r2,	#0
	b	b3548
.ltorg
b3545:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3542
	b	b3543
.ltorg
b3542:
	mov	r0,	#1
	b	b3544
.ltorg
b3541:
	mov	r1,	#0
	ldr	r0,	[sp,	#808]
	cmp	r0,	r1
	bne	b3538
	b	b3539
.ltorg
b3538:
	mov	r1,	#1
	b	b3540
.ltorg
b3537:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3534
	b	b3535
.ltorg
b3534:
	mov	r6,	#1
	b	b3536
.ltorg
b3530:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3527
	b	b3528
.ltorg
b3527:
	mov	r0,	#1
	b	b3529
.ltorg
b3526:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3523
	b	b3524
.ltorg
b3524:
	mov	r1,	#0
	b	b3525
.ltorg
b3522:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3519
	b	b3520
.ltorg
b3519:
	mov	r3,	#1
	b	b3521
.ltorg
b3515:
	mov	r3,	#0
	ldr	r0,	[sp,	#808]
	cmp	r0,	r3
	bne	b3512
	b	b3513
.ltorg
b3512:
	mov	r0,	#1
	b	b3514
.ltorg
b3511:
	mov	r1,	#0
	ldr	r0,	[sp,	#808]
	cmp	r0,	r1
	bne	b3508
	b	b3509
.ltorg
b3509:
	mov	r1,	#0
	b	b3510
.ltorg
b3507:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3504
	b	b3505
.ltorg
b3505:
	mov	r2,	#0
	b	b3506
.ltorg
b3503:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3500
	b	b3501
.ltorg
b3500:
	mov	r0,	#1
	b	b3502
.ltorg
b3499:
	mov	r1,	#0
	ldr	r0,	[sp,	#784]
	cmp	r0,	r1
	bne	b3496
	b	b3497
.ltorg
b3496:
	mov	r1,	#1
	b	b3498
.ltorg
b3495:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3492
	b	b3493
.ltorg
b3492:
	mov	r8,	#1
	b	b3494
.ltorg
b3488:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3485
	b	b3486
.ltorg
b3485:
	mov	r0,	#1
	b	b3487
.ltorg
b3484:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3481
	b	b3482
.ltorg
b3482:
	mov	r1,	#0
	b	b3483
.ltorg
b3481:
	mov	r1,	#1
	b	b3483
.ltorg
b3480:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3477
	b	b3478
.ltorg
b3477:
	mov	r3,	#1
	b	b3479
.ltorg
b3478:
	mov	r3,	#0
	b	b3479
.ltorg
b3473:
	mov	r3,	#0
	ldr	r0,	[sp,	#784]
	cmp	r0,	r3
	bne	b3470
	b	b3471
.ltorg
b3470:
	mov	r0,	#1
	b	b3472
.ltorg
b3469:
	mov	r1,	#0
	ldr	r0,	[sp,	#784]
	cmp	r0,	r1
	bne	b3466
	b	b3467
.ltorg
b3467:
	mov	r1,	#0
	b	b3468
.ltorg
b3466:
	mov	r1,	#1
	b	b3468
.ltorg
b3465:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3462
	b	b3463
.ltorg
b3463:
	mov	r2,	#0
	b	b3464
.ltorg
b3461:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3458
	b	b3459
.ltorg
b3458:
	mov	r0,	#1
	b	b3460
.ltorg
b3457:
	mov	r1,	#0
	ldr	r0,	[sp,	#900]
	cmp	r0,	r1
	bne	b3454
	b	b3455
.ltorg
b3454:
	mov	r1,	#1
	b	b3456
.ltorg
b3453:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3450
	b	b3451
.ltorg
b3450:
	mov	r0,	#1
	b	b3452
.ltorg
b3446:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3443
	b	b3444
.ltorg
b3443:
	mov	r0,	#1
	b	b3445
.ltorg
b3442:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3439
	b	b3440
.ltorg
b3440:
	mov	r1,	#0
	b	b3441
.ltorg
b3438:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3435
	b	b3436
.ltorg
b3435:
	mov	r3,	#1
	b	b3437
.ltorg
b3431:
	mov	r3,	#0
	ldr	r0,	[sp,	#900]
	cmp	r0,	r3
	bne	b3428
	b	b3429
.ltorg
b3428:
	mov	r0,	#1
	b	b3430
.ltorg
b3427:
	mov	r1,	#0
	ldr	r0,	[sp,	#900]
	cmp	r0,	r1
	bne	b3424
	b	b3425
.ltorg
b3425:
	mov	r1,	#0
	b	b3426
.ltorg
b3423:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3420
	b	b3421
.ltorg
b3421:
	mov	r2,	#0
	b	b3422
.ltorg
b3419:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b3416
	b	b3417
.ltorg
b3416:
	mov	r0,	#1
	b	b3418
.ltorg
b3415:
	mov	r1,	#0
	ldr	r0,	[sp,	#896]
	cmp	r0,	r1
	bne	b3412
	b	b3413
.ltorg
b3412:
	mov	r1,	#1
	b	b3414
.ltorg
b3411:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3408
	b	b3409
.ltorg
b3408:
	mov	r0,	#1
	b	b3410
.ltorg
b3404:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b3401
	b	b3402
.ltorg
b3401:
	mov	r0,	#1
	b	b3403
.ltorg
b3400:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b3397
	b	b3398
.ltorg
b3398:
	mov	r1,	#0
	b	b3399
.ltorg
b3396:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3393
	b	b3394
.ltorg
b3393:
	mov	r2,	#1
	b	b3395
.ltorg
b3389:
	mov	r2,	#0
	ldr	r0,	[sp,	#896]
	cmp	r0,	r2
	bne	b3386
	b	b3387
.ltorg
b3386:
	mov	r0,	#1
	b	b3388
.ltorg
b3385:
	mov	r1,	#0
	ldr	r0,	[sp,	#896]
	cmp	r0,	r1
	bne	b3382
	b	b3383
.ltorg
b3383:
	mov	r1,	#0
	b	b3384
.ltorg
b3381:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3378
	b	b3379
.ltorg
b3379:
	mov	r4,	#0
	b	b3380
.ltorg
b3377:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b3374
	b	b3375
.ltorg
b3374:
	mov	r0,	#1
	b	b3376
.ltorg
b3373:
	mov	r1,	#0
	ldr	r0,	[sp,	#912]
	cmp	r0,	r1
	bne	b3370
	b	b3371
.ltorg
b3370:
	mov	r1,	#1
	b	b3372
.ltorg
b3369:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3366
	b	b3367
.ltorg
b3366:
	mov	r0,	#1
	b	b3368
.ltorg
b3362:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b3359
	b	b3360
.ltorg
b3359:
	mov	r0,	#1
	b	b3361
.ltorg
b3358:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b3355
	b	b3356
.ltorg
b3356:
	mov	r1,	#0
	b	b3357
.ltorg
b3354:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3351
	b	b3352
.ltorg
b3351:
	mov	r2,	#1
	b	b3353
.ltorg
b3347:
	mov	r2,	#0
	ldr	r0,	[sp,	#912]
	cmp	r0,	r2
	bne	b3344
	b	b3345
.ltorg
b3344:
	mov	r0,	#1
	b	b3346
.ltorg
b3343:
	mov	r1,	#0
	ldr	r0,	[sp,	#912]
	cmp	r0,	r1
	bne	b3340
	b	b3341
.ltorg
b3341:
	mov	r1,	#0
	b	b3342
.ltorg
b3340:
	mov	r1,	#1
	b	b3342
.ltorg
b3331:
	mov	r1,	#0
	ldr	r0,	[sp,	#908]
	cmp	r0,	r1
	bne	b3328
	b	b3329
.ltorg
b3328:
	mov	r1,	#1
	b	b3330
.ltorg
b3327:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3324
	b	b3325
.ltorg
b3324:
	mov	r0,	#1
	b	b3326
.ltorg
b3320:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3317
	b	b3318
.ltorg
b3317:
	mov	r0,	#1
	b	b3319
.ltorg
b3316:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3313
	b	b3314
.ltorg
b3314:
	mov	r1,	#0
	b	b3315
.ltorg
b3312:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3309
	b	b3310
.ltorg
b3309:
	mov	r6,	#1
	b	b3311
.ltorg
b3305:
	mov	r6,	#0
	ldr	r0,	[sp,	#908]
	cmp	r0,	r6
	bne	b3302
	b	b3303
.ltorg
b3302:
	mov	r0,	#1
	b	b3304
.ltorg
b3301:
	mov	r1,	#0
	ldr	r0,	[sp,	#908]
	cmp	r0,	r1
	bne	b3298
	b	b3299
.ltorg
b3299:
	mov	r1,	#0
	b	b3300
.ltorg
b3297:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3294
	b	b3295
.ltorg
b3295:
	mov	r2,	#0
	b	b3296
.ltorg
b3293:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3290
	b	b3291
.ltorg
b3290:
	mov	r0,	#1
	b	b3292
.ltorg
b3289:
	mov	r1,	#0
	ldr	r0,	[sp,	#504]
	cmp	r0,	r1
	bne	b3286
	b	b3287
.ltorg
b3286:
	mov	r1,	#1
	b	b3288
.ltorg
b3285:
	mov	r8,	#0
	cmp	r0,	r8
	bne	b3282
	b	b3283
.ltorg
b3282:
	mov	r0,	#1
	b	b3284
.ltorg
b3278:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3275
	b	b3276
.ltorg
b3275:
	mov	r0,	#1
	b	b3277
.ltorg
b3274:
	mov	r0,	#0
	cmp	r2,	r0
	bne	b3271
	b	b3272
.ltorg
b3272:
	mov	r8,	#0
	b	b3273
.ltorg
b3270:
	mov	r6,	#0
	cmp	r0,	r6
	bne	b3267
	b	b3268
.ltorg
b3267:
	mov	r6,	#1
	b	b3269
.ltorg
b3263:
	mov	r8,	#0
	ldr	r0,	[sp,	#504]
	cmp	r0,	r8
	bne	b3260
	b	b3261
.ltorg
b3260:
	mov	r0,	#1
	b	b3262
.ltorg
b3259:
	mov	r6,	#0
	ldr	r0,	[sp,	#504]
	cmp	r0,	r6
	bne	b3256
	b	b3257
.ltorg
b3257:
	mov	r6,	#0
	b	b3258
.ltorg
b3255:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b3252
	b	b3253
.ltorg
b3253:
	mov	r2,	#0
	b	b3254
.ltorg
b3251:
	mov	r6,	#0
	ldr	r0,	[sp,	#492]
	cmp	r0,	r6
	bne	b3248
	b	b3249
.ltorg
b3248:
	mov	r0,	#1
	b	b3250
.ltorg
b3247:
	mov	r2,	#0
	ldr	r0,	[sp,	#496]
	cmp	r0,	r2
	bne	b3244
	b	b3245
.ltorg
b3244:
	mov	r2,	#1
	b	b3246
.ltorg
b3243:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b3240
	b	b3241
.ltorg
b3240:
	mov	r0,	#1
	b	b3242
.ltorg
b3236:
	mov	r9,	#0
	ldr	r0,	[sp,	#492]
	cmp	r0,	r9
	bne	b3233
	b	b3234
.ltorg
b3233:
	mov	r0,	#1
	b	b3235
.ltorg
b3232:
	mov	r2,	#0
	ldr	r0,	[sp,	#492]
	cmp	r0,	r2
	bne	b3229
	b	b3230
.ltorg
b3230:
	mov	r2,	#0
	b	b3231
.ltorg
b3228:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b3225
	b	b3226
.ltorg
b3225:
	mov	r8,	#1
	b	b3227
.ltorg
b3221:
	mov	r8,	#0
	ldr	r0,	[sp,	#496]
	cmp	r0,	r8
	bne	b3218
	b	b3219
.ltorg
b3218:
	mov	r0,	#1
	b	b3220
.ltorg
b3217:
	mov	r2,	#0
	ldr	r0,	[sp,	#496]
	cmp	r0,	r2
	bne	b3214
	b	b3215
.ltorg
b3215:
	mov	r2,	#0
	b	b3216
.ltorg
b3213:
	b	b3211
.ltorg
b3211:
	mov	r0,	#0
	b	b3212
.ltorg
b3210:
	mov	r0,	#1
	b	b3212
.ltorg
b3201:
	mov	r9,	#0
	ldr	r0,	[sp,	#584]
	cmp	r0,	r9
	bne	b3198
	b	b3199
.ltorg
b3198:
	mov	r0,	#1
	b	b3200
.ltorg
b3190:
	mov	r9,	#0
	b	b3189
.ltorg
b3186:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b3183
	b	b3184
.ltorg
b3183:
	mov	r2,	#1
	b	b3185
.ltorg
b3179:
	mov	r0,	#0
	cmp	r8,	r0
	bne	b3176
	b	b3177
.ltorg
b3176:
	mov	r0,	#1
	b	b3178
.ltorg
b3175:
	mov	r0,	#0
	cmp	r8,	r0
	bne	b3172
	b	b3173
.ltorg
b3173:
	mov	r2,	#0
	b	b3174
.ltorg
b3128:
	mov	r7,	#0
	sub	r2,	r7,	r2
	mov	r2,	r2
	b	b3129
.ltorg
b3112:
	mov	r2,	#0
	sub	r1,	r2,	r1
	mov	r1,	r1
	b	b3113
.ltorg
b3107:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3104
	b	b3105
.ltorg
b3105:
	b	b3106
.ltorg
b3103:
	mov	r10,	#0
	cmp	r0,	r10
	bne	b3100
	b	b3101
.ltorg
b3100:
	mov	r0,	#1
	b	b3102
.ltorg
b3099:
	mov	r10,	#0
	ldr	r1,	[sp,	#580]
	cmp	r1,	r10
	bne	b3096
	b	b3097
.ltorg
b3096:
	mov	r1,	#1
	b	b3098
.ltorg
b3095:
	mov	r4,	#0
	cmp	r1,	r4
	bne	b3092
	b	b3093
.ltorg
b3092:
	mov	r4,	#1
	b	b3094
.ltorg
b3088:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3085
	b	b3086
.ltorg
b3085:
	mov	r1,	#1
	b	b3087
.ltorg
b3084:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3081
	b	b3082
.ltorg
b3082:
	mov	r4,	#0
	b	b3083
.ltorg
b3080:
	mov	r4,	#0
	cmp	r1,	r4
	bne	b3077
	b	b3078
.ltorg
b3077:
	mov	r1,	#1
	b	b3079
.ltorg
b3073:
	mov	r10,	#0
	ldr	r1,	[sp,	#580]
	cmp	r1,	r10
	bne	b3070
	b	b3071
.ltorg
b3070:
	mov	r1,	#1
	b	b3072
.ltorg
b3069:
	mov	r4,	#0
	ldr	r1,	[sp,	#580]
	cmp	r1,	r4
	bne	b3066
	b	b3067
.ltorg
b3067:
	mov	r4,	#0
	b	b3068
.ltorg
b3065:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3062
	b	b3063
.ltorg
b3063:
	mov	r0,	#0
	b	b3064
.ltorg
b3061:
	mov	r4,	#0
	ldr	r0,	[sp,	#604]
	cmp	r0,	r4
	bne	b3058
	b	b3059
.ltorg
b3058:
	mov	r0,	#1
	b	b3060
.ltorg
b3057:
	mov	r1,	#0
	ldr	r0,	[sp,	#596]
	cmp	r0,	r1
	bne	b3054
	b	b3055
.ltorg
b3054:
	mov	r1,	#1
	b	b3056
.ltorg
b3053:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3050
	b	b3051
.ltorg
b3050:
	mov	r0,	#1
	b	b3052
.ltorg
b3046:
	mov	r10,	#0
	ldr	r0,	[sp,	#604]
	cmp	r0,	r10
	bne	b3043
	b	b3044
.ltorg
b3043:
	mov	r0,	#1
	b	b3045
.ltorg
b3042:
	mov	r1,	#0
	ldr	r0,	[sp,	#604]
	cmp	r0,	r1
	bne	b3039
	b	b3040
.ltorg
b3040:
	mov	r1,	#0
	b	b3041
.ltorg
b3038:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3035
	b	b3036
.ltorg
b3035:
	mov	r4,	#1
	b	b3037
.ltorg
b3031:
	mov	r4,	#0
	ldr	r0,	[sp,	#596]
	cmp	r0,	r4
	bne	b3028
	b	b3029
.ltorg
b3028:
	mov	r0,	#1
	b	b3030
.ltorg
b3027:
	mov	r1,	#0
	ldr	r0,	[sp,	#596]
	cmp	r0,	r1
	bne	b3024
	b	b3025
.ltorg
b3025:
	mov	r1,	#0
	b	b3026
.ltorg
b3023:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3020
	b	b3021
.ltorg
b3021:
	mov	r0,	#0
	b	b3022
.ltorg
b3019:
	mov	r0,	#0
	cmp	r10,	r0
	bne	b3016
	b	b3017
.ltorg
b3016:
	mov	r0,	#1
	b	b3018
.ltorg
b3015:
	mov	r1,	#0
	ldr	r0,	[sp,	#608]
	cmp	r0,	r1
	bne	b3012
	b	b3013
.ltorg
b3012:
	mov	r1,	#1
	b	b3014
.ltorg
b3011:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b3008
	b	b3009
.ltorg
b3008:
	mov	r0,	#1
	b	b3010
.ltorg
b3004:
	mov	r0,	#0
	cmp	r10,	r0
	bne	b3001
	b	b3002
.ltorg
b3001:
	mov	r0,	#1
	b	b3003
.ltorg
b3000:
	mov	r0,	#0
	cmp	r10,	r0
	bne	b2997
	b	b2998
.ltorg
b2998:
	mov	r1,	#0
	b	b2999
.ltorg
b2996:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2993
	b	b2994
.ltorg
b2993:
	mov	r4,	#1
	b	b2995
.ltorg
b2989:
	mov	r4,	#0
	ldr	r0,	[sp,	#608]
	cmp	r0,	r4
	bne	b2986
	b	b2987
.ltorg
b2986:
	mov	r0,	#1
	b	b2988
.ltorg
b2985:
	mov	r1,	#0
	ldr	r0,	[sp,	#608]
	cmp	r0,	r1
	bne	b2982
	b	b2983
.ltorg
b2983:
	mov	r1,	#0
	b	b2984
.ltorg
b2982:
	mov	r1,	#1
	b	b2984
.ltorg
b2973:
	mov	r10,	#0
	ldr	r1,	[sp,	#652]
	cmp	r1,	r10
	bne	b2970
	b	b2971
.ltorg
b2970:
	mov	r1,	#1
	b	b2972
.ltorg
b2969:
	mov	r7,	#0
	cmp	r1,	r7
	bne	b2966
	b	b2967
.ltorg
b2966:
	mov	r7,	#1
	b	b2968
.ltorg
b2962:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2959
	b	b2960
.ltorg
b2959:
	mov	r1,	#1
	b	b2961
.ltorg
b2958:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2955
	b	b2956
.ltorg
b2956:
	mov	r7,	#0
	b	b2957
.ltorg
b2954:
	mov	r4,	#0
	cmp	r1,	r4
	bne	b2951
	b	b2952
.ltorg
b2951:
	mov	r4,	#1
	b	b2953
.ltorg
b2947:
	mov	r7,	#0
	ldr	r1,	[sp,	#652]
	cmp	r1,	r7
	bne	b2944
	b	b2945
.ltorg
b2944:
	mov	r1,	#1
	b	b2946
.ltorg
b2943:
	mov	r4,	#0
	ldr	r1,	[sp,	#652]
	cmp	r1,	r4
	bne	b2940
	b	b2941
.ltorg
b2941:
	mov	r4,	#0
	b	b2942
.ltorg
b2939:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2936
	b	b2937
.ltorg
b2937:
	mov	r0,	#0
	b	b2938
.ltorg
b2935:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b2932
	b	b2933
.ltorg
b2932:
	mov	r0,	#1
	b	b2934
.ltorg
b2931:
	mov	r1,	#0
	ldr	r0,	[sp,	#620]
	cmp	r0,	r1
	bne	b2928
	b	b2929
.ltorg
b2928:
	mov	r1,	#1
	b	b2930
.ltorg
b2927:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2924
	b	b2925
.ltorg
b2924:
	mov	r8,	#1
	b	b2926
.ltorg
b2920:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b2917
	b	b2918
.ltorg
b2917:
	mov	r0,	#1
	b	b2919
.ltorg
b2916:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b2913
	b	b2914
.ltorg
b2914:
	mov	r1,	#0
	b	b2915
.ltorg
b2912:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2909
	b	b2910
.ltorg
b2909:
	mov	r4,	#1
	b	b2911
.ltorg
b2905:
	mov	r4,	#0
	ldr	r0,	[sp,	#620]
	cmp	r0,	r4
	bne	b2902
	b	b2903
.ltorg
b2902:
	mov	r0,	#1
	b	b2904
.ltorg
b2901:
	mov	r1,	#0
	ldr	r0,	[sp,	#620]
	cmp	r0,	r1
	bne	b2898
	b	b2899
.ltorg
b2899:
	mov	r1,	#0
	b	b2900
.ltorg
b2897:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2894
	b	b2895
.ltorg
b2895:
	mov	r7,	#0
	b	b2896
.ltorg
b2893:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b2890
	b	b2891
.ltorg
b2890:
	mov	r0,	#1
	b	b2892
.ltorg
b2889:
	mov	r1,	#0
	ldr	r0,	[sp,	#748]
	cmp	r0,	r1
	bne	b2886
	b	b2887
.ltorg
b2886:
	mov	r1,	#1
	b	b2888
.ltorg
b2885:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2882
	b	b2883
.ltorg
b2882:
	mov	r9,	#1
	b	b2884
.ltorg
b2878:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b2875
	b	b2876
.ltorg
b2875:
	mov	r0,	#1
	b	b2877
.ltorg
b2874:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b2871
	b	b2872
.ltorg
b2872:
	mov	r1,	#0
	b	b2873
.ltorg
b2870:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2867
	b	b2868
.ltorg
b2867:
	mov	r4,	#1
	b	b2869
.ltorg
b2863:
	mov	r4,	#0
	ldr	r0,	[sp,	#748]
	cmp	r0,	r4
	bne	b2860
	b	b2861
.ltorg
b2860:
	mov	r0,	#1
	b	b2862
.ltorg
b2859:
	mov	r1,	#0
	ldr	r0,	[sp,	#748]
	cmp	r0,	r1
	bne	b2856
	b	b2857
.ltorg
b2857:
	mov	r1,	#0
	b	b2858
.ltorg
b2855:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2852
	b	b2853
.ltorg
b2853:
	mov	r7,	#0
	b	b2854
.ltorg
b2852:
	mov	r7,	#1
	b	b2854
.ltorg
b2851:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b2848
	b	b2849
.ltorg
b2848:
	mov	r0,	#1
	b	b2850
.ltorg
b2849:
	mov	r0,	#0
	b	b2850
.ltorg
b2843:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2840
	b	b2841
.ltorg
b2840:
	mov	r5,	#1
	b	b2842
.ltorg
b2837:
	mov	r0,	#1
	b	b2839
.ltorg
b2838:
	mov	r0,	#0
	b	b2839
.ltorg
b2832:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b2829
	b	b2830
.ltorg
b2830:
	mov	r1,	#0
	b	b2831
.ltorg
b2828:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2825
	b	b2826
.ltorg
b2825:
	mov	r4,	#1
	b	b2827
.ltorg
b2821:
	mov	r4,	#0
	ldr	r0,	[sp,	#804]
	cmp	r0,	r4
	bne	b2818
	b	b2819
.ltorg
b2818:
	mov	r0,	#1
	b	b2820
.ltorg
b2817:
	mov	r1,	#0
	ldr	r0,	[sp,	#804]
	cmp	r0,	r1
	bne	b2814
	b	b2815
.ltorg
b2815:
	mov	r1,	#0
	b	b2816
.ltorg
b2813:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2810
	b	b2811
.ltorg
b2811:
	mov	r7,	#0
	b	b2812
.ltorg
b2809:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b2806
	b	b2807
.ltorg
b2806:
	mov	r0,	#1
	b	b2808
.ltorg
b2805:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b2802
	b	b2803
.ltorg
b2802:
	mov	r1,	#1
	b	b2804
.ltorg
b2801:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2798
	b	b2799
.ltorg
b2798:
	mov	r6,	#1
	b	b2800
.ltorg
b2794:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b2791
	b	b2792
.ltorg
b2791:
	mov	r0,	#1
	b	b2793
.ltorg
b2790:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b2787
	b	b2788
.ltorg
b2788:
	mov	r1,	#0
	b	b2789
.ltorg
b2786:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2783
	b	b2784
.ltorg
b2783:
	mov	r8,	#1
	b	b2785
.ltorg
b2779:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b2776
	b	b2777
.ltorg
b2776:
	mov	r0,	#1
	b	b2778
.ltorg
b2775:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b2772
	b	b2773
.ltorg
b2773:
	mov	r1,	#0
	b	b2774
.ltorg
b2771:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2768
	b	b2769
.ltorg
b2769:
	mov	r7,	#0
	b	b2770
.ltorg
b2767:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b2764
	b	b2765
.ltorg
b2764:
	mov	r0,	#1
	b	b2766
.ltorg
b2763:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2760
	b	b2761
.ltorg
b2760:
	mov	r1,	#1
	b	b2762
.ltorg
b2759:
	mov	r2,	#0
	cmp	r1,	r2
	bne	b2756
	b	b2757
.ltorg
b2756:
	mov	r2,	#1
	b	b2758
.ltorg
b2752:
	mov	r1,	#0
	cmp	r7,	r1
	bne	b2749
	b	b2750
.ltorg
b2749:
	mov	r1,	#1
	b	b2751
.ltorg
b2748:
	mov	r1,	#0
	cmp	r7,	r1
	bne	b2745
	b	b2746
.ltorg
b2746:
	mov	r2,	#0
	b	b2747
.ltorg
b2744:
	mov	r2,	#0
	cmp	r1,	r2
	bne	b2741
	b	b2742
.ltorg
b2741:
	mov	r8,	#1
	b	b2743
.ltorg
b2737:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2734
	b	b2735
.ltorg
b2734:
	mov	r1,	#1
	b	b2736
.ltorg
b2733:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2730
	b	b2731
.ltorg
b2731:
	mov	r2,	#0
	b	b2732
.ltorg
b2729:
	mov	r2,	#0
	cmp	r1,	r2
	bne	b2726
	b	b2727
.ltorg
b2727:
	mov	r7,	#0
	b	b2728
.ltorg
b2726:
	mov	r7,	#1
	b	b2728
.ltorg
b2725:
	mov	r1,	#0
	cmp	r8,	r1
	bne	b2722
	b	b2723
.ltorg
b2722:
	mov	r1,	#1
	b	b2724
.ltorg
b2721:
	mov	r7,	#0
	cmp	r2,	r7
	bne	b2718
	b	b2719
.ltorg
b2718:
	mov	r2,	#1
	b	b2720
.ltorg
b2719:
	mov	r2,	#0
	b	b2720
.ltorg
b2711:
	mov	r3,	#1
	b	b2713
.ltorg
b2710:
	mov	r3,	#0
	cmp	r8,	r3
	bne	b2707
	b	b2708
.ltorg
b2707:
	mov	r3,	#1
	b	b2709
.ltorg
b2708:
	mov	r3,	#0
	b	b2709
.ltorg
b2702:
	mov	r3,	#0
	cmp	r1,	r3
	bne	b2699
	b	b2700
.ltorg
b2699:
	mov	r1,	#1
	b	b2701
.ltorg
b2696:
	mov	r1,	#1
	b	b2698
.ltorg
b2697:
	mov	r1,	#0
	b	b2698
.ltorg
b2691:
	mov	r1,	#0
	cmp	r2,	r1
	bne	b2688
	b	b2689
.ltorg
b2689:
	mov	r3,	#0
	b	b2690
.ltorg
b2687:
	mov	r3,	#0
	cmp	r1,	r3
	bne	b2684
	b	b2685
.ltorg
b2685:
	mov	r8,	#0
	b	b2686
.ltorg
b2683:
	mov	r1,	#0
	cmp	r8,	r1
	bne	b2680
	b	b2681
.ltorg
b2680:
	mov	r1,	#1
	b	b2682
.ltorg
b2679:
	mov	r1,	#0
	cmp	r3,	r1
	bne	b2676
	b	b2677
.ltorg
b2676:
	mov	r3,	#1
	b	b2678
.ltorg
b2675:
	mov	r10,	#0
	cmp	r1,	r10
	bne	b2672
	b	b2673
.ltorg
b2672:
	mov	r1,	#1
	b	b2674
.ltorg
b2668:
	mov	r1,	#0
	cmp	r8,	r1
	bne	b2665
	b	b2666
.ltorg
b2665:
	mov	r1,	#1
	b	b2667
.ltorg
b2664:
	mov	r1,	#0
	cmp	r8,	r1
	bne	b2661
	b	b2662
.ltorg
b2662:
	mov	r10,	#0
	b	b2663
.ltorg
b2660:
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2657
	b	b2658
.ltorg
b2657:
	mov	r9,	#1
	b	b2659
.ltorg
b2653:
	mov	r1,	#0
	cmp	r3,	r1
	bne	b2650
	b	b2651
.ltorg
b2650:
	mov	r1,	#1
	b	b2652
.ltorg
b2649:
	mov	r1,	#0
	cmp	r3,	r1
	bne	b2646
	b	b2647
.ltorg
b2647:
	mov	r9,	#0
	b	b2648
.ltorg
b2645:
	mov	r8,	#0
	cmp	r1,	r8
	bne	b2642
	b	b2643
.ltorg
b2643:
	mov	r8,	#0
	b	b2644
.ltorg
b2641:
	mov	r1,	#0
	cmp	r9,	r1
	bne	b2638
	b	b2639
.ltorg
b2638:
	mov	r1,	#1
	b	b2640
.ltorg
b2637:
	mov	r1,	#0
	cmp	r8,	r1
	bne	b2634
	b	b2635
.ltorg
b2634:
	mov	r8,	#1
	b	b2636
.ltorg
b2633:
	mov	r10,	#0
	cmp	r1,	r10
	bne	b2630
	b	b2631
.ltorg
b2630:
	mov	r1,	#1
	b	b2632
.ltorg
b2626:
	mov	r1,	#0
	cmp	r9,	r1
	bne	b2623
	b	b2624
.ltorg
b2623:
	mov	r1,	#1
	b	b2625
.ltorg
b2622:
	mov	r1,	#0
	cmp	r9,	r1
	bne	b2619
	b	b2620
.ltorg
b2620:
	mov	r10,	#0
	b	b2621
.ltorg
b2618:
	mov	r10,	#0
	cmp	r1,	r10
	bne	b2615
	b	b2616
.ltorg
b2615:
	mov	r1,	#1
	b	b2617
.ltorg
b2611:
	mov	r1,	#0
	cmp	r8,	r1
	bne	b2608
	b	b2609
.ltorg
b2608:
	mov	r1,	#1
	b	b2610
.ltorg
b2607:
	mov	r1,	#0
	cmp	r8,	r1
	bne	b2604
	b	b2605
.ltorg
b2605:
	mov	r10,	#0
	b	b2606
.ltorg
b2603:
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2600
	b	b2601
.ltorg
b2601:
	mov	r9,	#0
	b	b2602
.ltorg
b2599:
	mov	r1,	#0
	cmp	r10,	r1
	bne	b2596
	b	b2597
.ltorg
b2596:
	mov	r1,	#1
	b	b2598
.ltorg
b2595:
	mov	r1,	#0
	ldr	r9,	[sp,	#468]
	cmp	r9,	r1
	bne	b2592
	b	b2593
.ltorg
b2592:
	mov	r9,	#1
	b	b2594
.ltorg
b2591:
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2588
	b	b2589
.ltorg
b2588:
	mov	r1,	#1
	b	b2590
.ltorg
b2589:
	mov	r1,	#0
	b	b2590
.ltorg
b2584:
	mov	r1,	#0
	cmp	r10,	r1
	bne	b2581
	b	b2582
.ltorg
b2581:
	mov	r1,	#1
	b	b2583
.ltorg
b2580:
	mov	r1,	#0
	cmp	r10,	r1
	bne	b2577
	b	b2578
.ltorg
b2578:
	mov	r9,	#0
	b	b2579
.ltorg
b2577:
	mov	r9,	#1
	b	b2579
.ltorg
b2570:
	mov	r1,	#1
	b	b2572
.ltorg
b2569:
	mov	r1,	#0
	ldr	r11,	[sp,	#468]
	cmp	r11,	r1
	bne	b2566
	b	b2567
.ltorg
b2566:
	mov	r1,	#1
	b	b2568
.ltorg
b2567:
	mov	r1,	#0
	b	b2568
.ltorg
b2561:
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2558
	b	b2559
.ltorg
b2559:
	mov	r10,	#0
	b	b2560
.ltorg
b2557:
	mov	r1,	#0
	cmp	r10,	r1
	bne	b2554
	b	b2555
.ltorg
b2554:
	mov	r1,	#1
	b	b2556
.ltorg
b2553:
	mov	r9,	#0
	ldr	r1,	[sp,	#3684]
	cmp	r1,	r9
	bne	b2550
	b	b2551
.ltorg
b2550:
	mov	r9,	#1
	b	b2552
.ltorg
b2549:
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2546
	b	b2547
.ltorg
b2546:
	mov	r1,	#1
	b	b2548
.ltorg
b2542:
	mov	r1,	#0
	cmp	r10,	r1
	bne	b2539
	b	b2540
.ltorg
b2539:
	mov	r1,	#1
	b	b2541
.ltorg
b2538:
	mov	r1,	#0
	cmp	r10,	r1
	bne	b2535
	b	b2536
.ltorg
b2536:
	mov	r1,	#0
	b	b2537
.ltorg
b2534:
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2531
	b	b2532
.ltorg
b2531:
	mov	r1,	#1
	b	b2533
.ltorg
b2527:
	mov	r9,	#0
	ldr	r1,	[sp,	#3684]
	cmp	r1,	r9
	bne	b2524
	b	b2525
.ltorg
b2524:
	mov	r1,	#1
	b	b2526
.ltorg
b2523:
	mov	r9,	#0
	ldr	r1,	[sp,	#3684]
	cmp	r1,	r9
	bne	b2520
	b	b2521
.ltorg
b2521:
	mov	r1,	#0
	b	b2522
.ltorg
b2519:
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2516
	b	b2517
.ltorg
b2517:
	mov	r10,	#0
	b	b2518
.ltorg
b2515:
	mov	r1,	#0
	cmp	r10,	r1
	bne	b2512
	b	b2513
.ltorg
b2512:
	mov	r1,	#1
	b	b2514
.ltorg
b2511:
	mov	r9,	#0
	ldr	r1,	[sp,	#352]
	cmp	r1,	r9
	bne	b2508
	b	b2509
.ltorg
b2508:
	mov	r9,	#1
	b	b2510
.ltorg
b2507:
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2504
	b	b2505
.ltorg
b2504:
	mov	r1,	#1
	b	b2506
.ltorg
b2500:
	mov	r1,	#0
	cmp	r10,	r1
	bne	b2497
	b	b2498
.ltorg
b2497:
	mov	r1,	#1
	b	b2499
.ltorg
b2496:
	mov	r1,	#0
	cmp	r10,	r1
	bne	b2493
	b	b2494
.ltorg
b2494:
	mov	r1,	#0
	b	b2495
.ltorg
b2492:
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2489
	b	b2490
.ltorg
b2489:
	mov	r1,	#1
	b	b2491
.ltorg
b2485:
	mov	r9,	#0
	ldr	r1,	[sp,	#352]
	cmp	r1,	r9
	bne	b2482
	b	b2483
.ltorg
b2482:
	mov	r1,	#1
	b	b2484
.ltorg
b2481:
	mov	r9,	#0
	ldr	r1,	[sp,	#352]
	cmp	r1,	r9
	bne	b2478
	b	b2479
.ltorg
b2479:
	mov	r1,	#0
	b	b2480
.ltorg
b2477:
	b	b2475
.ltorg
b2475:
	mov	r10,	#0
	b	b2476
.ltorg
b2473:
	b	b2471
.ltorg
b2469:
	mov	r1,	#0
	ldr	r9,	[sp,	#2012]
	cmp	r9,	r1
	bne	b2466
	b	b2467
.ltorg
b2466:
	mov	r1,	#1
	b	b2468
.ltorg
b2465:
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2462
	b	b2463
.ltorg
b2462:
	mov	r1,	#1
	b	b2464
.ltorg
b2458:
	b	b2456
.ltorg
b2454:
	mov	r1,	#0
	b	b2453
.ltorg
b2451:
	mov	r1,	#1
	b	b2453
.ltorg
b2450:
	mov	r9,	#0
	cmp	r1,	r9
	bne	b2447
	b	b2448
.ltorg
b2447:
	mov	r1,	#1
	b	b2449
.ltorg
b2448:
	mov	r1,	#0
	b	b2449
.ltorg
b2443:
	mov	r1,	#0
	ldr	r9,	[sp,	#2012]
	cmp	r9,	r1
	bne	b2440
	b	b2441
.ltorg
b2440:
	mov	r1,	#1
	b	b2442
.ltorg
b2439:
	mov	r1,	#0
	ldr	r9,	[sp,	#2012]
	cmp	r9,	r1
	bne	b2436
	b	b2437
.ltorg
b2437:
	mov	r1,	#0
	b	b2438
.ltorg
b2436:
	mov	r1,	#1
	b	b2438
.ltorg
b2434:
	mov	r9,	#0
	sub	r1,	r9,	r1
	mov	r1,	r1
	b	b2435
.ltorg
b2418:
	mov	r1,	#0
	sub	r0,	r1,	r0
	mov	r0,	r0
	b	b2419
.ltorg
b2371:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b2368
	b	b2369
.ltorg
b2369:
	b	b2370
.ltorg
b2367:
	mov	r9,	#0
	ldr	r0,	[sp,	#344]
	cmp	r0,	r9
	bne	b2364
	b	b2365
.ltorg
b2364:
	mov	r0,	#1
	b	b2366
.ltorg
b2363:
	b	b2361
.ltorg
b2359:
	mov	r2,	#0
	ldr	r0,	[sp,	#864]
	cmp	r0,	r2
	bne	b2356
	b	b2357
.ltorg
b2356:
	mov	r2,	#1
	b	b2358
.ltorg
b2352:
	mov	r0,	#0
	ldr	r10,	[sp,	#344]
	cmp	r10,	r0
	bne	b2349
	b	b2350
.ltorg
b2349:
	mov	r0,	#1
	b	b2351
.ltorg
b2348:
	mov	r0,	#0
	ldr	r2,	[sp,	#344]
	cmp	r2,	r0
	bne	b2345
	b	b2346
.ltorg
b2346:
	mov	r2,	#0
	b	b2347
.ltorg
b2344:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b2341
	b	b2342
.ltorg
b2341:
	mov	r9,	#1
	b	b2343
.ltorg
b2337:
	b	b2335
.ltorg
b2333:
	b	b2331
.ltorg
b2331:
	mov	r2,	#0
	b	b2332
.ltorg
b2329:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b2326
	b	b2327
.ltorg
b2327:
	mov	r0,	#0
	b	b2328
.ltorg
b2326:
	mov	r0,	#1
	b	b2328
.ltorg
b2325:
	mov	r0,	#0
	cmp	r10,	r0
	bne	b2322
	b	b2323
.ltorg
b2322:
	mov	r0,	#1
	b	b2324
.ltorg
b2311:
	mov	r0,	#1
	b	b2313
.ltorg
b2310:
	mov	r0,	#0
	cmp	r10,	r0
	bne	b2307
	b	b2308
.ltorg
b2307:
	mov	r0,	#1
	b	b2309
.ltorg
b2308:
	mov	r0,	#0
	b	b2309
.ltorg
b2302:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b2299
	b	b2300
.ltorg
b2299:
	mov	r9,	#1
	b	b2301
.ltorg
b2296:
	mov	r0,	#1
	b	b2298
.ltorg
b2297:
	mov	r0,	#0
	b	b2298
.ltorg
b2291:
	b	b2289
.ltorg
b2289:
	mov	r2,	#0
	b	b2290
.ltorg
b2287:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b2284
	b	b2285
.ltorg
b2285:
	mov	r10,	#0
	b	b2286
.ltorg
b2283:
	mov	r9,	#0
	ldr	r0,	[sp,	#888]
	cmp	r0,	r9
	bne	b2280
	b	b2281
.ltorg
b2280:
	mov	r0,	#1
	b	b2282
.ltorg
b2279:
	b	b2277
.ltorg
b2275:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b2272
	b	b2273
.ltorg
b2272:
	mov	r0,	#1
	b	b2274
.ltorg
b2268:
	mov	r10,	#0
	ldr	r0,	[sp,	#888]
	cmp	r0,	r10
	bne	b2265
	b	b2266
.ltorg
b2265:
	mov	r0,	#1
	b	b2267
.ltorg
b2264:
	mov	r2,	#0
	ldr	r0,	[sp,	#888]
	cmp	r0,	r2
	bne	b2261
	b	b2262
.ltorg
b2262:
	mov	r2,	#0
	b	b2263
.ltorg
b2260:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b2257
	b	b2258
.ltorg
b2257:
	mov	r9,	#1
	b	b2259
.ltorg
b2253:
	b	b2251
.ltorg
b2249:
	b	b2247
.ltorg
b2247:
	mov	r2,	#0
	b	b2248
.ltorg
b2245:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b2242
	b	b2243
.ltorg
b2243:
	mov	r0,	#0
	b	b2244
.ltorg
b2241:
	mov	r9,	#0
	ldr	r0,	[sp,	#868]
	cmp	r0,	r9
	bne	b2238
	b	b2239
.ltorg
b2238:
	mov	r0,	#1
	b	b2240
.ltorg
b2237:
	b	b2235
.ltorg
b2233:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b2230
	b	b2231
.ltorg
b2230:
	mov	r0,	#1
	b	b2232
.ltorg
b2226:
	mov	r10,	#0
	ldr	r0,	[sp,	#868]
	cmp	r0,	r10
	bne	b2223
	b	b2224
.ltorg
b2223:
	mov	r0,	#1
	b	b2225
.ltorg
b2222:
	mov	r2,	#0
	ldr	r0,	[sp,	#868]
	cmp	r0,	r2
	bne	b2219
	b	b2220
.ltorg
b2220:
	mov	r2,	#0
	b	b2221
.ltorg
b2218:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b2215
	b	b2216
.ltorg
b2215:
	mov	r9,	#1
	b	b2217
.ltorg
b2211:
	b	b2209
.ltorg
b2207:
	b	b2205
.ltorg
b2205:
	mov	r2,	#0
	b	b2206
.ltorg
b2203:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b2200
	b	b2201
.ltorg
b2201:
	mov	r0,	#0
	b	b2202
.ltorg
b2199:
	mov	r0,	#0
	ldr	r9,	[sp,	#532]
	cmp	r9,	r0
	bne	b2196
	b	b2197
.ltorg
b2196:
	mov	r0,	#1
	b	b2198
.ltorg
b2195:
	b	b2193
.ltorg
b2191:
	mov	r10,	#0
	cmp	r0,	r10
	bne	b2188
	b	b2189
.ltorg
b2188:
	mov	r0,	#1
	b	b2190
.ltorg
b2189:
	mov	r0,	#0
	b	b2190
.ltorg
b2184:
	mov	r0,	#0
	ldr	r11,	[sp,	#532]
	cmp	r11,	r0
	bne	b2181
	b	b2182
.ltorg
b2181:
	mov	r0,	#1
	b	b2183
.ltorg
b2180:
	mov	r0,	#0
	ldr	r10,	[sp,	#532]
	cmp	r10,	r0
	bne	b2177
	b	b2178
.ltorg
b2178:
	mov	r10,	#0
	b	b2179
.ltorg
b2177:
	mov	r10,	#1
	b	b2179
.ltorg
b2170:
	mov	r0,	#1
	b	b2172
.ltorg
b2161:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b2158
	b	b2159
.ltorg
b2159:
	mov	r0,	#0
	b	b2160
.ltorg
b2157:
	mov	r0,	#0
	ldr	r10,	[sp,	#524]
	cmp	r10,	r0
	bne	b2154
	b	b2155
.ltorg
b2154:
	mov	r0,	#1
	b	b2156
.ltorg
b2153:
	b	b2151
.ltorg
b2149:
	mov	r10,	#0
	cmp	r4,	r10
	bne	b2146
	b	b2147
.ltorg
b2146:
	mov	r4,	#1
	b	b2148
.ltorg
b2142:
	mov	r4,	#0
	ldr	r11,	[sp,	#524]
	cmp	r11,	r4
	bne	b2139
	b	b2140
.ltorg
b2139:
	mov	r4,	#1
	b	b2141
.ltorg
b2138:
	mov	r4,	#0
	ldr	r10,	[sp,	#524]
	cmp	r10,	r4
	bne	b2135
	b	b2136
.ltorg
b2136:
	mov	r10,	#0
	b	b2137
.ltorg
b2134:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2131
	b	b2132
.ltorg
b2131:
	mov	r0,	#1
	b	b2133
.ltorg
b2127:
	b	b2125
.ltorg
b2123:
	b	b2121
.ltorg
b2121:
	mov	r4,	#0
	b	b2122
.ltorg
b2119:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2116
	b	b2117
.ltorg
b2117:
	mov	r0,	#0
	b	b2118
.ltorg
b2115:
	mov	r0,	#0
	ldr	r10,	[sp,	#508]
	cmp	r10,	r0
	bne	b2112
	b	b2113
.ltorg
b2112:
	mov	r0,	#1
	b	b2114
.ltorg
b2111:
	b	b2109
.ltorg
b2107:
	mov	r7,	#0
	cmp	r4,	r7
	bne	b2104
	b	b2105
.ltorg
b2104:
	mov	r7,	#1
	b	b2106
.ltorg
b2100:
	mov	r4,	#0
	ldr	r11,	[sp,	#508]
	cmp	r11,	r4
	bne	b2097
	b	b2098
.ltorg
b2097:
	mov	r4,	#1
	b	b2099
.ltorg
b2096:
	mov	r4,	#0
	ldr	r7,	[sp,	#508]
	cmp	r7,	r4
	bne	b2093
	b	b2094
.ltorg
b2094:
	mov	r7,	#0
	b	b2095
.ltorg
b2092:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2089
	b	b2090
.ltorg
b2089:
	mov	r0,	#1
	b	b2091
.ltorg
b2085:
	b	b2083
.ltorg
b2081:
	b	b2079
.ltorg
b2079:
	mov	r4,	#0
	b	b2080
.ltorg
b2077:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2074
	b	b2075
.ltorg
b2075:
	mov	r0,	#0
	b	b2076
.ltorg
b2073:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b2070
	b	b2071
.ltorg
b2070:
	mov	r0,	#1
	b	b2072
.ltorg
b2069:
	b	b2067
.ltorg
b2065:
	mov	r8,	#0
	cmp	r4,	r8
	bne	b2062
	b	b2063
.ltorg
b2062:
	mov	r8,	#1
	b	b2064
.ltorg
b2058:
	mov	r4,	#0
	cmp	r7,	r4
	bne	b2055
	b	b2056
.ltorg
b2055:
	mov	r4,	#1
	b	b2057
.ltorg
b2054:
	mov	r4,	#0
	cmp	r7,	r4
	bne	b2051
	b	b2052
.ltorg
b2052:
	mov	r8,	#0
	b	b2053
.ltorg
b2051:
	mov	r8,	#1
	b	b2053
.ltorg
b2050:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2047
	b	b2048
.ltorg
b2047:
	mov	r0,	#1
	b	b2049
.ltorg
b2048:
	mov	r0,	#0
	b	b2049
.ltorg
b2043:
	b	b2041
.ltorg
b2039:
	b	b2037
.ltorg
b2037:
	mov	r4,	#0
	b	b2038
.ltorg
b2036:
	mov	r4,	#1
	b	b2038
.ltorg
b2035:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b2032
	b	b2033
.ltorg
b2033:
	mov	r7,	#0
	b	b2034
.ltorg
b2031:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b2028
	b	b2029
.ltorg
b2028:
	mov	r0,	#1
	b	b2030
.ltorg
b2027:
	b	b2025
.ltorg
b2023:
	mov	r4,	#0
	cmp	r3,	r4
	bne	b2020
	b	b2021
.ltorg
b2020:
	mov	r3,	#1
	b	b2022
.ltorg
b2016:
	mov	r3,	#0
	cmp	r7,	r3
	bne	b2013
	b	b2014
.ltorg
b2013:
	mov	r3,	#1
	b	b2015
.ltorg
b2012:
	mov	r3,	#0
	cmp	r7,	r3
	bne	b2009
	b	b2010
.ltorg
b2010:
	mov	r4,	#0
	b	b2011
.ltorg
b2008:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b2005
	b	b2006
.ltorg
b2005:
	mov	r0,	#1
	b	b2007
.ltorg
b2001:
	b	b1999
.ltorg
b1997:
	b	b1995
.ltorg
b1995:
	mov	r3,	#0
	b	b1996
.ltorg
b1993:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b1990
	b	b1991
.ltorg
b1991:
	mov	r7,	#0
	b	b1992
.ltorg
b1989:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1986
	b	b1987
.ltorg
b1986:
	mov	r0,	#1
	b	b1988
.ltorg
b1985:
	b	b1983
.ltorg
b1981:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b1978
	b	b1979
.ltorg
b1978:
	mov	r5,	#1
	b	b1980
.ltorg
b1974:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1971
	b	b1972
.ltorg
b1971:
	mov	r0,	#1
	b	b1973
.ltorg
b1970:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1967
	b	b1968
.ltorg
b1968:
	mov	r3,	#0
	b	b1969
.ltorg
b1966:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b1963
	b	b1964
.ltorg
b1963:
	mov	r7,	#1
	b	b1965
.ltorg
b1959:
	b	b1957
.ltorg
b1955:
	b	b1953
.ltorg
b1953:
	mov	r3,	#0
	b	b1954
.ltorg
b1951:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b1948
	b	b1949
.ltorg
b1949:
	mov	r4,	#0
	b	b1950
.ltorg
b1947:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b1944
	b	b1945
.ltorg
b1944:
	mov	r0,	#1
	b	b1946
.ltorg
b1943:
	b	b1941
.ltorg
b1939:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b1936
	b	b1937
.ltorg
b1936:
	mov	r6,	#1
	b	b1938
.ltorg
b1932:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b1929
	b	b1930
.ltorg
b1929:
	mov	r0,	#1
	b	b1931
.ltorg
b1928:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b1925
	b	b1926
.ltorg
b1926:
	mov	r3,	#0
	b	b1927
.ltorg
b1924:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b1921
	b	b1922
.ltorg
b1921:
	mov	r4,	#1
	b	b1923
.ltorg
b1917:
	b	b1915
.ltorg
b1913:
	b	b1911
.ltorg
b1911:
	mov	r3,	#0
	b	b1912
.ltorg
b1910:
	mov	r3,	#1
	b	b1912
.ltorg
b1901:
	b	b1899
.ltorg
b1897:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b1894
	b	b1895
.ltorg
b1894:
	mov	r0,	#1
	b	b1896
.ltorg
b1890:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1887
	b	b1888
.ltorg
b1887:
	mov	r0,	#1
	b	b1889
.ltorg
b1886:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1883
	b	b1884
.ltorg
b1884:
	mov	r3,	#0
	b	b1885
.ltorg
b1882:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b1879
	b	b1880
.ltorg
b1879:
	mov	r5,	#1
	b	b1881
.ltorg
b1875:
	b	b1873
.ltorg
b1871:
	b	b1869
.ltorg
b1869:
	mov	r3,	#0
	b	b1870
.ltorg
b1867:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b1864
	b	b1865
.ltorg
b1865:
	mov	r4,	#0
	b	b1866
.ltorg
b1863:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1860
	b	b1861
.ltorg
b1860:
	mov	r0,	#1
	b	b1862
.ltorg
b1859:
	b	b1857
.ltorg
b1855:
	mov	r6,	#0
	cmp	r0,	r6
	bne	b1852
	b	b1853
.ltorg
b1852:
	mov	r0,	#1
	b	b1854
.ltorg
b1848:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1845
	b	b1846
.ltorg
b1845:
	mov	r0,	#1
	b	b1847
.ltorg
b1844:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1841
	b	b1842
.ltorg
b1842:
	mov	r6,	#0
	b	b1843
.ltorg
b1840:
	mov	r5,	#0
	cmp	r0,	r5
	bne	b1837
	b	b1838
.ltorg
b1837:
	mov	r5,	#1
	b	b1839
.ltorg
b1833:
	b	b1831
.ltorg
b1829:
	b	b1827
.ltorg
b1827:
	mov	r5,	#0
	b	b1828
.ltorg
b1825:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b1822
	b	b1823
.ltorg
b1823:
	mov	r4,	#0
	b	b1824
.ltorg
b1821:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b1818
	b	b1819
.ltorg
b1818:
	mov	r0,	#1
	b	b1820
.ltorg
b1817:
	b	b1815
.ltorg
b1813:
	mov	r7,	#0
	cmp	r0,	r7
	bne	b1810
	b	b1811
.ltorg
b1810:
	mov	r0,	#1
	b	b1812
.ltorg
b1806:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b1803
	b	b1804
.ltorg
b1803:
	mov	r0,	#1
	b	b1805
.ltorg
b1802:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b1799
	b	b1800
.ltorg
b1800:
	mov	r7,	#0
	b	b1801
.ltorg
b1798:
	mov	r6,	#0
	cmp	r0,	r6
	bne	b1795
	b	b1796
.ltorg
b1795:
	mov	r6,	#1
	b	b1797
.ltorg
b1791:
	b	b1789
.ltorg
b1787:
	b	b1785
.ltorg
b1785:
	mov	r6,	#0
	b	b1786
.ltorg
b1783:
	mov	r5,	#0
	cmp	r0,	r5
	bne	b1780
	b	b1781
.ltorg
b1781:
	mov	r5,	#0
	b	b1782
.ltorg
b1780:
	mov	r5,	#1
	b	b1782
.ltorg
b1779:
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1776
	b	b1777
.ltorg
b1776:
	mov	r0,	#1
	b	b1778
.ltorg
b1777:
	mov	r0,	#0
	b	b1778
.ltorg
b1771:
	mov	r8,	#0
	cmp	r0,	r8
	bne	b1768
	b	b1769
.ltorg
b1768:
	mov	r0,	#1
	b	b1770
.ltorg
b1765:
	mov	r0,	#1
	b	b1767
.ltorg
b1766:
	mov	r0,	#0
	b	b1767
.ltorg
b1760:
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1757
	b	b1758
.ltorg
b1758:
	mov	r8,	#0
	b	b1759
.ltorg
b1756:
	mov	r7,	#0
	cmp	r0,	r7
	bne	b1753
	b	b1754
.ltorg
b1753:
	mov	r7,	#1
	b	b1755
.ltorg
b1749:
	b	b1747
.ltorg
b1745:
	b	b1743
.ltorg
b1743:
	mov	r7,	#0
	b	b1744
.ltorg
b1741:
	b	b1739
.ltorg
b1739:
	mov	r6,	#0
	b	b1740
.ltorg
b1737:
	b	b1735
.ltorg
b1733:
	b	b1730
.ltorg
b1730:
	mov	r0,	#1
	b	b1732
.ltorg
b1729:
	mov	r8,	#0
	cmp	r0,	r8
	bne	b1726
	b	b1727
.ltorg
b1726:
	mov	r0,	#1
	b	b1728
.ltorg
b1722:
	b	b1720
.ltorg
b1718:
	mov	r8,	#0
	b	b1717
.ltorg
b1714:
	mov	r6,	#0
	cmp	r0,	r6
	bne	b1711
	b	b1712
.ltorg
b1711:
	mov	r6,	#1
	b	b1713
.ltorg
b1707:
	b	b1704
.ltorg
b1704:
	mov	r0,	#1
	b	b1706
.ltorg
b1703:
	b	b1700
.ltorg
b1555:
	mov	r0,	#0
	str	r0,	[sp,	#1060]
	ldr	r0,	[sp,	#728]
	ldr	r11,	[sp,	#1060]
	str	r11,	[sp,	#1960]
	ldr	r11,	[sp,	#1960]
	str	r11,	[sp,	#1360]
	ldr	r11,	[sp,	#1360]
	str	r11,	[sp,	#1956]
	ldr	r11,	[sp,	#1956]
	cmp	r0,	r11
	bne	b1552
	b	b1553
.ltorg
b1553:
	b	b1554
.ltorg
b1551:
	mov	r0,	#0
	str	r0,	[sp,	#1064]
	ldr	r0,	[sp,	#732]
	ldr	r11,	[sp,	#1064]
	str	r11,	[sp,	#1968]
	ldr	r11,	[sp,	#1968]
	str	r11,	[sp,	#1356]
	ldr	r11,	[sp,	#1356]
	str	r11,	[sp,	#1964]
	ldr	r11,	[sp,	#1964]
	cmp	r0,	r11
	bne	b1548
	b	b1549
.ltorg
b1548:
	mov	r0,	#1
	b	b1550
.ltorg
b1547:
	mov	r0,	#0
	str	r0,	[sp,	#1056]
	ldr	r0,	[sp,	#696]
	ldr	r11,	[sp,	#1056]
	str	r11,	[sp,	#1916]
	ldr	r11,	[sp,	#1916]
	str	r11,	[sp,	#1364]
	ldr	r11,	[sp,	#1364]
	str	r11,	[sp,	#1912]
	ldr	r11,	[sp,	#1912]
	cmp	r0,	r11
	bne	b1544
	b	b1545
.ltorg
b1544:
	mov	r0,	#1
	b	b1546
.ltorg
b1543:
	mov	r0,	#0
	ldr	r11,	[sp,	#724]
	cmp	r11,	r0
	bne	b1540
	b	b1541
.ltorg
b1540:
	mov	r0,	#1
	b	b1542
.ltorg
b1541:
	mov	r0,	#0
	b	b1542
.ltorg
b1536:
	mov	r0,	#0
	str	r0,	[sp,	#1052]
	ldr	r0,	[sp,	#732]
	ldr	r11,	[sp,	#1052]
	str	r11,	[sp,	#1936]
	ldr	r11,	[sp,	#1936]
	str	r11,	[sp,	#1352]
	ldr	r11,	[sp,	#1352]
	str	r11,	[sp,	#1932]
	ldr	r11,	[sp,	#1932]
	cmp	r0,	r11
	bne	b1533
	b	b1534
.ltorg
b1533:
	mov	r0,	#1
	b	b1535
.ltorg
b1532:
	mov	r0,	#0
	ldr	r11,	[sp,	#732]
	cmp	r11,	r0
	bne	b1529
	b	b1530
.ltorg
b1530:
	mov	r0,	#0
	b	b1531
.ltorg
b1529:
	mov	r0,	#1
	b	b1531
.ltorg
b1522:
	mov	r0,	#1
	b	b1524
.ltorg
b1521:
	mov	r0,	#0
	ldr	r11,	[sp,	#696]
	cmp	r11,	r0
	bne	b1518
	b	b1519
.ltorg
b1518:
	mov	r0,	#1
	b	b1520
.ltorg
b1519:
	mov	r0,	#0
	b	b1520
.ltorg
b1513:
	mov	r0,	#0
	ldr	r11,	[sp,	#712]
	cmp	r11,	r0
	bne	b1510
	b	b1511
.ltorg
b1511:
	mov	r0,	#0
	b	b1512
.ltorg
b1509:
	mov	r0,	#0
	ldr	r11,	[sp,	#716]
	cmp	r11,	r0
	bne	b1506
	b	b1507
.ltorg
b1506:
	mov	r0,	#1
	b	b1508
.ltorg
b1505:
	mov	r0,	#0
	str	r0,	[sp,	#1044]
	ldr	r0,	[sp,	#720]
	ldr	r11,	[sp,	#1044]
	str	r11,	[sp,	#1892]
	ldr	r11,	[sp,	#1892]
	str	r11,	[sp,	#1376]
	ldr	r11,	[sp,	#1376]
	str	r11,	[sp,	#1928]
	ldr	r11,	[sp,	#1928]
	cmp	r0,	r11
	bne	b1502
	b	b1503
.ltorg
b1502:
	mov	r0,	#1
	b	b1504
.ltorg
b1501:
	mov	r0,	#0
	ldr	r4,	[sp,	#1048]
	cmp	r4,	r0
	bne	b1498
	b	b1499
.ltorg
b1498:
	mov	r4,	#1
	b	b1500
.ltorg
b1494:
	mov	r0,	#0
	ldr	r4,	[sp,	#716]
	cmp	r4,	r0
	bne	b1491
	b	b1492
.ltorg
b1491:
	mov	r0,	#1
	b	b1493
.ltorg
b1490:
	mov	r0,	#0
	ldr	r4,	[sp,	#716]
	cmp	r4,	r0
	bne	b1487
	b	b1488
.ltorg
b1488:
	mov	r0,	#0
	b	b1489
.ltorg
b1486:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b1483
	b	b1484
.ltorg
b1483:
	mov	r0,	#1
	b	b1485
.ltorg
b1479:
	mov	r0,	#0
	ldr	r11,	[sp,	#720]
	cmp	r11,	r0
	bne	b1476
	b	b1477
.ltorg
b1476:
	mov	r0,	#1
	b	b1478
.ltorg
b1475:
	mov	r0,	#0
	ldr	r4,	[sp,	#720]
	cmp	r4,	r0
	bne	b1472
	b	b1473
.ltorg
b1473:
	mov	r4,	#0
	b	b1474
.ltorg
b1471:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b1468
	b	b1469
.ltorg
b1469:
	mov	r0,	#0
	b	b1470
.ltorg
b1467:
	mov	r0,	#0
	ldr	r11,	[sp,	#740]
	cmp	r11,	r0
	bne	b1464
	b	b1465
.ltorg
b1464:
	mov	r0,	#1
	b	b1466
.ltorg
b1463:
	mov	r4,	#0
	ldr	r11,	[sp,	#744]
	cmp	r11,	r4
	bne	b1460
	b	b1461
.ltorg
b1460:
	mov	r4,	#1
	b	b1462
.ltorg
b1459:
	mov	r4,	#0
	cmp	r2,	r4
	bne	b1456
	b	b1457
.ltorg
b1456:
	mov	r2,	#1
	b	b1458
.ltorg
b1452:
	mov	r2,	#0
	ldr	r11,	[sp,	#740]
	cmp	r11,	r2
	bne	b1449
	b	b1450
.ltorg
b1449:
	mov	r2,	#1
	b	b1451
.ltorg
b1448:
	mov	r2,	#0
	ldr	r4,	[sp,	#740]
	cmp	r4,	r2
	bne	b1445
	b	b1446
.ltorg
b1446:
	mov	r4,	#0
	b	b1447
.ltorg
b1444:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1441
	b	b1442
.ltorg
b1441:
	mov	r0,	#1
	b	b1443
.ltorg
b1437:
	mov	r0,	#0
	ldr	r4,	[sp,	#744]
	cmp	r4,	r0
	bne	b1434
	b	b1435
.ltorg
b1434:
	mov	r0,	#1
	b	b1436
.ltorg
b1433:
	mov	r0,	#0
	ldr	r2,	[sp,	#744]
	cmp	r2,	r0
	bne	b1430
	b	b1431
.ltorg
b1431:
	mov	r2,	#0
	b	b1432
.ltorg
b1429:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1426
	b	b1427
.ltorg
b1427:
	mov	r0,	#0
	b	b1428
.ltorg
b1425:
	mov	r0,	#0
	ldr	r4,	[sp,	#736]
	cmp	r4,	r0
	bne	b1422
	b	b1423
.ltorg
b1422:
	mov	r0,	#1
	b	b1424
.ltorg
b1421:
	mov	r4,	#0
	ldr	r2,	[sp,	#252]
	cmp	r2,	r4
	bne	b1418
	b	b1419
.ltorg
b1418:
	mov	r2,	#1
	b	b1420
.ltorg
b1417:
	mov	r4,	#0
	cmp	r2,	r4
	bne	b1414
	b	b1415
.ltorg
b1414:
	mov	r8,	#1
	b	b1416
.ltorg
b1410:
	mov	r2,	#0
	ldr	r8,	[sp,	#736]
	cmp	r8,	r2
	bne	b1407
	b	b1408
.ltorg
b1407:
	mov	r2,	#1
	b	b1409
.ltorg
b1406:
	mov	r2,	#0
	ldr	r4,	[sp,	#736]
	cmp	r4,	r2
	bne	b1403
	b	b1404
.ltorg
b1404:
	mov	r4,	#0
	b	b1405
.ltorg
b1403:
	mov	r4,	#1
	b	b1405
.ltorg
b1402:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1399
	b	b1400
.ltorg
b1399:
	mov	r0,	#1
	b	b1401
.ltorg
b1400:
	mov	r0,	#0
	b	b1401
.ltorg
b1395:
	mov	r4,	#0
	ldr	r0,	[sp,	#252]
	cmp	r0,	r4
	bne	b1392
	b	b1393
.ltorg
b1392:
	mov	r0,	#1
	b	b1394
.ltorg
b1391:
	mov	r2,	#0
	ldr	r0,	[sp,	#252]
	cmp	r0,	r2
	bne	b1388
	b	b1389
.ltorg
b1389:
	mov	r2,	#0
	b	b1390
.ltorg
b1388:
	mov	r2,	#1
	b	b1390
.ltorg
b1387:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1384
	b	b1385
.ltorg
b1385:
	mov	r0,	#0
	b	b1386
.ltorg
b1383:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1380
	b	b1381
.ltorg
b1380:
	mov	r0,	#1
	b	b1382
.ltorg
b1379:
	mov	r0,	#0
	ldr	r2,	[sp,	#340]
	cmp	r2,	r0
	bne	b1376
	b	b1377
.ltorg
b1376:
	mov	r2,	#1
	b	b1378
.ltorg
b1375:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1372
	b	b1373
.ltorg
b1372:
	mov	r0,	#1
	b	b1374
.ltorg
b1368:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1365
	b	b1366
.ltorg
b1365:
	mov	r0,	#1
	b	b1367
.ltorg
b1364:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1361
	b	b1362
.ltorg
b1362:
	mov	r2,	#0
	b	b1363
.ltorg
b1360:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1357
	b	b1358
.ltorg
b1357:
	mov	r8,	#1
	b	b1359
.ltorg
b1353:
	mov	r0,	#0
	ldr	r8,	[sp,	#340]
	cmp	r8,	r0
	bne	b1350
	b	b1351
.ltorg
b1350:
	mov	r0,	#1
	b	b1352
.ltorg
b1349:
	mov	r0,	#0
	ldr	r2,	[sp,	#340]
	cmp	r2,	r0
	bne	b1346
	b	b1347
.ltorg
b1347:
	mov	r2,	#0
	b	b1348
.ltorg
b1345:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1342
	b	b1343
.ltorg
b1343:
	mov	r4,	#0
	b	b1344
.ltorg
b1341:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1338
	b	b1339
.ltorg
b1338:
	mov	r0,	#1
	b	b1340
.ltorg
b1337:
	mov	r2,	#0
	ldr	r8,	[sp,	#284]
	cmp	r8,	r2
	bne	b1334
	b	b1335
.ltorg
b1334:
	mov	r2,	#1
	b	b1336
.ltorg
b1333:
	mov	r6,	#0
	cmp	r2,	r6
	bne	b1330
	b	b1331
.ltorg
b1330:
	mov	r6,	#1
	b	b1332
.ltorg
b1326:
	mov	r2,	#0
	cmp	r4,	r2
	bne	b1323
	b	b1324
.ltorg
b1323:
	mov	r2,	#1
	b	b1325
.ltorg
b1322:
	mov	r2,	#0
	cmp	r4,	r2
	bne	b1319
	b	b1320
.ltorg
b1320:
	mov	r6,	#0
	b	b1321
.ltorg
b1318:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1315
	b	b1316
.ltorg
b1315:
	mov	r0,	#1
	b	b1317
.ltorg
b1311:
	mov	r0,	#0
	ldr	r6,	[sp,	#284]
	cmp	r6,	r0
	bne	b1308
	b	b1309
.ltorg
b1308:
	mov	r0,	#1
	b	b1310
.ltorg
b1307:
	mov	r0,	#0
	ldr	r2,	[sp,	#284]
	cmp	r2,	r0
	bne	b1304
	b	b1305
.ltorg
b1305:
	mov	r2,	#0
	b	b1306
.ltorg
b1303:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1300
	b	b1301
.ltorg
b1301:
	mov	r4,	#0
	b	b1302
.ltorg
b1299:
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1296
	b	b1297
.ltorg
b1296:
	mov	r0,	#1
	b	b1298
.ltorg
b1295:
	mov	r0,	#0
	ldr	r2,	[sp,	#272]
	cmp	r2,	r0
	bne	b1292
	b	b1293
.ltorg
b1292:
	mov	r2,	#1
	b	b1294
.ltorg
b1291:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1288
	b	b1289
.ltorg
b1288:
	mov	r7,	#1
	b	b1290
.ltorg
b1284:
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1281
	b	b1282
.ltorg
b1281:
	mov	r0,	#1
	b	b1283
.ltorg
b1280:
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1277
	b	b1278
.ltorg
b1278:
	mov	r2,	#0
	b	b1279
.ltorg
b1276:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1273
	b	b1274
.ltorg
b1273:
	mov	r4,	#1
	b	b1275
.ltorg
b1269:
	mov	r0,	#0
	ldr	r4,	[sp,	#272]
	cmp	r4,	r0
	bne	b1266
	b	b1267
.ltorg
b1266:
	mov	r0,	#1
	b	b1268
.ltorg
b1265:
	mov	r0,	#0
	ldr	r2,	[sp,	#272]
	cmp	r2,	r0
	bne	b1262
	b	b1263
.ltorg
b1263:
	mov	r2,	#0
	b	b1264
.ltorg
b1262:
	mov	r2,	#1
	b	b1264
.ltorg
b1253:
	mov	r0,	#0
	ldr	r2,	[sp,	#316]
	cmp	r2,	r0
	bne	b1250
	b	b1251
.ltorg
b1250:
	mov	r2,	#1
	b	b1252
.ltorg
b1249:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1246
	b	b1247
.ltorg
b1246:
	mov	r10,	#1
	b	b1248
.ltorg
b1242:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1239
	b	b1240
.ltorg
b1239:
	mov	r0,	#1
	b	b1241
.ltorg
b1238:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1235
	b	b1236
.ltorg
b1236:
	mov	r2,	#0
	b	b1237
.ltorg
b1234:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1231
	b	b1232
.ltorg
b1231:
	mov	r6,	#1
	b	b1233
.ltorg
b1227:
	mov	r0,	#0
	ldr	r6,	[sp,	#316]
	cmp	r6,	r0
	bne	b1224
	b	b1225
.ltorg
b1224:
	mov	r0,	#1
	b	b1226
.ltorg
b1223:
	mov	r0,	#0
	ldr	r2,	[sp,	#316]
	cmp	r2,	r0
	bne	b1220
	b	b1221
.ltorg
b1221:
	mov	r2,	#0
	b	b1222
.ltorg
b1219:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1216
	b	b1217
.ltorg
b1217:
	mov	r4,	#0
	b	b1218
.ltorg
b1215:
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1212
	b	b1213
.ltorg
b1212:
	mov	r0,	#1
	b	b1214
.ltorg
b1211:
	mov	r0,	#0
	ldr	r2,	[sp,	#428]
	cmp	r2,	r0
	bne	b1208
	b	b1209
.ltorg
b1208:
	mov	r2,	#1
	b	b1210
.ltorg
b1207:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1204
	b	b1205
.ltorg
b1204:
	mov	r9,	#1
	b	b1206
.ltorg
b1200:
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1197
	b	b1198
.ltorg
b1197:
	mov	r0,	#1
	b	b1199
.ltorg
b1196:
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1193
	b	b1194
.ltorg
b1194:
	mov	r2,	#0
	b	b1195
.ltorg
b1192:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1189
	b	b1190
.ltorg
b1189:
	mov	r4,	#1
	b	b1191
.ltorg
b1185:
	mov	r0,	#0
	ldr	r4,	[sp,	#428]
	cmp	r4,	r0
	bne	b1182
	b	b1183
.ltorg
b1182:
	mov	r0,	#1
	b	b1184
.ltorg
b1181:
	mov	r0,	#0
	ldr	r2,	[sp,	#428]
	cmp	r2,	r0
	bne	b1178
	b	b1179
.ltorg
b1179:
	mov	r2,	#0
	b	b1180
.ltorg
b1177:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1174
	b	b1175
.ltorg
b1175:
	mov	r6,	#0
	b	b1176
.ltorg
b1173:
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1170
	b	b1171
.ltorg
b1170:
	mov	r0,	#1
	b	b1172
.ltorg
b1169:
	mov	r0,	#0
	ldr	r2,	[sp,	#460]
	cmp	r2,	r0
	bne	b1166
	b	b1167
.ltorg
b1166:
	mov	r2,	#1
	b	b1168
.ltorg
b1165:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b1162
	b	b1163
.ltorg
b1162:
	mov	r1,	#1
	b	b1164
.ltorg
b1158:
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1155
	b	b1156
.ltorg
b1155:
	mov	r0,	#1
	b	b1157
.ltorg
b1154:
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1151
	b	b1152
.ltorg
b1152:
	mov	r1,	#0
	b	b1153
.ltorg
b1150:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b1147
	b	b1148
.ltorg
b1147:
	mov	r4,	#1
	b	b1149
.ltorg
b1143:
	mov	r0,	#0
	ldr	r2,	[sp,	#460]
	cmp	r2,	r0
	bne	b1140
	b	b1141
.ltorg
b1140:
	mov	r0,	#1
	b	b1142
.ltorg
b1139:
	mov	r0,	#0
	ldr	r1,	[sp,	#460]
	cmp	r1,	r0
	bne	b1136
	b	b1137
.ltorg
b1137:
	mov	r1,	#0
	b	b1138
.ltorg
b1135:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b1132
	b	b1133
.ltorg
b1133:
	mov	r6,	#0
	b	b1134
.ltorg
b1132:
	mov	r6,	#1
	b	b1134
.ltorg
b1131:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1128
	b	b1129
.ltorg
b1128:
	mov	r0,	#1
	b	b1130
.ltorg
b1129:
	mov	r0,	#0
	b	b1130
.ltorg
b1123:
	mov	r6,	#0
	cmp	r0,	r6
	bne	b1120
	b	b1121
.ltorg
b1120:
	mov	r0,	#1
	b	b1122
.ltorg
b1117:
	mov	r0,	#1
	b	b1119
.ltorg
b1118:
	mov	r0,	#0
	b	b1119
.ltorg
b1112:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b1109
	b	b1110
.ltorg
b1110:
	mov	r6,	#0
	b	b1111
.ltorg
b1108:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1105
	b	b1106
.ltorg
b1105:
	mov	r2,	#1
	b	b1107
.ltorg
b1101:
	mov	r0,	#0
	ldr	r6,	[sp,	#972]
	cmp	r6,	r0
	bne	b1098
	b	b1099
.ltorg
b1098:
	mov	r0,	#1
	b	b1100
.ltorg
b1097:
	mov	r0,	#0
	ldr	r2,	[sp,	#972]
	cmp	r2,	r0
	bne	b1094
	b	b1095
.ltorg
b1095:
	mov	r2,	#0
	b	b1096
.ltorg
b1093:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b1090
	b	b1091
.ltorg
b1091:
	mov	r4,	#0
	b	b1092
.ltorg
b1089:
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1086
	b	b1087
.ltorg
b1086:
	mov	r0,	#1
	b	b1088
.ltorg
b1085:
	mov	r0,	#0
	ldr	r2,	[sp,	#380]
	cmp	r2,	r0
	bne	b1082
	b	b1083
.ltorg
b1082:
	mov	r2,	#1
	b	b1084
.ltorg
b1081:
	mov	r7,	#0
	cmp	r0,	r7
	bne	b1078
	b	b1079
.ltorg
b1078:
	mov	r0,	#1
	b	b1080
.ltorg
b1074:
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1071
	b	b1072
.ltorg
b1071:
	mov	r0,	#1
	b	b1073
.ltorg
b1070:
	mov	r0,	#0
	cmp	r6,	r0
	bne	b1067
	b	b1068
.ltorg
b1068:
	mov	r7,	#0
	b	b1069
.ltorg
b1066:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b1063
	b	b1064
.ltorg
b1063:
	mov	r4,	#1
	b	b1065
.ltorg
b1059:
	mov	r0,	#0
	ldr	r7,	[sp,	#380]
	cmp	r7,	r0
	bne	b1056
	b	b1057
.ltorg
b1056:
	mov	r0,	#1
	b	b1058
.ltorg
b1055:
	mov	r0,	#0
	ldr	r4,	[sp,	#380]
	cmp	r4,	r0
	bne	b1052
	b	b1053
.ltorg
b1053:
	mov	r4,	#0
	b	b1054
.ltorg
b1051:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b1048
	b	b1049
.ltorg
b1049:
	mov	r6,	#0
	b	b1050
.ltorg
b1047:
	mov	r0,	#0
	cmp	r8,	r0
	bne	b1044
	b	b1045
.ltorg
b1044:
	mov	r0,	#1
	b	b1046
.ltorg
b1043:
	mov	r0,	#0
	ldr	r4,	[sp,	#364]
	cmp	r4,	r0
	bne	b1040
	b	b1041
.ltorg
b1040:
	mov	r4,	#1
	b	b1042
.ltorg
b1039:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b1036
	b	b1037
.ltorg
b1036:
	mov	r0,	#1
	b	b1038
.ltorg
b1032:
	mov	r0,	#0
	cmp	r8,	r0
	bne	b1029
	b	b1030
.ltorg
b1029:
	mov	r0,	#1
	b	b1031
.ltorg
b1028:
	mov	r0,	#0
	cmp	r8,	r0
	bne	b1025
	b	b1026
.ltorg
b1026:
	mov	r4,	#0
	b	b1027
.ltorg
b1024:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b1021
	b	b1022
.ltorg
b1021:
	mov	r7,	#1
	b	b1023
.ltorg
b1017:
	mov	r0,	#0
	ldr	r7,	[sp,	#364]
	cmp	r7,	r0
	bne	b1014
	b	b1015
.ltorg
b1014:
	mov	r0,	#1
	b	b1016
.ltorg
b1013:
	mov	r0,	#0
	ldr	r4,	[sp,	#364]
	cmp	r4,	r0
	bne	b1010
	b	b1011
.ltorg
b1011:
	mov	r4,	#0
	b	b1012
.ltorg
b1009:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b1006
	b	b1007
.ltorg
b1007:
	mov	r8,	#0
	b	b1008
.ltorg
b1006:
	mov	r8,	#1
	b	b1008
.ltorg
b1005:
	mov	r0,	#0
	cmp	r8,	r0
	bne	b1002
	b	b1003
.ltorg
b1002:
	mov	r0,	#1
	b	b1004
.ltorg
b1001:
	mov	r7,	#0
	cmp	r4,	r7
	bne	b998
	b	b999
.ltorg
b998:
	mov	r4,	#1
	b	b1000
.ltorg
b999:
	mov	r4,	#0
	b	b1000
.ltorg
b991:
	mov	r5,	#1
	b	b993
.ltorg
b990:
	mov	r5,	#0
	cmp	r8,	r5
	bne	b987
	b	b988
.ltorg
b987:
	mov	r5,	#1
	b	b989
.ltorg
b988:
	mov	r5,	#0
	b	b989
.ltorg
b982:
	mov	r5,	#0
	cmp	r0,	r5
	bne	b979
	b	b980
.ltorg
b979:
	mov	r0,	#1
	b	b981
.ltorg
b976:
	mov	r0,	#1
	b	b978
.ltorg
b977:
	mov	r0,	#0
	b	b978
.ltorg
b971:
	mov	r0,	#0
	cmp	r4,	r0
	bne	b968
	b	b969
.ltorg
b969:
	mov	r5,	#0
	b	b970
.ltorg
b967:
	mov	r5,	#0
	cmp	r0,	r5
	bne	b964
	b	b965
.ltorg
b965:
	mov	r8,	#0
	b	b966
.ltorg
b963:
	mov	r8,	#0
	cmp	r0,	r8
	bne	b960
	b	b961
.ltorg
b960:
	mov	r0,	#1
	b	b962
.ltorg
b959:
	mov	r5,	#0
	cmp	r9,	r5
	bne	b956
	b	b957
.ltorg
b956:
	mov	r5,	#1
	b	b958
.ltorg
b955:
	mov	r5,	#0
	cmp	r3,	r5
	bne	b952
	b	b953
.ltorg
b952:
	mov	r3,	#1
	b	b954
.ltorg
b948:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b945
	b	b946
.ltorg
b945:
	mov	r3,	#1
	b	b947
.ltorg
b944:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b941
	b	b942
.ltorg
b942:
	mov	r5,	#0
	b	b943
.ltorg
b940:
	mov	r5,	#0
	cmp	r3,	r5
	bne	b937
	b	b938
.ltorg
b937:
	mov	r10,	#1
	b	b939
.ltorg
b933:
	mov	r3,	#0
	cmp	r9,	r3
	bne	b930
	b	b931
.ltorg
b930:
	mov	r3,	#1
	b	b932
.ltorg
b929:
	mov	r3,	#0
	cmp	r9,	r3
	bne	b926
	b	b927
.ltorg
b927:
	mov	r5,	#0
	b	b928
.ltorg
b925:
	b	b923
.ltorg
b923:
	mov	r0,	#0
	b	b924
.ltorg
b921:
	b	b919
.ltorg
b917:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b914
	b	b915
.ltorg
b914:
	mov	r0,	#1
	b	b916
.ltorg
b913:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b910
	b	b911
.ltorg
b910:
	mov	r0,	#1
	b	b912
.ltorg
b906:
	b	b904
.ltorg
b902:
	mov	r3,	#0
	b	b901
.ltorg
b898:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b895
	b	b896
.ltorg
b895:
	mov	r0,	#1
	b	b897
.ltorg
b891:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b888
	b	b889
.ltorg
b888:
	mov	r0,	#1
	b	b890
.ltorg
b887:
	mov	r0,	#0
	cmp	r5,	r0
	bne	b884
	b	b885
.ltorg
b885:
	mov	r3,	#0
	b	b886
.ltorg
b878:
	mov	r10,	#0
	sub	r0,	r10,	r0
	mov	r0,	r0
	b	b879
.ltorg
b862:
	mov	r10,	#0
	sub	r0,	r10,	r0
	mov	r0,	r0
	b	b863
.ltorg
b819:
	mov	r10,	#0
	str	r10,	[sp,	#56]
	ldr	r10,	[sp,	#56]
	cmp	r0,	r10
	bne	b816
	b	b817
.ltorg
b817:
	b	b818
.ltorg
b815:
	mov	r0,	#0
	str	r0,	[sp,	#64]
	ldr	r0,	[sp,	#64]
	cmp	r10,	r0
	bne	b812
	b	b813
.ltorg
b812:
	mov	r0,	#1
	b	b814
.ltorg
b811:
	b	b809
.ltorg
b807:
	mov	r9,	#0
	str	r9,	[sp,	#68]
	ldr	r9,	[sp,	#68]
	cmp	r0,	r9
	bne	b804
	b	b805
.ltorg
b804:
	mov	r9,	#1
	b	b806
.ltorg
b800:
	mov	r0,	#0
	cmp	r10,	r0
	bne	b797
	b	b798
.ltorg
b797:
	mov	r0,	#1
	b	b799
.ltorg
b796:
	mov	r0,	#0
	cmp	r10,	r0
	bne	b793
	b	b794
.ltorg
b794:
	mov	r0,	#0
	b	b795
.ltorg
b792:
	mov	r9,	#0
	str	r9,	[sp,	#60]
	ldr	r9,	[sp,	#60]
	cmp	r0,	r9
	bne	b789
	b	b790
.ltorg
b789:
	mov	r0,	#1
	b	b791
.ltorg
b785:
	b	b783
.ltorg
b781:
	b	b779
.ltorg
b779:
	mov	r0,	#0
	b	b780
.ltorg
b777:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b774
	b	b775
.ltorg
b775:
	mov	r10,	#0
	b	b776
.ltorg
b773:
	mov	r0,	#0
	cmp	r9,	r0
	bne	b770
	b	b771
.ltorg
b770:
	mov	r0,	#1
	b	b772
.ltorg
b769:
	b	b767
.ltorg
b765:
	mov	r10,	#0
	cmp	r0,	r10
	bne	b762
	b	b763
.ltorg
b762:
	mov	r0,	#1
	b	b764
.ltorg
b758:
	mov	r0,	#0
	cmp	r9,	r0
	bne	b755
	b	b756
.ltorg
b755:
	mov	r0,	#1
	b	b757
.ltorg
b754:
	mov	r0,	#0
	cmp	r9,	r0
	bne	b751
	b	b752
.ltorg
b752:
	mov	r10,	#0
	b	b753
.ltorg
b750:
	mov	r10,	#0
	cmp	r0,	r10
	bne	b747
	b	b748
.ltorg
b747:
	mov	r0,	#1
	b	b749
.ltorg
b743:
	b	b741
.ltorg
b739:
	b	b737
.ltorg
b737:
	mov	r0,	#0
	b	b738
.ltorg
b735:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b732
	b	b733
.ltorg
b733:
	mov	r9,	#0
	b	b734
.ltorg
b732:
	mov	r9,	#1
	b	b734
.ltorg
b731:
	mov	r0,	#0
	ldr	r10,	[sp,	#292]
	cmp	r10,	r0
	bne	b728
	b	b729
.ltorg
b728:
	mov	r0,	#1
	b	b730
.ltorg
b729:
	mov	r0,	#0
	b	b730
.ltorg
b723:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b720
	b	b721
.ltorg
b720:
	mov	r0,	#1
	b	b722
.ltorg
b717:
	mov	r0,	#1
	b	b719
.ltorg
b718:
	mov	r0,	#0
	b	b719
.ltorg
b712:
	mov	r0,	#0
	ldr	r9,	[sp,	#292]
	cmp	r9,	r0
	bne	b709
	b	b710
.ltorg
b710:
	mov	r0,	#0
	b	b711
.ltorg
b708:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b705
	b	b706
.ltorg
b705:
	mov	r10,	#1
	b	b707
.ltorg
b701:
	b	b699
.ltorg
b697:
	b	b695
.ltorg
b695:
	mov	r9,	#0
	b	b696
.ltorg
b693:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b690
	b	b691
.ltorg
b691:
	mov	r0,	#0
	b	b692
.ltorg
b689:
	mov	r0,	#0
	cmp	r10,	r0
	bne	b686
	b	b687
.ltorg
b686:
	mov	r0,	#1
	b	b688
.ltorg
b685:
	b	b683
.ltorg
b681:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b678
	b	b679
.ltorg
b678:
	mov	r0,	#1
	b	b680
.ltorg
b674:
	mov	r0,	#0
	cmp	r10,	r0
	bne	b671
	b	b672
.ltorg
b671:
	mov	r0,	#1
	b	b673
.ltorg
b670:
	mov	r0,	#0
	cmp	r10,	r0
	bne	b667
	b	b668
.ltorg
b668:
	mov	r0,	#0
	b	b669
.ltorg
b666:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b663
	b	b664
.ltorg
b663:
	mov	r0,	#1
	b	b665
.ltorg
b659:
	b	b657
.ltorg
b655:
	b	b653
.ltorg
b653:
	mov	r0,	#0
	b	b654
.ltorg
b651:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b648
	b	b649
.ltorg
b649:
	mov	r10,	#0
	b	b650
.ltorg
b647:
	mov	r0,	#0
	cmp	r9,	r0
	bne	b644
	b	b645
.ltorg
b644:
	mov	r0,	#1
	b	b646
.ltorg
b643:
	b	b641
.ltorg
b639:
	mov	r10,	#0
	cmp	r0,	r10
	bne	b636
	b	b637
.ltorg
b636:
	mov	r0,	#1
	b	b638
.ltorg
b632:
	mov	r0,	#0
	cmp	r9,	r0
	bne	b629
	b	b630
.ltorg
b629:
	mov	r0,	#1
	b	b631
.ltorg
b628:
	mov	r0,	#0
	cmp	r9,	r0
	bne	b625
	b	b626
.ltorg
b626:
	mov	r0,	#0
	b	b627
.ltorg
b624:
	mov	r10,	#0
	cmp	r0,	r10
	bne	b621
	b	b622
.ltorg
b621:
	mov	r0,	#1
	b	b623
.ltorg
b617:
	b	b615
.ltorg
b613:
	b	b611
.ltorg
b611:
	mov	r0,	#0
	b	b612
.ltorg
b609:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b606
	b	b607
.ltorg
b607:
	mov	r9,	#0
	b	b608
.ltorg
b606:
	mov	r9,	#1
	b	b608
.ltorg
b605:
	mov	r0,	#0
	ldr	r10,	[sp,	#400]
	cmp	r10,	r0
	bne	b602
	b	b603
.ltorg
b602:
	mov	r0,	#1
	b	b604
.ltorg
b591:
	mov	r0,	#1
	b	b593
.ltorg
b590:
	mov	r0,	#0
	ldr	r10,	[sp,	#400]
	cmp	r10,	r0
	bne	b587
	b	b588
.ltorg
b587:
	mov	r0,	#1
	b	b589
.ltorg
b588:
	mov	r0,	#0
	b	b589
.ltorg
b582:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b579
	b	b580
.ltorg
b579:
	mov	r0,	#1
	b	b581
.ltorg
b576:
	mov	r0,	#1
	b	b578
.ltorg
b577:
	mov	r0,	#0
	b	b578
.ltorg
b571:
	b	b569
.ltorg
b569:
	mov	r9,	#0
	b	b570
.ltorg
b567:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b564
	b	b565
.ltorg
b565:
	mov	r0,	#0
	b	b566
.ltorg
b563:
	mov	r0,	#0
	cmp	r10,	r0
	bne	b560
	b	b561
.ltorg
b560:
	mov	r0,	#1
	b	b562
.ltorg
b559:
	b	b557
.ltorg
b555:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b552
	b	b553
.ltorg
b552:
	mov	r0,	#1
	b	b554
.ltorg
b548:
	mov	r0,	#0
	cmp	r10,	r0
	bne	b545
	b	b546
.ltorg
b545:
	mov	r0,	#1
	b	b547
.ltorg
b544:
	mov	r0,	#0
	cmp	r10,	r0
	bne	b541
	b	b542
.ltorg
b542:
	mov	r0,	#0
	b	b543
.ltorg
b540:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b537
	b	b538
.ltorg
b537:
	mov	r0,	#1
	b	b539
.ltorg
b533:
	b	b531
.ltorg
b529:
	b	b527
.ltorg
b527:
	mov	r9,	#0
	b	b528
.ltorg
b525:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b522
	b	b523
.ltorg
b523:
	mov	r10,	#0
	b	b524
.ltorg
b521:
	mov	r10,	#0
	cmp	r0,	r10
	bne	b518
	b	b519
.ltorg
b518:
	mov	r0,	#1
	b	b520
.ltorg
b517:
	b	b515
.ltorg
b513:
	mov	r9,	#0
	cmp	r7,	r9
	bne	b510
	b	b511
.ltorg
b510:
	mov	r7,	#1
	b	b512
.ltorg
b506:
	mov	r7,	#0
	cmp	r0,	r7
	bne	b503
	b	b504
.ltorg
b503:
	mov	r7,	#1
	b	b505
.ltorg
b502:
	mov	r7,	#0
	cmp	r0,	r7
	bne	b499
	b	b500
.ltorg
b500:
	mov	r9,	#0
	b	b501
.ltorg
b498:
	mov	r9,	#0
	cmp	r7,	r9
	bne	b495
	b	b496
.ltorg
b495:
	mov	r7,	#1
	b	b497
.ltorg
b491:
	b	b489
.ltorg
b487:
	b	b485
.ltorg
b485:
	mov	r9,	#0
	b	b486
.ltorg
b483:
	mov	r7,	#0
	cmp	r0,	r7
	bne	b480
	b	b481
.ltorg
b481:
	mov	r0,	#0
	b	b482
.ltorg
b479:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b476
	b	b477
.ltorg
b476:
	mov	r0,	#1
	b	b478
.ltorg
b475:
	b	b473
.ltorg
b471:
	mov	r7,	#0
	cmp	r2,	r7
	bne	b468
	b	b469
.ltorg
b468:
	mov	r2,	#1
	b	b470
.ltorg
b469:
	mov	r2,	#0
	b	b470
.ltorg
b464:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b461
	b	b462
.ltorg
b461:
	mov	r2,	#1
	b	b463
.ltorg
b460:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b457
	b	b458
.ltorg
b458:
	mov	r7,	#0
	b	b459
.ltorg
b457:
	mov	r7,	#1
	b	b459
.ltorg
b450:
	mov	r2,	#1
	b	b452
.ltorg
b441:
	mov	r2,	#0
	cmp	r0,	r2
	bne	b438
	b	b439
.ltorg
b439:
	mov	r0,	#0
	b	b440
.ltorg
b437:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b434
	b	b435
.ltorg
b434:
	mov	r0,	#1
	b	b436
.ltorg
b433:
	b	b431
.ltorg
b429:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b426
	b	b427
.ltorg
b426:
	mov	r3,	#1
	b	b428
.ltorg
b422:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b419
	b	b420
.ltorg
b419:
	mov	r0,	#1
	b	b421
.ltorg
b418:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b415
	b	b416
.ltorg
b416:
	mov	r3,	#0
	b	b417
.ltorg
b414:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b411
	b	b412
.ltorg
b411:
	mov	r9,	#1
	b	b413
.ltorg
b407:
	b	b405
.ltorg
b403:
	b	b401
.ltorg
b401:
	mov	r3,	#0
	b	b402
.ltorg
b399:
	mov	r3,	#0
	cmp	r0,	r3
	bne	b396
	b	b397
.ltorg
b397:
	mov	r7,	#0
	b	b398
.ltorg
b395:
	mov	r0,	#0
	cmp	r9,	r0
	bne	b392
	b	b393
.ltorg
b392:
	mov	r0,	#1
	b	b394
.ltorg
b391:
	b	b389
.ltorg
b387:
	mov	r5,	#0
	cmp	r0,	r5
	bne	b384
	b	b385
.ltorg
b384:
	mov	r5,	#1
	b	b386
.ltorg
b380:
	mov	r0,	#0
	cmp	r9,	r0
	bne	b377
	b	b378
.ltorg
b377:
	mov	r0,	#1
	b	b379
.ltorg
b376:
	mov	r0,	#0
	cmp	r9,	r0
	bne	b373
	b	b374
.ltorg
b374:
	mov	r5,	#0
	b	b375
.ltorg
b372:
	mov	r5,	#0
	cmp	r0,	r5
	bne	b369
	b	b370
.ltorg
b369:
	mov	r7,	#1
	b	b371
.ltorg
b365:
	b	b363
.ltorg
b361:
	b	b359
.ltorg
b359:
	mov	r5,	#0
	b	b360
.ltorg
b357:
	mov	r5,	#0
	cmp	r0,	r5
	bne	b354
	b	b355
.ltorg
b355:
	mov	r9,	#0
	b	b356
.ltorg
b353:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b350
	b	b351
.ltorg
b350:
	mov	r0,	#1
	b	b352
.ltorg
b349:
	b	b347
.ltorg
b345:
	mov	r6,	#0
	cmp	r0,	r6
	bne	b342
	b	b343
.ltorg
b342:
	mov	r6,	#1
	b	b344
.ltorg
b338:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b335
	b	b336
.ltorg
b335:
	mov	r0,	#1
	b	b337
.ltorg
b334:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b331
	b	b332
.ltorg
b332:
	mov	r6,	#0
	b	b333
.ltorg
b331:
	mov	r6,	#1
	b	b333
.ltorg
b330:
	mov	r6,	#0
	cmp	r0,	r6
	bne	b327
	b	b328
.ltorg
b327:
	mov	r9,	#1
	b	b329
.ltorg
b328:
	mov	r9,	#0
	b	b329
.ltorg
b323:
	b	b321
.ltorg
b319:
	b	b317
.ltorg
b317:
	mov	r6,	#0
	b	b318
.ltorg
b316:
	mov	r6,	#1
	b	b318
.ltorg
b315:
	mov	r6,	#0
	cmp	r0,	r6
	bne	b312
	b	b313
.ltorg
b313:
	mov	r7,	#0
	b	b314
.ltorg
b311:
	mov	r0,	#0
	cmp	r9,	r0
	bne	b308
	b	b309
.ltorg
b308:
	mov	r0,	#1
	b	b310
.ltorg
b307:
	b	b305
.ltorg
b303:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b300
	b	b301
.ltorg
b300:
	mov	r1,	#1
	b	b302
.ltorg
b296:
	mov	r0,	#0
	cmp	r9,	r0
	bne	b293
	b	b294
.ltorg
b293:
	mov	r0,	#1
	b	b295
.ltorg
b292:
	mov	r0,	#0
	cmp	r9,	r0
	bne	b289
	b	b290
.ltorg
b290:
	mov	r1,	#0
	b	b291
.ltorg
b288:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b285
	b	b286
.ltorg
b285:
	mov	r7,	#1
	b	b287
.ltorg
b281:
	b	b279
.ltorg
b277:
	b	b275
.ltorg
b275:
	mov	r1,	#0
	b	b276
.ltorg
b273:
	mov	r1,	#0
	cmp	r0,	r1
	bne	b270
	b	b271
.ltorg
b271:
	mov	r9,	#0
	b	b272
.ltorg
b269:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b266
	b	b267
.ltorg
b266:
	mov	r0,	#1
	b	b268
.ltorg
b265:
	b	b263
.ltorg
b261:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b258
	b	b259
.ltorg
b258:
	mov	r4,	#1
	b	b260
.ltorg
b254:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b251
	b	b252
.ltorg
b251:
	mov	r0,	#1
	b	b253
.ltorg
b250:
	mov	r0,	#0
	cmp	r7,	r0
	bne	b247
	b	b248
.ltorg
b248:
	mov	r4,	#0
	b	b249
.ltorg
b246:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b243
	b	b244
.ltorg
b243:
	mov	r9,	#1
	b	b245
.ltorg
b239:
	b	b237
.ltorg
b235:
	b	b233
.ltorg
b233:
	mov	r4,	#0
	b	b234
.ltorg
b231:
	mov	r4,	#0
	cmp	r0,	r4
	bne	b228
	b	b229
.ltorg
b229:
	mov	r7,	#0
	b	b230
.ltorg
b227:
	mov	r7,	#0
	ldr	r0,	[sp,	#820]
	cmp	r0,	r7
	bne	b224
	b	b225
.ltorg
b224:
	mov	r0,	#1
	b	b226
.ltorg
b223:
	b	b221
.ltorg
b219:
	mov	r9,	#0
	cmp	r0,	r9
	bne	b216
	b	b217
.ltorg
b216:
	mov	r0,	#1
	b	b218
.ltorg
b212:
	mov	r10,	#0
	ldr	r0,	[sp,	#820]
	cmp	r0,	r10
	bne	b209
	b	b210
.ltorg
b209:
	mov	r0,	#1
	b	b211
.ltorg
b208:
	mov	r9,	#0
	ldr	r0,	[sp,	#820]
	cmp	r0,	r9
	bne	b205
	b	b206
.ltorg
b206:
	mov	r9,	#0
	b	b207
.ltorg
b204:
	mov	r7,	#0
	cmp	r0,	r7
	bne	b201
	b	b202
.ltorg
b201:
	mov	r7,	#1
	b	b203
.ltorg
b197:
	b	b195
.ltorg
b193:
	b	b191
.ltorg
b191:
	mov	r7,	#0
	b	b192
.ltorg
b190:
	mov	r7,	#1
	b	b192
.ltorg
b181:
	b	b178
.ltorg
b178:
	mov	r0,	#1
	b	b180
.ltorg
b177:
	mov	r8,	#0
	cmp	r0,	r8
	bne	b174
	b	b175
.ltorg
b174:
	mov	r8,	#1
	b	b176
.ltorg
b170:
	b	b168
.ltorg
b166:
	mov	r8,	#0
	b	b165
.ltorg
b162:
	mov	r7,	#0
	cmp	r0,	r7
	bne	b159
	b	b160
.ltorg
b159:
	mov	r7,	#1
	b	b161
.ltorg
b155:
	b	b152
.ltorg
b152:
	mov	r0,	#1
	b	b154
.ltorg
b151:
	b	b148
.ltorg
.global	main
main:
	push	{lr}
	sub	sp,	sp,	#4
b3845:
	mov	r4,	#1
	b	b3846
.ltorg
b3846:
	mov	r4,	r4
	mov	r0,	#20
	cmp	r4,	r0
	ble	b3847
	b	b3848
.ltorg
b3847:
	mov	r0,	#102
	bl	putch
	mov	r0,	#105
	bl	putch
	mov	r0,	#98
	bl	putch
	mov	r0,	#40
	bl	putch
	mov	r0,	r4
	bl	putint
	mov	r0,	#41
	bl	putch
	mov	r0,	#32
	bl	putch
	mov	r0,	#61
	bl	putch
	mov	r0,	#32
	bl	putch
	mov	r0,	r4
	bl	fib
	mov	r0,	r0
	mov	r0,	r0
	bl	putint
	mov	r0,	#10
	bl	putch
	mov	r0,	#1
	add	r4,	r4,	r0
	mov	r4,	r4
	b	b3846
.ltorg
b3848:
	mov	r0,	#0
	add	sp,	sp,	#4
	pop	{pc}
	bx	lr
.ltorg
