; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 21 x i8 ] c"\0A Entrer le %deme:  \00"
@.fmt2 = global [ 3 x i8 ] c"%d\00"
@.fmt3 = global [ 13 x i8 ] c"\0A t[%d] = %d\00"


define void @main() {
  %tmp1 = alloca [10 x i32]
  %a292938459 = getelementptr [10 x i32], [10 x i32]* %tmp1, i64 0, i32 0
  %i292938459 = alloca i32
  %j292938459 = alloca i32
  store i32 0, i32* %i292938459
  br label %while_start1
while_start1:
  %tmp2 = load i32, i32* %i292938459
  %tmp3 = sub i32 10, %tmp2
  %tmp4 = icmp ne i32 %tmp3, 0
  br i1 %tmp4, label %while_do2, label %while_end3
while_do2:
  %tmp5 = load i32, i32* %i292938459
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.fmt1, i64 0, i64 0), i32 %tmp5)
  call i32 (i8* , ...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.fmt2, i64 0, i64 0), i32* %j292938459)
  %tmp6 = load i32, i32* %j292938459
  %tmp7 = load i32, i32* %i292938459
  %tmp8 = getelementptr i32, i32* %a292938459, i32 %tmp7
  store i32 %tmp6, i32* %tmp8
  %tmp9 = load i32, i32* %i292938459
  %tmp10 = add i32 %tmp9, 1
  store i32 %tmp10, i32* %i292938459
  br label %while_start1
while_end3:
  %tmp11 = getelementptr i32, i32* %a292938459, i32 0
  call void @naivesort(i32* %tmp11, i32 9)
  store i32 0, i32* %i292938459
  br label %while_start4
while_start4:
  %tmp12 = load i32, i32* %i292938459
  %tmp13 = sub i32 10, %tmp12
  %tmp14 = icmp ne i32 %tmp13, 0
  br i1 %tmp14, label %while_do5, label %while_end6
while_do5:
  %tmp15 = load i32, i32* %i292938459
  %tmp18 = load i32, i32* %i292938459
  %tmp16 = getelementptr i32, i32* %a292938459, i32 %tmp18
  %tmp17 = load i32, i32* %tmp16
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.fmt3, i64 0, i64 0), i32 %tmp15, i32 %tmp17)
  %tmp19 = load i32, i32* %i292938459
  %tmp20 = add i32 %tmp19, 1
  store i32 %tmp20, i32* %i292938459
  br label %while_start4
while_end6:
  ret void 
}


define void @naivesort(i32* %t1121172875, i32 %index11211728751) {
  %index1121172875 = alloca i32
  store i32 %index11211728751, i32* %index1121172875
  %max649734728 = alloca i32
  %maxpos649734728 = alloca i32
  %i649734728 = alloca i32
  %tmp21 = load i32, i32* %index1121172875
  %tmp22 = icmp ne i32 %tmp21, 0
  br i1 %tmp22, label %if_then7, label %if_end8
if_then7:
  %tmp25 = load i32, i32* %index1121172875
  %tmp23 = getelementptr i32, i32* %t1121172875, i32 %tmp25
  %tmp24 = load i32, i32* %tmp23
  store i32 %tmp24, i32* %max649734728
  %tmp26 = load i32, i32* %index1121172875
  store i32 %tmp26, i32* %i649734728
  %tmp27 = load i32, i32* %index1121172875
  store i32 %tmp27, i32* %maxpos649734728
  br label %while_start9
while_start9:
  %tmp28 = load i32, i32* %i649734728
  %tmp29 = add i32 %tmp28, 1
  %tmp30 = icmp ne i32 %tmp29, 0
  br i1 %tmp30, label %while_do10, label %while_end11
while_do10:
  %tmp33 = load i32, i32* %i649734728
  %tmp31 = getelementptr i32, i32* %t1121172875, i32 %tmp33
  %tmp32 = load i32, i32* %tmp31
  %tmp34 = load i32, i32* %max649734728
  %tmp35 = call i32 @plusgrandstrict(i32 %tmp32, i32 %tmp34)
  %tmp36 = icmp ne i32 %tmp35, 0
  br i1 %tmp36, label %if_then12, label %if_end13
if_then12:
  %tmp39 = load i32, i32* %i649734728
  %tmp37 = getelementptr i32, i32* %t1121172875, i32 %tmp39
  %tmp38 = load i32, i32* %tmp37
  store i32 %tmp38, i32* %max649734728
  %tmp40 = load i32, i32* %i649734728
  store i32 %tmp40, i32* %maxpos649734728
  br label %if_end13
if_end13:
  %tmp41 = load i32, i32* %i649734728
  %tmp42 = sub i32 %tmp41, 1
  store i32 %tmp42, i32* %i649734728
  br label %while_start9
while_end11:
  %tmp45 = load i32, i32* %index1121172875
  %tmp43 = getelementptr i32, i32* %t1121172875, i32 %tmp45
  %tmp44 = load i32, i32* %tmp43
  %tmp46 = load i32, i32* %maxpos649734728
  %tmp47 = getelementptr i32, i32* %t1121172875, i32 %tmp46
  store i32 %tmp44, i32* %tmp47
  %tmp48 = load i32, i32* %max649734728
  %tmp49 = load i32, i32* %index1121172875
  %tmp50 = getelementptr i32, i32* %t1121172875, i32 %tmp49
  store i32 %tmp48, i32* %tmp50
  %tmp51 = getelementptr i32, i32* %t1121172875, i32 0
  %tmp52 = load i32, i32* %index1121172875
  %tmp53 = sub i32 %tmp52, 1
  call void @naivesort(i32* %tmp51, i32 %tmp53)
  br label %if_end8
if_end8:
  ret void 
}


define i32 @plusgrandstrict(i32 %n14863710511, i32 %m14863710511) {
  %n1486371051 = alloca i32
  store i32 %n14863710511, i32* %n1486371051
  %m1486371051 = alloca i32
  store i32 %m14863710511, i32* %m1486371051
  %continue1121647253 = alloca i32
  %nn1121647253 = alloca i32
  %mm1121647253 = alloca i32
  %tmp54 = load i32, i32* %n1486371051
  %tmp55 = load i32, i32* %m1486371051
  %tmp56 = mul i32 %tmp54, %tmp55
  store i32 %tmp56, i32* %continue1121647253
  %tmp57 = load i32, i32* %n1486371051
  store i32 %tmp57, i32* %nn1121647253
  %tmp58 = load i32, i32* %m1486371051
  store i32 %tmp58, i32* %mm1121647253
  br label %while_start14
while_start14:
  %tmp59 = load i32, i32* %continue1121647253
  %tmp60 = icmp ne i32 %tmp59, 0
  br i1 %tmp60, label %while_do15, label %while_end16
while_do15:
  %tmp61 = load i32, i32* %mm1121647253
  %tmp62 = sub i32 %tmp61, 1
  store i32 %tmp62, i32* %mm1121647253
  %tmp63 = load i32, i32* %nn1121647253
  %tmp64 = sub i32 %tmp63, 1
  store i32 %tmp64, i32* %nn1121647253
  %tmp65 = load i32, i32* %nn1121647253
  %tmp66 = load i32, i32* %mm1121647253
  %tmp67 = mul i32 %tmp65, %tmp66
  store i32 %tmp67, i32* %continue1121647253
  br label %while_start14
while_end16:
  %tmp68 = load i32, i32* %nn1121647253
  %tmp69 = icmp ne i32 %tmp68, 0
  br i1 %tmp69, label %if_then17, label %if_else19
if_then17:
  ret i32 1
  br label %if_end18
if_else19:
  ret i32 0
  br label %if_end18
if_end18:
  ret i32  0
}



