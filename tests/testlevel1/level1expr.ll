; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)

; Actual code begins



@.fmt1 = global [ 12 x i8 ] c"%d+%d = %d\0A\00"
@.fmt2 = global [ 12 x i8 ] c"%d-%d = %d\0A\00"
@.fmt3 = global [ 12 x i8 ] c"%d*%d = %d\0A\00"
@.fmt4 = global [ 12 x i8 ] c"%d/%d = %d\0A\00"
@.fmt5 = global [ 12 x i8 ] c"%d+%d = %d\0A\00"
@.fmt6 = global [ 18 x i8 ] c"%d* (%d+%d) = %d\0A\00"
@.fmt7 = global [ 18 x i8 ] c"%d*  %d+%d  = %d\0A\00"
define void @main() {
  %tmp1 = add i32 5, 7
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.fmt1, i64 0, i64 0), i32 5, i32 7, i32 %tmp1)
  %tmp2 = sub i32 5, 7
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.fmt2, i64 0, i64 0), i32 5, i32 7, i32 %tmp2)
  %tmp3 = mul i32 5, 7
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.fmt3, i64 0, i64 0), i32 5, i32 7, i32 %tmp3)
  %tmp4 = udiv i32 5, 7
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.fmt4, i64 0, i64 0), i32 5, i32 7, i32 %tmp4)
  %tmp5 = add i32 5, 1
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.fmt5, i64 0, i64 0), i32 5, i32 1, i32 %tmp5)
  %tmp6 = add i32 5, 7
  %tmp7 = mul i32 5, %tmp6
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.fmt6, i64 0, i64 0), i32 5, i32 5, i32 7, i32 %tmp7)
  %tmp8 = mul i32 5, 5
  %tmp9 = add i32 %tmp8, 7
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.fmt7, i64 0, i64 0), i32 5, i32 5, i32 7, i32 %tmp9)
  ret void 
}

