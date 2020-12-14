; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 5 x i8 ] c"Toto\00"


define void @main() {
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.fmt1, i64 0, i64 0))
  br label %while_start1
while_start1:
  %tmp1 = icmp ne i32 1, 0
  br i1 %tmp1, label %while_do2, label %while_end3
while_do2:
  %x581374081 = alloca i32
  store i32 1, i32* %x581374081
  br label %while_start1
while_end3:
  ret void 
}



