<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- context path 값을 내장객체 변수로 저장한다: contextPath라는 변수를 만들고, 현재 애플리케이션의 context path 값을 저장한다-->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>2025 SEOUL MARATHON</title>
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
					<li class="#"><a href="${contextPath}/">메인</a></li> <!--루트(/)만 입력하면 controller(context path)가 생략되므로, 명시적으로 /controller/를 입력 -->
					<li><a href="boardMain.do">커뮤니티</a></li>
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
									
					<c:if test="${mvo.memProfile ne ''}">
						<li>
							<img style="width:50px; height:50px;" class="img-circle" alt="" src= "${contextPath}/resources/upload/${mvo.memProfile}"
						<li>
					</c:if>
					
					<c:if test="${mvo.memProfile eq ''}">
						<li>
							<img style="width:50px; height:50px;" class="img-circle" alt="" src= "${contextPath}/resources/upload/default.png"
						<li>
					</c:if>
					
					${mvo.memName}님 환영합니다
					
					<li><a href="${contextPath}/updateForm.do"><span class="glyphicon glyphicon-edit"></span>&nbsp;회원정보수정</a></li>
					<li><a href="${contextPath}/imageForm.do"><span class="glyphicon glyphicon-picture"></span>&nbsp;프로필사진등록</a></li>
					<li><a href="${contextPath}/logout.do"><span class="glyphicon glyphicon-log-out"></span>&nbsp;로그아웃</a></li>	
					
				
				</ul>
				</c:if>
				
			</div>
		</div>
	</nav>
	
</body>
</html>