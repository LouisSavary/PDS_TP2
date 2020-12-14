; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 31 x i8 ] c"Main: Tableau de taille %d = [\00"
@.fmt2 = global [ 2 x i8 ] c",\00"
@.fmt3 = global [ 3 x i8 ] c"%d\00"
@.fmt4 = global [ 3 x i8 ] c"]\0A\00"
@.fmt5 = global [ 5 x i8 ] c"Fini\00"
@.fmt6 = global [ 15 x i8 ] c"entrezno :%d  \00"
@.fmt7 = global [ 3 x i8 ] c"%d\00"
@.fmt8 = global [ 25 x i8 ] c"Tableau de taille %d = [\00"
@.fmt9 = global [ 2 x i8 ] c",\00"
@.fmt10 = global [ 3 x i8 ] c"%d\00"
@.fmt11 = global [ 3 x i8 ] c"]\0A\00"


define void @main() {
  %i292938459 = alloca i32
  %s292938459 = alloca i32
  %tmp1 = alloca [2 x i32]
  %t292938459 = getelementptr [2 x i32], [2 x i32]* %tmp1, i64 0, i32 0
  store i32 2, i32* %s292938459
  %tmp2 = load i32, i32* %s292938459
  %tmp3 = getelementptr i32, i32* %t292938459, i32 0
  call void @readprinttab1694819250(i32 %tmp2, i32* %tmp3)
  %tmp4 = load i32, i32* %s292938459
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.fmt1, i64 0, i64 0), i32 %tmp4)
  store i32 0, i32* %i292938459
  br label %while_start1
while_start1:
  %tmp5 = load i32, i32* %s292938459
  %tmp6 = load i32, i32* %i292938459
  %tmp7 = sub i32 %tmp5, %tmp6
  %tmp8 = icmp ne i32 %tmp7, 0
  br i1 %tmp8, label %while_do2, label %while_end3
while_do2:
  %tmp9 = load i32, i32* %i292938459
  %tmp10 = icmp ne i32 %tmp9, 0
  br i1 %tmp10, label %if_then4, label %if_end5
if_then4:
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.fmt2, i64 0, i64 0))
  br label %if_end5
if_end5:
  %tmp13 = load i32, i32* %i292938459
  %tmp11 = getelementptr i32, i32* %t292938459, i32 %tmp13
  %tmp12 = load i32, i32* %tmp11
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.fmt3, i64 0, i64 0), i32 %tmp12)
  %tmp14 = load i32, i32* %i292938459
  %tmp15 = add i32 %tmp14, 1
  store i32 %tmp15, i32* %i292938459
  br label %while_start1
while_end3:
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.fmt4, i64 0, i64 0))
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.fmt5, i64 0, i64 0))
  ret void 
}


define void @readprinttab(i32 %size9400600041, i32* %t940060004) {
  %size940060004 = alloca i32
  store i32 %size9400600041, i32* %size940060004
  %i234698513 = alloca i32
  store i32 0, i32* %i234698513
  br label %while_start6
while_start6:
  %tmp16 = load i32, i32* %size940060004
  %tmp17 = load i32, i32* %i234698513
  %tmp18 = sub i32 %tmp16, %tmp17
  %tmp19 = icmp ne i32 %tmp18, 0
  br i1 %tmp19, label %while_do7, label %while_end8
while_do7:
  %tmp20 = load i32, i32* %i234698513
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.fmt6, i64 0, i64 0), i32 %tmp20)
  %tmp22 = load i32, i32* %i234698513
  %tmp21 = getelementptr i32, i32* %t940060004, i32 %tmp22
  call i32 (i8* , ...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.fmt7, i64 0, i64 0), i32* %tmp21)
  %tmp23 = load i32, i32* %i234698513
  %tmp24 = add i32 %tmp23, 1
  store i32 %tmp24, i32* %i234698513
  br label %while_start6
while_end8:
  %tmp25 = load i32, i32* %size940060004
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.fmt8, i64 0, i64 0), i32 %tmp25)
  store i32 0, i32* %i234698513
  br label %while_start9
while_start9:
  %tmp26 = load i32, i32* %size940060004
  %tmp27 = load i32, i32* %i234698513
  %tmp28 = sub i32 %tmp26, %tmp27
  %tmp29 = icmp ne i32 %tmp28, 0
  br i1 %tmp29, label %while_do10, label %while_end11
while_do10:
  %tmp30 = load i32, i32* %i234698513
  %tmp31 = icmp ne i32 %tmp30, 0
  br i1 %tmp31, label %if_then12, label %if_end13
if_then12:
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.fmt9, i64 0, i64 0))
  br label %if_end13
if_end13:
  %tmp34 = load i32, i32* %i234698513
  %tmp32 = getelementptr i32, i32* %t940060004, i32 %tmp34
  %tmp33 = load i32, i32* %tmp32
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.fmt10, i64 0, i64 0), i32 %tmp33)
  %tmp35 = load i32, i32* %i234698513
  %tmp36 = add i32 %tmp35, 1
  store i32 %tmp36, i32* %i234698513
  br label %while_start9
while_end11:
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.fmt11, i64 0, i64 0))
  ret void 
}



