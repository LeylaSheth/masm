//ģ��һ��ajax����
function ajax(content) {
    console.log("ajax content" + content);
}

//һ����������
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
//�������������ڣ���ʹʹ���˷������������������⣬�����޷�ʹ��boom
//����boom����ִ�У�����ʱ������2s������ִ�е�ʱ����1s������һֱ�����´�����ʱ

function throttle(fun, delay) {
    let last, deferTimer;
    return function(agrs) {
        let _this = this;
        let _args = agrs;
        let now = +new Date();
        if (last && now < last) {}
    }
}