; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 3 x i8 ] c"%d\00"
@.fmt2 = global [ 12 x i8 ] c"t[%d] = %d\0A\00"


define void @main() {
  %i1651191114 = alloca i32
  %tmp1 = alloca [8 x i32]
  %t1651191114 = getelementptr [8 x i32], [8 x i32]* %tmp1, i64 0, i32 0
  %x1651191114 = alloca i32
  store i32 0, i32* %i1651191114
  br label %while_start1
while_start1:
  %tmp2 = load i32, i32* %i1651191114
  %tmp3 = sub i32 8, %tmp2
  %tmp4 = icmp ne i32 %tmp3, 0
  br i1 %tmp4, label %while_do2, label %while_end3
while_do2:
  call i32 (i8* , ...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.fmt1, i64 0, i64 0), i32* %x1651191114)
  %tmp5 = load i32, i32* %x1651191114
  %tmp6 = load i32, i32* %i1651191114
  %tmp7 = getelementptr i32, i32* %t1651191114, i32 %tmp6
  store i32 %tmp5, i32* %tmp7
  %tmp8 = load i32, i32* %i1651191114
  %tmp9 = add i32 %tmp8, 1
  store i32 %tmp9, i32* %i1651191114
  br label %while_start1
while_end3:
  store i32 0, i32* %i1651191114
  br label %while_start4
while_start4:
  %tmp10 = load i32, i32* %i1651191114
  %tmp11 = sub i32 8, %tmp10
  %tmp12 = icmp ne i32 %tmp11, 0
  br i1 %tmp12, label %while_do5, label %while_end6
while_do5:
  %tmp13 = load i32, i32* %i1651191114
  %tmp16 = load i32, i32* %i1651191114
  %tmp14 = getelementptr i32, i32* %t1651191114, i32 %tmp16
  %tmp15 = load i32, i32* %tmp14
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.fmt2, i64 0, i64 0), i32 %tmp13, i32 %tmp15)
  %tmp17 = load i32, i32* %i1651191114
  %tmp18 = add i32 %tmp17, 1
  store i32 %tmp18, i32* %i1651191114
  br label %while_start4
while_end6:
  ret void 
}



