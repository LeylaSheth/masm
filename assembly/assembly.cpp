// assembly.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。
//

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct student
{
	char name[12];
	short score[4];
};
int main()
{
	struct student info[3];
	char na[12];
	int i, j;
	char op;

	strcpy_s(info[0].name, "zhangsan");
	info[0].score[0] = 98;
	info[0].score[1] = 89;
	info[0].score[2] = 78;
	info[0].score[3] = 0;

	strcpy_s(info[1].name, "lisi");
	info[1].score[0] = 78;
	info[1].score[1] = 66;
	info[1].score[2] = 55;
	info[1].score[3] = 0;

	strcpy_s(info[2].name, "wangwu");
	info[2].score[0] = 85;
	info[2].score[1] = 86;
	info[2].score[2] = 87;
	info[2].score[3] = 0;
	do
	{
		printf("Type in the name of the student: ");
		scanf_s("%s", na, 10);
		getchar();
		_asm
		{
			mov	ecx, 3
			lea	edi, info[0]
			LI:			lea esi, na
						mov edx, 12
						LJ : mov al, byte ptr[esi]
							 mov bl, byte ptr[edi]
							 cmp al, bl
							 jnz NEXT
							 cmp al, '\0'
							 jz	OPR
							 dec edx
							 inc	edi
							 inc	esi
							 jmp	LJ
							 NEXT : dec	ecx
									jz	NTFOUND
									add	edx, 8
									add	edi, edx
									jmp LI
									OPR : add edi, edx
										  mov	al, byte ptr[edi]
										  mov ah, 0
										  add	ax, ax
										  add   ax, ax
										  mov	dl, byte ptr[edi + 2]
										  mov	dh, 0
										  add ax, dx
										  add ax, dx
										  mov	dl, byte ptr[edi + 4]
										  mov dh, 0
										  add ax, dx
										  mov	bl, 7
										  div bl
										  mov ah, 0
										  mov word ptr[edi + 6], ax
		}
		for (i = 0; i < 3; i++)
		{
			if (!strcmp(info[i].name, na))
			{
				printf("%s\t", info[i].name);
				for (j = 0; j < 4; j++)
				{
					printf("%d\t", info[i].score[j]);
				}
				printf("\n");
			}
		}
		_asm
		{
		CNTI:
		}
		printf("Input Y to continue, N to exit...");
		scanf_s("%c", &op, 1);
		getchar();
		if (op == 'N' || op == 'n') {
			return 0;
		}
	}
	
	while (op == 'Y' || op == 'y');
	_asm
	{
	NTFOUND:
	}
	printf("No such person!\n");
	_asm
	{
		jmp CNTI
	}
}


// 运行程序: Ctrl + F5 或调试 >“开始执行(不调试)”菜单
// 调试程序: F5 或调试 >“开始调试”菜单

// 入门使用技巧: 
//   1. 使用解决方案资源管理器窗口添加/管理文件
//   2. 使用团队资源管理器窗口连接到源代码管理
//   3. 使用输出窗口查看生成输出和其他消息
//   4. 使用错误列表窗口查看错误
//   5. 转到“项目”>“添加新项”以创建新的代码文件，或转到“项目”>“添加现有项”以将现有代码文件添加到项目
//   6. 将来，若要再次打开此项目，请转到“文件”>“打开”>“项目”并选择 .sln 文件
