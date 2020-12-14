; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 3 x i8 ] c"%d\00"
@.fmt2 = global [ 7 x i8 ] c"i vrai\00"
@.fmt3 = global [ 7 x i8 ] c"i faux\00"


define i32 @test(i32* %t1865127310) {
  %i305808283 = alloca i32
  store i32 0, i32* %i305808283
  br label %while_start1
while_start1:
  %tmp1 = load i32, i32* %i305808283
  %tmp2 = sub i32 5, %tmp1
  %tmp3 = icmp ne i32 %tmp2, 0
  br i1 %tmp3, label %while_do2, label %while_end3
while_do2:
  %tmp4 = load i32, i32* %i305808283
  %tmp5 = load i32, i32* %i305808283
  %tmp6 = getelementptr i32, i32* %t1865127310, i32 %tmp5
  store i32 %tmp4, i32* %tmp6
  br label %while_start1
while_end3:
  %tmp7 = load i32, i32* %i305808283
  ret i32 %tmp7
  ret i32  0
}


define void @main() {
  %tmp8 = alloca [5 x i32]
  %t1308927845 = getelementptr [5 x i32], [5 x i32]* %tmp8, i64 0, i32 0
  %tmp9 = getelementptr i32, i32* %t1308927845, i32 0
  %tmp10 = call i32 @test(i32* %tmp9)
  %tmp11 = getelementptr i32, i32* %t1308927845, i32 4
  %tmp12 = load i32, i32* %tmp11
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.fmt1, i64 0, i64 0), i32 %tmp12)
  %i1308927845 = alloca i1
  %tmp13 = icmp ne i32 1, 0
  store i1 %tmp13, i1* %i1308927845
  %tmp14 = load i1, i1* %i1308927845
  br i1 %tmp14, label %if_then4, label %if_else6
if_then4:
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.fmt2, i64 0, i64 0))
  br label %if_end5
if_else6:
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.fmt3, i64 0, i64 0))
  br label %if_end5
if_end5:
  ret void 
}



