# 线性表的顺序存储——顺序表
### 类型定义

```c
typedef struct{
    ElemType data[MaxSize];
    int length;
}SqList; //顺序表类型
```

## 顺序表运算的实现
### 建立顺序表

```c
void CreateList(SqList *&L,ElemType a[],int n){
    int i;
    L=(SqList *)malloc(sizeof(SqList));
    for(i=0;i<n;i++){
        L->data[i]=a[i];
    }
    L->length=n;
}
```
创建思路：传入顺序表指针，和一个a数组，以及数组的长度n
然后给L分配空间，for循环，给L的每个data赋值a，表长为n

*表指针，&引用参数，执行结果回传

## 顺序表基本运算算法
### 初始化线性表

```c
void InitList(SqList *&L){
    L=(SqList *)malloc(sizeof(SqList));
    L->length=0;
} //分配空间，长度初始为0
```

### 销毁线性表

```c
void DestoryList(SqList *&L){
    free(L);
} //释放L所指向的空间
```

### 判定是否为空表

```c
bool ListEmpty(SqList *L){
    return(L->lengt==0);
} //判断length是否为0
```

### 求线性表长度

```c
int ListLength(SqList *L){
    return(L->length);
} //返回length即可
```

### 输出线性表

```c
void DispList(SqList *L){
    int i;
    if(ListEmpty(L))return;//若为空，终止
    for(i=0;i<L->length;i++){
        print(“%c”,L->data[i]);//不为空遍历输出
    }
    printf(“\n”);
}
```

### 求某个元素值

```c
bool GetElem(SqList *L,int i,ElemType &e){
    if(i<1||i>L->length)return false;//i不合法
    e=L->data[i-1];
    return true;
}
```

### 按元素值查找LocateElem(L,e)

```c
int LocateElem(SqList *L,ElemType e){
    int i=0;//传入表和查找元素
    while(i<L->length && L->data[i]!=e){
        i++; //遍历比较
    }
    if(i>=L->length)return 0;找不到返回0
    else return i+1;找到了返回逻辑位置
}
```

### 插入数据元素

```c
bool ListInsert(Sqlist *&L,int i,ElemType e){
    int j;
    if(i<1||i>L->length+1)return false;//插入位置不正确
    i—;i-1获得数组位置
    for(j=L->length;j>i;j—){
        L->data[j]=L->data[j-1]; //后移一位
    }
    L->data[i]=e;//插入元素
    L->length++;
    return true;
}
```

### 删除数据元素

```c
bool ListDelete(SqList *&L,int i,ElemType &e){
    int j;
    if(i<1||i>L->length+1)return false;
    i—;
    e=L->data[i];//把要删除的值赋值给e
    for(j=i;j<L->length-1;j++){
        L->data[j]=L->data[j+1];//把元素依次前移实现删除
    }
    L->length—;
    return true;
}
```

## 算法
### 删除所有值为x的元素

```c
void dednode1(SqList *&A, ElemType x){
    int k=0,i; //k记录不等于x的个数
    for(i=0;i<A->length;i++){
        if(A->data[i]!=x){
            A->data[k]=A->data[i];//不等于x则插入A
            k++;
        }
    }
    A->length=k;
}
```
相当于是重建了一个新的表

```c
void delnode2(SqLisr *&A,ElemType x){
    int k=0,i=0;//k记录等于x的元素个数
    while (i<A->length){
        if(A->data[i]==x)k++;//当前元素值为x时k增加1
        else A->data[i-k]=A->data[i];//当前元素不为x，前移k个位置
        i++;
    }
    A->length-=k;//顺序表A的长度递减k
}
```
改变元素的位置，然后减小表长

# 单链表
### 节点类型定义

```c
typedef struct LNode{//定义节点类型
    ElemType data;//数据
    struct LNode *next;//指向后继节点
}LinkList;
```

### 插入节点

![](15712005731296.jpg)

```c
s->next=p->next;
P->next=s;
```

### 删除节点


![](15712010687117.jpg)

```c
p->next=p->next->next;
```

## 建立单链表
### 头插法
* 从空表开始创立一个头节点
* 依次读取数组的元素，生成新的节点
* 新节点插入到当前链表的表头，直到结束

节点次序与逻辑次序相反

```c
void CreateListF(LinkList *&L,ElemType a[],int n){
    LinkList *s;
    int i;
    L=(LinkList *)malloc(sizeof(LinkList));
    L->next=NULL; //创建头节点
    for(i=0;i<n;i++){
        s=(LinkList *)malloc(sizeof(LinkList));//创建一个链表
        s->data=a[i];//这个链表获取所有的数据
        s->next=L->next;//将*s插在原始节点之前，头节点之后
        L->next=s;
    }
}
```

### 尾插法
插入新节点到表尾，增加一个尾指针r，使它始终指向尾节点

```c
void CreateListR(LinkList *&L,ElemType a[],int n){
    LinkList *s,*r;
    int i;
    L=(LinkList *)malloc(sizeof(LinkList));//创建头节点
    r=L;//r始终指向尾节点，开始指向头节点
    for(i=0;i<n;i++){
        s=(LinkList *)malloc(sizeof(LinkList));
        s->data=a[i];
        r->next=s;//将*s插入*r之后
        r=s;
    }
    r->next=NULL;//尾节点next被空
}
```

## 基本运算的实现
### 初始化
建立空链表，创建头节点

```c
void InitList(LinkList *&L){
    L=(LinkList *)malloc(sizeof(LinkList));
    L->next=NULL;
}
```

### 销毁链表
释放空间

```c
void DestoryList(LinkList *&L){
    LinkList *pre=L, *p=L->next;//pre指向*p的前驱节点
    while(p!=NULL){
        free(pre);//释放*pre节点
        pre=p;//同步后移一个节点
        p=pre->next;
    }
    free(pre);//p为NULL，pre指向尾节点，释放
}
```

### 判断是否为空表 

```c
bool ListEmpty(LinkList *L){
    return(L->next==NULL);
}
```

### 求线性表的长度
返回单链表L中数据节点的个数

```c
int ListLength(LinkList *L){
    int n = 0;
    LinkList *p = L; //指向表头
    while (P->next! = NULL) {
        n++;    //遍历并递增
        p = p ->next;
    }
    return n;
}
```

### 输出线性表DispList(L)
扫描L的每个数据节点，并显示各节点的data域值

```c
void DispList(LinkList *L) {
    LinkList *p = L->next;  //p指向开始节点
    while(p != NULL){
        printf(“%d”,p->data);
        p=p->next;
    }
    print(“\n”);
}
```

### 求线性表L中位置i的数据元素

```c
bool GetElem(LinkList *L,int i,ElemType &e){
    int j = 0;
    LinkList *p=L; //指向头节点，正好j=0，序号为0
    while(j<i && p!=NULL){//遍历找到该节点
        j++;
        p=p->next;
    }
    if(p==NULL){
        return false;
    } else{
        e=p->data;
        return true;
    }
}
```

### 按元素值查找LocateElem(L,e)
查找一个data与e相等的值，返回其index

```c
int LocateElem(LinkList *L,ElemType e){
    int i=1;
    LinkList *p=L->next;
    while(p!=NULL && p->data!=e){
        p=p->next;
        i++;
    }
    if(p==NULL){
        return (0);
    } else {
        return i;
    }
}
```

### 插入数据元素LinkInsert(&L,i,e)
找到第i-1个节点，若存在这样的节点，将值为e的节点*s插入其后

```c
bool LinkInsert(LinkList *&L,int i,ElemType e){
    int j = 0;
    LinkList *p=L,*s;
    while(j<i-1 && p!=NULL){
        j++;
        p=p->next;
    }
    if(p==NULL){
        return false;
    } else {
        s=(LinkList *)malloc(sizeof(LinkList));
        s->data=e;
        s->next=p->next;
        p->nex=s; //插入操作
        return true;
    }
}
```

### 删除数据元素ListDelete(&L,i,&e)
找到第i-1节点，若存在该节点，也存在后继节点，则删除后继节点

```c
bool LinkDelete(LinkList *&L, int i, ElemType &e){
    int j=0;
    LinkList *p=L,*q;
    while(j<i-1 && p!=NULL){
        j++;
        p=p->next;
    }
    if(p==NULL){
        return false;   //没找到i-1节点
    } else {
        q=p->next; //q指向第i个节点
        if(q==NULL){
            return false; //不存在第i个节点
        } 
        e=q->data;
        p->next=q->next; //删除q
        free(q); //释放q的内存空间
        return true;
    }
}
```

## 单链表算法
### 删除元素值最大的节点
一对同步指针,主要是p和pre在移动

```c
void delmaxnode(LinkList *&L){
    LinkList *p=L->next, *pre=L, *maxp=p, *maxpre=pre;
    while(p!=NULL){
        if(maxp->data < p->data){ //找到值更大的
            maxp=p; //更改maxp
            maxpre=pre; //更改maxpre
        }
        pre=p;
        p=p->next; //同步后移一个节点
    }
    maxpre->next=maxp->next; //删除
    free(maxp);
}
```

### 有序排列

```c
void sort(LinkList *&L){
    LinkList *p, *pre, *q;
    p=L->next->next; //p指向L的第二个数据节点
    L->next->next=NULL; //构造只含一个数据节点的有序表，第一个数据节点还是存在的
    while(p!=NULL){
        q=p->next; //q保存p的后继节点的指针
        
        pre=L; //从头节点开始，指向*p的前驱节点
        while(pre->next!=NULL && pre->next->data < p->data)
        {//第一个节点不为空，第一个节点的数据<p所在节点的数据
            pre=pre->next;    //pre后移，直到遍历或者找到了比p大的
        }
        p->next=pre->next; //插入pre
        pre->next=p;
        p=q;
    }
}
```

### 节点逆置

```c
void Reverse(LinkList *&L){
    LinkList *p=L->next, *q;
    L->next=NULL;
    while(p!=NULL){
        q=p->next;
        p->next=L->next;
        L->next=p;
        p=q;
    }
}
```

## 双链表
在单链表中，每个物理节点称增加一个指向后继节点的指针域和一个指向前驱节点的指针域，即双链表

### 类型定义

```c
typedef struct DNode{
    ElemType data;
    struct DNode *pior;
    struct DNode *next;
} DLinkList;
```

### 插入和删除
Insert s

```c
s->next = p->next;
p->next->prior=s;
s->prior=p;
p->next=s;
```

Delete

```c
p->next->next->prior = p
p->next=p->next->next
```

### 建立双向链表
#### 头插法

```c
void CreateListF(DLinkList *&L, ElemType a[], int n){
    DLinkList *s;
    int i;
    L=(DLinkList *)malloc(sizeof(DLinkList)); //头节点
    L->prior=L->next=NULL; //指针空
    for(i=0; i<n; i++){
        s=(DLinkList *)malloc(sizeof(DLinkList));
        s->data=a[i];
        s->next=L->next;
        if(L->next!=NULL){
            L->next->prior=s; //头插
        }
        L->next=s;
        s->prior=L;
    }
}
```

## 循环链表
首尾相连

## 线性表的应用

# 栈和队列

栈是一种只能在一端进行插入或删除操作的线性表

* 允许进行插入、删除操作的一端称为**栈顶**
* 表的另一端称为**栈底**
* 当栈中没有数据元素时，称为**空栈**
* 栈的插入操作通常称为**进栈**或**入栈**
* 栈的删除操作通常称为**退栈**或**出栈**

栈的主要特点是“后进先出”，后进先出表，就像堆书一样

## 栈的顺序存储结构及其基本运算实现

### 定义顺序栈类型

```c
typedef struct {
    ElemType data[MaxSize];
    int top;	//栈顶指针
} SqStack;
```

* 约定top总是指向栈顶元素，初始值为-1
* 当top=MaxSize-1时不能再进栈——栈满
* 进栈时top+1，出栈时top-1

顺序栈四要素

* 栈空条件：top=-1
* 栈满条件：top=MaxSize-1
* 进栈操作：top++；将e放在top处
* 退栈操作：从top处取出元素e；top--

### 初始化栈InitStack

建立一个新的空栈s，实际上是将栈顶指针指向-1

```c
void InitStack(SqStack *&s) {
    s=(SqStack *)malloc(sizeof(SqStack));
    s->top=-1;
}
```



### 销毁栈DestoryStack(&s)

释放栈s占用的存储空间

```c
void DestoryStack(SqStack *&s){
    free(s);
}
```

### 判断栈是否为空StackEmpty(s)

```c
bool StackEmpty(SqStack *s){
    return(s->top=-1);
}
```



### 进栈Push(&s,e)

在栈不满的条件下，先将栈指针+1，然后在该位置插入元素

```c
bool Push(SqStack *&s,ElemType e){
    if(s->top==MaxSize-1){
        return false;
    }
    s->top++;
    s->data[s->top]=e;
    return true;
}
```



### 出栈Pop(&s,&e)

在栈不为空时，将栈顶元素给e，然后top-1

```c
bool Pop(SqStack *&s,ElemType &e){
    if(s->top==-1)P{
        return false;
    }
    e=s->data[s->top];
    s->top--;
    return true
}
```



### 取栈顶元素GetTop(s.&e)

在栈不为空，将栈顶元素赋值给e

```c
bool GetTop(SqStack *s,ElemType){
    if(s->top==-1){
        return false;
    }
    e=s->data[s->top];
    return true
}
```

取元素时没有动栈的



### 设计算法

判断字符串是否为对称串

字符串str所有元素依次进栈，产生的出栈序列正好与str顺序相同

```c
bool symmetry(ElemType str[]){
    int i;
    ElemType e;
    SqStack *st;
    initStack(st);
    
    for(i=0;str[i]!='\0';i++){
        Push(st,str[i]);
    }
    
    for(i=0;str[i]!='\0';i++){
        Pop(st,e);
        if(str[i]!=e){
            DestoryStack(st);
            return false;
        }
    }
    
    DestoryStack(st);
    return true;
}
```



## 栈的链式存储结构及其基本运算实现

链栈的4要素

* 栈空条件：s->next=NULL
* 栈满条件：不考虑
* 进栈e操作：将包含e的节点插入到头节点之后
* 退栈操作：取出头节点之后节点的元素并删除

### 数据节点的类型LiStack定义

```c
typedef struct linknode{
    ElemType data;
    struct linknode *next;
}LiStack;
```

### 初始化栈initStack(&s)

创建头节点，next置为NULL

```c
void initStack (LiStack *&s){
    s=(LiStack *)malloc(sizeof(LiStack));
    s->next=NULL;
}
```



### 销毁栈DestoryStack(&s)

```c
void DestoryStack(LiStack *&s){
    LiStack *p=s, *q=s->next; //p指向s，然后移动逐个释放
    while(q!=NULL){
        free(p);
        p=q;
        q=p->next;
    }
    free(p); //p指向尾节点，释放其空间
}
```



### 判断栈是否为空StackEmpty(s)

```c
bool StackEmpty(LiStack *s){
    return(s->next==NULL);
}
```



### 进栈Push(&s, e)

```c
void Push(LiStack *&s, ElemType e){
    LiStack *p;
    p=(LiStack *)malloc(sizeof(LiStack));
    p->data=e;
    p->next=s->next;
    s->next=p;
}
```



### 出栈Pop(&s, &e)

```c
bool Pop(LiStack *&s,ElemType &e){
    LiStack *p;
    if(s->next==NULL){
        return false;
    }
    p=s->next;
    e=p->data;
    s->next=p->next; //删除节点
    free(p);
    return true;
}
```



### 取栈顶元素GetTop(s,e)

```c
bool GetTop(LiStack *s,ElemType &e){
    if(s->next==NULL){
        return false;
    }
    e=s->next->data;
    return true;
}
```



### 算法设计

判断输入的括号是否配对

按照最近位置配对

```c
bool Match(char exp[], int n){
    int i=0;
    char e;
    bool match = true;
    LiStack *st;
    
    InitStack(st);
    while(i<n && match){
        if(exp[i]=='(') Push(st,exp[i]); //左括号进栈
         else if(exp[i]==')'){ 
            if(GetTop(st,e)==true){ //能够匹配栈顶的元素
                if(e!='(') match=false; 
                else Pop(st,e);
            } else match = false;
        } 
		i++;
	}
	if(!StackEmpty(st)) match=false;

	DestroyStack(st);
	return match;
}
```



## 队列的顺序存储结构及其基本运算的实现

运算受限的线性表

队列只能选取一个断点进行插入操作，另一个端点进行删除操作

* 把进行插入的一段称作**队尾（rear）**
* 进行删除的一端称作**队首（front）**
* 向队列插入新元素称作进队，进队后成为新的队尾元素
* 删除称作出队，出队后，后继元素就成为队首元素

先进先出表

### 顺序队类型SqQueue定义

```c
typedef struct
{
    /* data */
    ElemType data[MaxSize];
    int front,rear;
} SqQueue;
```

* rear总是指向队尾元素
* 元素进队，rear+1
* front指向当前队中队头元素的前一位置
* 元素出队，front-1
* 当rear=MaxSize-1时，不能再进队



队列的各种状态

* 初始状态 `front=rear=-1`
* 队空状态 `rear=MaxSize-1`
* 元素e进队` rear++;` `data[rear]=e`;
* 元素e出队 `front++;` `e=data[front]`



### 初始化队列InitQueue(q)

构造一个空队列q，将front和rear指针均设置成初始化-1

```c
void InitQueue(SqQueue *&q){
    q=(SqQueue *)malloc(sizeof(SqQueue));
    q->front=q->rear=-1;
}
```



### 销毁队列DestroyQueue(q)

```c
void DestoryQueue(SqQueue *&q){
    free(q);
}
```



### 判断队列是否为空QueueEmpty(q)

根据条件判断，即首尾指向同一个位置

```c
bool QueueEmpty(SqQueue *q){
    return(q->front == q->rear);
}
```



### 进队列enQueue(q,e)

```c
bool enQueue(SqQueue *&q, ElemType e){
    if(q->rear==MaxSize-1){
        return false;
    } 
    q->rear++;
    q->data[q->rear]=e;
    return true;
}
```



### 出队列deQueue(q,e)

队首指针加一，把该位置的值赋值给e

```c
bool deQueue(SqQueue *&q, ElemType &e){
    if(q->rear == q->front){
        return false;
    }
    q->front++;
    e = q->data[q->front];
    return true;
}
```



### 栈与队列求解迷宫问题

栈和队列都是存放多个数据的容器，通常用于存放临时数据

* 先放入数据后处理，使用栈
* 先放入数据先处理，使用队列

迷宫问题

给定一个MxN的迷宫图、入口与出口、行走规则。求一条简单路径



使用栈顺序存储结构

```c
typedef struct{
    int i;//当前方块行号
    int j;//当前方块列号
    int di;//下一可走相邻方位的方块号
} Box;
typedef struct{
    Box data[MaxSize];
    int top
} StType;
```



## 串

### 串的基本概念

串时有零个或多个字符组成的有限序列

是线性表的子集

## 数组和稀疏矩阵

数组

稀疏矩阵

一个阶数较大的矩阵中的非0元素个数s相对于矩阵元素的总个数t很小时，该矩阵为系数绝阵



## 树

### 树的概念

树形式化定义：T = {D, R}，D是包含n个节点的有限集合，当n=0时为空树，否则关系R满足以下条件

* 有且仅有一个节点d0，且没有前驱节点，则成为根节点
* 除了根节点，每个节点有且仅有一个前驱节点
* D中每个节点可有0或多个后继节点

<hr/>
节点的度和树的度

* 节点的度

  树中一个节点的子树的个数称为该节点的度

* 树中各节点的度的最大值称为树的度

通常将度为m的树成为m叉树

<hr/>
分支节点和叶节点

* 分支节点

  度不为0，度为1的为单分支节点，度为2的节点的为双分支节点

* 叶节点

  度为0

<hr/>
路径与路径长度

* 路径

  两个节点的节点序列成为路径，<dx, dy>是分支

* 路径长度

  等于路径所通过的节点数目-1，即路径上分支数目

<hr/>
孩子节点、双亲节点和兄弟节点

* 孩子节点

  每个节点的后继被称为该节点的孩子节点

* 双亲节点

  孩子节点的前驱

* 兄弟节点

  拥有同一双亲的孩子节点互为兄弟节点

子孙节点祖父节点。。。



节点的层次和树的高度

* 节点的层次

  树中的每个节点有处在一个层次上，节点的层次从树根开始定义，根节点是第一层

* 高度/深度

  树中节点的最大层次称为树的高度

<hr/>
有序树和无序树

* 有序树

  树中各个节点的子树是按照一定的次序从左向右安排的，且相对次序是不能随意变换的，则称为有序树

<hr/>
森林

互不相交的树的集合

只要把树的根节点删除就成为了森林

### 树的性质

1. 树中的节点数等于所有节点的度数+1

   * 树中每个分支计为一个节点的度=>所有节点的度之和 = 分支数
   * 根节点加上一个分支，这样的分支树相同=>实际分支数 = n-1

   n=度之和-1

2. 度为m的树中第i层上至多有m^(i-1)个节点

3. 。。。



### 树的基本运算

#### 树的遍历

按某种方式访问树中的每一个节点且每个节点只被访问一次



* 先根遍历

  若树不空，则前访问根节点，然后依次先根遍历各个子树

* 后根遍历

  若树不空，则先依次后根遍历各个子树，然后访问根节点

* 层次遍历

  若树不空，则自上而下、自左至右访问树中的每个节点



### 树的存储结构

#### 双亲存储结构

伪指针指示其双亲节点的位置

![image-20191028172913963](img\image-20191028172913963.png)

#### 孩子链存储结构

每个指针指向一棵子树

```c
typedef struct node{
    ElemType data; //
    struct node *son[MaxSons]; //指向孩子的节点
}TSonNode;
```

![image-20191028173303531](img\image-20191028173303531.png)

#### 孩子兄弟链存储结构

每个节点有两个指针域

```c
typedef struct tnode{
    ElemType data;
    struct tnode *hp; //指向兄弟
    struct tnode *vp; //指向孩子
}TSBNode;
```

![image-20191028173217258](img\image-20191028173217258.png)



### 二叉树的存储结构

#### 顺序存储结构

完全二叉树节点按层序编号

完全二叉树的顺序存储用数组存储

非完全二叉树没有节点的地方置为空

```c
typedef ElemType SqBTree[MaxSize];
SqBTree bt = "#ABD#C#E#####F";
```



#### 二叉树的链式存储结构

树的孩子链存储结构 => 二叉树的链式存储结构

```c
typedef struct node{
    ElemType data;
    struct node *lchild, *rchild; //分别指向二叉树
} BTNode;
```

 ![img](img\{A746CCA2-401C-CB90-089B-03DE723CDC6C}.jpg) 



* n个节点 => 2n个指针域
* 分支数为n-1 => 非空指针域有 n-1 个
* 空指针域个数 =2n-(n-1)=n+1



### 二叉树的基本运算

#### 创建二叉树`CreateBTNode(*b,*str)`

二叉树括号表示串中只有4类字符

* 单个字符：节点值
* (：表示一棵左子树的开始
* )：表示一棵子树的结束
* ,：表示一棵右子树的开始

<hr/>
算法设计

* 先构造根节点N，再构造左子树L，最后构造右子树R
* 构造右子树R时，找不到N了，所以需要保存N
* 节点是按最近原则匹配的，所以需要一个栈保存N

<hr/>
用ch扫描采用括号表示法表示二叉树的字符串

1. 若ch='('：则将前面刚创建的节点作为双亲节点进栈，并设置k=1，表示开始处理左孩子节点

2. 若ch=')'：表示栈顶节点的左右孩子节点处理完毕，退栈

3. 若ch=','：表示开始处理右孩子节点，设置k=2

4. 其他情况（节点值）：

   创建*p节点用于存放ch；

   当k=1时，将*p节点作为栈顶节点的左孩子节点

   当k=2时，将*p节点作为栈顶节点的右孩子节点

A(B(D(,G)),C(E,F))

```c
typedef struct node{
    ElemType data;
    struct node *lchild, *rchild; //分别指向二叉树
} BTNode;

void CreateBTNode(BTNode *&b,char *str){
    //由str=>二叉链b
    BTNode *St[MaxSize], *p;
    int top = -1, k, j = 0;
    char ch;
    b = NULL; //建立二叉链初始时为空
    ch = str[j];
    while(ch != '\0'){ //str未扫描完时循环
        switch(ch){
            case '(':top++; St[top]=p; k=1; break; //可能有左孩子节点
            case ')':top--; break;
            case ',':k=2; break; //后面为右孩子节点
            default: //遇到节点值
                p=(BTNode *)malloc(sizeof(BTNode));
                p->data=ch;  //p为二叉树根节点
                p->lchild = p->rchild = NULL;
                if(b==NULL) b=q;
                else{	//已创建二叉树根节点
                    switch(k){
                        case 1:St[top]->lchild = p; break;
                        case 2:St[top]->rchild = p; break;
                    }
                }
        }
        j++;
        ch = str[j];  //继续扫描
    }
}
```



#### 销毁二叉树`DestoryBT(*b)`

设`f(b)`销毁二叉树b

则`f(b->lchild)`销毁左子树，`f(b->rchild)`销毁右子树

递归模型

* 若b=NULL，f(b)不做任何事情

* 其他情况，`f(b)=f(b->lchild);  f(b->rchild); `

* 释放`*b`节点

```c
void DestoryBT(BTNode *&b){
  if(b == NULL) return ;
  else{
    DestoryBT(b->lchild);
    DestoryBT(b->rchild);
    free(b);	//剩下一个节点*b，直接释放
  }
}
```



#### 查找节点`FindNode(*b,x)`

设f(b,x)在二叉树b中查找值为x的节点（唯一），找到后返回其指针，否则返回NULL

`f(b,x)`      `f(b->lchild, x)`      `f(b->rchild,x)`

递归模型

* 若`b=NULL`，`f(b,x)=NULL`
* 若`b->data=x`，f(b,x)=b
* 若在左子树中找到了，即`p=f(->lchild,x)`且`p!=NULL`
* 其他情况，`f(b,x)=f(b->rchild,x)`

```c
BTNode *FindNode(BTNode *b,ElemType x){
  BTNode *p; 
  if(b==NULL) return NULL;//树为空
  else if(b->data = x) return b;
  else {
    p=FindNode(b->lchild,x);
    if(p!=NULL) return p;
    else return FindNode(b->rchild,x);
  }
}
```



#### 找到孩子节点`LchildNode(p)`和`RchildNode(p)`

```c
BTNode *LchildNode(BTNode *p){
  return p->lchild;
}

BTNode *RchildNode(BTNode *p){
  return p->rchild;
}
```



#### 求高度`BTNodeDepth(*b)`

递归模型

* 当b=NULL `f(b)=0`
* 其他情况`f(b)=MAX{f(b->lchild),f(b->rchild)}+1`

```c
int BTNodeDepth(BTNode *b){
  int lchilddep, rchilddep;
  if(b==NULL) return(0);
  else{
    lchilddep = BTNodeDepth(b->lchild);
    rchilddep = BTNodeDepth(b->rchild);
    return(lchilddep > rchilddep)?(lchilddep+1):(rchilddep+1)
  }
}
```



#### 输出二叉树`DispBTNode(*b)`

二叉树的二叉链   =>   二叉树的括号表示

​            ^                                  ^

​            ||                                  ||

​      存储结构       =>          逻辑结构     

表示形式

`root(lchild,rchild)`

```c
void DisBTNode(BTNode *b){
  if(b!=NULL){
    printf("%c",b->data);
    if(b->lchild != NULL || b->rchild != NULL){
      printf("(");
      DispBTNode(b->lchild);//递归处理左子树
      if(b->rchild != NULL) printf(",");
      DispBTNode(b->rchild);//递归处理右子树
      printf(")");
    }
  }
}
```

### 二叉树的遍历

#### 先序遍历NRL

* 访问根节点
* 先序遍历左子树
* 先序遍历右子树

```c
void PreOrder(BTNode *b){
  if(b != NULL){
    printf("%c",b->data);
    PreOrder(b->lchild);
    PreOrder(b->rchild);
  }
}
```

 <img src="img\{D5340ED6-C2F7-A680-0B5B-3CDBBFA4325A}.jpg" alt="img" style="zoom: 67%;" /> 

<hr/>
#### 中序遍历LNR

* 中序遍历左子树
* 访问根节点
* 中序遍历右子树

```c
void InOrder(BTNode *b){
  if(b!= NULL){
    InOrder(b->lchild);
    printf("%c",b->data);
    InOrder(b->rchild);
  }
}
```

 ![img](img\{94B9DD90-6430-0C20-63A9-D2435B891B4A}.jpg) 

<hr/>
#### 后序遍历LRN

* 后序遍历左子树
* 后序遍历右子树
* 访问根节点

```c
void PostOrder(BTNode *b){
  if(b!=NULL){
    PostOrder(b->lchild);
    PostOrder(b->rchild);
    printf("%c",b->data);
  }
}
```



![img](img\{F17D05C4-0955-2E9B-8F89-91F01DBC5118}.jpg) 

<hr/>
#### 层次遍历

对于二叉树从根节点开始，从上到下从左到右访问每一个节点

思路：

1. 将根节点进队
2. 队不空时循环：从队列中出列一个节点*p，访问它
   * 若它有左孩子，则将左孩子节点进队
   * 若它有右孩子，则将右孩子节点进队

```c
void LevelOrder(BTNode *b){
  BTNode *p;
  BTNode *qu[MaxSize]; //定义环形队列，存放节点指针
  int front,rear; //定义队头和队尾指针
  front = rear =0; //设置队列为空
  rear++; 
  qu[rear] = b; //根节点指针进入队列
  while(front!=rear){ //队列不为空
    front=(front+1)%MaxSize;
    p = qu[front]; //队头出队列
    printf("%c",p->data); //访问节点
    if(p->lchild != NULL){ 
      rear = (rear+1)%MaxSize;
      qu[rear] = p->lchild;
    }
    if(p->rchild != NULL){
      rear = (rear+1)%MaxSize;
      qu[rear] = p->rchild;
    }
  }
}
```



### 二叉树遍历的应用

#### 三种递归遍历算法的应用

Q：给定一个二叉链存储结构的二叉树，计算所有节点个数
$$
若b=NULL，f(b)=0
\\else: f(b)=f(b->lchild)+f(b->rchild)+1
$$

```c
int Nodes(BTNode *b){
  int num1, num2;
  if(b==NULL){
    return 0;
  } else {
    return Nodes(b->lchild)+Nodes(b->rchild)+1;
    //先左子树，后右子树，最后加上根节点
  }
}
```

<hr/>
Q：计算所有叶子节点个数
$$
若b=NULL,f(b)=0
\\若*b为叶子节点,f(b)=1
\\else: f(b)=f(b->lchild)+f(b->rchild)
$$

```c
int LeafNodes(BTNode *b){
  int num1,num2;
  if(b==NULL){
    return 0;
  } else if (b->lchild==NULL && b->rchild == NULL){
    return 1;
  } else {
    return(LeafNodes(b->lchild)+LeafNodes(b->rchild))
  }
}
```

<hr/>
Q：复制二叉树
$$
若b=NULL, f(b,t)\equiv t=NULL;
\\else: f(b,t)\equiv 复制根节点*b产生*t节点
\\f(b->lchild,t->lchild);
\\f(b->rchild,t->rchild);
$$

```c
void Copy(BTNode *b,BTNode *&t){
  if(b==NULL) t=NULL;
  else{
    t=(BTNode *)malloc(sizeof(BTNode));
    t->data=b->date;	//复制一个根节点*t
    Copy(b->lchild,t->lchild); //递归复制左子树
    Copy(b->rchild,t->rchild);
  }
}
```

<hr/>
Q：交换左右子树，不破坏原有二叉树

$$
建立一个新二叉树，交换了左右子树
\\若b=NULL，f(b,t)\equiv t=NULL
\\else: f(b,t)\equiv复制根节点*b产生*t节点
\\f(b->lchild,t->rchild);
\\f(b->rchild,t->lchild);
$$

```c
void Swap(BTNode *b,BTNode *&t){
  if(b==NULL) t=NULL;
  else{
    t=(BTNode *)malloc(sizeof(BTNode));
    t->data = b->data;
    Swap(b->lchild,t->rchild);
    Swap(b->rchild,t->lchild);
  }
}
```

<hr/>
Q：求二叉树b中值为x的节点层次
$$
设Level(b,x,h)返回二叉树b中data值为x 的节点的层次，其中h表示b所指节点的层次
\\在二叉树b中找到data值为x的节点，返回其层次，若没找到，返回0
\\初始调用：Level(b,x,1);指向根节点，层次为1
\\空二叉树中找不到值为x的节点\Rightarrow Level(b,x,h)=0;若b=NULL
\\若b指向值为x的节点\Rightarrow Level(b,x,h)=h,若b->data=x
\\else:先在左子树中找。若是找到了则返回
\\Level(b,x,h)=l,当l=Level(b->lchild,x,h+1)\neq 0
\\否则返回在右左子树中的查找结果
\\Level(b,x,h)=Level(b->rchild,x,h+1)
$$

<hr/>
$$
当b=NULL,f(b,x,h)=0
\\当b->data=x,f(b,x,h)=h
\\当l=f(b->lchild,x,h+1)\neq0,f(b,x,h)=1
\\else:f(b,x,h)=f(b->rchild,x,h+1)
$$

```c
int Level(BTNode *b,ElemType x,int h){
  if(b == NULL) return 0; //空树返回0
  else if(b->data == x) return h; //找到返回
  else {
    l=Level(b->lchild,x,h+1); //在左子树中查找
    if(l == 0){ //左子树中未找到
      return Level(b->rchild,x,h+1); //在右子树中找
    } else {
      return l;
    }
  }
}
```



### 二叉树的构造

* 给定一棵二叉树的**先序序列和中序序列**就能唯一确定这棵二叉树 <span style="font-family:'Wingdings 2'">R</span>
* 给定一棵二叉树的**中序序列和后序序列**就能唯一确定这棵二叉树 <span style="font-family:'Wingdings 2'">R</span>
* 给定一棵二叉树的**先序序列和后序序列**就能唯一确定这棵二叉树 <span style="font-family:'Wingdings 2'">W</span>



#### 先序序列和中序序列构造二叉树

```c
BTNode *CreateBT1(char *pre, char *in, int n){
  BTNode *s;
  char *p;
  int k;
  if(n<=0) return NULL;
  s=(BTNode *)malloc(sizeof(BTNode)); //创建根节点
  s->data=*pre;
  for(p=in;p<in+n;p++){ //在in中找为*pre的位置k
    if(*p==*pre) break;
  }
  k=p-in;
  s->lchild = CreateBT1(pre+1, in, k); //构造左子树
  s->rchild = CreateBT1(pre+k+1,p+1,n-k-1); //构造右子树
  return s;
}
```

> 左子树：
>
> * 先序序列为pre+1开始的k个字符
> * 中序序列为in开始的k个字符
>
> 右子树：
>
> * 先序序列为pre+k+1开始的n-k-1个字符
> * 中序序列为p+1开始的n-k-1个字符

<hr/>
#### 中序序列和后序序列构造二叉树

```c
BTNode *CreateBT2(char *post,char *in,int n){
  BTNode *b;
  char r, *p;
  int k;
  if(n<=0) return NULL;
  r=*(post+n-1); //根节点值
  b=(BTNode *)malloc(sizeof(BTNode)); //创建二叉树节点*b
  b->data=r;
  for(p=in;p<in+n;p++){ //在in中查找根节点
    if(*p==r) break;
  }
  k=p-in; //k为根节点在in中的下标
  b->lchild=CreateBT2(post,in,k); //递归构造左子树
  b->rchild=CreateBT2(post+k,p+1,n-k-1);
}
```

> 左子树
>
> * 后序序列为post开始的k个字符
> * 中序序列为in开始的k个字符
>
> 右子树
>
> * 后序序列为post+k开始的n-k-1个字符
> * 中序序列为p+1开始的n-k-1个字符

<hr/>
#### 将顺序存储结构转换成链式

设二叉树的顺序存储结构为a，由$f(a,1)$返回创建的二叉链存储结构的根节点指针b
$$
当i>MaxSize,f(a,i)=NULL;
\\当i对应的节点为空,f(a,i)=NULL;
\\else: f(a,i)=b(创建根节点*b，b->data=a[i])
\\b->lchild=f(a,2*i);
\\b->rchild=f(a,2*i+1);
$$

<hr/>
``` c
BTNode *trans1(SqBTree a, int i){
  BTNode *b;
  if(i>MaxSize) return NULL;
  if(a[i]=='#') return NULL; //当节点不存在时返回NULL
  b=(BTNode *)malloc(sizeof(BTNode)); //创建根节点
  b->data=a[i]; 
  b->lchild=trans1(a,2*i); //递归创建左子树
  b->rchild=trans1(a,2*i+1); //递归创建右子树
  return (b); //返回根节点
}
```



#### 将链式存储结构转换成顺序

$$
f(b,a,i):由二叉链b创建a[i]为根节点的顺序存储结构a
\\初始调用：f(b,a,1)
\\调用前a的所有元素为\#
$$

<hr/>
$$
当b=NULL,f(b,a,i)\equiv不动
\\else:f(b,a,i)\equiv a[i]=b->data(创建根节点);
\\f(b->lchild,a,2*i);
\\f(b->rchild,a,2*i+1);
$$

```c
void *trans2(BTNode *b,SqBTree a,int i){
  if(b!=NULL){
    a[i]=b->data; //创建根节点
    trans2(b->lchild,a,2*i); //递归创建左子树
    trans2(b->rchild,a,2*i+1); //递归创建右子树
  }
}
```

### 线索二叉树

> * 对于具有n个节点的二叉树，采用二叉链存储结构时，每个节点有两个指针域，总共有2n个指针域
> * 其中只有n-1个节点被有效指针所指向，即有n-1个非空指针域
> * 总共有2n-(n-1)=n+1个空链域

* 采用某种方法遍历二叉树的结果是一个节点的线性序列
* 修改空链域改为存放执行节点的前驱和后继节点的地址
* 指向该线性序列中的前驱和后继的指针，称为线索
* 创建线索的过程称为线索化
* 线索化的二叉树称为线索二叉树
* 有先序中序后序
* 线索二叉树的目的是提高该遍历过程的效率



如何实现

在节点的存储结构上添加**两个标志位**来区分

左标志Itag：0表示lchild指向左孩子节点，1表示lchild指向前驱节点，左线索

右标志Itag：0表示rchild指向右孩子节点，1表示rchild指向后继节点，右线索



每个节点的存储结构

| ltag | lchild | data | rchild | rtag |
| ---- | ------ | ---- | ------ | ---- |
|      |        |      |        |      |

```c
typedef struct node {
  ElemType data;//数据域
  int ltag,rtag;//增加线索标记
  struct node *lchild;//左孩子或线索指针
  struct node *rchild;//右孩子或线索指针
} TBTNode;//线索树节点类型定义
```



#### 建立中序线索二叉树的算法

`CreatThread(b)`算法：对以二叉链存储的二叉树b进行中序线索化，并返回线索化后头结点的指针root

Thread(p)算法：对以*p为根节点的二叉树子树的中序线索化



> 在中序遍历中
>
> * p总是指向当前线索化的节点
> * `pre`作为全局变量，指向刚刚访问过的节点
> * `*pre` 是 *p的中序前趋节点，*p 是 `*pre`的中序后继节点



```c
TBTNode *pre;//全局变量
TBTNode *CreatThread(TBTNode *b){//中序线索化二叉树
  TBTNode *root;
  root = (TBTNode *)malloc(sizeof(TBTNode));//创建头节点
  root->ltag = 0;
  root->rtag = 1;
  root->rchild = b;
  if(b==NULL) root->lchild = b;//空二叉树
  else {
    root->lchild = b;
    pre = root; //pre是*p的前趋节点，供加线索用
    Thread(b); //中序遍历线索化二叉树
    pre->rchild = root; //最后处理，加入指向头节点的线索
    pre->rtag = 1;
    root->rchild = pre;
  }
  return root;
}

void Thread(TBTNode *&p){
  if(p!=NULL){
    Thread(p->lchild);//左子树线索化
    if(p->lchild==NULL){//前趋线索化
      p->lchild=pre;//建立当前节点的前趋线索
      p->ltag=1;
    } else p->ltag=0;
    if(pre->rchild==NULL){//后继线索化
      pre->rchild=p;//建立当前节点的后继线索
      pre->rtag=1;
    } else pre->rtag=0;
    pre=p;
    Thread(p->rchild);//递归调用右子树线索化
  }
}
```



# 不想看了，还没写完，以后补



# 图

## 概念

定义

> 图(Graph)G由顶点集合V(G)和边集合E(G)构成
>
> G=(V,E)
>
> V={0,1,2,3,4}
>
> E={(0,1), (0,4), (1,2), (1,3), (2,3), (3,4)}

基本术语

1. 端点和邻接点

   无向图：一条边的两个顶点称为端点，互为邻接点

   有向图：一条边，有起始端点和终止端点，互为邻接点

2. 顶点的度、入度和出度

   无向图：以顶点i为端点的边数称为该顶点的度

   有向图：以顶点i为终点的入边的数目，称为该顶点的入度

   ​			  以顶点i为始点的出边的数目，称为该顶点的出度

   ​			  出度入度之和称为度

3. 完全图

   无向图：每两个顶点之间都存在着一条边，称为完全无向图，包含$\frac{n(n-1)}{2}$条边

   有向图：每两个顶点之间都存在着方向相反的两条边，称为完全有向图，包含$n(n-1)$条边

4. 子图

   边集，点集都是子集，图就是子图

5. 路径和路径长度

   在一个图G=(V,E)中，从顶点i到顶点j的一条路径($i,i_1,i_2,...,i_m,j$)。其中所有的$(i_x,i_y)\in E(G)$，或者$<i_x,i_y>\in E(G)$

   路径长度是指一条路径上经过的边的数目

   若一条路径除了开始点和结束点可以相同外，其余顶点均不相同，则称此路径为简单路径

6. 回路或环

   若一条路径上的开始点与结束点为同一顶点，则此路径被称为回路或环

   开始点与结束点相同的简单路径被称为简单回路或简单环

7. 连通、连通图和连通分量

   无向图：若从顶点i到顶点j有路径，则称顶点i和j是连通的

   若图中任意两个顶点都连通，则称为连通图，否则称为非连通图

   无向图G中的极大连通子图称为G的连通分量。显然，任何连通图的连通分量只有一个，即本身，而非连通图有多个连通分量

8. 强连通图和强连通分量

   有向图：若从顶点i到顶点j有路径，则称从顶点i到j是连通的

   若图G中的任意两个顶点i和j都连通，即从顶点i到j和从顶点j到i都存在路径，则称图G是强连通图

   有向图G中的极大连通子图称为G的强连通分量。显然，强连通图的连通分量只有一个，即本身，而非强连通图有多个强连通分量

   <hr/>
在一个非强连通中找强连通分量的方法
   
1. 在图中找有向环
   2. 扩展该有向环：如果某个顶点到该环中的任一顶点有路径，并且该环中任一顶点到这个顶点也有路径，则加入这个顶点
   
9. 权和网

   图中每一条边都可以附带有一个对应的数值，这种与边相关的数值称为权，权可以表示从一个顶点到另一个顶点的距离或花费的代价

   边上带有权的图称为带权图，也称作网



## 图的存储结构

图的逻辑结构 map到 图的存储结构（存储每个顶点的信息，以及每条边的信息）

图的两种主要存储结构

* 邻接矩阵
* 邻接表

### 邻接矩阵存储

$$
邻接矩阵是表示顶点之间相邻关系的矩阵
\\设G+(V,E)是具有n(n>0)个顶点的图，顶点编号依次为0~n-1
\\G的邻接矩阵A是n阶方阵，定义如下
\\(1)如果G是无向图，则：A[i][j]=1:若(i,j)\in E(G) 0:其他
\\(2)如果G是有向图，则：A[i][j]=1:若<i,j>\in E(G) 0:其他
\\(3)如果G是带权无向图，则：A[i][j]=w_{ij}:若i\neq j且(i,j)\in E(G); 0:i=j; \infty:其他
\\(4)如果G是带权有向图，则：A[i][j]=w_{ij}:若i\neq j且<i,j>\in E(G); 0:i=j; \infty:其他
$$

邻接矩阵的主要特点：

* 一个图的邻接矩阵表示是唯一的
* 特别适合于稠密图的存储（存储空间为$O(n^2)$）

```c++
#define MAXV<最大顶点数>
typedef struct {
  int no;//顶点编号
  InfoType info;//顶点其他信息
} VertexType;

typedef struct {//图的定义
  int edges[MAXV][MAXV];//邻接矩阵
  int n, e;//顶点数、边数
  VertexType vexs[MAXV];//存放顶点信息
} MGraph;
```

### 邻接表存储方法

对图中每个顶点建立一个单链表，将顶点i的所有邻接点链起

每个单链表上添加一个表头节点（表示顶点信息）。并将所有表头节点构成一个数组，下标为i的元素表示顶点i的表头节点

图的邻接表存储方式是一种顺序分配与链式分配相结合的存储方法

邻接表的特点：

* 邻接表表示不唯一
* 适合于稀疏图存储（存储空间为$O(n+e)$）

```c
//声明边节点
typedef struct ANode {
  int adjvex; //该边的终点编号
  struct ANode *nextarc; //指向下一条边的指针
  InfoType info; //该边的权值等信息
} ArcNode;

//声明邻接表头节点类型
typedef struct VNode {
  Vertex data; //顶点信息
  ArcNode *firstarc; //指向第一条边
} VNode;

//声明邻接表类型
typedef struct {
  VNode adjlist[MAXV]; //邻接表
  int n,e; //图中顶点数n和边数e
} ALGraph;
```

一个邻接表通常用指针引用

引用头节点`G->adjlist[i]`

引用头节点的指针域：`G->adjlist[i].firstarc`



## 图的遍历

### 图的遍历的概念

从给定图中任意指定的顶点（称为初始点）出发，按照某种搜索方式沿着图的边访问图中的所有顶点，使每个顶点仅被访问依次，这个过程成果图的遍历

#### 深度优先算法

> 1. 从图中某个初始顶点v出发，首先访问初始顶点v
> 2. 选择一个与顶点v相邻且没被访问过的顶点w，再从w出发并行深度优先搜索，直到图中与当前顶点v邻接的所有顶点都被访问过为止

##### 算法设计思路

* 深度优先遍历的过程体现出后进后出的特点：用栈或递归方式实现

* 如何确定一个顶点是否访问过？设置一个visited[]全局数组

  visited[i]=0表示顶点i没有访问；visited[i]=1表示顶点i已经访问过



邻接表实现DFS算法

```c
void DFS(ALGraph *G, int v){
  ArcNode *p;
  int w;
  visited[v]=1; //置以访问标记
  printf("%d",v); //输出被访问顶点编号
  p=G->adjlist[v].firstarc; //p指向顶点v的第一条边的边头节点
  while(p!=NULL){
    w=p->adjvex;
    if(visited[w]==0){
      DFS(G,w); //若w顶点未访问，递归访问它
    }
    p=p->nextarc; //p指向顶点v的下一条边的边头节点
  }
}
```



#### 广度优先遍历算法

> 1. 访问初始点v，接着访问v的所有未被访问过的邻接点$v_1,v_2,...,v_t$
> 2. 按照$v_1,v_2,...,v_t$的次序，访问每一个顶点的所有未被访问过的邻接点
> 3. 依次类推，直到图中所有和初始点v有路径相通的顶点都被访问过为止

##### 设计思路

* 广度优先搜索遍历体现先进先出的特点，用队列实现

* 如何确定一个顶点是否访问过？设置一个visited[]全局数组

  visited[i]=0表示顶点i没有访问；visited[i]=1表示顶点i已经访问过



采用邻接表的BFS算法

```c
void BFS(ALGraph *G, int v) {
  ArcNode *p;
  int w, i;
  int queue[MAXV], front = 0, rear = 0; //定义循环队列
  int visited[MAXV];
  for(i=0;i<G->n;i++){
    visited[i]=0; //访问标志数组初始化
  }
  printf("%2d",v); //输出被访问顶点的编号
  visited[v]=1; //置以访问标记
  rear=(rear+1)%MAXV;
  queue[rear]=v; //v进队
  while(front!=rear){ //队列不为空时循环
    front=(front+1)%MAXV;
    w=queue[front]; //出队并赋给w
    p=G->adjlist[w].firstarc; //找w的第一个的邻接点
    while(p!=NULL){
      if(visited[p->adjvex]==0){
        printf("%2d",p->adjvex); //访问它
        visited[p->adjvex]=1;
        rear=(rear+1)%MAXV; //相邻顶点进队
        queue[rear]=p->adjvex;
      }
      p=p->nextarc; //找下一个顶点
    }
  }
}
```



#### 非连通图的遍历

无向非连通图：调用依次DFS或BFS，只能访问到初始点所在连通分量中的所有顶点，不可能访问到其他连通分量中的顶点

可以分别遍历每个连通分量，才能够访问到图中的所有顶点

```c
void DFS1(ALGraph *G){
  int i;
  for(i=0;i<G->n;i++){//遍历所有未访问过的顶点
    if(visited[i]==0){
      DFS(G,i);
    }
  }
}
```

```c
void BFS1(ALGraph *G){
  int i;
  for(i=0;i<G->n;i++){//遍历所有未访问过的顶点
    if(visited[i]==0){
      BFS(G,i);
    }
  }
}
```

调用的次数恰好等于连通分量的个数



#### 邻接表判断无向图是否连通

求解思路

> * 采用某种遍历方式来判断无向图G是否连通。可用深度优先遍历方法，先给visited[]数组置初值0，然后从0顶点开始遍历该图
> * 在一次遍历之后，若所有顶点i的          