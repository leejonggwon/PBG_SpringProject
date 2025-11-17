<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅 시작</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 50px; text-align: center; }
        h2 { margin-bottom: 20px; }
        input { padding: 10px; font-size: 16px; width: 200px; }
        button { padding: 10px 20px; font-size: 16px; }
    </style>
</head>
<body>

<h2>닉네임을 입력하세요</h2>
<form action="chat" method="get">
    <input type="text" name="nick" placeholder="닉네임" required />
    <button type="submit">채팅 시작</button>
</form>

</body>
</html>
