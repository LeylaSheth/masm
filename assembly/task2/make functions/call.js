/* --------------------CALL-------------------- */
//func.call(thisArg, ...args)
Function.prototype.CALL = function(thisArgs, ...args) {
  const fn = Symbol("fn"); //�����������ƣ��Է�ֹ����
  //thisArgs.fn = this; //����fn����ָ��this��Ҳ���ǵ�ǰ����
  thisArgs = typeof thisArgs === 'object' ? thisArgs || window : {}
  thisArgs[fn] = this;
  thisArgs[fn](...args); //����
  delete thisArgs[fn] //��ԭ
}


/* --------------------APPLY-------------------- */
//func.apply(thisArg, [argsArray])
//��call���ƣ����Ǵ���Ĳ�������������
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
  delete thisArg[fn] // ��ͬ�� delete ������
}

/* --------------------BIND-------------------- */
//bind()��������һ���µĺ�������bind()������ʱ������º�����this��bind�ĵ�һ������ָ��������Ĳ�������Ϊ�º����Ĳ���������ʱʹ�á�
Function.prototype.BIND = function(thisArg) {
  let self = this;
  let agrs = Array.prototype.slice.CALL(arguments, 1); //�ӵڶ���������ʼȡ
  return function() { //BIND����һ���º���������
    let bindArgs = Array.prototype.slice.CALL(arguments);
    return self.APPLY(thisArg, args.concat(bindArgs)); //ʹ��APPLY���󶨣�ʹ�ô���Ķ���ָ��
  }
}

/* --------------------NEW-------------------- */
//new��ʵ��
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
foo.CALL(obj, 'fn', 'a'); //fn����foo()

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