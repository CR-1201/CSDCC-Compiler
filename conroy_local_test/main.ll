@rt = dso_local global i32 0
@tot = dso_local global i32 0
@f = dso_local global [100010 x i32] zeroinitializer
@ch = dso_local global [100010 x [2 x i32]] zeroinitializer
@a = dso_local global [100010 x i32] zeroinitializer
@c = dso_local global [100010 x i32] zeroinitializer
@s = dso_local global [100010 x i32] zeroinitializer

declare dso_local i32 @getint()
declare dso_local i32 @getch()
declare dso_local float @getfloat()
declare dso_local i32 @getarray(i32* %a0)
declare dso_local i32 @getfarray(float* %a0)
declare dso_local void @putint(i32 %a0)
declare dso_local void @putch(i32 %a0)
declare dso_local void @putfloat(float %a0)
declare dso_local void @putarray(i32 %a0, i32* %a1)
declare dso_local void @putfarray(i32 %a0, float* %a1)
declare dso_local void @memset(i32* %a0, i32 %a1, i32 %a2)
declare dso_local void @_sysy_starttime()
declare dso_local void @_sysy_stoptime()
define dso_local void @upd(i32 %a0) {
b0:
	%v2 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %a0
	%v4 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %a0
	%v5 = getelementptr inbounds [2 x i32], [2 x i32]* %v4, i32 0, i32 0
	%v6 = load i32, i32* %v5
	%v7 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v6
	%v8 = load i32, i32* %v7
	%v11 = getelementptr inbounds [2 x i32], [2 x i32]* %v4, i32 0, i32 1
	%v12 = load i32, i32* %v11
	%v13 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v12
	%v14 = load i32, i32* %v13
	%v15 = add i32 %v8, %v14
	%v17 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %a0
	%v18 = load i32, i32* %v17
	%v19 = add i32 %v15, %v18
	store i32 %v19, i32* %v2
	ret void
}
define dso_local i32 @get(i32 %a0) {
b1:
	%v23 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %a0
	%v24 = load i32, i32* %v23
	%v25 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %v24
	%v26 = getelementptr inbounds [2 x i32], [2 x i32]* %v25, i32 0, i32 1
	%v27 = load i32, i32* %v26
	%v28 = icmp eq i32 %a0, %v27
	br i1 %v28, label %b2, label %b3
b2:
	ret i32 1
b3:
	ret i32 0
}
define dso_local void @clr(i32 %a0) {
b7:
	%v31 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %a0
	store i32 0, i32* %v31
	%v33 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %a0
	%v34 = getelementptr inbounds [2 x i32], [2 x i32]* %v33, i32 0, i32 0
	store i32 0, i32* %v34
	%v37 = getelementptr inbounds [2 x i32], [2 x i32]* %v33, i32 0, i32 1
	store i32 0, i32* %v37
	%v39 = getelementptr inbounds [100010 x i32], [100010 x i32]* @a, i32 0, i32 %a0
	store i32 0, i32* %v39
	%v41 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %a0
	store i32 0, i32* %v41
	%v43 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %a0
	store i32 0, i32* %v43
	ret void
}
define dso_local i32 @xor1(i32 %a0) {
b8:
	%v46 = srem i32 %a0, 2
	%v47 = icmp eq i32 %v46, 0
	br i1 %v47, label %b9, label %b10
b9:
	%v49 = add i32 %a0, 1
	ret i32 %v49
b10:
	%v51 = sub i32 %a0, 1
	ret i32 %v51
}
define dso_local void @rot(i32 %a0) {
b14:
	%v55 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %a0
	%v56 = load i32, i32* %v55
	%v59 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %v56
	%v60 = load i32, i32* %v59
	%v63 = call i32 @get(i32 %a0)
	%v66 = call i32 @get(i32 %v56)
	%v70 = call i32 @xor1(i32 %v63)
	%v68 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %a0
	%v71 = getelementptr inbounds [2 x i32], [2 x i32]* %v68, i32 0, i32 %v70
	%v72 = load i32, i32* %v71
	%v73 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %v72
	store i32 %v56, i32* %v73
	%v84 = load i32, i32* %v71
	%v76 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %v56
	%v78 = getelementptr inbounds [2 x i32], [2 x i32]* %v76, i32 0, i32 %v63
	store i32 %v84, i32* %v78
	store i32 %a0, i32* %v59
	store i32 %v56, i32* %v71
	call void @upd(i32 %v56)
	call void @upd(i32 %a0)
	store i32 %v60, i32* %v55
	%v101 = load i32, i32* %v55
	%v102 = icmp ne i32 %v101, 0
	br i1 %v102, label %b15, label %b16
b15:
	%v104 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %v60
	%v106 = getelementptr inbounds [2 x i32], [2 x i32]* %v104, i32 0, i32 %v66
	store i32 %a0, i32* %v106
	br label %b16
b16:
	ret void
}
define dso_local void @splay(i32 %a0, i32 %a1) {
b17:
	%v112 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %a0
	%v113 = load i32, i32* %v112
	br label %b18
b18:
	%p0 = phi i32 [ %v113, %b17 ],  [ %v132, %b22 ]
	%v116 = icmp ne i32 %p0, %a1
	br i1 %v116, label %b19, label %b20
b19:
	%v118 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %p0
	%v119 = load i32, i32* %v118
	%v121 = icmp ne i32 %v119, %a1
	br i1 %v121, label %b21, label %b22
b20:
	%v134 = icmp eq i32 %a1, 0
	%v135 = zext i1 %v134 to i32
	%v136 = icmp ne i32 %v135, 0
	br i1 %v136, label %b26, label %b27
b21:
	%v123 = call i32 @get(i32 %a0)
	%v125 = call i32 @get(i32 %p0)
	%v126 = icmp eq i32 %v123, %v125
	br i1 %v126, label %b23, label %b24
b22:
	call void @rot(i32 %a0)
	%v132 = load i32, i32* %v112
	br label %b18
b23:
	call void @rot(i32 %p0)
	br label %b25
b24:
	call void @rot(i32 %a0)
	br label %b25
b25:
	br label %b22
b26:
	store i32 %a0, i32* @rt
	br label %b27
b27:
	ret void
}
define dso_local void @ins(i32 %a0) {
b28:
	%v139 = load i32, i32* @rt
	%v140 = icmp eq i32 %v139, 0
	%v141 = zext i1 %v140 to i32
	%v142 = icmp ne i32 %v141, 0
	br i1 %v142, label %b29, label %b30
b29:
	%v143 = load i32, i32* @tot
	%v144 = add i32 %v143, 1
	store i32 %v144, i32* @tot
	%v145 = load i32, i32* @tot
	store i32 %v145, i32* @rt
	%v146 = load i32, i32* @rt
	%v147 = getelementptr inbounds [100010 x i32], [100010 x i32]* @a, i32 0, i32 %v146
	store i32 %a0, i32* %v147
	%v149 = load i32, i32* @tot
	%v150 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %v149
	store i32 1, i32* %v150
	%v151 = load i32, i32* @tot
	%v152 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v151
	store i32 1, i32* %v152
	ret void
b30:
	%v154 = load i32, i32* @rt
	br label %b32
b32:
	%p2 = phi i32 [ %v154, %b30 ],  [ %p3, %b42 ]
	%p1 = phi i32 [ 0, %b30 ],  [ %p2, %b42 ]
	br label %b33
b33:
	%v158 = getelementptr inbounds [100010 x i32], [100010 x i32]* @a, i32 0, i32 %p2
	%v159 = load i32, i32* %v158
	%v161 = icmp eq i32 %v159, %a0
	br i1 %v161, label %b35, label %b36
b35:
	%v163 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %p2
	%v166 = load i32, i32* %v163
	%v167 = add i32 %v166, 1
	store i32 %v167, i32* %v163
	%v169 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %p2
	%v172 = load i32, i32* %v169
	%v173 = add i32 %v172, 1
	store i32 %v173, i32* %v169
	call void @upd(i32 %p1)
	call void @splay(i32 %p2, i32 0)
	ret void
b36:
	%v179 = load i32, i32* %v158
	%v181 = icmp slt i32 %v179, %a0
	br i1 %v181, label %b38, label %b39
b38:
	%v183 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %p2
	%v184 = getelementptr inbounds [2 x i32], [2 x i32]* %v183, i32 0, i32 1
	%v185 = load i32, i32* %v184
	br label %b40
b39:
	%v187 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %p2
	%v188 = getelementptr inbounds [2 x i32], [2 x i32]* %v187, i32 0, i32 0
	%v189 = load i32, i32* %v188
	br label %b40
b40:
	%p3 = phi i32 [ %v189, %b39 ],  [ %v185, %b38 ]
	%v191 = icmp eq i32 %p3, 0
	%v192 = zext i1 %v191 to i32
	%v193 = icmp ne i32 %v192, 0
	br i1 %v193, label %b41, label %b42
b41:
	%v194 = load i32, i32* @tot
	%v195 = add i32 %v194, 1
	store i32 %v195, i32* @tot
	%v196 = load i32, i32* @tot
	%v197 = getelementptr inbounds [100010 x i32], [100010 x i32]* @a, i32 0, i32 %v196
	store i32 %a0, i32* %v197
	%v199 = load i32, i32* @tot
	%v200 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %v199
	store i32 1, i32* %v200
	%v201 = load i32, i32* @tot
	%v202 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v201
	store i32 1, i32* %v202
	%v203 = load i32, i32* @tot
	%v204 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %v203
	store i32 %p2, i32* %v204
	%v208 = load i32, i32* %v158
	%v210 = icmp slt i32 %v208, %a0
	br i1 %v210, label %b43, label %b44
b42:
	br label %b32
b43:
	%v214 = load i32, i32* @tot
	%v212 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %p2
	%v213 = getelementptr inbounds [2 x i32], [2 x i32]* %v212, i32 0, i32 1
	store i32 %v214, i32* %v213
	br label %b45
b44:
	%v218 = load i32, i32* @tot
	%v216 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %p2
	%v217 = getelementptr inbounds [2 x i32], [2 x i32]* %v216, i32 0, i32 0
	store i32 %v218, i32* %v217
	br label %b45
b45:
	call void @upd(i32 %p2)
	%v220 = load i32, i32* @tot
	call void @splay(i32 %v220, i32 0)
	ret void
}
define dso_local i32 @rank(i32 %a0) {
b47:
	%v223 = load i32, i32* @rt
	br label %b48
b48:
	%p7 = phi i32 [ %v223, %b47 ],  [ %p6, %b53 ]
	%p5 = phi i32 [ 0, %b47 ],  [ %p4, %b53 ]
	br label %b49
b49:
	%v228 = getelementptr inbounds [100010 x i32], [100010 x i32]* @a, i32 0, i32 %p7
	%v229 = load i32, i32* %v228
	%v230 = icmp slt i32 %a0, %v229
	br i1 %v230, label %b51, label %b52
b51:
	%v232 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %p7
	%v233 = getelementptr inbounds [2 x i32], [2 x i32]* %v232, i32 0, i32 0
	%v234 = load i32, i32* %v233
	%v235 = icmp eq i32 %v234, 0
	%v236 = zext i1 %v235 to i32
	%v237 = icmp ne i32 %v236, 0
	br i1 %v237, label %b54, label %b55
b52:
	%v247 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %p7
	%v248 = getelementptr inbounds [2 x i32], [2 x i32]* %v247, i32 0, i32 0
	%v249 = load i32, i32* %v248
	%v250 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v249
	%v251 = load i32, i32* %v250
	%v256 = load i32, i32* %v228
	%v257 = icmp eq i32 %a0, %v256
	%v252 = add i32 %p5, %v251
	br i1 %v257, label %b57, label %b58
b53:
	%p6 = phi i32 [ %v279, %b61 ],  [ %v244, %b55 ]
	%p4 = phi i32 [ %v265, %b61 ],  [ %p5, %b55 ]
	br label %b48
b54:
	call void @splay(i32 %p7, i32 0)
	%v240 = add i32 %p5, 1
	ret i32 %v240
b55:
	%v244 = load i32, i32* %v233
	br label %b53
b57:
	call void @splay(i32 %p7, i32 0)
	%v260 = add i32 %v252, 1
	ret i32 %v260
b58:
	%v263 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %p7
	%v264 = load i32, i32* %v263
	%v268 = getelementptr inbounds [2 x i32], [2 x i32]* %v247, i32 0, i32 1
	%v269 = load i32, i32* %v268
	%v270 = icmp eq i32 %v269, 0
	%v271 = zext i1 %v270 to i32
	%v272 = icmp ne i32 %v271, 0
	%v265 = add i32 %v252, %v264
	br i1 %v272, label %b60, label %b61
b60:
	call void @splay(i32 %p7, i32 0)
	%v275 = add i32 %v265, 1
	ret i32 %v275
b61:
	%v279 = load i32, i32* %v268
	br label %b53
}
define dso_local i32 @kth(i32 %a0) {
b63:
	%v282 = load i32, i32* @rt
	br label %b64
b64:
	%p11 = phi i32 [ %a0, %b63 ],  [ %p10, %b69 ]
	%p9 = phi i32 [ %v282, %b63 ],  [ %p8, %b69 ]
	br label %b65
b65:
	%v286 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %p9
	%v287 = getelementptr inbounds [2 x i32], [2 x i32]* %v286, i32 0, i32 0
	%v288 = load i32, i32* %v287
	%v289 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v288
	%v290 = load i32, i32* %v289
	%v291 = icmp sle i32 %p11, %v290
	br i1 %v291, label %b67, label %b68
b67:
	%v295 = load i32, i32* %v287
	br label %b69
b68:
	%v300 = load i32, i32* %v287
	%v301 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v300
	%v302 = load i32, i32* %v301
	%v306 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %p9
	%v307 = load i32, i32* %v306
	%v303 = sub i32 %p11, %v302
	%v308 = icmp sle i32 %v303, %v307
	br i1 %v308, label %b70, label %b71
b69:
	%p10 = phi i32 [ %p11, %b67 ],  [ %v317, %b71 ]
	%p8 = phi i32 [ %v295, %b67 ],  [ %v321, %b71 ]
	br label %b64
b70:
	call void @splay(i32 %p9, i32 0)
	%v311 = getelementptr inbounds [100010 x i32], [100010 x i32]* @a, i32 0, i32 %p9
	%v312 = load i32, i32* %v311
	ret i32 %v312
b71:
	%v316 = load i32, i32* %v306
	%v320 = getelementptr inbounds [2 x i32], [2 x i32]* %v286, i32 0, i32 1
	%v321 = load i32, i32* %v320
	%v317 = sub i32 %v303, %v316
	br label %b69
}
define dso_local i32 @pre(i32 %a0) {
b73:
	%v324 = call i32 @rank(i32 %a0)
	%v325 = sub i32 %v324, 1
	%v326 = call i32 @kth(i32 %v325)
	ret i32 %v326
}
define dso_local i32 @nxt(i32 %a0) {
b75:
	%v329 = add i32 %a0, 1
	%v330 = call i32 @rank(i32 %v329)
	%v331 = call i32 @kth(i32 %v330)
	ret i32 %v331
}
define dso_local void @del(i32 %a0) {
b77:
	%v334 = call i32 @rank(i32 %a0)
	%v336 = load i32, i32* @rt
	%v337 = getelementptr inbounds [100010 x i32], [100010 x i32]* @a, i32 0, i32 %v336
	%v338 = load i32, i32* %v337
	%v339 = icmp ne i32 %a0, %v338
	br i1 %v339, label %b78, label %b79
b78:
	ret void
b79:
	%v340 = load i32, i32* @rt
	%v341 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %v340
	%v342 = load i32, i32* %v341
	%v343 = icmp sgt i32 %v342, 1
	br i1 %v343, label %b81, label %b82
b81:
	%v344 = load i32, i32* @rt
	%v346 = load i32, i32* @rt
	%v347 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %v346
	%v348 = load i32, i32* %v347
	%v349 = sub i32 %v348, 1
	%v345 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %v344
	store i32 %v349, i32* %v345
	%v350 = load i32, i32* @rt
	%v352 = load i32, i32* @rt
	%v353 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v352
	%v354 = load i32, i32* %v353
	%v355 = sub i32 %v354, 1
	%v351 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v350
	store i32 %v355, i32* %v351
	ret void
b82:
	%v357 = load i32, i32* @rt
	%v359 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %v357
	%v360 = getelementptr inbounds [2 x i32], [2 x i32]* %v359, i32 0, i32 0
	%v361 = load i32, i32* %v360
	%v362 = icmp eq i32 %v361, 0
	%v363 = zext i1 %v362 to i32
	%v364 = icmp ne i32 %v363, 0
	br i1 %v364, label %b86, label %b85
b84:
	store i32 0, i32* @rt
	call void @clr(i32 %v357)
	ret void
b85:
	%v376 = load i32, i32* %v360
	%v377 = icmp eq i32 %v376, 0
	%v378 = zext i1 %v377 to i32
	%v379 = icmp ne i32 %v378, 0
	br i1 %v379, label %b88, label %b90
b86:
	%v367 = getelementptr inbounds [2 x i32], [2 x i32]* %v359, i32 0, i32 1
	%v368 = load i32, i32* %v367
	%v369 = icmp eq i32 %v368, 0
	%v370 = zext i1 %v369 to i32
	%v371 = icmp ne i32 %v370, 0
	br i1 %v371, label %b84, label %b85
b88:
	%v390 = load i32, i32* %v360
	%v393 = getelementptr inbounds [2 x i32], [2 x i32]* %v359, i32 0, i32 1
	%v394 = load i32, i32* %v393
	%v395 = add i32 %v390, %v394
	store i32 %v395, i32* @rt
	%v396 = load i32, i32* @rt
	%v397 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %v396
	store i32 0, i32* %v397
	call void @clr(i32 %v357)
	ret void
b89:
	%v400 = call i32 @pre(i32 %a0)
	%v404 = load i32, i32* %v382
	%v406 = load i32, i32* @rt
	%v405 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %v404
	store i32 %v406, i32* %v405
	%v407 = load i32, i32* @rt
	%v413 = load i32, i32* %v382
	%v408 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %v407
	%v409 = getelementptr inbounds [2 x i32], [2 x i32]* %v408, i32 0, i32 1
	store i32 %v413, i32* %v409
	call void @clr(i32 %v357)
	%v415 = load i32, i32* @rt
	%v417 = load i32, i32* @rt
	%v418 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v417
	%v419 = load i32, i32* %v418
	%v420 = sub i32 %v419, 1
	%v416 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v415
	store i32 %v420, i32* %v416
	ret void
b90:
	%v382 = getelementptr inbounds [2 x i32], [2 x i32]* %v359, i32 0, i32 1
	%v383 = load i32, i32* %v382
	%v384 = icmp eq i32 %v383, 0
	%v385 = zext i1 %v384 to i32
	%v386 = icmp ne i32 %v385, 0
	br i1 %v386, label %b88, label %b89
}
define dso_local i32 @main() {
b93:
	%v421 = call i32 @getint()
	br label %b94
b94:
	%p14 = phi i32 [ %v421, %b93 ],  [ %v425, %b99 ]
	%v423 = icmp ne i32 %p14, 0
	br i1 %v423, label %b95, label %b96
b95:
	%v426 = call i32 @getint()
	%v427 = call i32 @getint()
	%v429 = icmp eq i32 %v426, 1
	br i1 %v429, label %b97, label %b98
b96:
	ret i32 0
b97:
	call void @ins(i32 %v427)
	br label %b99
b98:
	%v432 = icmp eq i32 %v426, 2
	br i1 %v432, label %b100, label %b101
b99:
	%v425 = sub i32 %p14, 1
	br label %b94
b100:
	call void @del(i32 %v427)
	br label %b102
b101:
	%v435 = icmp eq i32 %v426, 3
	br i1 %v435, label %b103, label %b104
b102:
	br label %b99
b103:
	%v437 = call i32 @rank(i32 %v427)
	call void @putint(i32 %v437)
	call void @putch(i32 10)
	br label %b105
b104:
	%v439 = icmp eq i32 %v426, 4
	br i1 %v439, label %b106, label %b107
b105:
	br label %b102
b106:
	%v441 = call i32 @kth(i32 %v427)
	call void @putint(i32 %v441)
	call void @putch(i32 10)
	br label %b108
b107:
	%v443 = icmp eq i32 %v426, 5
	br i1 %v443, label %b109, label %b110
b108:
	br label %b105
b109:
	%v445 = call i32 @pre(i32 %v427)
	call void @putint(i32 %v445)
	call void @putch(i32 10)
	br label %b111
b110:
	%v447 = icmp eq i32 %v426, 6
	br i1 %v447, label %b112, label %b113
b111:
	br label %b108
b112:
	%v449 = call i32 @nxt(i32 %v427)
	call void @putint(i32 %v449)
	call void @putch(i32 10)
	br label %b113
b113:
	br label %b111
}
