<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>채팅구현</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<script type="text/javascript">
	window.onload=function(){ //웹페이지가 완전히 로드된 뒤에 실행할 코드를 지정
		
		//TODO 002 일대다 채팅 Controller 요청
		document.querySelector(".btn-primary").onclick=function(){
			location.href="./chatOneToMany.do";
		}
		document.querySelector(".btn-success").onclick=function(){
			location.href="./chatGroup.do";
		}
	}
</script>

<body>
	<div class="container" style="margin-top:200px; text-align:center;">
		<button class="btn btn-primary">1:N 채팅</button>
		<button class="btn btn-success">Group 채팅</button>
	</div>
</body>
</html>