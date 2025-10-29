<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--JSTL Core 라이브러리: JSP에서 조건문, 반복문, 변수 설정 등을 할 때 사용, 자바 코드 대신 JSTL 문법으로 표현 가능 -->     
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!-- JSTL Functions(함수) 라이브러리: 줄바꿈, 날짜일정문자 잘라내는 기능들이 있다 -->  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!--JSTL Formatting라이브러리: fmt 태그는 주로 날짜/시간, 숫자, 메시지 포맷 처리에 사용 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!-- ${cpath}/login/loginProcess 이렇게 쓰인다  -->

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
		<div class="panel-heading">Board</div>
		<div class="panel-body">
			<form action="${cpath}/board/modify" method="post">
			<table class="table table-bordered table-hover">
				<tr>
					<td>번호</td>
					<td><input readonly="readonly" value="${vo.idx}" name="idx" type="text" class="form-control"></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input value="${vo.title}" name="title" type="text" class="form-control"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<textarea name="content" class="form-control" rows="10" cols="">${vo.content}</textarea>
					</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input readonly="readonly" value="${vo.writer}" name="writer" type="text" class="form-control"></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center">
						<button type="submit" class="btn btn-sm btn-primary">수정</button>
						<button type="button" onclick="location.href='${cpath}/board/remove?idx=${vo.idx}'" class="btn btn-sm btn-success">삭제</button>   
						<button type="button" onclick="location.href='${cpath}/board/list'" class="btn btn-sm btn-warning">목록</button>
					</td>
				</tr>
			</table>
			</form>
		</div>
		<div class="panel-footer">스프링게시판 - 이종권</div>
	  </div>
	</div>
	
	<script type="text/javascript">

	</script>
	
</body>
</html>





