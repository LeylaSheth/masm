/* --------------------CALL-------------------- */
//func.call(thisArg, ...args)
Function.prototype.CALL = function(thisArgs, ...args) {
  const fn = Symbol("fn"); //创建属性名称，以防止重名
  //thisArgs.fn = this; //创建fn属性指向this，也就是当前对象
  thisArgs = typeof thisArgs === 'object' ? thisArgs || window : {}
  thisArgs[fn] = this;
  thisArgs[fn](...args); //调用
  delete thisArgs[fn] //还原
}


/* --------------------APPLY-------------------- */
//func.apply(thisArg, [argsArray])
//与call相似，但是传入的参数必须是数组
Function.prototype.APPLY = function(thisArg, argsArray) {
  const fn = Symbol("fn")
  thisArg = typeof thisArg === 'object' ? thisArg || window : {}
  thisArg[fn] = this;
  if (!argsArray) {
    thisArg[fn]();
  } else if (argsArray instanceof Array) {
    argsArray = new Array(argsArray);
    thisArg[fn](...argsArray[argsArray.length - 1]);
  } else {
    throw TypeError("The argsArray is not an Array");
  }
  delete thisArg[fn] // 等同于 delete 操作符
}

/* --------------------BIND-------------------- */
//bind()方法创建一个新的函数，在bind()被调用时，这个新函数的this被bind的第一个参数指定，其余的参数将作为新函数的参数供调用时使用。
Function.prototype.BIND = function(thisArg) {
  let self = this;
  let agrs = Array.prototype.slice.CALL(arguments, 1); //从第二个参数开始取
  return function() { //BIND创建一个新函数并返回
    let bindArgs = Array.prototype.slice.CALL(arguments);
    return self.APPLY(thisArg, args.concat(bindArgs)); //使用APPLY来绑定，使得传入的对象指向
  }
}

/* --------------------NEW-------------------- */
//new的实现
function NEW() {
  var Func = [].shift.call(arguments);
  var obj = Object.create(Func.prototype);
  Func.CALL(obj, arguments);
  return obj;
}




/* ---------------------TEST-------------------- */


function Person(name, age) {
  this.name = name;
  this.age = age;

}

let xm = NEW(Person, 'xiaoming', 18);
console.log(xm);

function foo() {
  for (let i = 0; i < arguments.length; i++) {
    console.log(this[arguments[i]]);
  }
}


let obj = { fn: 1, a: 'Hello' }
foo.CALL(obj, 'fn', 'a'); //fn传入foo()

var fuu = {
  value: 1
};


function bar(name, age) {
  console.log(this.value);
  console.log(name);
  console.log(age);

}

var bindFoo = bar.bind(fuu, 'daisy');
bindFoo('18');
// 1
// daisy
// 18