; Mouse interrupt call procedure for QBasic.
push bp           ; Save previous bp.
mov bp,sp         ; Set new bp.
push si           ; Save si.
mov si,[bp+6]     ; Load registers structure offset. 
mov ax,[si]       ; Load values into CPU registers.
mov cx,[si+2]     ;
mov dx,[si+4]     ; 
mov bx,[si+6]     ; 
int 0x33          ; Call mouse interrupt.
mov [si],ax       ; Save CPU registers to structure.
mov [si+2],cx     ; 
mov [si+4],dx     ; 
mov [si+6],bx     ; 
pop si            ; Restore si.
pop bp            ; Restore bp.
retf 2            ; Return and remove arguments from stack.
