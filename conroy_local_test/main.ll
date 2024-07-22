@a = dso_local global [10000000 x i32] zeroinitializer

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
define dso_local i32 @meanless_calculation(i32 %a0, i32 %a1) {
b0:
	br label %b1
b1:
	%p1 = phi i32 [ 0, %b0 ],  [ %v11, %b2 ]
	%p0 = phi i32 [ 0, %b0 ],  [ %v16, %b2 ]
	%v6 = icmp slt i32 %p1, %a0
	br i1 %v6, label %b4, label %b3
b2:
	%v14 = add i32 %p0, %a0
	%v11 = add i32 %p1, 1
	%v16 = add i32 %v14, %v11
	br label %b1
b3:
	ret i32 %p0
b4:
	%v9 = icmp slt i32 %p1, %a1
	br i1 %v9, label %b2, label %b3
}
define dso_local i32 @swap(i32* %a0, i32 %a1, i32 %a2) {
b6:
	%v24 = getelementptr inbounds i32, i32* %a0, i32 %a1
	%v25 = load i32, i32* %v24
	%v31 = getelementptr inbounds i32, i32* %a0, i32 %a2
	%v32 = load i32, i32* %v31
	store i32 %v32, i32* %v24
	store i32 %v25, i32* %v31
	%v39 = call i32 @meanless_calculation(i32 %a1, i32 %a2)
	ret i32 0
}
define dso_local i32 @median(i32* %a0, i32 %a1, i32 %a2, i32 %a3) {
b8:
	%v47 = getelementptr inbounds i32, i32* %a0, i32 %a1
	%v48 = load i32, i32* %v47
	%v53 = add i32 %a2, 1
	br label %b9
b9:
	%p11 = phi i32 [ %a1, %b8 ],  [ %p10, %b24 ]
	%p8 = phi i32 [ %v53, %b8 ],  [ %p7, %b24 ]
	%p3 = phi i32 [ 0, %b8 ],  [ %p5, %b24 ]
	br i1 1, label %b10, label %b11
b10:
	br label %b12
b11:
	%p12 = phi i32 [ %p11, %b9 ],  [ %p10, %b22 ]
	%p9 = phi i32 [ %p8, %b9 ],  [ %p7, %b22 ]
	%p4 = phi i32 [ %p3, %b9 ],  [ %p5, %b22 ]
	store i32 %v48, i32* %v47
	%v96 = call i32 @swap(i32* %a0, i32 %a1, i32 %p12)
	%v99 = icmp sgt i32 %p12, %a3
	br i1 %v99, label %b25, label %b26
b12:
	%p6 = phi i32 [ %p8, %b10 ],  [ %v60, %b16 ]
	%p2 = phi i32 [ %p3, %b10 ],  [ %v68, %b16 ]
	%v58 = icmp slt i32 %p11, %p6
	br i1 %v58, label %b13, label %b14
b13:
	%v60 = sub i32 %p6, 1
	%v63 = getelementptr inbounds i32, i32* %a0, i32 %v60
	%v64 = load i32, i32* %v63
	%v66 = icmp slt i32 %v64, %v48
	br i1 %v66, label %b15, label %b16
b14:
	%p7 = phi i32 [ %p6, %b12 ],  [ %v60, %b15 ]
	br label %b17
b15:
	br label %b14
b16:
	%v68 = add i32 %p2, 1
	br label %b12
b17:
	%p13 = phi i32 [ %p11, %b14 ],  [ %v73, %b21 ]
	%p5 = phi i32 [ %p2, %b14 ],  [ %v81, %b21 ]
	%v71 = icmp slt i32 %p13, %p7
	br i1 %v71, label %b18, label %b19
b18:
	%v73 = add i32 %p13, 1
	%v76 = getelementptr inbounds i32, i32* %a0, i32 %v73
	%v77 = load i32, i32* %v76
	%v79 = icmp sge i32 %v77, %v48
	br i1 %v79, label %b20, label %b21
b19:
	%p10 = phi i32 [ %p13, %b17 ],  [ %v73, %b20 ]
	%v84 = icmp eq i32 %p10, %p7
	br i1 %v84, label %b22, label %b23
b20:
	br label %b19
b21:
	%v81 = sub i32 %p5, 1
	br label %b17
b22:
	br label %b11
b23:
	%v88 = call i32 @swap(i32* %a0, i32 %p10, i32 %p7)
	br label %b24
b24:
	br label %b9
b25:
	%v104 = call i32 @median(i32* %a0, i32 %a1, i32 %p12, i32 %a3)
	ret i32 0
b26:
	%v107 = icmp slt i32 %p12, %a3
	br i1 %v107, label %b28, label %b29
b28:
	%v110 = add i32 %p12, 1
	%v113 = call i32 @median(i32* %a0, i32 %v110, i32 %a2, i32 %a3)
	ret i32 0
b29:
	ret i32 0
}
define dso_local i32 @main() {
b32:
	%v115 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @a, i32 0, i32 0
	%v116 = call i32 @getarray(i32* %v115)
	call void @_sysy_starttime()
	%v119 = sub i32 %v116, 1
	%v121 = sdiv i32 %v116, 2
	%v122 = call i32 @median(i32* %v115, i32 0, i32 %v119, i32 %v121)
	call void @_sysy_stoptime()
	call void @putarray(i32 %v116, i32* %v115)
	%v127 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @a, i32 0, i32 %v121
	%v128 = load i32, i32* %v127
	%v129 = srem i32 %v128, 256
	ret i32 %v129
}
