; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)

; Actual code begins



define i32 @main() {
  %tmp1 = add i32 6, 4
  %tmp2 = mul i32 5, %tmp1
  ret i32 %tmp2
}

