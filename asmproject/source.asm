.386p
.model flat,c
.code
extern buf:byte
extern N:dword
extern M:dword
extern level:dword
extern flag:dword
extern in_name:byte    ;传递c程序中的变量
public cal_all
public solve       ;声明函数可供c程序调用
cal_all proc
		mov esi, N
calculate:
		lea ebx, buf
		mov eax, N
		sub eax, esi
		mov edx, M
		mul edx
		add ebx, eax
		add ebx, 10d    ;ebx此时指向学生成绩的首地址

		mov ecx, 0
		mov edx, 0
		;为了防止溢出，下面把成绩表达式拆成3项运算，并先算除法再算乘法，最后将3部分成绩相加

		mov eax, 0
		mov al, [ebx]
		mov dl, 7
		div dl
		mov ch, ah    ;ch暂存余数
		mov dl, 4
		mul dl
		add cl, al
		mov al, ch
		mul dl
		mov dl, 7
		div dl
		add cl, al   ;将第一项的成绩累加到cl
		add dh, ah   ;将第一项的余数累加到dh

		mov eax, 0
		mov al, [ebx + 1]
		add al, al
		mov dl, 7
		div dl
		add cl, al    ;将第二项的成绩累加到cl
		add dh, ah    ;将第二项的余数累加的dh

		mov eax, 0
		mov al, [ebx + 2]
		mov dl, 7
		div dl
		add cl, al   ;将第二项的成绩累加到cl
		add dh, ah   ;将第二项的余数累加的dh

		mov eax, 0
		mov al, dh
		mov dl, 7
		div dl
		add cl, al   ;dh寄存的是三项的余数和，还需要判断是否进位到cl

		mov byte ptr[ebx + 3], cl   ;cl是计算出的成绩，存在指定处

		dec esi
		jnz calculate
		ret
cal_all endp

solve proc
		lea edi, in_name
		mov ecx, N
outlp:
		lea ebx, buf
		mov eax, N
		sub eax, ecx
		mov edx, M
		mul edx
		add ebx, eax    ;ebx指向当前学生名字首地址
		mov eax, 10d
		dec ecx
		jl nofind
		mov esi, 0
inlp:
		mov dl, [ebx + esi]
		mov dh, [edi + esi] 
		cmp dl, '0'
		jz compar
		cmp dl, dh
		jnz outlp    ;比较in_name中的字符和buf中的字符，判断名字能否找到
		inc esi
		dec eax
		jnz inlp
nofind:
		mov flag, 1   ;flag=1表示没有找到
		jmp quit
compar:
		add ebx, 10d
		mov cl, [ebx + 3]

		cmp cl, 90
		jae levelA

		cmp cl, 80
		jae levelB

		cmp cl, 70
		jae levelC

		cmp cl, 60
		jae levelD

		cmp cl, 60
		jl  levelF

		mov byte ptr [ebx + 3], cl

levelA:
		mov level, 1
		jmp quit
levelB :
		mov level, 2
		jmp quit
levelC :
		mov level, 3
		jmp quit
levelD :
		mov level, 4
		jmp quit
levelF :
		mov	level, 5
		jmp quit
quit:
		ret
solve endp
end
