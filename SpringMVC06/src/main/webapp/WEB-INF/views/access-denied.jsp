<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 너 권한이 없어 다시 로그인해서 접근해 알려주기 -->
	<h2>Access Denied - You are not authorized to access this resouce.</h2>
	<hr>
	<a href="${pageContext.request.contextPath}/">Back to Home Page</a> 
	<!-- contextPath값을 가져오는 방법, 애플리케이션의 “메인 페이지” 혹은 시작 페이지로 연결되는 링크 --> 
	
</body>
</html>