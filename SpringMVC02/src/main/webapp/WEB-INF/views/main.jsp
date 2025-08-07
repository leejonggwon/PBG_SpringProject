<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring MVC02</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<h2>Spring MVC02 비동기방식</h2>
		<div class="panel panel-default">
			<div class="panel-heading">Board</div>
			<div class="panel-body">
				<table class="table table-bordered table-hover">
					<tr class="active">
						<td>번호</td>
						<td>제목</td>
						<td>작성자</td>
						<td>작성일</td>
						<td>조회수</td>
					</tr>
					
					<tbody id="#view">
					<!-- 비동기 방식으로 가져온 게시글 나오게할 부분-->	
						
						
					</tbody>
					

				</table>
						
			</div>
			<div class="panel-footer">스프링게시판 - 이종권</div>
		</div>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function(){
			//HTML 요소들이 다 로딩되고나서 아래 코드실행한다 
			loadList();
		});
	
		function loadList() {
			//기능: 비동기방식으로 게시글 리스트 가져오기 기능
			//ajax - 요청 url, 어떻게 데이터 받을지, 요청방식 등 ... → 객체형태 
			$.ajax({
				url : "boardList.do", //이 주소로 비동기 요청을 보낸다
				type: "get",
				dataType: "json",  //받을 데이터 타입
				success: makeView, //콜백함수 성공시 makeView 함수 요청
				error: function(){ alert("error"); }
			});
		}
		
		//서버로부터 비동기방식통신을 하고 나서 성공했을때 작동하는 함수 
		function makeView(data){
			console.log(data);
		}
	
	
	
	</script>
	
</body>
</html>





