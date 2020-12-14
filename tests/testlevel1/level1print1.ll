; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 6 x i8 ] c"Hello\00"


define void @main() {
call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.fmt1, i64 0, i64 0))
ret void 
}

