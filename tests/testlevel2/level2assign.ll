; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins



@fmt1 = global [ 3 x i8 ] c"%d\00"
@.fmt2 = global [ 10 x i8 ] c"y vaut %d\00"
define void @main() {
  %x = alloca i32
  %y = alloca i32
  call i32 (i8* , ...) @scanf(i8* getelementptr inbounds ([ 3 x i8 ], [ 3 x i8 ]* @fmt1, i64 0, i64 0), i32* %x)
  %tmp1 = load i32, i32* %x
  store i32 %tmp1, i32* %y
  %tmp2 = load i32, i32* %y
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.fmt2, i64 0, i64 0), i32 %tmp2)
  ret void 
}

