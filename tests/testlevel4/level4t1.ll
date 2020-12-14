; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 19 x i8 ] c"Et voila: %d%d%d%d\00"


define void @main() {
  %i1651191114 = alloca i32
  %j1651191114 = alloca i32
  %k1651191114 = alloca i32
  %l1651191114 = alloca i32
  store i32 0, i32* %i1651191114
  store i32 0, i32* %j1651191114
  store i32 0, i32* %k1651191114
  store i32 0, i32* %l1651191114
  %i205125520 = alloca i32
  %j205125520 = alloca i32
  %k205125520 = alloca i32
  store i32 1, i32* %l1651191114
  %i1911006827 = alloca i32
  %j1911006827 = alloca i32
  store i32 2, i32* %k205125520
  %i717356484 = alloca i32
  store i32 3, i32* %j1911006827
  %tmp1 = load i32, i32* %i1651191114
  %tmp2 = load i32, i32* %j1651191114
  %tmp3 = load i32, i32* %k1651191114
  %tmp4 = load i32, i32* %l1651191114
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.fmt1, i64 0, i64 0), i32 %tmp1, i32 %tmp2, i32 %tmp3, i32 %tmp4)
  ret void 
}



