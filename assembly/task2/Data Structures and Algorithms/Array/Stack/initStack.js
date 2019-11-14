class arrayStack {
  constructor() {
      this.items = [];
    }
    //添加元素
  push(element) {
      this.items.push(element);
    }
    //移除元素
  pop() {
      return this.items.pop();
    }
    //查看栈顶元素
  peek() {
      return this.items[this.items.length - 1];
    }
    //检查栈是否为空
  isEmpty() {
      return this.items.length === 0;
    }
    //查看栈的大小
  size() {
      return this.items.length;
    }
    //清空栈
  clear() {
    this.items = [];
  }
}


const stack = new arrayStack();


class objStack {
  constructor() {
      this.items = {};
      this.count = 0;
    }
    //添加元素
  push(element) {
      this.items[this.count] = element;
      this.count++;
    }
    //移除元素
  pop() {
      if (this.isEmpty) {
        return undefined;
      }
      this.count--;
      const result = this.items[this.count];
      delete this.items[this.count];
      return result;
    }
    //查看栈顶元素
  peek() {
      if (this.isEmpty) {
        return undefined;
      }
      return this.items[this.count - 1];
    }
    //检查栈是否为空
  isEmpty() {
      return this.count === 0;
    }
    //查看栈的大小
  size() {
      return this.count;
    }
    //清空栈                                                                                                                                                                                                                                                                       
  clear() {
    this.items = {};
    this.count = 0;
  }
}




var isValid = function(s) {
  let match = true;
  let arr = s.split();
  let myArr = [];
  let i = 0;
  while (i < arr.lenght && match) {
    if (arr[i] === "(" || arr[i] === "[" || arr[i] === "{") {
      myArr.push(arr[i]);
    } else if (arr[i] === ")" || arr[i] === "]" || arr[i] === "}") {
      if (myArr[lenght - 1] === arr[i]) {

      }
    }
  }
};