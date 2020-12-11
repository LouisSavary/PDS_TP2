; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)

; Actual code begins



@.fmt1 = global [ 7 x i8 ] c"1 = %d\00"
define void @main() {
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.fmt1, i64 0, i64 0), i32 1)
  ret void 
}

