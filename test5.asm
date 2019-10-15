.386
DATA  SEGMENT  USE16
N    EQU   20
BUF  DB 'zhangsan',0,0   ;学生姓名，不足10字节部分用0填充
DB   100, 85, 80,?    
DB   'lisi',6 DUP(0)
DB   80, 100, 70,?
DB   'wangwu',4 DUP(0)
DB   70, 92, 66,?
DB   'hehehe',4 DUP(0)
DB   65, 70, 74,?
DB   'lee',7 DUP(0)
DB   68, 58, 58,?
DB   N-6 DUP('TempValue',0,80,90,95,?) ;除了6个已经具体定义了学生信息的成绩表以外，其他学生的信息暂时假定一样
DB  'liyue',5 DUP(0);最后一个必须是自己名字的拼音
DB    100,100,100,?
T1 DB 0AH,0DH,'Please input the student name!$'
T2 DB 0AH,0DH,'NOT FOUND!$'
T3 DB 0AH,0DH,'ERROR!$'
TE DB 0AH,0DH,'BYE BYE!$'
in_name DB 20
     	DB 0
     	DB 20 DUP(0)
POIN DW 0
DATA  ENDS

STACK SEGMENT USE16 STACK
      DB  200 DUP(0)
STACK ENDS
CODE SEGMENT USE16
	ASSUME CS:CODE,DS:DATA,SS:STACK
START:
	MOV  AX,DATA
    MOV  DS,AX
	MOV SI,OFFSET BUF
	MOV DI,20
score:
	MOV AL,[SI+10]  ;平均成绩计算段
	MOV BL,[SI+11]
	MOV CL,[SI+12]
	MOV AH,0
	MOV BH,0
	MOV CH,0
	SAL AX,2  ;（A*4+B*2+C）/3.5
	SAL BX,1
	ADD AX,BX
	ADD AX,CX
	MOV CL,7
	DIV CL
	MOV [SI+13],AL
	ADD SI,14
	DEC DI          ;将20名学生的平均值计算完后进入下一步
	JNE score		;
NEXT:
	MOV SI,OFFSET BUF
	MOV DI,OFFSET in_name
	LEA DX,T1
	MOV AH,9
	INT 21H		;显示提示信息'Please input the student name!'
	MOV DL,0AH
	MOV AH,2
	INT 21H
	MOV DL,0DH
	MOV AH,2
	INT 21H		;输出换行回车
	LEA DX,in_name
	MOV AH,10
	INT 21H		;输入学生姓名
	MOV BL,in_name+1
	MOV BH,0
	CMP BL,0
	JE NEXT		;如果没有输入字符则跳回提示状态提示T1
	CMP BL,10
	JA fail		;如果输入超过10个字符
	CMP BL,1	;如果只输入了一个字符
	JE NEXT1
	MOV CX,20	;赋初始值
LP1:
	MOVZX DX,in_name+1;输入字符串的长度	
S1:	MOVZX BX,in_name+1
	SUB BX,DX
	MOV AL,[SI+BX]
	MOV AH,[DI+BX+2]  ;取同位置值
	CMP AH,'A'    ;
	JB fail
	CMP AH,'z'
	JA fail
	CMP AH,'a'
	JAE L1
	CMP AH,'Z'
	JBE L1
	JMP fail
L1:	CMP AH,AL
	JNE S2
	DEC DX
	JNE S1
S3:	MOV AH,[SI+BX+1];取姓名中的结束标记
	CMP AH,0
	JNE S2	
	MOV POIN,SI	;将偏移地址保存在POIN中
	JMP LEVEL 
S2:	ADD SI,14
	MOVSX DX,in_name+1
	DEC CX
	JNZ S1		
	LEA DX,T2
	MOV AH,9
	INT 21H		;显示提示错误信息'NO FOUND THE STUDENT!'
	JMP NEXT	;重新输入
LEVEL:	MOV BX,POIN
	MOV AL,DS:[BX+13];赋予平均值，使用变址寻址
	CMP AL,90      ;判断成绩是否大于90，是则进入输出A的代码段
	JAE A1
	CMP AL,80      ;判断成绩是否大于80，是则进入输出B的代码段
	JAE B2
	CMP AL,70      ;判断成绩是否大于70，是则进入输出C的代码段
	JAE C3
	CMP AL,60
    JAE D4	;判断成绩是否大于60，是则进入输出D的代码段
F5:
	MOV DL,0AH
	MOV AH,2
	INT 21H
	MOV DL,0DH
	MOV AH,2
	INT 21H
	MOV DL,46H	;输出F
	MOV AH,2
	INT 21H
	JMP NEXT
A1:	MOV DL,0AH    
	MOV AH,2
	INT 21H
	MOV DL,0DH
	MOV AH,2
	INT 21H
	MOV DL,41H	;输出A
	MOV AH,2
	INT 21H
	JMP NEXT
B2:	MOV DL,0AH
	MOV AH,2
	INT 21H
	MOV DL,0DH
	MOV AH,2
	INT 21H
	MOV DL,42H	;输出B
	MOV AH,2
	INT 21H
	JMP NEXT
C3:	MOV DL,0AH
	MOV AH,2
	INT 21H
	MOV DL,0DH
	MOV AH,2
	INT 21H
	MOV DL,43H	;输出C
	MOV AH,2
	INT 21H
	JMP NEXT
D4:	MOV DL,0AH
	MOV AH,2
	INT 21H
	MOV DL,0DH
	MOV AH,2
	INT 21H
	MOV DL,44H	;输出D
	MOV AH,2
	INT 21H
	JMP NEXT
NEXT1:	MOV AL,in_name+2
	CMP AL,71H
	JE EXIT		;如果为q则退出程序
	JMP LP1		
FAIL:	LEA DX,T3
	MOV AH,9
	INT 21H		;'INPUT ERROR!'
	JMP NEXT
EXIT:	LEA DX,TE
	MOV AH,9
	INT 21H		;'BYE BYE'
	MOV AH,4CH
	INT 21H
CODE ENDS
	END START