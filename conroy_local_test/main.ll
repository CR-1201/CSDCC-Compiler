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
define dso_local i32 @foo() {
b0:
	%v0 = alloca [16 x i32]
	%v1 = getelementptr inbounds [16 x i32], [16 x i32]* %v0, i32 0, i32 0
	call void @memset(i32* %v1, i32 0, i32 64)
	%v2 = getelementptr inbounds i32, i32* %v1, i32 0
	store i32 0, i32* %v2
	%v3 = getelementptr inbounds i32, i32* %v1, i32 1
	store i32 1, i32* %v3
	%v4 = getelementptr inbounds i32, i32* %v1, i32 2
	store i32 2, i32* %v4
	%v5 = getelementptr inbounds i32, i32* %v1, i32 3
	store i32 3, i32* %v5
	%v6 = getelementptr inbounds i32, i32* %v1, i32 4
	store i32 0, i32* %v6
	%v7 = getelementptr inbounds i32, i32* %v1, i32 5
	store i32 1, i32* %v7
	%v8 = getelementptr inbounds i32, i32* %v1, i32 6
	store i32 2, i32* %v8
	%v9 = getelementptr inbounds i32, i32* %v1, i32 7
	store i32 3, i32* %v9
	%v10 = getelementptr inbounds i32, i32* %v1, i32 8
	store i32 0, i32* %v10
	%v11 = getelementptr inbounds i32, i32* %v1, i32 9
	store i32 1, i32* %v11
	%v12 = getelementptr inbounds i32, i32* %v1, i32 10
	store i32 2, i32* %v12
	%v13 = getelementptr inbounds i32, i32* %v1, i32 11
	store i32 3, i32* %v13
	%v14 = getelementptr inbounds i32, i32* %v1, i32 12
	store i32 0, i32* %v14
	%v15 = getelementptr inbounds i32, i32* %v1, i32 13
	store i32 1, i32* %v15
	%v16 = getelementptr inbounds i32, i32* %v1, i32 14
	store i32 2, i32* %v16
	%v17 = getelementptr inbounds i32, i32* %v1, i32 15
	store i32 3, i32* %v17
	%v70 = getelementptr inbounds [16 x i32], [16 x i32]* %v0, i32 0, i32 3
	%v71 = load i32, i32* %v70
	%v72 = add i32 71, %v71
	ret i32 %v72
}
define dso_local i32 @main() {
b2:
	%v122 = call i32 @foo()
	%v123 = add i32 30, %v122
	%v133 = call i32 @foo()
	%v134 = add i32 41, %v133
	%v162 = add i32 %v123, %v134
	%v164 = add i32 %v162, 35
	call void @putint(i32 %v164)
	call void @putch(i32 10)
	ret i32 0
}
