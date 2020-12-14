; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 9 x i8 ] c"%d %d %d\00"
@.fmt2 = global [ 7 x i8 ] c"%d%d%d\00"


define void @main() {
  %x1651191114 = alloca i32
  %tmp1 = alloca [3 x i32]
  %t1651191114 = getelementptr [3 x i32], [3 x i32]* %tmp1, i64 0, i32 0
  %tmp2 = getelementptr i32, i32* %t1651191114, i32 0
  %tmp3 = getelementptr i32, i32* %t1651191114, i32 1
  %tmp4 = getelementptr i32, i32* %t1651191114, i32 2
  call i32 (i8* , ...) @scanf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.fmt1, i64 0, i64 0), i32* %tmp2, i32* %tmp3, i32* %tmp4)
  %tmp5 = getelementptr i32, i32* %t1651191114, i32 0
  %tmp6 = load i32, i32* %tmp5
  %tmp7 = getelementptr i32, i32* %t1651191114, i32 1
  %tmp8 = load i32, i32* %tmp7
  %tmp9 = getelementptr i32, i32* %t1651191114, i32 2
  %tmp10 = load i32, i32* %tmp9
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.fmt2, i64 0, i64 0), i32 %tmp6, i32 %tmp8, i32 %tmp10)
  ret void 
}



