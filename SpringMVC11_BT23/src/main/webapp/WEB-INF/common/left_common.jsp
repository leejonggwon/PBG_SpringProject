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
  
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous"></head>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<style>
.table-cnt {
    text-align: center;
}
</style>

<body>
	<!-- 첫번째칸 -->
	<div class="col-lg-2">
		<div class="card" style="min-height: 500px; max-height: 2000px;">
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
					<p class="card-text">${mvo.nick_name} (${mvo.username})</p>
					</h6>
				
									
					<p style="text-align: center">내 등급 [
						<c:choose>
					        <c:when test="${mvo.role == 'ADMIN'}">관리자</c:when>
					        <c:when test="${mvo.role == 'INSTRUCTOR'}">강사</c:when>									       
					        <c:when test="${mvo.role == 'STUDENT'}">학생</c:when>									       
					        <c:when test="${mvo.role == 'GUEST'}">승인대기</c:when>									       
					        <c:otherwise>이용제한</c:otherwise>
					    </c:choose>
				    ] </p>				
					<!-- <sec:authentication property="principal.member.role" /> -->
					<hr>

					<!-- 관리자 권한-->
					<sec:authorize access="hasRole('ADMIN')">
						<form action="${cpath}/member/adminPage">
							<button id="adminPage" type="submit" class="form-control btn btn-outline-dark btn-sm">관리자페이지</button>
						</form>					
						<br>
						<form action="#">
							<button type="submit" class="form-control btn btn-outline-dark btn-sm">강사전용 커뮤니티</button>
						</form>
						<hr>							
					
						<p style="text-align: center">[백엔드]</p>
						<form action="${cpath}/learning/learning_list">
							<button id="learning_list" type="submit" class="form-control btn btn-light btn-sm">강의</button>
						</form><br>
						<form action="${cpath}/board/list">
							<button id="list" type="submit" class="form-control btn btn-light btn-sm">커뮤니티</button>
						</form>
						<hr>					
						
						<p style="text-align: center">[프론트엔드]</p>
						<form action="#">
							<button type="submit" class="form-control btn btn-light btn-sm">강의</button>
						</form><br>
						<form action="#">
							<button type="submit" class="form-control btn btn-light btn-sm">커뮤니티</button>
						</form>
						<hr>
						
						<p style="text-align: center">[UX/UI 디자인]</p>
						<form action="#">
							<button type="submit" class="form-control btn btn-light btn-sm">강의</button>
						</form><br>
						<form action="#">
							<button type="submit" class="form-control btn btn-light btn-sm">커뮤니티</button>
						</form>
						<hr>
						
						<p style="text-align: center">[데이터분석]</p>
						<form action="#">
							<button type="submit" class="form-control btn btn-light btn-sm">강의</button>
						</form><br>
						<form action="#">
							<button type="submit" class="form-control btn btn-light btn-sm">커뮤니티</button>
						</form>						
					</sec:authorize> <!-- end ADMIN -->
		
					<!-- 강사 -->
					<sec:authorize access="hasRole('INSTRUCTOR')">			
						<form action="#">
							<button type="submit" class="form-control btn btn-outline-dark btn-sm">강사전용 커뮤니티</button>
						</form>
						<hr>
					</sec:authorize>
					
					<!-- 권한 -->
					<c:if test="${mvo.role != 'ADMIN'}">
						<c:choose>
					        <c:when test="${mvo.cource == 'BACK'}">
					        	<p style="text-align: center">내 교육과정 [백엔드]</p>
								<form action="${cpath}/learning/learning_list">
									<button id="learning_list" type="submit" class="form-control btn btn-light btn-sm">강의</button>
								</form><br>
								<form action="${cpath}/board/list">
									<button id="list" type="submit" class="form-control btn btn-light btn-sm">커뮤니티</button>
								</form>				
					        </c:when>
					        <c:when test="${mvo.cource == 'FRONT'}">
					        	<p style="text-align: center">내 교육과정 [프론트엔드]</p>
								<form action="${cpath}/learning/learning_list">
									<button id="learning_list" type="submit" class="form-control btn btn-light btn-sm">강의</button>
								</form><br>
								<form action="${cpath}/board/list">
									<button id="list" type="submit" class="form-control btn btn-light btn-sm">커뮤니티</button>
								</form>							 
					        </c:when>
					        <c:when test="${mvo.cource == 'DESIGN'}">
					        	<p style="text-align: center">내 교육과정 [UX/UI 디자인]</p>
								<form action="${cpath}/learning/learning_list">
									<button id="learning_list" type="submit" class="form-control btn btn-light btn-sm">강의</button>
								</form><br>
								<form action="${cpath}/board/list">
									<button id="list" type="submit" class="form-control btn btn-light btn-sm">커뮤니티</button>
								</form>							  
					        </c:when>
					        <c:when test="${mvo.cource == 'DATA'}">
					        	<p style="text-align: center">내 교육과정 [데이터분석]</p>
								<form action="${cpath}/learning/learning_list">
									<button id="learning_list" type="submit" class="form-control btn btn-light btn-sm">강의</button>
								</form><br>
								<form action="${cpath}/board/list">
									<button id="list" type="submit" class="form-control btn btn-light btn-sm">커뮤니티</button>
								</form>							   
					        </c:when>
					    </c:choose>
					</c:if>
					

					<!-- 공통부분 -->
					<hr>
					<form action="${cpath}/member/memberUpdateForm_passwordCheckForm">
						<button id="memberUpdateForm" class="form-control btn btn-outline-dark btn-sm">계정관리</button>
					</form>
					<br>
	
					<form action="${cpath}/member/logout">
						<button type="submit" class="form-control btn btn-outline-dark btn-sm">로그아웃</button>
					</form>
	
					<br>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	
	$(document).ready(function() {
	    // ***현재 주소 가져오기 (예: /boot/learning/learning_list)
	    var currentPath = window.location.pathname;
	    
		//alert(currentPath);
		if(currentPath == "/boot/member/adminPage"){
			$("#adminPage").removeClass("btn-outline-dark");
			$("#adminPage").addClass("btn-custom");
		}else if(currentPath == "/boot/learning/learning_list"){
			$("#learning_list").removeClass("btn-outline-dark");
			$("#learning_list").addClass("btn-custom");
		}else if(currentPath == "/boot/board/list"){
			$("#list").removeClass("btn-outline-dark");
			$("#list").addClass("btn-custom");
		}else if(currentPath == "/boot/member/memberUpdateForm_passwordCheckForm" || currentPath == "/boot/member/memberUpdateForm"){
			$("#memberUpdateForm").removeClass("btn-outline-dark");
			$("#memberUpdateForm").addClass("btn-custom");		
		}
	    
	});
	
	
	</script>


</body>
</html>

