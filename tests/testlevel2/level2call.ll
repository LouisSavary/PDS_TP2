; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 11 x i8 ] c"one() = %d\00"


define void @main() {
  %tmp1 = call i32 @one()
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.fmt1, i64 0, i64 0), i32 %tmp1)
  ret void 
}
define i32 @one() {
  ret i32 1
  ret i32  0
}

