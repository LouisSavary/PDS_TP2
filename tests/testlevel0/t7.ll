; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)

; Actual code begins



define i32 @main() {
  %assigned = alloca i32
  %tmp1 = add i32 6, 4
  %tmp2 = mul i32 %tmp1, 3
  store i32 %tmp2, i32* %assigned
  %tmp3 = icmp ne i32 1, 0
  br i1 %tmp3, label %if_then1, label %if_else3
if_then1:
  store i32 0, i32* %assigned
  br label %if_end2
if_else3:
  store i32 1, i32* %assigned
  br label %if_end2
if_end2:
  ret i32 %assigned
}

