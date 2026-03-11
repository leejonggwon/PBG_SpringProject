<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Spring Security 관련 태그라이브러리(JSTL방식)-->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="cpath" value="${pageContext.request.contextPath}"/>

<!-- 로그인한 계정정보 EL식-->
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
   		<div class= "col-lg-2"> 
   			<div class="card" style="min-height: 500px; max-height: 1000px;">
   				<div class="card-body">
   					<h4 class="card-title">
   					
   				
						  <%-- 1. 시큐리티의 principal.member 객체를 'mvo'라는 변수에 담는다 --%>
							<sec:authentication property="principal.member" var="mvo"/>
							
							<c:choose>
							    <%-- 2. 이제 'mvo' 변수로 체크하면 값이 잘 나와! --%>
							    <c:when test="${not empty mvo.profile}">
							        <img class="rounded-circle" width="100" height="100"  
							             src="${cpath}/upload/${mvo.profile}" alt="프로필" />
							    </c:when>
							    
							    <c:otherwise>
							        <img class="rounded-circle" width="100" height="100" 
							             src="${cpath}/resources/images/default.png" alt="기본이미지" />						   
							    </c:otherwise>
							</c:choose>
										
					</h4>
					
   					<p class="card-text">${mvo.name} (${mvo.username})</p>
	
   					
   					현재 권한: <sec:authentication property="principal.member.role"/>				
   	
   					<!-- 권한에 따른 화면구성 다르게 보여주기 --> 
					<sec:authorize access="hasRole('ADMIN')"> 
                    		       		
                    	<form action="${cpath}/member/adminPage">
   							<button type="submit" class="form-control btn btn-sm btn-info">관리자페이지</button> 						
   						</form>

                    		<br>
                    		<button class="btn btn-success form-control">커뮤니티 (강사전용)</button>
                    		<br>
                    		<br>
                    	<form action="${cpath}/board/list">
   							<button type="submit" class="form-control btn btn-sm btn-success">커뮤니티</button> 						
   						</form>                   	                 		
                 	</sec:authorize>
                 		
               		<sec:authorize access="hasRole('PROFESSOR')">                 		
                  		<button class="btn btn-success form-control">강사전용 커뮤니티</button>
                  		<br>
                  		<br>
                  		<button class="btn btn-success form-control">커뮤니티</button>
                  		
               		</sec:authorize>
                 		
               		<sec:authorize access="hasRole('STUDENT')">                 		               		
                  		
               		</sec:authorize>
               		
               		<sec:authorize access="hasRole('GUEST')">                 		               		
                  
               		</sec:authorize>
                 		
               		<br>
               		<br>
   					
   					<form action="${cpath}/member/updateForm">
   						<button class="btn btn-warning form-control">개인정보수정</button>
   					</form>
   					<br>
   					<br>
   					
   					<form action="${cpath}/member/logout">
   						<button type="submit" class="form-control btn btn-sm btn-primary">로그아웃</button> 						
   					</form>
   					
   					<br>   							
   				</div>
   			</div>
   		</div>


</body>
</html>

