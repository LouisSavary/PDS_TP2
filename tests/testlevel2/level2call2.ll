; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 9 x i8 ] c"1+3 = %d\00"


define void @main() {
  %tmp1 = call i32 @plus(i32 1, i32 3)
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.fmt1, i64 0, i64 0), i32 %tmp1)
  ret void 
}
define i32 @plus(i32 %x1, i32 %y1) {
  %x = alloca i32
  store i32 %x1, i32* %x
  %y = alloca i32
  store i32 %y1, i32* %y
  %tmp2 = load i32, i32* %x
  %tmp3 = load i32, i32* %y
  %tmp4 = add i32 %tmp2, %tmp3
  ret i32 %tmp4
  ret i32  0
}

