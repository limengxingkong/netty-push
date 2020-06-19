<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>

<form onsubmit="return false">
    <textarea id="responseText" style="height: 150px; width: 300px;"></textarea>
    <input type="button" value="清空内容" onclick="document.getElementById('responseText').value=''">
</form>
<form onsubmit="return false">
    <textarea id="responseText1" style="height: 150px; width: 300px;"></textarea>
    <input type="button" id="btnSend"  value="发送" />
</form>

<script>
    var socket;
    // 判断当前浏览器是否支持webSocket
    if(window.WebSocket){
        socket = new WebSocket("ws://localhost:58080/webSocket")
        // 相当于channel的read事件，ev 收到服务器回送的消息
        socket.onmessage = function (ev) {
            var rt = document.getElementById("responseText");
            rt.value = rt.value + "\n" + ev.data;
        }

        //发送消息
        var btn = document.getElementById('btnSend');
        btn.onclick = function(){
            console.log("调用方法")
            var rt = document.getElementById("responseText1");
            console.log(rt.value)
            socket.send(
                    JSON.stringify({
                        // 连接成功将，用户ID传给服务端
                        uid: rt.value
                    })
            );

        };

        // 相当于连接开启
        socket.onopen = function (ev) {
            var rt = document.getElementById("responseText");
            rt.value =  "连接开启了..."
            socket.send(
                    JSON.stringify({
                        // 连接成功将，用户ID传给服务端
                        uid: "123456"
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

</body>
</html>