; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 2 x i8 ] c"\0A\00"
@.fmt2 = global [ 8 x i8 ] c"%d^2 + \00"
@.fmt3 = global [ 10 x i8 ] c"1^2 = %d\0A\00"


define void @main() {
  %n1651191114 = alloca i32
  %i1651191114 = alloca i32
  %s1651191114 = alloca i32
  store i32 5, i32* %n1651191114
  store i32 0, i32* %s1651191114
  %tmp1 = load i32, i32* %n1651191114
  store i32 %tmp1, i32* %i1651191114
  br label %while_start1
while_start1:
  %tmp2 = load i32, i32* %i1651191114
  %tmp3 = icmp ne i32 %tmp2, 0
  br i1 %tmp3, label %while_do2, label %while_end3
while_do2:
  %tmp4 = load i32, i32* %s1651191114
  %tmp5 = load i32, i32* %i1651191114
  %tmp6 = load i32, i32* %i1651191114
  %tmp7 = mul i32 %tmp5, %tmp6
  %tmp8 = add i32 %tmp4, %tmp7
  store i32 %tmp8, i32* %s1651191114
  %tmp9 = load i32, i32* %i1651191114
  %tmp10 = sub i32 %tmp9, 1
  store i32 %tmp10, i32* %i1651191114
  br label %while_start1
while_end3:
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.fmt1, i64 0, i64 0))
  %tmp11 = load i32, i32* %n1651191114
  store i32 %tmp11, i32* %i1651191114
  br label %while_start4
while_start4:
  %tmp12 = load i32, i32* %i1651191114
  %tmp13 = sub i32 %tmp12, 1
  %tmp14 = icmp ne i32 %tmp13, 0
  br i1 %tmp14, label %while_do5, label %while_end6
while_do5:
  %tmp15 = load i32, i32* %i1651191114
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.fmt2, i64 0, i64 0), i32 %tmp15)
  %tmp16 = load i32, i32* %i1651191114
  %tmp17 = sub i32 %tmp16, 1
  store i32 %tmp17, i32* %i1651191114
  br label %while_start4
while_end6:
  %tmp18 = load i32, i32* %s1651191114
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.fmt3, i64 0, i64 0), i32 %tmp18)
  ret void 
}



