; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)

; Actual code begins



define i32 @main() {
  %tmp1 = mul i32 5, 6
  %tmp2 = add i32 %tmp1, 4
  ret i32 %tmp2
}

