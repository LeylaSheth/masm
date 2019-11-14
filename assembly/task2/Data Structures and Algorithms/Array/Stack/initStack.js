class arrayStack {
  constructor() {
      this.items = [];
    }
    //���Ԫ��
  push(element) {
      this.items.push(element);
    }
    //�Ƴ�Ԫ��
  pop() {
      return this.items.pop();
    }
    //�鿴ջ��Ԫ��
  peek() {
      return this.items[this.items.length - 1];
    }
    //���ջ�Ƿ�Ϊ��
  isEmpty() {
      return this.items.length === 0;
    }
    //�鿴ջ�Ĵ�С
  size() {
      return this.items.length;
    }
    //���ջ
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
    //���Ԫ��
  push(element) {
      this.items[this.count] = element;
      this.count++;
    }
    //�Ƴ�Ԫ��
  pop() {
      if (this.isEmpty) {
        return undefined;
      }
      this.count--;
      const result = this.items[this.count];
      delete this.items[this.count];
      return result;
    }
    //�鿴ջ��Ԫ��
  peek() {
      if (this.isEmpty) {
        return undefined;
      }
      return this.items[this.count - 1];
    }
    //���ջ�Ƿ�Ϊ��
  isEmpty() {
      return this.count === 0;
    }
    //�鿴ջ�Ĵ�С
  size() {
      return this.count;
    }
    //���ջ                                                                                                                                                                                                                                                                       
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