#include <stdio.h>
#include <stdlib.h>
#include <string.h>
const int N = 6;
const int M = 14;
char buf[100005] = { 'z','h','a','n','g','s','a','n','0','0','2','U','P','?',
					 'l','i','s','i','0','0','0','0','0','0','F','d','F','?',
					 'w','a','n','g','w','u','0','0','0','0','_','X','R','?',
					 'f','u','c','a','0','0','0','0','0','0','<','F','K','?',
					 'g','e','r','a','l','t','0','0','0','0','_','Z','Z','?',
					 'l','i','y','u','e','0','0','0','0','0','U','U','d','?' };
//����buf���飬���гɼ����ַ���ASCII�����;
char in_name[15];
char noexist[] = { "No exist" };
int flag, level;   //flag����Ƿ���ҵ����֣�levelȷ���ɼ��ȼ�
extern void cal_all();
extern void solve();     //�����ⲿ����

void init() {
	memset(in_name, '\0', sizeof(in_name));
	flag = level = 0;
}

int main() {
	cal_all();   //���û���ӳ������ÿ��ѧ��ƽ���ɼ�
	while (1) {
		init();   //��ʼ��
		printf("input student names:\n");
		char ch = getchar();
		if (ch == '\n' || ch == '\r') continue;
		if (ch == 'q') break;
		int len = 0;
		in_name[len++] = ch;
		while (1) {
			ch = getchar();
			if (ch == '\n' || ch == '\r') break;
			in_name[len++] = ch;
		}
		solve();   //���û���ӳ������ѧ��������ѯ���ɼ��ȼ��ж�
		if (flag) {
			printf("%s\n", noexist);
			continue;
		}
		if (level == 1) {
			printf("A\n");
			continue;
		}
		if (level == 2) {
			printf("B\n");
			continue;
		}
		if (level == 3) {
			printf("C\n");
			continue;
		}
		if (level == 4) {
			printf("D\n");
			continue;
		}
		if (level == 5) {
			printf("F\n");
			continue;
		}
	}
	return 0;
}
