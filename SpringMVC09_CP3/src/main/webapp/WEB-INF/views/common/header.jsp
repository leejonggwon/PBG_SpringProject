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
<title>Spring MVC09</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 메뉴바 -->
	<nav class="navbar navbar-default">
		<div class="container-fluid">
		
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">SEOUL MARATHON</a>
			</div>
				
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav">
					<li class="#"><a href="${cpath}/board/list/">메인</a></li> <!--루트(/)만 입력하면 controller(context path)가 생략되므로, 명시적으로 /controller/를 입력 -->
					<li><a href="#">커뮤니티</a></li>
				</ul>	
				
				<!-- 세션이 비어있어 로그인하지 않은 상태일 때 보여줄 영역  --> 
				<c:if test="${empty mvo}">
				<ul class="nav navbar-nav navbar-right">		
					<li><a href="${contextPath}/loginForm.do"><span class="glyphicon glyphicon-log-in"></span>&nbsp;로그인</a></li>
					<li><a href="${contextPath}/joinForm.do"><span class="glyphicon glyphicon-check"></span>&nbsp;회원가입</a></li> <!-- contextPath를 붙여서 배포 환경이 바뀌어도 항상 올바른 경로로 이동하도록 함 -->			
				</ul>
				</c:if>
					 
							
				<!-- 로그인된 사용자(세션이 유효한 경우)에게 보여주는 영역  --> 
				<c:if test="${not empty mvo}"> <!-- mvo로 session을 꺼내기로 했다 -->
				<ul class="nav navbar-nav navbar-right">
				
					<c:if test="${not empty mvo.memProfile}">
					    <li>				    	
					        <img style="width:50px; height:50px;" class="img-circle" alt="" src="${cpath}/resources/upload/${mvo.memProfile}" />
					   		<span>${mvo.memName}님 환영합니다</span>
					    </li>
					</c:if>
					
					<c:if test="${empty mvo.memProfile}">
					    <li>				    	
					        <img style="width:50px; height:50px;" class="img-circle" alt="" src="${cpath}/resources/images/default.png" /> 
					    	<span>${mvo.memName}님 환영합니다</span>
					    </li>
					</c:if>
				
													
					
					
					<li><a href="${cpath}/member/updateForm"><span class="glyphicon glyphicon-edit"></span>&nbsp;회원정보수정</a></li>
					<li><a href="${cpath}/member/imageForm"><span class="glyphicon glyphicon-picture"></span>&nbsp;프로필사진등록</a></li>
					<li><a href="#"><span class="glyphicon glyphicon-log-out"></span>&nbsp;로그아웃</a></li>								
				</ul>
				
				
				</c:if>
				
			</div>
		</div>
	</nav>
	
</body>
</html>