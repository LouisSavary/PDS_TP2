; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 3 x i8 ] c"%d\00"
@.fmt2 = global [ 25 x i8 ] c"Tableau de taille %d = [\00"
@.fmt3 = global [ 2 x i8 ] c",\00"
@.fmt4 = global [ 3 x i8 ] c"%d\00"
@.fmt5 = global [ 3 x i8 ] c"]\0A\00"


define void @main() {
  %i292938459 = alloca i32
  %tmp1 = alloca [8 x i32]
  %t292938459 = getelementptr [8 x i32], [8 x i32]* %tmp1, i64 0, i32 0
  %x292938459 = alloca i32
  store i32 0, i32* %i292938459
  br label %while_start1
while_start1:
  %tmp2 = load i32, i32* %i292938459
  %tmp3 = sub i32 8, %tmp2
  %tmp4 = icmp ne i32 %tmp3, 0
  br i1 %tmp4, label %while_do2, label %while_end3
while_do2:
  call i32 (i8* , ...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.fmt1, i64 0, i64 0), i32* %x292938459)
  %tmp5 = load i32, i32* %x292938459
  %tmp6 = load i32, i32* %i292938459
  %tmp7 = getelementptr i32, i32* %t292938459, i32 %tmp6
  store i32 %tmp5, i32* %tmp7
  %tmp8 = load i32, i32* %i292938459
  %tmp9 = add i32 %tmp8, 1
  store i32 %tmp9, i32* %i292938459
  br label %while_start1
while_end3:
  %tmp10 = getelementptr i32, i32* %t292938459, i32 0
  call void @printtab1694819250(i32 8, i32* %tmp10)
  ret void 
}


define void @printtab(i32 %size18097870671, i32* %t1809787067) {
  %size1809787067 = alloca i32
  store i32 %size18097870671, i32* %size1809787067
  %i1802598046 = alloca i32
  %tmp11 = load i32, i32* %size1809787067
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.fmt2, i64 0, i64 0), i32 %tmp11)
  store i32 0, i32* %i1802598046
  br label %while_start4
while_start4:
  %tmp12 = load i32, i32* %size1809787067
  %tmp13 = load i32, i32* %i1802598046
  %tmp14 = sub i32 %tmp12, %tmp13
  %tmp15 = icmp ne i32 %tmp14, 0
  br i1 %tmp15, label %while_do5, label %while_end6
while_do5:
  %tmp16 = load i32, i32* %i1802598046
  %tmp17 = icmp ne i32 %tmp16, 0
  br i1 %tmp17, label %if_then7, label %if_end8
if_then7:
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.fmt3, i64 0, i64 0))
  br label %if_end8
if_end8:
  %tmp20 = load i32, i32* %i1802598046
  %tmp18 = getelementptr i32, i32* %t1809787067, i32 %tmp20
  %tmp19 = load i32, i32* %tmp18
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.fmt4, i64 0, i64 0), i32 %tmp19)
  %tmp21 = load i32, i32* %i1802598046
  %tmp22 = add i32 %tmp21, 1
  store i32 %tmp22, i32* %i1802598046
  br label %while_start4
while_end6:
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.fmt5, i64 0, i64 0))
  ret void 
}



