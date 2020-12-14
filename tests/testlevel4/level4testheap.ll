; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins

@.fmt1 = global [ 20 x i8 ] c"\0A Entrer le%deme:  \00"
@.fmt2 = global [ 3 x i8 ] c"%d\00"
@.fmt3 = global [ 14 x i8 ] c"   i=%d  j=%d\00"
@.fmt4 = global [ 13 x i8 ] c"\0A t[%d] = %d\00"


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
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.fmt1, i64 0, i64 0), i32 %tmp5)
  call i32 (i8* , ...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.fmt2, i64 0, i64 0), i32* %j292938459)
  %tmp6 = load i32, i32* %j292938459
  %tmp7 = load i32, i32* %i292938459
  %tmp8 = getelementptr i32, i32* %a292938459, i32 %tmp7
  store i32 %tmp6, i32* %tmp8
  %tmp9 = load i32, i32* %i292938459
  %tmp10 = add i32 %tmp9, 1
  store i32 %tmp10, i32* %i292938459
  %tmp11 = load i32, i32* %i292938459
  %tmp12 = load i32, i32* %j292938459
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.fmt3, i64 0, i64 0), i32 %tmp11, i32 %tmp12)
  br label %while_start1
while_end3:
  %tmp13 = getelementptr i32, i32* %a292938459, i32 0
  call void @heapsort(i32* %tmp13, i32 10)
  store i32 0, i32* %i292938459
  br label %while_start4
while_start4:
  %tmp14 = load i32, i32* %i292938459
  %tmp15 = sub i32 10, %tmp14
  %tmp16 = icmp ne i32 %tmp15, 0
  br i1 %tmp16, label %while_do5, label %while_end6
while_do5:
  %tmp17 = load i32, i32* %i292938459
  %tmp20 = load i32, i32* %i292938459
  %tmp18 = getelementptr i32, i32* %a292938459, i32 %tmp20
  %tmp19 = load i32, i32* %tmp18
  call i32 (i8* , ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.fmt4, i64 0, i64 0), i32 %tmp17, i32 %tmp19)
  %tmp21 = load i32, i32* %i292938459
  %tmp22 = add i32 %tmp21, 1
  store i32 %tmp22, i32* %i292938459
  br label %while_start4
while_end6:
  ret void 
}


define void @heapsort(i32* %t1121172875, i32 %n11211728751) {
  %n1121172875 = alloca i32
  store i32 %n11211728751, i32* %n1121172875
  %l649734728 = alloca i32
  %r649734728 = alloca i32
  %j649734728 = alloca i32
  %s649734728 = alloca i32
  %test649734728 = alloca i32
  %tmp23 = load i32, i32* %n1121172875
  %tmp24 = udiv i32 %tmp23, 2
  %tmp25 = add i32 %tmp24, 1
  store i32 %tmp25, i32* %l649734728
  %tmp26 = load i32, i32* %n1121172875
  store i32 %tmp26, i32* %r649734728
  br label %while_start7
while_start7:
  %tmp27 = load i32, i32* %r649734728
  %tmp28 = call i32 @plusgrand(i32 %tmp27, i32 2)
  %tmp29 = icmp ne i32 %tmp28, 0
  br i1 %tmp29, label %while_do8, label %while_end9
while_do8:
  %tmp30 = load i32, i32* %l649734728
  %tmp31 = call i32 @plusgrandstrict(i32 %tmp30, i32 1)
  %tmp32 = icmp ne i32 %tmp31, 0
  br i1 %tmp32, label %if_then10, label %if_else12
if_then10:
  %tmp33 = load i32, i32* %l649734728
  %tmp34 = sub i32 %tmp33, 1
  store i32 %tmp34, i32* %l649734728
  %tmp35 = load i32, i32* %l649734728
  store i32 %tmp35, i32* %j649734728
  br label %if_end11
if_else12:
  %ex32017212 = alloca i32
  %tmp36 = getelementptr i32, i32* %t1121172875, i32 0
  %tmp37 = load i32, i32* %tmp36
  store i32 %tmp37, i32* %ex32017212
  %tmp40 = load i32, i32* %r649734728
  %tmp41 = sub i32 %tmp40, 1
  %tmp38 = getelementptr i32, i32* %t1121172875, i32 %tmp41
  %tmp39 = load i32, i32* %tmp38
  %tmp42 = getelementptr i32, i32* %t1121172875, i32 0
  store i32 %tmp39, i32* %tmp42
  %tmp43 = load i32, i32* %ex32017212
  %tmp44 = load i32, i32* %r649734728
  %tmp45 = sub i32 %tmp44, 1
  %tmp46 = getelementptr i32, i32* %t1121172875, i32 %tmp45
  store i32 %tmp43, i32* %tmp46
  %tmp47 = load i32, i32* %r649734728
  %tmp48 = sub i32 %tmp47, 1
  store i32 %tmp48, i32* %r649734728
  store i32 1, i32* %j649734728
  br label %if_end11
if_end11:
  %tmp51 = load i32, i32* %j649734728
  %tmp52 = sub i32 %tmp51, 1
  %tmp49 = getelementptr i32, i32* %t1121172875, i32 %tmp52
  %tmp50 = load i32, i32* %tmp49
  store i32 %tmp50, i32* %s649734728
  %tmp53 = load i32, i32* %r649734728
  %tmp54 = load i32, i32* %j649734728
  %tmp55 = mul i32 2, %tmp54
  %tmp56 = call i32 @plusgrand(i32 %tmp53, i32 %tmp55)
  store i32 %tmp56, i32* %test649734728
  br label %while_start13
while_start13:
  %tmp57 = load i32, i32* %test649734728
  %tmp58 = icmp ne i32 %tmp57, 0
  br i1 %tmp58, label %while_do14, label %while_end15
while_do14:
  %k555826066 = alloca i32
  %tmp59 = load i32, i32* %j649734728
  %tmp60 = mul i32 2, %tmp59
  store i32 %tmp60, i32* %k555826066
  %tmp61 = load i32, i32* %r649734728
  %tmp62 = load i32, i32* %k555826066
  %tmp63 = call i32 @plusgrandstrict(i32 %tmp61, i32 %tmp62)
  %tmp66 = load i32, i32* %k555826066
  %tmp64 = getelementptr i32, i32* %t1121172875, i32 %tmp66
  %tmp65 = load i32, i32* %tmp64
  %tmp69 = load i32, i32* %k555826066
  %tmp70 = sub i32 %tmp69, 1
  %tmp67 = getelementptr i32, i32* %t1121172875, i32 %tmp70
  %tmp68 = load i32, i32* %tmp67
  %tmp71 = call i32 @plusgrandstrict(i32 %tmp65, i32 %tmp68)
  %tmp72 = mul i32 %tmp63, %tmp71
  %tmp73 = icmp ne i32 %tmp72, 0
  br i1 %tmp73, label %if_then16, label %if_end17
if_then16:
  %tmp74 = load i32, i32* %k555826066
  %tmp75 = add i32 %tmp74, 1
  store i32 %tmp75, i32* %k555826066
  br label %if_end17
if_end17:
  %tmp78 = load i32, i32* %k555826066
  %tmp79 = sub i32 %tmp78, 1
  %tmp76 = getelementptr i32, i32* %t1121172875, i32 %tmp79
  %tmp77 = load i32, i32* %tmp76
  %tmp80 = load i32, i32* %s649734728
  %tmp81 = call i32 @plusgrandstrict(i32 %tmp77, i32 %tmp80)
  %tmp82 = icmp ne i32 %tmp81, 0
  br i1 %tmp82, label %if_then18, label %if_else20
if_then18:
  %tmp85 = load i32, i32* %k555826066
  %tmp86 = sub i32 %tmp85, 1
  %tmp83 = getelementptr i32, i32* %t1121172875, i32 %tmp86
  %tmp84 = load i32, i32* %tmp83
  %tmp87 = load i32, i32* %j649734728
  %tmp88 = sub i32 %tmp87, 1
  %tmp89 = getelementptr i32, i32* %t1121172875, i32 %tmp88
  store i32 %tmp84, i32* %tmp89
  %tmp90 = load i32, i32* %k555826066
  store i32 %tmp90, i32* %j649734728
  %tmp91 = load i32, i32* %r649734728
  %tmp92 = load i32, i32* %j649734728
  %tmp93 = mul i32 2, %tmp92
  %tmp94 = call i32 @plusgrand(i32 %tmp91, i32 %tmp93)
  store i32 %tmp94, i32* %test649734728
  br label %if_end19
if_else20:
  store i32 0, i32* %test649734728
  br label %if_end19
if_end19:
  br label %while_start13
while_end15:
  %tmp95 = load i32, i32* %s649734728
  %tmp96 = load i32, i32* %j649734728
  %tmp97 = sub i32 %tmp96, 1
  %tmp98 = getelementptr i32, i32* %t1121172875, i32 %tmp97
  store i32 %tmp95, i32* %tmp98
  br label %while_start7
while_end9:
  ret void 
}


define i32 @plusgrandstrict(i32 %n1832845701, i32 %m1832845701) {
  %n183284570 = alloca i32
  store i32 %n1832845701, i32* %n183284570
  %m183284570 = alloca i32
  store i32 %m1832845701, i32* %m183284570
  %continue1607305514 = alloca i32
  %nn1607305514 = alloca i32
  %mm1607305514 = alloca i32
  %tmp99 = load i32, i32* %n183284570
  %tmp100 = load i32, i32* %m183284570
  %tmp101 = mul i32 %tmp99, %tmp100
  store i32 %tmp101, i32* %continue1607305514
  %tmp102 = load i32, i32* %n183284570
  store i32 %tmp102, i32* %nn1607305514
  %tmp103 = load i32, i32* %m183284570
  store i32 %tmp103, i32* %mm1607305514
  br label %while_start21
while_start21:
  %tmp104 = load i32, i32* %continue1607305514
  %tmp105 = icmp ne i32 %tmp104, 0
  br i1 %tmp105, label %while_do22, label %while_end23
while_do22:
  %tmp106 = load i32, i32* %mm1607305514
  %tmp107 = sub i32 %tmp106, 1
  store i32 %tmp107, i32* %mm1607305514
  %tmp108 = load i32, i32* %nn1607305514
  %tmp109 = sub i32 %tmp108, 1
  store i32 %tmp109, i32* %nn1607305514
  %tmp110 = load i32, i32* %nn1607305514
  %tmp111 = load i32, i32* %mm1607305514
  %tmp112 = mul i32 %tmp110, %tmp111
  store i32 %tmp112, i32* %continue1607305514
  br label %while_start21
while_end23:
  %tmp113 = load i32, i32* %nn1607305514
  %tmp114 = icmp ne i32 %tmp113, 0
  br i1 %tmp114, label %if_then24, label %if_else26
if_then24:
  ret i32 1
  br label %if_end25
if_else26:
  ret i32 0
  br label %if_end25
if_end25:
  ret i32  0
}


define i32 @plusgrand(i32 %n1463053491, i32 %m1463053491) {
  %n146305349 = alloca i32
  store i32 %n1463053491, i32* %n146305349
  %m146305349 = alloca i32
  store i32 %m1463053491, i32* %m146305349
  %continue1686369710 = alloca i32
  %nn1686369710 = alloca i32
  %mm1686369710 = alloca i32
  %tmp115 = load i32, i32* %n146305349
  %tmp116 = load i32, i32* %m146305349
  %tmp117 = mul i32 %tmp115, %tmp116
  store i32 %tmp117, i32* %continue1686369710
  %tmp118 = load i32, i32* %n146305349
  store i32 %tmp118, i32* %nn1686369710
  %tmp119 = load i32, i32* %m146305349
  store i32 %tmp119, i32* %mm1686369710
  br label %while_start27
while_start27:
  %tmp120 = load i32, i32* %continue1686369710
  %tmp121 = icmp ne i32 %tmp120, 0
  br i1 %tmp121, label %while_do28, label %while_end29
while_do28:
  %tmp122 = load i32, i32* %mm1686369710
  %tmp123 = sub i32 %tmp122, 1
  store i32 %tmp123, i32* %mm1686369710
  %tmp124 = load i32, i32* %nn1686369710
  %tmp125 = sub i32 %tmp124, 1
  store i32 %tmp125, i32* %nn1686369710
  %tmp126 = load i32, i32* %nn1686369710
  %tmp127 = load i32, i32* %mm1686369710
  %tmp128 = mul i32 %tmp126, %tmp127
  store i32 %tmp128, i32* %continue1686369710
  br label %while_start27
while_end29:
  %tmp129 = load i32, i32* %nn1686369710
  %tmp130 = icmp ne i32 %tmp129, 0
  br i1 %tmp130, label %if_then30, label %if_else32
if_then30:
  ret i32 1
  br label %if_end31
if_else32:
  %tmp131 = load i32, i32* %mm1686369710
  %tmp132 = icmp ne i32 %tmp131, 0
  br i1 %tmp132, label %if_then33, label %if_else35
if_then33:
  ret i32 0
  br label %if_end34
if_else35:
  ret i32 1
  br label %if_end34
if_end34:
  br label %if_end31
if_end31:
  ret i32  0
}



