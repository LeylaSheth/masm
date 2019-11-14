//模拟一段ajax请求
function ajax(content) {
    console.log("ajax content" + content);
}

//一个节流函数
function debounce(fun, delay) {
    return function(args) {
        let _this = this;
        let _args = args;
        clearTimeout(fun.id);
        fun.id = setTimeout(function() {
            fun.call(_this, _args);
        }, delay)
    }
}

let myInput = document.getElementById("unDebounce");

let debounceAjax = debounce(ajax, 500)

myInput.addEventListener("keyup", function(e) {
    debounceAjax(e.target.value);
})

let biu = function() {
    console.log("biu biu biu", new Date().toDateString("HH:mm:ss"));
}

let boom = function() {
    console.log("hoom boom boom", new Date().toDateString("HH:mm:ss"));
}

setInterval(debounce(biu, 500), 1000);
setInterval(debounce(boom, 2000), 1000);
//这里的问题就在于，即使使用了防抖函数，还是有问题，这里无法使用boom
//这里boom不会执行，他的时间间隔是2s，但是执行的时间是1s，所以一直会重新触发计时

function throttle(fun, delay) {
    let last, deferTimer;
    return function(agrs) {
        let _this = this;
        let _args = agrs;
        let now = +new Date();
        if (last && now < last) {}
    }
}