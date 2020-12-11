; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins



define void @main() {
   call void (i32,i32)  @compare(i32 2, i32 1)
   call void (i32,i32)  @compare(i32 1, i32 2)
   call void (i32,i32)  @compare(i32 1, i32 1)
  ret void 
}
define void @compare(i32 %x1, i32 %y1) {
  %x = alloca i32
  store i32 %x1, i32* %x
  %y = alloca i32
  store i32 %y1, i32* %y
  %tmp1 = load i32, i32* %x
  %tmp2 = load i32, i32* %y
  %tmp3 = sub i32 %tmp1, %tmp2
  %tmp4 = icmp ne i32 %tmp3, 0
  br i1 %tmp4, label %if_then1, label %if_else3
if_then1:
  @.fmt1 = global [ 24 x i8 ] c"%d est different de %d\0A\00"
%tmp5 = load i32, i32* %x
%tmp6 = load i32, i32* %y
call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.fmt1, i64 0, i64 0), i32 %tmp5, i32 %tmp6)
  br label %if_end2
if_else3:
  @.fmt2 = global [ 18 x i8 ] c"%d est egal a %d\0A\00"
%tmp7 = load i32, i32* %x
%tmp8 = load i32, i32* %y
call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.fmt2, i64 0, i64 0), i32 %tmp7, i32 %tmp8)
  br label %if_end2
if_end2:
  ret void 
}

