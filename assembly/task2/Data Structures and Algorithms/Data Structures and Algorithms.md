# 数组

## 创建和初始化数组

```javascript
let daysOfWeek = new Array();
let daysOfWeek = [];
```

### 访问元素和迭代数组

for循环，根据下标遍历

## 添加元素

### 在数组末尾插入`push`

```javascript
number.push(12,13);
```

### 在数组开头插入`unshift`

```javascript
Array.prototype.insertFirstPosition = function(value){
  for(let i = this.length; i>=0; i--){
    this[i] = this[i-1];//依次后移一位
  }
  this[0] = value;
}
numbers.insertFirstPositon(-1);
```

原生给出的方法

```javascript
numbers.unshift(-4,-3)
```



## 删除元素

### 从数组末尾删除元素`pop`

```javascript
numbers.pop();
```

### 从数组开头删除元素`shift`

```javascript
for(let i = 0; i < numbers.lenght; i++){
  numbers[i] = numbers[i+1];
}
//这个方法有漏洞，数组的长度没有改变，最后一个元素undefined
```

```javascript
Array.prototype.reIndex = function(myArray) {
  const newArray = [];
  for(let i = 0; i < myArray.length; i++){
    if(myArray !== undefined){
      newArray.push(myArray[i]);
    }
  }
  return newArray;
}
```



### 在任意位置添加或删除元素`splice`

通过位置索引，删除相应位置上指定数量的元素

```javascript
numbers.splice(5,3);//从索引5开始删除3个元素
numbers.splice(5,3,2,3,4);//删除三个之后又加入2,3,4
```



## 数组方法

| 方法        | 描述                                                         |
| ----------- | ------------------------------------------------------------ |
| concat      | 连接2个或多个数组并返回结果                                  |
| every       | 对数组中的每个元素运行给定函数，如果该函数对每个元素都返回true，则返回true |
| filter      | 对数组中的每个元素运行给定函数，返回函数会返回true的元素组成的数组 |
| forEach     | 对数组中的每个元素运行给定函数，没有返回值                   |
| join        | 将所有的数组元素连接成一个字符串                             |
| indexOf     | 返回第一个与给定参数相等的数组元素的所有，没找到则返回-1     |
| lastIndexOf | 返回在数组中搜索到的与给定参数相等的元素的索引最大值         |
| map         | 对数组中的每个元素运行给定函数，返回每次函数调用的结果组成的数组 |
| reverse     | 翻转数组                                                     |
| slice       | 传入索引值，将数组里对应索引范围内的元素作为新数组返回       |
| some        | 对数组中的每个元素运行给定函数，任一为true，则返回true       |
| sort        | 按照字母顺序对数组排序，支持传入指定排序方法的函数作为参数   |
| toString    | 将数组作为字符串返回                                         |
| valueOf     | 类似toString                                                 |

