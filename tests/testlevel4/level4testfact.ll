; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 12 x i8 ] c"f(%d) = %d\0A\00"


define void @main() {
  %i1579572132 = alloca i32
  %tmp1 = alloca [11 x i32]
  %t1579572132 = getelementptr [11 x i32], [11 x i32]* %tmp1, i64 0, i32 0
  store i32 0, i32* %i1579572132
  br label %while_start1
while_start1:
  %tmp2 = load i32, i32* %i1579572132
  %tmp3 = sub i32 11, %tmp2
  %tmp4 = icmp ne i32 %tmp3, 0
  br i1 %tmp4, label %while_do2, label %while_end3
while_do2:
  %tmp5 = load i32, i32* %i1579572132
  %tmp6 = call i32 @fact(i32 %tmp5)
  %tmp7 = load i32, i32* %i1579572132
  %tmp8 = getelementptr i32, i32* %t1579572132, i32 %tmp7
  store i32 %tmp6, i32* %tmp8
  %tmp9 = load i32, i32* %i1579572132
  %tmp10 = add i32 %tmp9, 1
  store i32 %tmp10, i32* %i1579572132
  br label %while_start1
while_end3:
  store i32 0, i32* %i1579572132
  br label %while_start4
while_start4:
  %tmp11 = load i32, i32* %i1579572132
  %tmp12 = sub i32 11, %tmp11
  %tmp13 = icmp ne i32 %tmp12, 0
  br i1 %tmp13, label %while_do5, label %while_end6
while_do5:
  %tmp14 = load i32, i32* %i1579572132
  %tmp17 = load i32, i32* %i1579572132
  %tmp15 = getelementptr i32, i32* %t1579572132, i32 %tmp17
  %tmp16 = load i32, i32* %tmp15
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.fmt1, i64 0, i64 0), i32 %tmp14, i32 %tmp16)
  %tmp18 = load i32, i32* %i1579572132
  %tmp19 = add i32 %tmp18, 1
  store i32 %tmp19, i32* %i1579572132
  br label %while_start4
while_end6:
  ret void 
}


define i32 @fact(i32 %n16519450121) {
  %n1651945012 = alloca i32
  store i32 %n16519450121, i32* %n1651945012
  %tmp20 = load i32, i32* %n1651945012
  %tmp21 = icmp ne i32 %tmp20, 0
  br i1 %tmp21, label %if_then7, label %if_else9
if_then7:
  %tmp22 = load i32, i32* %n1651945012
  %tmp23 = load i32, i32* %n1651945012
  %tmp24 = sub i32 %tmp23, 1
  %tmp25 = call i32 @fact(i32 %tmp24)
  %tmp26 = mul i32 %tmp22, %tmp25
  ret i32 %tmp26
  br label %if_end8
if_else9:
  ret i32 1
  br label %if_end8
if_end8:
  ret i32  0
}



