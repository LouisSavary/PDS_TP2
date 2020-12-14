; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 26 x i8 ] c"\0A Hanoi avec %d disques\0A\0A\00"
@.fmt2 = global [ 26 x i8 ] c"\0A\0AHanoi avec %d disques\0A\0A\00"
@.fmt3 = global [ 31 x i8 ] c"Deplacer un disque de %d a %d\0A\00"


define void @main() {
  %ndisque1579572132 = alloca i32
  %a1579572132 = alloca i32
  store i32 3, i32* %ndisque1579572132
  %tmp1 = load i32, i32* %ndisque1579572132
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.fmt1, i64 0, i64 0), i32 %tmp1)
  %tmp2 = load i32, i32* %ndisque1579572132
  %tmp3 = call i32 @hanoi(i32 %tmp2, i32 1, i32 3, i32 2)
  store i32 %tmp3, i32* %a1579572132
  store i32 4, i32* %ndisque1579572132
  %tmp4 = load i32, i32* %ndisque1579572132
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.fmt2, i64 0, i64 0), i32 %tmp4)
  %tmp5 = load i32, i32* %ndisque1579572132
  %tmp6 = call i32 @hanoi(i32 %tmp5, i32 1, i32 3, i32 2)
  store i32 %tmp6, i32* %a1579572132
  ret void 
}


define i32 @hanoi(i32 %n13089278451, i32 %delatour13089278451, i32 %alatour13089278451, i32 %parlatour13089278451) {
  %n1308927845 = alloca i32
  store i32 %n13089278451, i32* %n1308927845
  %delatour1308927845 = alloca i32
  store i32 %delatour13089278451, i32* %delatour1308927845
  %alatour1308927845 = alloca i32
  store i32 %alatour13089278451, i32* %alatour1308927845
  %parlatour1308927845 = alloca i32
  store i32 %parlatour13089278451, i32* %parlatour1308927845
  %b2017354584 = alloca i32
  %tmp7 = load i32, i32* %n1308927845
  %tmp8 = icmp ne i32 %tmp7, 0
  br i1 %tmp8, label %if_then1, label %if_end2
if_then1:
  %tmp9 = load i32, i32* %n1308927845
  %tmp10 = sub i32 %tmp9, 1
  %tmp11 = load i32, i32* %delatour1308927845
  %tmp12 = load i32, i32* %parlatour1308927845
  %tmp13 = load i32, i32* %alatour1308927845
  %tmp14 = call i32 @hanoi(i32 %tmp10, i32 %tmp11, i32 %tmp12, i32 %tmp13)
  store i32 %tmp14, i32* %b2017354584
  %tmp15 = load i32, i32* %delatour1308927845
  %tmp16 = load i32, i32* %alatour1308927845
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.fmt3, i64 0, i64 0), i32 %tmp15, i32 %tmp16)
  %tmp17 = load i32, i32* %n1308927845
  %tmp18 = sub i32 %tmp17, 1
  %tmp19 = load i32, i32* %parlatour1308927845
  %tmp20 = load i32, i32* %alatour1308927845
  %tmp21 = load i32, i32* %delatour1308927845
  %tmp22 = call i32 @hanoi(i32 %tmp18, i32 %tmp19, i32 %tmp20, i32 %tmp21)
  store i32 %tmp22, i32* %b2017354584
  br label %if_end2
if_end2:
  ret i32 1
  ret i32  0
}



