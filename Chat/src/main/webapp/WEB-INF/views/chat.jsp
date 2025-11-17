<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String nick = request.getParameter("nick");
    if(nick == null || nick.trim().isEmpty()){
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅방 - <%= nick %></title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        #chat { width: 100%; height: 400px; border: 1px solid #ccc; overflow-y: auto; padding: 10px; margin-bottom: 10px; background: #f9f9f9; }
        #inputBox { display: flex; }
        #msg { flex: 1; padding: 5px; font-size: 14px; }
        #sendBtn { padding: 5px 10px; font-size: 14px; }
        .system { color: gray; }
    </style>
</head>
<body>

<h2>채팅방 (닉네임: <%= nick %>)</h2>
<div id="chat"></div>

<div id="inputBox">
    <input type="text" id="msg" placeholder="메시지를 입력하세요" />
    <button id="sendBtn">전송</button>
</div>

<script>
    // WebSocket 서버 주소
    var ws = new WebSocket("ws://" + location.host + "<%= request.getContextPath() %>/ws/chat");
    var nick = "<%= nick.replace("\"","\\\"") %>";

    var chatDiv = document.getElementById("chat");
    var input = document.getElementById("msg");
    var sendBtn = document.getElementById("sendBtn");

    // 서버로부터 메시지 수신
    ws.onmessage = function(event){
        appendMessage(event.data);
    };

    ws.onopen = function(){
        appendMessage("[시스템] 서버와 연결되었습니다.", "system");
    };

    ws.onclose = function(){
        appendMessage("[시스템] 서버와의 연결이 끊어졌습니다.", "system");
    };

    function appendMessage(text, type){
        var p = document.createElement("div");
        if(type === "system") p.classList.add("system");
        p.textContent = text;
        chatDiv.appendChild(p);
        chatDiv.scrollTop = chatDiv.scrollHeight;
    }

    function sendMsg(){
        var text = input.value.trim();
        if(!text) return;
        ws.send("[" + nick + "] " + text);
        input.value = "";
        input.focus();
    }

    sendBtn.addEventListener("click", sendMsg);
    input.addEventListener("keydown", function(e){
        if(e.key === "Enter") sendMsg();
    });

    window.addEventListener("beforeunload", function () {
        try { ws.close(); } catch(e) {}
    });
</script>

</body>
</html>
