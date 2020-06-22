<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<p>小星星</p>
<form onsubmit="return false">
    <textarea id="responseText" style="height: 150px; width: 300px;"></textarea>
    <input type="button" value="清空内容" onclick="document.getElementById('responseText').value=''">
</form>
<form onsubmit="return false">
    <textarea autofocus id="responseText1" style="height: 150px; width: 300px;"></textarea>
    <input type="button" id="btnSend"  value="发送" />
</form>
<script>
    var socket;
    // 判断当前浏览器是否支持webSocket
    if(window.WebSocket){
        socket = new WebSocket("ws://192.168.1.101:58080/webSocket")
        // 相当于channel的read事件，ev 收到服务器回送的消息
        socket.onmessage = function (ev) {
            var rt = document.getElementById("responseText");
            rt.value = rt.value + "\n" +ev.data;
            down();
        }

        //发送消息
        var btn = document.getElementById('btnSend');
        btn.onclick = function(){
            console.log("调用方法")
            var rt = document.getElementById("responseText1");
            console.log(rt.value)
            if (rt.value=="" || rt.value ==null){
                alert("输入不能为空");
                return;
            }
            socket.send(
                    JSON.stringify({
                        // 连接成功将，用户ID传给服务端
                        uid: "456789",
                        yid: "123456",
                        msg: rt.value
                    })
            );
            rt.value="";
        };

        // 相当于连接开启
        socket.onopen = function (ev) {
            var rt = document.getElementById("responseText");
            rt.value =  "连接开启了..."
            socket.send(
                    JSON.stringify({
                        // 连接成功将，用户ID传给服务端
                        uid: "456789"
                    })
            );
        }
        // 相当于连接关闭
        socket.onclose = function (ev) {
            var rt = document.getElementById("responseText");
            rt.value = rt.value + "\n" + "连接关闭了...";
        }
    }else{
        alert("当前浏览器不支持webSocket")
    }
</script>
<script>
    function down() {
        var textarea = document.getElementById("responseText");
        textarea.scrollTop = textarea.scrollHeight;
    }
</script>
</body>
</html>