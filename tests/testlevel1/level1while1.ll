; Target
target triple = "x86_64-unknown-linux-gnu"
; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)
declare i32 @scanf(i8* noalias nocapture, ...)

; Actual code begins



define i32 @main() {
while_start1:
br i1 1, label %while_do2, label %while_end3
while_do2:
ret i32 0
br label %while_start1
while_end3:
ret i32  0
}

