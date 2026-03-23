<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- **Spring Security 태그라이브러리(JSTL방식으로 사용자정보 불러온다)-->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>



<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!-- 로그인한 사용자정보 EL식-->
<c:set var="user" value="${SPRING_SECURITY_CONTEXT.authentication.principal}" />
<!-- 권한정보 EL식-->
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}" />

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="${cpath}/resources/css/btnStyle.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<style>
.table-cnt {
    text-align: center;
}
</style>

<body>
	<!-- 첫번째칸 -->
	<div class="col-lg-2">
		<div class="card" style="min-height: 500px; max-height: 1000px;">
			<div class="card-body">
				<h6 class="card-title" style="text-align: center">
					<%-- **시큐리티의 principal.member 객체를 'mvo'라는 변수에 담는다 --%>
					<sec:authentication property="principal.member" var="mvo" />
					
						<c:choose>
							<%--'mvo' 변수로 체크하면 회원값이 출력된다--%>
							<c:when test="${not empty mvo.profile}">
								<img class="rounded-circle" width="180" height="180"
									src="${cpath}/profile_upload/${mvo.profile}" alt="profile" />
							</c:when>
							<c:otherwise>
								<img class="rounded-circle" width="180" height="180"
									src="${cpath}/resources/images/default.png" alt="default_img" />
							</c:otherwise>
						</c:choose>
						
						<br><br>
						<p class="card-text">${mvo.name} (${mvo.username})</p>
						<p>${mvo.name}님의 현재 권한은<br>
							<c:choose>
						        <c:when test="${mvo.role == 'ADMIN'}">관리자</c:when>
						        <c:when test="${mvo.role == 'PROFESSOR'}">교수</c:when>									       
						        <c:otherwise>학생</c:otherwise>
						    </c:choose>
					    입니다 </p>				
						<!-- <sec:authentication property="principal.member.role" /> -->
				</h6>


				<!-- 권한에 따른 화면구성 다르게 보여주기 -->
				<sec:authorize access="hasRole('ADMIN')">

					<form action="${cpath}/member/adminPage">
						<button type="submit" class="form-control btn btn-secondary">관리자페이지</button>
					</form>

					<br>
					<button class="btn btn-secondary form-control">커뮤니티 (강사전용)</button>
					<br>
					<br>
					<p style="text-align: center">수업 커뮤니티</p>
					<form action="${cpath}/board/list">
						<button type="submit" class="form-control btn btn-custom">Spring CLASS</button>
					</form><br>
					
					<form action="#">
						<button type="submit" class="form-control btn btn-custom">JSP/Servlet CLASS</button>
					</form><br>
					
					<form action="#">
						<button type="submit" class="form-control btn btn-custom">Java CLASS</button>
					</form>
				</sec:authorize>

				<sec:authorize access="hasRole('PROFESSOR')">
					<button class="btn btn-secondary form-control">강사전용 커뮤니티</button>
					<br>
					<br>
					<button class="btn btn-secondary form-control">커뮤니티</button>

				</sec:authorize>

				<sec:authorize access="hasRole('STUDENT')">

				</sec:authorize>

				<sec:authorize access="hasRole('GUEST')">

				</sec:authorize>

				<br>

				<!-- 공통부분 -->
				<form action="${cpath}/member/memberUpdateForm">
					<button class="form-control btn btn-secondary">개인정보수정</button>
				</form>
				<br>

				<form action="${cpath}/member/logout">
					<button type="submit" class="form-control btn btn-secondary">로그아웃</button>
				</form>

				<br>
			</div>
		</div>
	</div>


</body>
</html>

