datarea segment
    string1 db 'move the cursor backward.'
    string2 db 'move the cursor backward.'
    mess1 db 'Match',13,10,'$'
    mess2 db 'No match!',13,10,'$'
datarea ends
program segment 
main proc far 
    assume cs:program, ds:datarea, es:datarea
start:
    push ds
   sub ax,ax
   push ax
   mov ax,datarea
mov ds,ax
mov es,ax
lea si,string1
lea si,string2
cld ;将标志寄存器Flag的方向标志位DF清零。
mov cx,25
repz cmpsb ;在字串操作中使变址寄存器SI或DI的地址指针自动增加，字串处理由前往后。 
jz match
lea dx,mess2
jmp short disp
match:
lea dx,mess1
disp:
mov ah,09
int 21h ;21h是一个中断号，表示中断调试。
ret 
main endp
program ends
end start

	