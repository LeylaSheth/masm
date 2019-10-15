.386p
.model flat,c
.code
extern buf:byte
extern N:dword
extern M:dword
extern level:dword
extern flag:dword
extern in_name:byte    ;����c�����еı���
public cal_all
public solve       ;���������ɹ�c�������
cal_all proc
		mov esi, N
calculate:
		lea ebx, buf
		mov eax, N
		sub eax, esi
		mov edx, M
		mul edx
		add ebx, eax
		add ebx, 10d    ;ebx��ʱָ��ѧ���ɼ����׵�ַ

		mov ecx, 0
		mov edx, 0
		;Ϊ�˷�ֹ���������ѳɼ����ʽ���3�����㣬�������������˷������3���ֳɼ����

		mov eax, 0
		mov al, [ebx]
		mov dl, 7
		div dl
		mov ch, ah    ;ch�ݴ�����
		mov dl, 4
		mul dl
		add cl, al
		mov al, ch
		mul dl
		mov dl, 7
		div dl
		add cl, al   ;����һ��ĳɼ��ۼӵ�cl
		add dh, ah   ;����һ��������ۼӵ�dh

		mov eax, 0
		mov al, [ebx + 1]
		add al, al
		mov dl, 7
		div dl
		add cl, al    ;���ڶ���ĳɼ��ۼӵ�cl
		add dh, ah    ;���ڶ���������ۼӵ�dh

		mov eax, 0
		mov al, [ebx + 2]
		mov dl, 7
		div dl
		add cl, al   ;���ڶ���ĳɼ��ۼӵ�cl
		add dh, ah   ;���ڶ���������ۼӵ�dh

		mov eax, 0
		mov al, dh
		mov dl, 7
		div dl
		add cl, al   ;dh�Ĵ��������������ͣ�����Ҫ�ж��Ƿ��λ��cl

		mov byte ptr[ebx + 3], cl   ;cl�Ǽ�����ĳɼ�������ָ����

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
		add ebx, eax    ;ebxָ��ǰѧ�������׵�ַ
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
		jnz outlp    ;�Ƚ�in_name�е��ַ���buf�е��ַ����ж������ܷ��ҵ�
		inc esi
		dec eax
		jnz inlp
nofind:
		mov flag, 1   ;flag=1��ʾû���ҵ�
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
