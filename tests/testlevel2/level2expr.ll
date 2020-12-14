; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 12 x i8 ] c"%d+%d = %d\0A\00"
@.fmt2 = global [ 12 x i8 ] c"%d-%d = %d\0A\00"
@.fmt3 = global [ 12 x i8 ] c"%d*%d = %d\0A\00"
@.fmt4 = global [ 12 x i8 ] c"%d/%d = %d\0A\00"
@.fmt5 = global [ 12 x i8 ] c"%d+%d = %d\0A\00"
@.fmt6 = global [ 18 x i8 ] c"%d* (%d+%d) = %d\0A\00"
@.fmt7 = global [ 18 x i8 ] c"%d*  %d+%d  = %d\0A\00"


define void @main() {
  call void @expr(i32 1, i32 3)
  call void @expr(i32 5, i32 2)
  ret void 
}
define void @expr(i32 %x1, i32 %y1) {
  %x = alloca i32
  store i32 %x1, i32* %x
  %y = alloca i32
  store i32 %y1, i32* %y
  %tmp1 = load i32, i32* %x
  %tmp2 = load i32, i32* %y
  %tmp3 = load i32, i32* %x
  %tmp4 = load i32, i32* %y
  %tmp5 = add i32 %tmp3, %tmp4
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.fmt1, i64 0, i64 0), i32 %tmp1, i32 %tmp2, i32 %tmp5)
  %tmp6 = load i32, i32* %x
  %tmp7 = load i32, i32* %y
  %tmp8 = load i32, i32* %x
  %tmp9 = load i32, i32* %y
  %tmp10 = sub i32 %tmp8, %tmp9
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.fmt2, i64 0, i64 0), i32 %tmp6, i32 %tmp7, i32 %tmp10)
  %tmp11 = load i32, i32* %x
  %tmp12 = load i32, i32* %y
  %tmp13 = load i32, i32* %x
  %tmp14 = load i32, i32* %y
  %tmp15 = mul i32 %tmp13, %tmp14
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.fmt3, i64 0, i64 0), i32 %tmp11, i32 %tmp12, i32 %tmp15)
  %tmp16 = load i32, i32* %x
  %tmp17 = load i32, i32* %y
  %tmp18 = load i32, i32* %x
  %tmp19 = load i32, i32* %y
  %tmp20 = udiv i32 %tmp18, %tmp19
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.fmt4, i64 0, i64 0), i32 %tmp16, i32 %tmp17, i32 %tmp20)
  %tmp21 = load i32, i32* %x
  %tmp22 = load i32, i32* %x
  %tmp23 = add i32 %tmp22, 1
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.fmt5, i64 0, i64 0), i32 %tmp21, i32 1, i32 %tmp23)
  %tmp24 = load i32, i32* %x
  %tmp25 = load i32, i32* %x
  %tmp26 = load i32, i32* %y
  %tmp27 = load i32, i32* %x
  %tmp28 = load i32, i32* %x
  %tmp29 = load i32, i32* %y
  %tmp30 = add i32 %tmp28, %tmp29
  %tmp31 = mul i32 %tmp27, %tmp30
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.fmt6, i64 0, i64 0), i32 %tmp24, i32 %tmp25, i32 %tmp26, i32 %tmp31)
  %tmp32 = load i32, i32* %x
  %tmp33 = load i32, i32* %x
  %tmp34 = load i32, i32* %y
  %tmp35 = load i32, i32* %x
  %tmp36 = load i32, i32* %x
  %tmp37 = mul i32 %tmp35, %tmp36
  %tmp38 = load i32, i32* %y
  %tmp39 = add i32 %tmp37, %tmp38
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.fmt7, i64 0, i64 0), i32 %tmp32, i32 %tmp33, i32 %tmp34, i32 %tmp39)
  ret void 
}

