; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque
%struct.timeval = type { i64, i64 }
%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@rt = dso_local global i32 0
@tot = dso_local global i32 0
@f = dso_local global [100010 x i32] zeroinitializer
@ch = dso_local global [100010 x [2 x i32]] zeroinitializer
@a = dso_local global [100010 x i32] zeroinitializer
@c = dso_local global [100010 x i32] zeroinitializer
@s = dso_local global [100010 x i32] zeroinitializer
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @before_main, i8* null }]
@llvm.global_dtors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @after_main, i8* null }]
@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"%a\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"%d:\00", align 1
@.str.4 = private unnamed_addr constant [4 x i8] c" %d\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.6 = private unnamed_addr constant [4 x i8] c" %a\00", align 1
@stdout = external global %struct._IO_FILE*, align 8
@_sysy_us = dso_local global [1024 x i32] zeroinitializer, align 16
@_sysy_s = dso_local global [1024 x i32] zeroinitializer, align 16
@_sysy_m = dso_local global [1024 x i32] zeroinitializer, align 16
@_sysy_h = dso_local global [1024 x i32] zeroinitializer, align 16
@_sysy_idx = dso_local global i32 0, align 4
@stderr = external global %struct._IO_FILE*, align 8
@.str.7 = private unnamed_addr constant [35 x i8] c"Timer@%04d-%04d: %dH-%dM-%dS-%dus\0A\00", align 1
@_sysy_l1 = dso_local global [1024 x i32] zeroinitializer, align 16
@_sysy_l2 = dso_local global [1024 x i32] zeroinitializer, align 16
@.str.8 = private unnamed_addr constant [25 x i8] c"TOTAL: %dH-%dM-%dS-%dus\0A\00", align 1
@_sysy_start = dso_local global %struct.timeval zeroinitializer, align 8
@_sysy_end = dso_local global %struct.timeval zeroinitializer, align 8

define dso_local void @upd(i32 %a0) {
b0:
  %v2 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %a0
  %v4 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %a0
  %v5 = getelementptr inbounds [2 x i32], [2 x i32]* %v4, i32 0, i32 0
  %v6 = load i32, i32* %v5, align 4
  %v7 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v6
  %v8 = load i32, i32* %v7, align 4
  %v11 = getelementptr inbounds [2 x i32], [2 x i32]* %v4, i32 0, i32 1
  %v12 = load i32, i32* %v11, align 4
  %v13 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v12
  %v14 = load i32, i32* %v13, align 4
  %v15 = add i32 %v8, %v14
  %v17 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %a0
  %v18 = load i32, i32* %v17, align 4
  %v19 = add i32 %v15, %v18
  store i32 %v19, i32* %v2, align 4
  ret void
}

define dso_local i32 @get(i32 %a0) {
b1:
  %v23 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %a0
  %v24 = load i32, i32* %v23, align 4
  %v25 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %v24
  %v26 = getelementptr inbounds [2 x i32], [2 x i32]* %v25, i32 0, i32 1
  %v27 = load i32, i32* %v26, align 4
  %v28 = icmp eq i32 %a0, %v27
  br i1 %v28, label %b2, label %b3

b2:                                               ; preds = %b1
  ret i32 1

b3:                                               ; preds = %b1
  ret i32 0
}

define dso_local void @clr(i32 %a0) {
b7:
  %v31 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %a0
  store i32 0, i32* %v31, align 4
  %v33 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %a0
  %v34 = getelementptr inbounds [2 x i32], [2 x i32]* %v33, i32 0, i32 0
  store i32 0, i32* %v34, align 4
  %v37 = getelementptr inbounds [2 x i32], [2 x i32]* %v33, i32 0, i32 1
  store i32 0, i32* %v37, align 4
  %v39 = getelementptr inbounds [100010 x i32], [100010 x i32]* @a, i32 0, i32 %a0
  store i32 0, i32* %v39, align 4
  %v41 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %a0
  store i32 0, i32* %v41, align 4
  %v43 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %a0
  store i32 0, i32* %v43, align 4
  ret void
}

define dso_local i32 @xor1(i32 %a0) {
b8:
  %v46 = srem i32 %a0, 2
  %v47 = icmp eq i32 %v46, 0
  br i1 %v47, label %b9, label %b10

b9:                                               ; preds = %b8
  %v49 = add i32 %a0, 1
  ret i32 %v49

b10:                                              ; preds = %b8
  %v51 = sub i32 %a0, 1
  ret i32 %v51
}

define dso_local void @rot(i32 %a0) {
b14:
  %v55 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %a0
  %v56 = load i32, i32* %v55, align 4
  %v59 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %v56
  %v60 = load i32, i32* %v59, align 4
  %v63 = call i32 @get(i32 %a0)
  %v66 = call i32 @get(i32 %v56)
  %v70 = call i32 @xor1(i32 %v63)
  %v68 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %a0
  %v71 = getelementptr inbounds [2 x i32], [2 x i32]* %v68, i32 0, i32 %v70
  %v72 = load i32, i32* %v71, align 4
  %v73 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %v72
  store i32 %v56, i32* %v73, align 4
  %v84 = load i32, i32* %v71, align 4
  %v76 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %v56
  %v78 = getelementptr inbounds [2 x i32], [2 x i32]* %v76, i32 0, i32 %v63
  store i32 %v84, i32* %v78, align 4
  store i32 %a0, i32* %v59, align 4
  store i32 %v56, i32* %v71, align 4
  call void @upd(i32 %v56)
  call void @upd(i32 %a0)
  store i32 %v60, i32* %v55, align 4
  %v101 = load i32, i32* %v55, align 4
  %v102 = icmp ne i32 %v101, 0
  br i1 %v102, label %b15, label %b16

b15:                                              ; preds = %b14
  %v104 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %v60
  %v106 = getelementptr inbounds [2 x i32], [2 x i32]* %v104, i32 0, i32 %v66
  store i32 %a0, i32* %v106, align 4
  br label %b16

b16:                                              ; preds = %b15, %b14
  ret void
}

define dso_local void @splay(i32 %a0, i32 %a1) {
b17:
  %v112 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %a0
  %v113 = load i32, i32* %v112, align 4
  br label %b18

b18:                                              ; preds = %b22, %b17
  %p0 = phi i32 [ %v113, %b17 ], [ %v132, %b22 ]
  %v116 = icmp ne i32 %p0, %a1
  br i1 %v116, label %b19, label %b20

b19:                                              ; preds = %b18
  %v118 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %p0
  %v119 = load i32, i32* %v118, align 4
  %v121 = icmp ne i32 %v119, %a1
  br i1 %v121, label %b21, label %b22

b20:                                              ; preds = %b18
  %v134 = icmp eq i32 %a1, 0
  %v135 = zext i1 %v134 to i32
  %v136 = icmp ne i32 %v135, 0
  br i1 %v136, label %b26, label %b27

b21:                                              ; preds = %b19
  %v123 = call i32 @get(i32 %a0)
  %v125 = call i32 @get(i32 %p0)
  %v126 = icmp eq i32 %v123, %v125
  br i1 %v126, label %b23, label %b24

b22:                                              ; preds = %b25, %b19
  call void @rot(i32 %a0)
  %v132 = load i32, i32* %v112, align 4
  br label %b18

b23:                                              ; preds = %b21
  call void @rot(i32 %p0)
  br label %b25

b24:                                              ; preds = %b21
  call void @rot(i32 %a0)
  br label %b25

b25:                                              ; preds = %b24, %b23
  br label %b22

b26:                                              ; preds = %b20
  store i32 %a0, i32* @rt, align 4
  br label %b27

b27:                                              ; preds = %b26, %b20
  ret void
}

define dso_local void @ins(i32 %a0) {
b28:
  %v139 = load i32, i32* @rt, align 4
  %v140 = icmp eq i32 %v139, 0
  %v141 = zext i1 %v140 to i32
  %v142 = icmp ne i32 %v141, 0
  br i1 %v142, label %b29, label %b30

b29:                                              ; preds = %b28
  %v143 = load i32, i32* @tot, align 4
  %v144 = add i32 %v143, 1
  store i32 %v144, i32* @tot, align 4
  %v145 = load i32, i32* @tot, align 4
  store i32 %v145, i32* @rt, align 4
  %v146 = load i32, i32* @rt, align 4
  %v147 = getelementptr inbounds [100010 x i32], [100010 x i32]* @a, i32 0, i32 %v146
  store i32 %a0, i32* %v147, align 4
  %v149 = load i32, i32* @tot, align 4
  %v150 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %v149
  store i32 1, i32* %v150, align 4
  %v151 = load i32, i32* @tot, align 4
  %v152 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v151
  store i32 1, i32* %v152, align 4
  ret void

b30:                                              ; preds = %b28
  %v154 = load i32, i32* @rt, align 4
  br label %b32

b32:                                              ; preds = %b42, %b30
  %p2 = phi i32 [ %v154, %b30 ], [ %p3, %b42 ]
  %p1 = phi i32 [ 0, %b30 ], [ %p2, %b42 ]
  br label %b33

b33:                                              ; preds = %b32
  %v158 = getelementptr inbounds [100010 x i32], [100010 x i32]* @a, i32 0, i32 %p2
  %v159 = load i32, i32* %v158, align 4
  %v161 = icmp eq i32 %v159, %a0
  br i1 %v161, label %b35, label %b36

b35:                                              ; preds = %b33
  %v163 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %p2
  %v166 = load i32, i32* %v163, align 4
  %v167 = add i32 %v166, 1
  store i32 %v167, i32* %v163, align 4
  %v169 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %p2
  %v172 = load i32, i32* %v169, align 4
  %v173 = add i32 %v172, 1
  store i32 %v173, i32* %v169, align 4
  call void @upd(i32 %p1)
  call void @splay(i32 %p2, i32 0)
  ret void

b36:                                              ; preds = %b33
  %v179 = load i32, i32* %v158, align 4
  %v181 = icmp slt i32 %v179, %a0
  br i1 %v181, label %b38, label %b39

b38:                                              ; preds = %b36
  %v183 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %p2
  %v184 = getelementptr inbounds [2 x i32], [2 x i32]* %v183, i32 0, i32 1
  %v185 = load i32, i32* %v184, align 4
  br label %b40

b39:                                              ; preds = %b36
  %v187 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %p2
  %v188 = getelementptr inbounds [2 x i32], [2 x i32]* %v187, i32 0, i32 0
  %v189 = load i32, i32* %v188, align 4
  br label %b40

b40:                                              ; preds = %b39, %b38
  %p3 = phi i32 [ %v189, %b39 ], [ %v185, %b38 ]
  %v191 = icmp eq i32 %p3, 0
  %v192 = zext i1 %v191 to i32
  %v193 = icmp ne i32 %v192, 0
  br i1 %v193, label %b41, label %b42

b41:                                              ; preds = %b40
  %v194 = load i32, i32* @tot, align 4
  %v195 = add i32 %v194, 1
  store i32 %v195, i32* @tot, align 4
  %v196 = load i32, i32* @tot, align 4
  %v197 = getelementptr inbounds [100010 x i32], [100010 x i32]* @a, i32 0, i32 %v196
  store i32 %a0, i32* %v197, align 4
  %v199 = load i32, i32* @tot, align 4
  %v200 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %v199
  store i32 1, i32* %v200, align 4
  %v201 = load i32, i32* @tot, align 4
  %v202 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v201
  store i32 1, i32* %v202, align 4
  %v203 = load i32, i32* @tot, align 4
  %v204 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %v203
  store i32 %p2, i32* %v204, align 4
  %v208 = load i32, i32* %v158, align 4
  %v210 = icmp slt i32 %v208, %a0
  br i1 %v210, label %b43, label %b44

b42:                                              ; preds = %b40
  br label %b32

b43:                                              ; preds = %b41
  %v214 = load i32, i32* @tot, align 4
  %v212 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %p2
  %v213 = getelementptr inbounds [2 x i32], [2 x i32]* %v212, i32 0, i32 1
  store i32 %v214, i32* %v213, align 4
  br label %b45

b44:                                              ; preds = %b41
  %v218 = load i32, i32* @tot, align 4
  %v216 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %p2
  %v217 = getelementptr inbounds [2 x i32], [2 x i32]* %v216, i32 0, i32 0
  store i32 %v218, i32* %v217, align 4
  br label %b45

b45:                                              ; preds = %b44, %b43
  call void @upd(i32 %p2)
  %v220 = load i32, i32* @tot, align 4
  call void @splay(i32 %v220, i32 0)
  ret void
}

define dso_local i32 @rank(i32 %a0) {
b47:
  %v223 = load i32, i32* @rt, align 4
  br label %b48

b48:                                              ; preds = %b53, %b47
  %p7 = phi i32 [ %v223, %b47 ], [ %p6, %b53 ]
  %p5 = phi i32 [ 0, %b47 ], [ %p4, %b53 ]
  br label %b49

b49:                                              ; preds = %b48
  %v228 = getelementptr inbounds [100010 x i32], [100010 x i32]* @a, i32 0, i32 %p7
  %v229 = load i32, i32* %v228, align 4
  %v230 = icmp slt i32 %a0, %v229
  br i1 %v230, label %b51, label %b52

b51:                                              ; preds = %b49
  %v232 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %p7
  %v233 = getelementptr inbounds [2 x i32], [2 x i32]* %v232, i32 0, i32 0
  %v234 = load i32, i32* %v233, align 4
  %v235 = icmp eq i32 %v234, 0
  %v236 = zext i1 %v235 to i32
  %v237 = icmp ne i32 %v236, 0
  br i1 %v237, label %b54, label %b55

b52:                                              ; preds = %b49
  %v247 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %p7
  %v248 = getelementptr inbounds [2 x i32], [2 x i32]* %v247, i32 0, i32 0
  %v249 = load i32, i32* %v248, align 4
  %v250 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v249
  %v251 = load i32, i32* %v250, align 4
  %v256 = load i32, i32* %v228, align 4
  %v257 = icmp eq i32 %a0, %v256
  %v252 = add i32 %p5, %v251
  br i1 %v257, label %b57, label %b58

b53:                                              ; preds = %b61, %b55
  %p6 = phi i32 [ %v279, %b61 ], [ %v244, %b55 ]
  %p4 = phi i32 [ %v265, %b61 ], [ %p5, %b55 ]
  br label %b48

b54:                                              ; preds = %b51
  call void @splay(i32 %p7, i32 0)
  %v240 = add i32 %p5, 1
  ret i32 %v240

b55:                                              ; preds = %b51
  %v244 = load i32, i32* %v233, align 4
  br label %b53

b57:                                              ; preds = %b52
  call void @splay(i32 %p7, i32 0)
  %v260 = add i32 %v252, 1
  ret i32 %v260

b58:                                              ; preds = %b52
  %v263 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %p7
  %v264 = load i32, i32* %v263, align 4
  %v268 = getelementptr inbounds [2 x i32], [2 x i32]* %v247, i32 0, i32 1
  %v269 = load i32, i32* %v268, align 4
  %v270 = icmp eq i32 %v269, 0
  %v271 = zext i1 %v270 to i32
  %v272 = icmp ne i32 %v271, 0
  %v265 = add i32 %v252, %v264
  br i1 %v272, label %b60, label %b61

b60:                                              ; preds = %b58
  call void @splay(i32 %p7, i32 0)
  %v275 = add i32 %v265, 1
  ret i32 %v275

b61:                                              ; preds = %b58
  %v279 = load i32, i32* %v268, align 4
  br label %b53
}

define dso_local i32 @kth(i32 %a0) {
b63:
  %v282 = load i32, i32* @rt, align 4
  br label %b64

b64:                                              ; preds = %b69, %b63
  %p11 = phi i32 [ %a0, %b63 ], [ %p10, %b69 ]
  %p9 = phi i32 [ %v282, %b63 ], [ %p8, %b69 ]
  br label %b65

b65:                                              ; preds = %b64
  %v286 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %p9
  %v287 = getelementptr inbounds [2 x i32], [2 x i32]* %v286, i32 0, i32 0
  %v288 = load i32, i32* %v287, align 4
  %v289 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v288
  %v290 = load i32, i32* %v289, align 4
  %v291 = icmp sle i32 %p11, %v290
  br i1 %v291, label %b67, label %b68

b67:                                              ; preds = %b65
  %v295 = load i32, i32* %v287, align 4
  br label %b69

b68:                                              ; preds = %b65
  %v300 = load i32, i32* %v287, align 4
  %v301 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v300
  %v302 = load i32, i32* %v301, align 4
  %v306 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %p9
  %v307 = load i32, i32* %v306, align 4
  %v303 = sub i32 %p11, %v302
  %v308 = icmp sle i32 %v303, %v307
  br i1 %v308, label %b70, label %b71

b69:                                              ; preds = %b71, %b67
  %p10 = phi i32 [ %p11, %b67 ], [ %v317, %b71 ]
  %p8 = phi i32 [ %v295, %b67 ], [ %v321, %b71 ]
  br label %b64

b70:                                              ; preds = %b68
  call void @splay(i32 %p9, i32 0)
  %v311 = getelementptr inbounds [100010 x i32], [100010 x i32]* @a, i32 0, i32 %p9
  %v312 = load i32, i32* %v311, align 4
  ret i32 %v312

b71:                                              ; preds = %b68
  %v316 = load i32, i32* %v306, align 4
  %v320 = getelementptr inbounds [2 x i32], [2 x i32]* %v286, i32 0, i32 1
  %v321 = load i32, i32* %v320, align 4
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
  %v336 = load i32, i32* @rt, align 4
  %v337 = getelementptr inbounds [100010 x i32], [100010 x i32]* @a, i32 0, i32 %v336
  %v338 = load i32, i32* %v337, align 4
  %v339 = icmp ne i32 %a0, %v338
  br i1 %v339, label %b78, label %b79

b78:                                              ; preds = %b77
  ret void

b79:                                              ; preds = %b77
  %v340 = load i32, i32* @rt, align 4
  %v341 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %v340
  %v342 = load i32, i32* %v341, align 4
  %v343 = icmp sgt i32 %v342, 1
  br i1 %v343, label %b81, label %b82

b81:                                              ; preds = %b79
  %v344 = load i32, i32* @rt, align 4
  %v346 = load i32, i32* @rt, align 4
  %v347 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %v346
  %v348 = load i32, i32* %v347, align 4
  %v349 = sub i32 %v348, 1
  %v345 = getelementptr inbounds [100010 x i32], [100010 x i32]* @c, i32 0, i32 %v344
  store i32 %v349, i32* %v345, align 4
  %v350 = load i32, i32* @rt, align 4
  %v352 = load i32, i32* @rt, align 4
  %v353 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v352
  %v354 = load i32, i32* %v353, align 4
  %v355 = sub i32 %v354, 1
  %v351 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v350
  store i32 %v355, i32* %v351, align 4
  ret void

b82:                                              ; preds = %b79
  %v357 = load i32, i32* @rt, align 4
  %v359 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %v357
  %v360 = getelementptr inbounds [2 x i32], [2 x i32]* %v359, i32 0, i32 0
  %v361 = load i32, i32* %v360, align 4
  %v362 = icmp eq i32 %v361, 0
  %v363 = zext i1 %v362 to i32
  %v364 = icmp ne i32 %v363, 0
  br i1 %v364, label %b86, label %b85

b84:                                              ; preds = %b86
  store i32 0, i32* @rt, align 4
  call void @clr(i32 %v357)
  ret void

b85:                                              ; preds = %b86, %b82
  %v376 = load i32, i32* %v360, align 4
  %v377 = icmp eq i32 %v376, 0
  %v378 = zext i1 %v377 to i32
  %v379 = icmp ne i32 %v378, 0
  br i1 %v379, label %b88, label %b90

b86:                                              ; preds = %b82
  %v367 = getelementptr inbounds [2 x i32], [2 x i32]* %v359, i32 0, i32 1
  %v368 = load i32, i32* %v367, align 4
  %v369 = icmp eq i32 %v368, 0
  %v370 = zext i1 %v369 to i32
  %v371 = icmp ne i32 %v370, 0
  br i1 %v371, label %b84, label %b85

b88:                                              ; preds = %b90, %b85
  %v390 = load i32, i32* %v360, align 4
  %v393 = getelementptr inbounds [2 x i32], [2 x i32]* %v359, i32 0, i32 1
  %v394 = load i32, i32* %v393, align 4
  %v395 = add i32 %v390, %v394
  store i32 %v395, i32* @rt, align 4
  %v396 = load i32, i32* @rt, align 4
  %v397 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %v396
  store i32 0, i32* %v397, align 4
  call void @clr(i32 %v357)
  ret void

b89:                                              ; preds = %b90
  %v400 = call i32 @pre(i32 %a0)
  %v404 = load i32, i32* %v382, align 4
  %v406 = load i32, i32* @rt, align 4
  %v405 = getelementptr inbounds [100010 x i32], [100010 x i32]* @f, i32 0, i32 %v404
  store i32 %v406, i32* %v405, align 4
  %v407 = load i32, i32* @rt, align 4
  %v413 = load i32, i32* %v382, align 4
  %v408 = getelementptr inbounds [100010 x [2 x i32]], [100010 x [2 x i32]]* @ch, i32 0, i32 %v407
  %v409 = getelementptr inbounds [2 x i32], [2 x i32]* %v408, i32 0, i32 1
  store i32 %v413, i32* %v409, align 4
  call void @clr(i32 %v357)
  %v415 = load i32, i32* @rt, align 4
  %v417 = load i32, i32* @rt, align 4
  %v418 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v417
  %v419 = load i32, i32* %v418, align 4
  %v420 = sub i32 %v419, 1
  %v416 = getelementptr inbounds [100010 x i32], [100010 x i32]* @s, i32 0, i32 %v415
  store i32 %v420, i32* %v416, align 4
  ret void

b90:                                              ; preds = %b85
  %v382 = getelementptr inbounds [2 x i32], [2 x i32]* %v359, i32 0, i32 1
  %v383 = load i32, i32* %v382, align 4
  %v384 = icmp eq i32 %v383, 0
  %v385 = zext i1 %v384 to i32
  %v386 = icmp ne i32 %v385, 0
  br i1 %v386, label %b88, label %b89
}

define dso_local i32 @main() {
b93:
  %v421 = call i32 @getint()
  br label %b94

b94:                                              ; preds = %b99, %b93
  %p14 = phi i32 [ %v421, %b93 ], [ %v425, %b99 ]
  %v423 = icmp ne i32 %p14, 0
  br i1 %v423, label %b95, label %b96

b95:                                              ; preds = %b94
  %v426 = call i32 @getint()
  %v427 = call i32 @getint()
  %v429 = icmp eq i32 %v426, 1
  br i1 %v429, label %b97, label %b98

b96:                                              ; preds = %b94
  ret i32 0

b97:                                              ; preds = %b95
  call void @ins(i32 %v427)
  br label %b99

b98:                                              ; preds = %b95
  %v432 = icmp eq i32 %v426, 2
  br i1 %v432, label %b100, label %b101

b99:                                              ; preds = %b102, %b97
  %v425 = sub i32 %p14, 1
  br label %b94

b100:                                             ; preds = %b98
  call void @del(i32 %v427)
  br label %b102

b101:                                             ; preds = %b98
  %v435 = icmp eq i32 %v426, 3
  br i1 %v435, label %b103, label %b104

b102:                                             ; preds = %b105, %b100
  br label %b99

b103:                                             ; preds = %b101
  %v437 = call i32 @rank(i32 %v427)
  call void @putint(i32 %v437)
  call void @putch(i32 10)
  br label %b105

b104:                                             ; preds = %b101
  %v439 = icmp eq i32 %v426, 4
  br i1 %v439, label %b106, label %b107

b105:                                             ; preds = %b108, %b103
  br label %b102

b106:                                             ; preds = %b104
  %v441 = call i32 @kth(i32 %v427)
  call void @putint(i32 %v441)
  call void @putch(i32 10)
  br label %b108

b107:                                             ; preds = %b104
  %v443 = icmp eq i32 %v426, 5
  br i1 %v443, label %b109, label %b110

b108:                                             ; preds = %b111, %b106
  br label %b105

b109:                                             ; preds = %b107
  %v445 = call i32 @pre(i32 %v427)
  call void @putint(i32 %v445)
  call void @putch(i32 10)
  br label %b111

b110:                                             ; preds = %b107
  %v447 = icmp eq i32 %v426, 6
  br i1 %v447, label %b112, label %b113

b111:                                             ; preds = %b113, %b109
  br label %b108

b112:                                             ; preds = %b110
  %v449 = call i32 @nxt(i32 %v427)
  call void @putint(i32 %v449)
  call void @putch(i32 10)
  br label %b113

b113:                                             ; preds = %b112, %b110
  br label %b111
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @before_main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  br label %2

2:                                                ; preds = %18, %0
  %3 = load i32, i32* %1, align 4
  %4 = icmp slt i32 %3, 1024
  br i1 %4, label %5, label %21

5:                                                ; preds = %2
  %6 = load i32, i32* %1, align 4
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 %7
  store i32 0, i32* %8, align 4
  %9 = load i32, i32* %1, align 4
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 %10
  store i32 0, i32* %11, align 4
  %12 = load i32, i32* %1, align 4
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 %13
  store i32 0, i32* %14, align 4
  %15 = load i32, i32* %1, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_h, i64 0, i64 %16
  store i32 0, i32* %17, align 4
  br label %18

18:                                               ; preds = %5
  %19 = load i32, i32* %1, align 4
  %20 = add nsw i32 %19, 1
  store i32 %20, i32* %1, align 4
  br label %2, !llvm.loop !6

21:                                               ; preds = %2
  store i32 1, i32* @_sysy_idx, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @after_main() #0 {
  %1 = alloca i32, align 4
  store i32 1, i32* %1, align 4
  br label %2

2:                                                ; preds = %63, %0
  %3 = load i32, i32* %1, align 4
  %4 = load i32, i32* @_sysy_idx, align 4
  %5 = icmp slt i32 %3, %4
  br i1 %5, label %6, label %66

6:                                                ; preds = %2
  %7 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %8 = load i32, i32* %1, align 4
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_l1, i64 0, i64 %9
  %11 = load i32, i32* %10, align 4
  %12 = load i32, i32* %1, align 4
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_l2, i64 0, i64 %13
  %15 = load i32, i32* %14, align 4
  %16 = load i32, i32* %1, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_h, i64 0, i64 %17
  %19 = load i32, i32* %18, align 4
  %20 = load i32, i32* %1, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 %21
  %23 = load i32, i32* %22, align 4
  %24 = load i32, i32* %1, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 %25
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* %1, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 %29
  %31 = load i32, i32* %30, align 4
  %32 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* noundef %7, i8* noundef getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i64 0, i64 0), i32 noundef %11, i32 noundef %15, i32 noundef %19, i32 noundef %23, i32 noundef %27, i32 noundef %31)
  %33 = load i32, i32* %1, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 %34
  %36 = load i32, i32* %35, align 4
  %37 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 0), align 16
  %38 = add nsw i32 %37, %36
  store i32 %38, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 0), align 16
  %39 = load i32, i32* %1, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 %40
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 0), align 16
  %44 = add nsw i32 %43, %42
  store i32 %44, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 0), align 16
  %45 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 0), align 16
  %46 = srem i32 %45, 1000000
  store i32 %46, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 0), align 16
  %47 = load i32, i32* %1, align 4
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 %48
  %50 = load i32, i32* %49, align 4
  %51 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 0), align 16
  %52 = add nsw i32 %51, %50
  store i32 %52, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 0), align 16
  %53 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 0), align 16
  %54 = srem i32 %53, 60
  store i32 %54, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 0), align 16
  %55 = load i32, i32* %1, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_h, i64 0, i64 %56
  %58 = load i32, i32* %57, align 4
  %59 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_h, i64 0, i64 0), align 16
  %60 = add nsw i32 %59, %58
  store i32 %60, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_h, i64 0, i64 0), align 16
  %61 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 0), align 16
  %62 = srem i32 %61, 60
  store i32 %62, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 0), align 16
  br label %63

63:                                               ; preds = %6
  %64 = load i32, i32* %1, align 4
  %65 = add nsw i32 %64, 1
  store i32 %65, i32* %1, align 4
  br label %2, !llvm.loop !8

66:                                               ; preds = %2
  %67 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %68 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_h, i64 0, i64 0), align 16
  %69 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 0), align 16
  %70 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 0), align 16
  %71 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 0), align 16
  %72 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* noundef %67, i8* noundef getelementptr inbounds ([25 x i8], [25 x i8]* @.str.8, i64 0, i64 0), i32 noundef %68, i32 noundef %69, i32 noundef %70, i32 noundef %71)
  ret void
}

declare i32 @fprintf(%struct._IO_FILE* noundef, i8* noundef, ...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @memset(i32* noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i8*, align 8
  store i32* %0, i32** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %8 = load i32*, i32** %4, align 8
  %9 = bitcast i32* %8 to i8*
  store i8* %9, i8** %7, align 8
  br label %10

10:                                               ; preds = %14, %3
  %11 = load i32, i32* %6, align 4
  %12 = add nsw i32 %11, -1
  store i32 %12, i32* %6, align 4
  %13 = icmp ne i32 %11, 0
  br i1 %13, label %14, label %19

14:                                               ; preds = %10
  %15 = load i32, i32* %5, align 4
  %16 = trunc i32 %15 to i8
  %17 = load i8*, i8** %7, align 8
  %18 = getelementptr inbounds i8, i8* %17, i32 1
  store i8* %18, i8** %7, align 8
  store i8 %16, i8* %17, align 1
  br label %10, !llvm.loop !9

19:                                               ; preds = %10
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @getint() #0 {
  %1 = alloca i32, align 4
  %2 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), i32* noundef %1)
  %3 = load i32, i32* %1, align 4
  ret i32 %3
}

declare i32 @__isoc99_scanf(i8* noundef, ...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @getch() #0 {
  %1 = alloca i8, align 1
  %2 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i64 0, i64 0), i8* noundef %1)
  %3 = load i8, i8* %1, align 1
  %4 = sext i8 %3 to i32
  ret i32 %4
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local float @getfloat() #0 {
  %1 = alloca float, align 4
  %2 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i64 0, i64 0), float* noundef %1)
  %3 = load float, float* %1, align 4
  ret float %3
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @getarray(i32* noundef %0) #0 {
  %2 = alloca i32*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32* %0, i32** %2, align 8
  %5 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), i32* noundef %3)
  store i32 0, i32* %4, align 4
  br label %6

6:                                                ; preds = %16, %1
  %7 = load i32, i32* %4, align 4
  %8 = load i32, i32* %3, align 4
  %9 = icmp slt i32 %7, %8
  br i1 %9, label %10, label %19

10:                                               ; preds = %6
  %11 = load i32*, i32** %2, align 8
  %12 = load i32, i32* %4, align 4
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds i32, i32* %11, i64 %13
  %15 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), i32* noundef %14)
  br label %16

16:                                               ; preds = %10
  %17 = load i32, i32* %4, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, i32* %4, align 4
  br label %6, !llvm.loop !10

19:                                               ; preds = %6
  %20 = load i32, i32* %3, align 4
  ret i32 %20
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @getfarray(float* noundef %0) #0 {
  %2 = alloca float*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store float* %0, float** %2, align 8
  %5 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), i32* noundef %3)
  store i32 0, i32* %4, align 4
  br label %6

6:                                                ; preds = %16, %1
  %7 = load i32, i32* %4, align 4
  %8 = load i32, i32* %3, align 4
  %9 = icmp slt i32 %7, %8
  br i1 %9, label %10, label %19

10:                                               ; preds = %6
  %11 = load float*, float** %2, align 8
  %12 = load i32, i32* %4, align 4
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds float, float* %11, i64 %13
  %15 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i64 0, i64 0), float* noundef %14)
  br label %16

16:                                               ; preds = %10
  %17 = load i32, i32* %4, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, i32* %4, align 4
  br label %6, !llvm.loop !11

19:                                               ; preds = %6
  %20 = load i32, i32* %3, align 4
  ret i32 %20
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @putint(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), i32 noundef %3)
  ret void
}

declare i32 @printf(i8* noundef, ...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @putch(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i64 0, i64 0), i32 noundef %3)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @putarray(i32 noundef %0, i32* noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32*, align 8
  %5 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32* %1, i32** %4, align 8
  %6 = load i32, i32* %3, align 4
  %7 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0), i32 noundef %6)
  store i32 0, i32* %5, align 4
  br label %8

8:                                                ; preds = %19, %2
  %9 = load i32, i32* %5, align 4
  %10 = load i32, i32* %3, align 4
  %11 = icmp slt i32 %9, %10
  br i1 %11, label %12, label %22

12:                                               ; preds = %8
  %13 = load i32*, i32** %4, align 8
  %14 = load i32, i32* %5, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds i32, i32* %13, i64 %15
  %17 = load i32, i32* %16, align 4
  %18 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.4, i64 0, i64 0), i32 noundef %17)
  br label %19

19:                                               ; preds = %12
  %20 = load i32, i32* %5, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, i32* %5, align 4
  br label %8, !llvm.loop !12

22:                                               ; preds = %8
  %23 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @putfloat(float noundef %0) #0 {
  %2 = alloca float, align 4
  store float %0, float* %2, align 4
  %3 = load float, float* %2, align 4
  %4 = fpext float %3 to double
  %5 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i64 0, i64 0), double noundef %4)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @putfarray(i32 noundef %0, float* noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca float*, align 8
  %5 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store float* %1, float** %4, align 8
  %6 = load i32, i32* %3, align 4
  %7 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0), i32 noundef %6)
  store i32 0, i32* %5, align 4
  br label %8

8:                                                ; preds = %20, %2
  %9 = load i32, i32* %5, align 4
  %10 = load i32, i32* %3, align 4
  %11 = icmp slt i32 %9, %10
  br i1 %11, label %12, label %23

12:                                               ; preds = %8
  %13 = load float*, float** %4, align 8
  %14 = load i32, i32* %5, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds float, float* %13, i64 %15
  %17 = load float, float* %16, align 4
  %18 = fpext float %17 to double
  %19 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.6, i64 0, i64 0), double noundef %18)
  br label %20

20:                                               ; preds = %12
  %21 = load i32, i32* %5, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, i32* %5, align 4
  br label %8, !llvm.loop !13

23:                                               ; preds = %8
  %24 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @putf(i8* noundef %0, ...) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca [1 x %struct.__va_list_tag], align 16
  store i8* %0, i8** %2, align 8
  %4 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %3, i64 0, i64 0
  %5 = bitcast %struct.__va_list_tag* %4 to i8*
  call void @llvm.va_start(i8* %5)
  %6 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %7 = load i8*, i8** %2, align 8
  %8 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %3, i64 0, i64 0
  %9 = call i32 @vfprintf(%struct._IO_FILE* noundef %6, i8* noundef %7, %struct.__va_list_tag* noundef %8)
  %10 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %3, i64 0, i64 0
  %11 = bitcast %struct.__va_list_tag* %10 to i8*
  call void @llvm.va_end(i8* %11)
  ret void
}

; Function Attrs: nofree nosync nounwind willreturn
declare void @llvm.va_start(i8*) #2

declare i32 @vfprintf(%struct._IO_FILE* noundef, i8* noundef, %struct.__va_list_tag* noundef) #1

; Function Attrs: nofree nosync nounwind willreturn
declare void @llvm.va_end(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @_sysy_starttime(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = load i32, i32* @_sysy_idx, align 4
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_l1, i64 0, i64 %5
  store i32 %3, i32* %6, align 4
  %7 = call i32 @gettimeofday(%struct.timeval* noundef @_sysy_start, i8* noundef null) #4
  ret void
}

; Function Attrs: nounwind
declare i32 @gettimeofday(%struct.timeval* noundef, i8* noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @_sysy_stoptime(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = call i32 @gettimeofday(%struct.timeval* noundef @_sysy_end, i8* noundef null) #4
  %4 = load i32, i32* %2, align 4
  %5 = load i32, i32* @_sysy_idx, align 4
  %6 = sext i32 %5 to i64
  %7 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_l2, i64 0, i64 %6
  store i32 %4, i32* %7, align 4
  %8 = load i64, i64* getelementptr inbounds (%struct.timeval, %struct.timeval* @_sysy_end, i32 0, i32 0), align 8
  %9 = load i64, i64* getelementptr inbounds (%struct.timeval, %struct.timeval* @_sysy_start, i32 0, i32 0), align 8
  %10 = sub nsw i64 %8, %9
  %11 = mul nsw i64 1000000, %10
  %12 = load i64, i64* getelementptr inbounds (%struct.timeval, %struct.timeval* @_sysy_end, i32 0, i32 1), align 8
  %13 = add nsw i64 %11, %12
  %14 = load i64, i64* getelementptr inbounds (%struct.timeval, %struct.timeval* @_sysy_start, i32 0, i32 1), align 8
  %15 = sub nsw i64 %13, %14
  %16 = load i32, i32* @_sysy_idx, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 %17
  %19 = load i32, i32* %18, align 4
  %20 = sext i32 %19 to i64
  %21 = add nsw i64 %20, %15
  %22 = trunc i64 %21 to i32
  store i32 %22, i32* %18, align 4
  %23 = load i32, i32* @_sysy_idx, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 %24
  %26 = load i32, i32* %25, align 4
  %27 = sdiv i32 %26, 1000000
  %28 = load i32, i32* @_sysy_idx, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 %29
  %31 = load i32, i32* %30, align 4
  %32 = add nsw i32 %31, %27
  store i32 %32, i32* %30, align 4
  %33 = load i32, i32* @_sysy_idx, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 %34
  %36 = load i32, i32* %35, align 4
  %37 = srem i32 %36, 1000000
  store i32 %37, i32* %35, align 4
  %38 = load i32, i32* @_sysy_idx, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 %39
  %41 = load i32, i32* %40, align 4
  %42 = sdiv i32 %41, 60
  %43 = load i32, i32* @_sysy_idx, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 %44
  %46 = load i32, i32* %45, align 4
  %47 = add nsw i32 %46, %42
  store i32 %47, i32* %45, align 4
  %48 = load i32, i32* @_sysy_idx, align 4
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 %49
  %51 = load i32, i32* %50, align 4
  %52 = srem i32 %51, 60
  store i32 %52, i32* %50, align 4
  %53 = load i32, i32* @_sysy_idx, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 %54
  %56 = load i32, i32* %55, align 4
  %57 = sdiv i32 %56, 60
  %58 = load i32, i32* @_sysy_idx, align 4
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_h, i64 0, i64 %59
  %61 = load i32, i32* %60, align 4
  %62 = add nsw i32 %61, %57
  store i32 %62, i32* %60, align 4
  %63 = load i32, i32* @_sysy_idx, align 4
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 %64
  %66 = load i32, i32* %65, align 4
  %67 = srem i32 %66, 60
  store i32 %67, i32* %65, align 4
  %68 = load i32, i32* @_sysy_idx, align 4
  %69 = add nsw i32 %68, 1
  store i32 %69, i32* @_sysy_idx, align 4
  ret void
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nosync nounwind willreturn }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2, !3, !4, !5}

!0 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 1}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
