; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)

; Actual code begins



define i32 @main() {
%tmp1 = urem i32 8, 4
%tmp2 = urem i32 9, 6
%tmp3 = add i32 %tmp1, %tmp2
ret i32 %tmp3
}

