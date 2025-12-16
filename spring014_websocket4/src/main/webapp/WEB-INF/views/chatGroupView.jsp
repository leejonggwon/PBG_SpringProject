<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- TODO 013 채팅그룹 화면 구성 -->
  <title>그룹채팅화면</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/chatGroupView.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/chatGroup.js"></script>
</head>
<body>
	현재 참여중인 자신의 정보 및 채팅 리스트<br>
	아이디 : ${sessionScope.mem_id}<br>
	그룹아이디 : ${sessionScope.gr_id}<br>
	채팅참여 리스트 : ${applicationScope.chatList} 
	<hr>
	<div class="container">
		<button class="btn btn-danger btn-block" onclick="roomClose()">채팅종료</button>
		<table>
			<tr>
				<td colspan="2" align="center">채팅그룹명:<b id="group">${gr_id}</b></td>
			</tr>
			<tr>
				<td width="300px" height="400px" align="center">
					<div class="resive_msg" style="border: 1px">
						<div id="nickName">접속자 아이디: <b>${mem_id}</b></div>
					</div>
				</td>
				<td width="130px" class="memListBox">
					<div class="listTitle">접속자 목록</div>
					<div class="memList"></div>
				</td>
			</tr>
		</table>
		<div class="chat_div">
			<input type="text" class="chat" onkeypress="if(event.keyCode==13)$('.chat_btn').click();">
			<input type="button" class="chat_btn" value="내용전송">
		</div>
	</div>
	
	
</body>
</html>
















