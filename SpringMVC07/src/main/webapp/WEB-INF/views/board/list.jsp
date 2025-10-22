<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><!-- 줄바꿈, 날짜일정문자 잘라내는 기능들이 있다 --> 

<!-- fmt 태그는 주로 날짜/시간, 숫자, 메시지 포맷 처리에 사용 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring MVC07</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<h2>Spring MVC07</h2>
		<div class="panel panel-default">
			<div class="panel-heading">
				<form class="form-inline" action="${cpath}/login/loginProcess" method="post">
					<div class="form-group">
						<label for="id">ID:
						<input type="text" class="form-control" id="id" nmae="memID">
					</div>
					<div class="form-group">
						<label for="pwd">Password:</label>
						<input type="password" class="form-control" id="pwd" nmae="memPwd">
					</div>
					
					<button type="submit" class="btn btn-defult">로그인</button>
				</form>
			</div>
			<div class="panel-body">
				<table class= "table table-bordered table-hover">
					<thead> <!-- thead: 테이블헤더를 구분해주는 영역태그 -->
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody> <!-- tbody: 테이블안에 영역구분하기 위한 태그 -->
						<c:forEach items="${list}" var="vo" varStatus="i"> <!-- model.addAttribute("list", list) -->
				            <tr>
				                <td>${i.count}</td> <!--i.count:1부터, i.index:0부터 -->
				                <td>${vo.title}</td>
				                <td>${vo.writer}</td>
				                <td>
				                	<fmt:formatDate value="${vo.indate}" pattern="yyyy-MM-dd"/>			             
				                </td>
				                <td>${vo.count}</td>
				            </tr>
				        </c:forEach>
					</tbody>
					<tr>
						<td colspan="5">
							<button id="regBtn" class="btn bts-xs btn-info pull-right">글쓰기</button>
						</td>
					</tr>			
				</table>
			</div>
			<div class="panel-footer">스프링게시판 - 이종권</div>
		</div>
	</div>
	<script type="text/javascript">
		//페이지가 다 로드 되면 함수를 실행하겠다 
		$(document).ready(function() {
			$("#regBtn").click(function(){
				//클릭하면 클쓰기 페이지 이동
				location.href="${cpath}/board/register"; 
			});
		});
	</script>
</body>
</html>





