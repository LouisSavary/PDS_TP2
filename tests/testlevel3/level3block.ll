; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 3 x i8 ] c"%d\00"
@.fmt2 = global [ 3 x i8 ] c"%d\00"
@.fmt3 = global [ 24 x i8 ] c"y a l'interieur vaut %d\00"
@.fmt4 = global [ 40 x i8 ] c", mais a l'exterieur du bloc il vaut %d\00"


define void @main() {
  %y1651191114 = alloca i32
  call i32 (i8* , ...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.fmt1, i64 0, i64 0), i32* %y1651191114)
  %y1993134103 = alloca i32
  call i32 (i8* , ...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.fmt2, i64 0, i64 0), i32* %y1993134103)
  %tmp1 = load i32, i32* %y1993134103
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.fmt3, i64 0, i64 0), i32 %tmp1)
  %tmp2 = load i32, i32* %y1651191114
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.fmt4, i64 0, i64 0), i32 %tmp2)
  ret void 
}



