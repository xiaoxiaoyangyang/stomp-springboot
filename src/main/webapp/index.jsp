<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>My JSP 'index.jsp' starting page</title>
    <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/sockjs.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/stomp.js"></script>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <script type="text/javascript">
        // var stompClient=null;
        // $(document).ready(function(){
        //     var socket = new SockJS("http://localhost:8888/webSocketServer");
        //     stompClient = Stomp.over(socket);
        //     stompClient.connect({}, function(frame) {
        //         stompClient.subscribe('/topic/public', function(txt) {
        //             alert(txt);
        //         });
        //     });
        // })
        // function send(txt) {
        //     stompClient.send("/app/send", {}, txt);
        // }
        var stompClient=null;
        $(document).ready(function(){
            // 建立连接对象（还未发起连接）
            var socket = new SockJS("http://localhost:8888/webSocketServer");

            // 获取 STOMP 子协议的客户端对象
            stompClient = Stomp.over(socket);

            // 向服务器发起websocket连接并发送CONNECT帧
            stompClient.connect(
                {},
                function connectCallback(frame) {
                    // 连接成功时（服务器响应 CONNECTED 帧）的回调方法
                    setMessageInnerHTML("连接成功");
                    stompClient.subscribe('/app/subscribeTest', function (response) {
                       setMessageInnerHTML("已成功订阅/app/subscribeTest");
                       var returnData = JSON.parse(response.body);
                       setMessageInnerHTML("/app/subscribeTest 你接收到的消息为:" + returnData.responseMessage);
                //       setMessageInnerHTML("/app/subscribeTest 你接收到的消息为:" + response);
                    });
                },
                function errorCallBack(error) {
                    // 连接失败时（服务器响应 ERROR 帧）的回调方法
                    setMessageInnerHTML("连接失败");
                }
            );
        });

        //发送消息
        function send() {
            var message = document.getElementById('text').value;
            var messageJson = JSON.stringify({ "name": message });
            stompClient.send("/app/sendTest", {}, messageJson);
            setMessageInnerHTML("/app/sendTest 你发送的消息:" + message);
        }

        //订阅消息
        function subscribe1() {
            stompClient.subscribe('/topic/subscribeTest', function (response) {
                setMessageInnerHTML("已成功订阅/topic/subscribeTest");
                var returnData = JSON.parse(response.body);
                setMessageInnerHTML("/topic/subscribeTest 你接收到的消息为:" + returnData.responseMessage);
            });
        }

        //订阅消息
        function subscribe2() {
            stompClient.subscribe('/topic/sendTest', function (response) {
                setMessageInnerHTML("已成功订阅/topic/sendTest");
                var returnData = JSON.parse(response.body);
                setMessageInnerHTML("/topic/sendTest 你接收到的消息为:" + returnData.responseMessage);
            });
        }

        //将消息显示在网页上
        function setMessageInnerHTML(innerHTML) {
            document.getElementById('message').innerHTML += innerHTML + '<br/>';
        }

    </script>
</head>

<body>
 <%--<button onclick="send(new Date())">Send</button>--%>
    Welcome<br/><input id="text" type="text" />
    <button onclick="send()">发送消息</button>
    <button onclick="subscribe2()">订阅消息/topic/sendTest</button>
    <button onclick="subscribe1()">订阅消息/topic/subscribeTest</button>
    <hr/>
    <button onclick="closeWebSocket()">关闭WebSocket连接</button>
    <hr/>
    <div id="message"></div>
</body>

</html>

