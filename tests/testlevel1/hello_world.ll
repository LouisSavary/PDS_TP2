; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 12 x i8 ] c"Hello World\00"


define i32 @main() {
call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.fmt1, i64 0, i64 0))
ret i32  0
}

