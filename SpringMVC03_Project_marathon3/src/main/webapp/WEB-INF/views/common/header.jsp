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
<title>2026 HANKUK MARATHON</title>
</head>
<style>

/*검정색 띠같은 ouline속성제거*/
.nav-tabs > li > a:focus, 
.nav-tabs > li > a:active,
.navbar-nav > li > a:focus,
.navbar-nav > li > a:active,
.navbar-brand:focus,
.navbar-brand:active {
    outline: none !important;
    box-shadow: none !important; /* 혹시 모를 부트스트랩 그림자 효과도 함께 제거 */
}

</style>
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
				<a class="navbar-brand" href="${contextPath}/">2026 HANKUK MARATHON</a>
			</div>
				
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav">
				
					<li><a href="${contextPath}/boardMain.do">공지사항</a></li>
					<li><a href="${contextPath}/record/recordSearch.do">개인기록조회</a></li>
				</ul>	
					 
				<!-- 세션이 비어있어 로그인하지 않은 상태일 때 보여줄 영역  --> 
				<c:if test="${empty mvo}">
				<ul class="nav navbar-nav navbar-right">		
					<li><a href="${contextPath}/loginForm.do">관리자로그인</a></li>		
				</ul>
				</c:if>
				
				<!-- 로그인된 사용자(세션이 유효한 경우)에게 보여주는 영역  --> 
				<c:if test="${not empty mvo}"> <!-- mvo로 session을 꺼내기로 했다 -->
				<ul class="nav navbar-nav navbar-right">
			
					<li style="padding: 15px; color: #333; margin-right: 20px;">
						<span class="glyphicon glyphicon-user" style="margin-right:6px"></span>${mvo.memName}님 환영합니다
					</li>		

					<li><a href="${contextPath}/updateForm.do">회원정보수정</a></li>				
					<li><a href="${contextPath}/logout.do">로그아웃</a></li>	
					
				
				</ul>
				</c:if>
				
			</div>
		</div>
	</nav>
	
</body>
</html>