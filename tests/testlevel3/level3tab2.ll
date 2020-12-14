; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 9 x i8 ] c"%d %d %d\00"
@.fmt2 = global [ 30 x i8 ] c"t[0] = %d\0At[1] = %d\0At[2] = %d\00"


define void @main() {
  %x1651191114 = alloca i32
  %y1651191114 = alloca i32
  %z1651191114 = alloca i32
  %tmp1 = alloca [3 x i32]
  %t1651191114 = getelementptr [3 x i32], [3 x i32]* %tmp1, i64 0, i32 0
  call i32 (i8* , ...) @scanf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.fmt1, i64 0, i64 0), i32* %x1651191114, i32* %y1651191114, i32* %z1651191114)
  %tmp2 = load i32, i32* %x1651191114
  %tmp3 = getelementptr i32, i32* %t1651191114, i32 0
  store i32 %tmp2, i32* %tmp3
  %tmp4 = load i32, i32* %y1651191114
  %tmp5 = getelementptr i32, i32* %t1651191114, i32 1
  store i32 %tmp4, i32* %tmp5
  %tmp6 = load i32, i32* %z1651191114
  %tmp7 = getelementptr i32, i32* %t1651191114, i32 2
  store i32 %tmp6, i32* %tmp7
  %tmp8 = getelementptr i32, i32* %t1651191114, i32 0
  %tmp9 = load i32, i32* %tmp8
  %tmp10 = getelementptr i32, i32* %t1651191114, i32 1
  %tmp11 = load i32, i32* %tmp10
  %tmp12 = getelementptr i32, i32* %t1651191114, i32 2
  %tmp13 = load i32, i32* %tmp12
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.fmt2, i64 0, i64 0), i32 %tmp9, i32 %tmp11, i32 %tmp13)
  ret void 
}



