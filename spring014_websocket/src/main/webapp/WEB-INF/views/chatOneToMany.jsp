<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>1:N채팅화면</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
	table{
		margin: auto;
		border: 1px solid black;
		width: 100%;
		height: 500px;
	}
	.container{
		width: 600px;
		margin: auto;
	}

</style>
</head>
<!-- TODO 003 채팅화면 구현 및 이벤트 작성페이지 -->
<script src="${pageContext.request.contextPath}/js/chatOneToMany.js"></script>


<body>
	<div class="container">
		<button style="width: 100%;" onclick="disconnection()">연결종료</button>
		<table>
			<tbody>
				<tr>
					<td align="center">
						<div id="resive_msg" style="overflow: scroll; width: 100%; height: 500px" >
							<input type="text" id="nickName" onkeypress="if(event.keyCode==13){$('#join_room').click()}" style= "width: 200px; height: 25px;">                        
							<input type="button" value="대화입장" id="join_room">
						</div>
					</td>
				</tr>
			</tbody>		
		</table>
		<div id="chat_div" style="display: none;">
			<input type="text" id="chat" style="width: 100%;" onkeypress="if(event.keyCode==13){$('#chat_btn').click()}">
			<input type="button" id="chat_btn" style="width: 100%;" value="전송">
		</div>
	
	</div>
	

</body>
</html>