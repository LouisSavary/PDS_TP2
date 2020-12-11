; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)

; Actual code begins



define i32 @main() {
  %tmp1 = icmp ne i32 1, 0
  br i1 %tmp1, label %if_then1, label %if_else3
if_then1:
  ret i32 1
  br label %if_end2
if_else3:
  ret i32 0
  br label %if_end2
if_end2:
  ret i32  0
}

