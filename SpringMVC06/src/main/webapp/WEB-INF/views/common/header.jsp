<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- context path 값을 내장객체 변수로 저장한다: contextPath라는 변수를 만들고, 현재 애플리케이션의 context path 값을 저장한다-->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!-- Spring Security에서 제공하는 태그라이브러리(보안관련된 태그라이브러리) -->
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!-- Spring Security에서 제공하는 계정정보 (SecurityContext 안에 계정정보 가져오기) -->
<!-- 로그인한 계정정보 
     MemberUserDetailsService에 있는 계정정보를 mvo를 받아온것이다-->
<!-- 로그인 정보는 SecurityContext에 저장되어 있고
	 authentication에서 모든걸 관리하는데 나의 계정정보는 principal에 있다-->     
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}" />
<!-- 권한정보 -->
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 메뉴바 -->
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
					<span class="icon-bar"></span> 
					<span class="icon-bar"></span> 
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">스프링주식회사</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav">
					<li class="active"><a href="${contextPath}/">메인</a></li> <!--루트(/)만 입력하면 controller(context path)가 생략되므로, 명시적으로 /controller/를 입력 -->
					<li><a href="boardMain.do">게시판</a></li>
				</ul>	
				
				<!-- 로그인 및 회원가입 메뉴는 '로그인하지 않은 상태'일 때만 표시된다.-->
     			<!-- 로그인 여부는 taglib의 security 태그를 통해 판단한다
     				 security:authorize access="조건": 조건이 맞을 때만 이 안의 HTML이 보인다
     				 access="isAnonymous(): 로그인하지 않은 사용자, 로그인을 안하면 true반환한다
     			-->	
				<security:authorize access="isAnonymous()">
				<ul class="nav navbar-nav navbar-right">		
					<li><a href="${contextPath}/loginForm.do"><span class="glyphicon glyphicon-log-in"></span>&nbsp;로그인</a></li>
					<li><a href="${contextPath}/joinForm.do"><span class="glyphicon glyphicon-list-alt"></span>&nbsp;회원가입</a></li> <!-- contextPath를 붙여서 배포 환경이 바뀌어도 항상 올바른 경로로 이동하도록 함 -->			
				</ul>
				</security:authorize>
				
				<!--로그인한 사용자만 이 내용을 볼 수 있게한다 -->
				<security:authorize access="isAuthenticated()"> 
				<ul class="nav navbar-nav navbar-right">
					<li>		
						<c:if test="${mvo.member.memProfile ne ''}">					
								<img style="width:50px; height:50px;" class="img-circle" alt="" src= "${contextPath}/resources/upload/${mvo.member.memProfile}">
						</c:if>
						<c:if test="${mvo.member.memProfile eq ''}">		
								<img style="width:50px; height:50px;" class="img-circle" alt="" src= "${contextPath}/resources/upload/default.png">				
						</c:if>
					<!-- mvo는 MemberUser타입이다 MemberUser인 member에서 memName을 꺼낸다 -->	
					${mvo.member.memName}님 환영합니다.
					[   
						<security:authorize access="hasRole('ROLE_USER')"> 
                     		U
                  		</security:authorize>
                  		
						<security:authorize access="hasRole('ROLE_MANAGER')">
							M 
						</security:authorize>
						
						<security:authorize access="hasRole('ROLE_ADMIN')">
							A
						</security:authorize>	
						<!-- 권한 정보 띄우기 -->
						<!-- 회원이 가진 권한의 리스트만큼 반복돌면서 꺼내기 -->
						<%-- <c:forEach items="${mvo.authList}" var="auth">
							<c:choose>
								<c:when test="${auth.auth eq 'ROLE_USER'}">
									U
								</c:when>
								<c:when test="${auth.auth eq 'ROLE_MANAGER'}">
									M
								</c:when>
								<c:when test="${auth.auth eq 'ROLE_ADMIN'}">
									A
								</c:when>
							</c:choose>
						</c:forEach> --%>
					]
					
					</li>
					
					<li><a href="${contextPath}/updateForm.do"><span class="glyphicon glyphicon-pencil"></span>&nbsp;회원정보수정</a></li>
					<li><a href="${contextPath}/imageForm.do"><span class="glyphicon glyphicon-picture"></span>&nbsp;프로필사진등록</a></li>
					<li><a href="javascript:logout()"><span class="glyphicon glyphicon-log-out"></span>&nbsp;로그아웃</a></li>
					<!-- 로그아웃요청하면 내부적으로 알아서 로그아웃 기능이 작동된다,
					     로그아웃버튼을 누르면 JS 로그아웃 함수를 실행한다(비동기요청) -->
						
				</ul>
				</security:authorize>
				
			</div>
		</div>
	</nav>
	
	<script type="text/javascript">
		//CSRF토큰값 가져오기
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		function logout() {
			$.ajax({
				url : "${contextPath}/logout",
				type : "post",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function() {
					location.href = "${contextPath}/"
				},
				error : function() {
					alter("error")
				}
			});
		}
	</script>
	

	
</body>
</html>