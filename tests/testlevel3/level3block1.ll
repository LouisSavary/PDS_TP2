; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 3 x i8 ] c"%d\00"


define void @main(i32 %f2316857851) {
  %f231685785 = alloca i32
  store i32 %f2316857851, i32* %f231685785
  %f932583850 = alloca i32
  store i32 100, i32* %f932583850
  %tmp1 = load i32, i32* %f932583850
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.fmt1, i64 0, i64 0), i32 %tmp1)
  ret void 
}



