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
.btn_gap {
    margin-bottom: 8px;
}
.line_gap {
    margin-bottom: 8px;
}


</style>

<body>
	<!-- 첫번째칸 -->
	<div class="col-lg-2">
		<div class="card" style="min-height: 500px; max-height: 2000px;">
			<div class="card-body">
				<h5 class="card-title" style="text-align: center; margin-bottom: 5px;">
				<%-- **시큐리티의 principal.member 객체를 'mvo'라는 변수에 담는다 --%>
				<sec:authentication property="principal.member" var="mvo" />
				
					<c:choose>
						<%--'mvo' 변수로 체크하면 회원값이 출력된다--%>
						<c:when test="${not empty mvo.profile}">
							<img class="rounded-circle" width="150" height="150"
								src="${cpath}/profile_upload/${mvo.profile}" alt="profile" />
						</c:when>
						<c:otherwise>
							<img class="rounded-circle" width="150" height="150"
								src="${cpath}/resources/images/default.png" alt="default_img" />
						</c:otherwise>
					</c:choose>
					
					<br><br>
					<p class="card-text">${mvo.nick_name}</p>
					</h5>
					<div>
						<p style="text-align: center" class="card-text">${mvo.name} (${mvo.username})</p>
					</div>	
				
					<hr style="margin-top: 8px;">				
					<p style="text-align: center">내 등급 [
						<c:choose>
					        <c:when test="${mvo.role == 'ADMIN'}">관리자</c:when>
					        <c:when test="${mvo.role == 'STAFF'}">운영부</c:when>
					        <c:when test="${mvo.role == 'INSTRUCTOR'}">강사</c:when>									       
					        <c:when test="${mvo.role == 'STUDENT'}">수강생</c:when>									       
					        <c:when test="${mvo.role == 'GUEST'}">승인대기</c:when>									       
					        <c:otherwise>이용제한</c:otherwise>
					    </c:choose>
				    ] </p>				
					<!-- <sec:authentication property="principal.member.role" /> -->

						
					<!-- 관리자 권한-->
					<sec:authorize access="hasRole('ADMIN')">
						<form action="${cpath}/member/adminPage" class="btn_gap">
							<button id="adminPage" type="submit" class="form-control btn btn-outline-dark btn-sm">관리자페이지</button>
						</form>					
						<form action="#">
							<button type="submit" class="form-control btn btn-outline-dark btn-sm">강사전용 커뮤니티</button>
						</form>
						<hr>							
					
						<p style="text-align: center">[백엔드]</p>
						<form action="${cpath}/learning/learning_list" class="btn_gap">
							<button id="learning_list" type="submit" class="form-control btn btn-light btn-sm">Back-End 강의</button>
						</form>
						<form action="${cpath}/board/list" class="btn_gap">
							<button id="list" type="submit" class="form-control btn btn-light btn-sm">Q&A</button>
						</form>				
						<form action="${cpath}/chat/chatGroup" class="btn_gap">
							<button id="chatGroup" type="submit" class="form-control btn btn-light btn-sm">오픈채팅</button>
						</form>	
						<form action="${cpath}/communication/communication_list" class="btn_gap">
							<button id="communication_list" type="submit" class="form-control btn btn-light btn-sm">커뮤니티</button>
						</form>
						<hr>					
						
						<p style="text-align: center">[프론트엔드]</p>
						<form action="#" class="btn_gap">
							<button type="submit" class="form-control btn btn-light btn-sm">Front-End 강의</button>
						</form>
						<form action="#" class="btn_gap">
							<button type="submit" class="form-control btn btn-light btn-sm">Q&A</button>
						</form>					
						<form action="#" class="btn_gap">
							<button id="#" type="#" class="form-control btn btn-light btn-sm">오픈채팅</button>
						</form>	
						<form action="#" class="btn_gap">
							<button id="#" type="#" class="form-control btn btn-light btn-sm">커뮤니티</button>
						</form>
						<hr>
						
						<p style="text-align: center">[UX/UI 디자인]</p>
						<form action="#" class="btn_gap">
							<button type="submit" class="form-control btn btn-light btn-sm">UX/UI Design 강의</button>
						</form>
						<form action="#" class="btn_gap">
							<button type="submit" class="form-control btn btn-light btn-sm">Q&A</button>
						</form>				
						<form action="#" class="btn_gap">
							<button id="#" type="#" class="form-control btn btn-light btn-sm">오픈채팅</button>
						</form>	
						<form action="#" class="btn_gap">
							<button id="#" type="#" class="form-control btn btn-light btn-sm">커뮤니티</button>
						</form>
						<hr>
						
						<p style="text-align: center">[데이터분석]</p>
						<form action="#" class="btn_gap">
							<button type="submit" class="form-control btn btn-light btn-sm">Data Analysis 강의</button>
						</form>
						<form action="#" class="btn_gap">
							<button type="submit" class="form-control btn btn-light btn-sm">Q&A</button>
						</form>				
						<form action="#" class="btn_gap">
							<button id="#" type="#" class="form-control btn btn-light btn-sm">오픈채팅</button>
						</form>						
						<form action="#" class="btn_gap">
							<button id="#" type="#" class="form-control btn btn-light btn-sm">커뮤니티</button>
						</form>	
					</sec:authorize> <!-- end ADMIN -->
					
					
					<!-- 운영부 권한-->
					<sec:authorize access="hasRole('STAFF')">								

						<p style="text-align: center">[백엔드]</p>
						<form action="${cpath}/learning/learning_list" class="btn_gap">
							<button id="learning_list" type="submit" class="form-control btn btn-light btn-sm">Back-End 강의</button>
						</form>
						<form action="${cpath}/board/list" class="btn_gap">
							<button id="list" type="submit" class="form-control btn btn-light btn-sm">Q&A</button>
						</form>				
						<form action="${cpath}/chat/chatGroup" class="btn_gap">
							<button id="chatGroup" type="submit" class="form-control btn btn-light btn-sm">오픈채팅</button>
						</form>	
						<form action="${cpath}/communication/communication_list" class="btn_gap">
							<button id="communication_list" type="submit" class="form-control btn btn-light btn-sm">커뮤니티</button>
						</form>
						<hr>					
						
						<p style="text-align: center">[프론트엔드]</p>
						<form action="#" class="btn_gap">
							<button type="submit" class="form-control btn btn-light btn-sm">Front-End 강의</button>
						</form>
						<form action="#" class="btn_gap">
							<button type="submit" class="form-control btn btn-light btn-sm">Q&A</button>
						</form>					
						<form action="#" class="btn_gap">
							<button id="#" type="#" class="form-control btn btn-light btn-sm">오픈채팅</button>
						</form>	
						<form action="#" class="btn_gap">
							<button id="#" type="#" class="form-control btn btn-light btn-sm">커뮤니티</button>
						</form>
						<hr>
						
						<p style="text-align: center">[UX/UI 디자인]</p>
						<form action="#" class="btn_gap">
							<button type="submit" class="form-control btn btn-light btn-sm">UX/UI Design 강의</button>
						</form>
						<form action="#" class="btn_gap">
							<button type="submit" class="form-control btn btn-light btn-sm">Q&A</button>
						</form>				
						<form action="#" class="btn_gap">
							<button id="#" type="#" class="form-control btn btn-light btn-sm">오픈채팅</button>
						</form>	
						<form action="#" class="btn_gap">
							<button id="#" type="#" class="form-control btn btn-light btn-sm">커뮤니티</button>
						</form>
						<hr>
						
						<p style="text-align: center">[데이터분석]</p>
						<form action="#" class="btn_gap">
							<button type="submit" class="form-control btn btn-light btn-sm">Data Analysis 강의</button>
						</form>
						<form action="#" class="btn_gap">
							<button type="submit" class="form-control btn btn-light btn-sm">Q&A</button>
						</form>				
						<form action="#" class="btn_gap">
							<button id="#" type="#" class="form-control btn btn-light btn-sm">오픈채팅</button>
						</form>						
						<form action="#" class="btn_gap">
							<button id="#" type="#" class="form-control btn btn-light btn-sm">커뮤니티</button>
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
					<c:if test="${mvo.role != 'ADMIN' && mvo.role != 'STAFF'}">
						<c:choose>
					        <c:when test="${mvo.course == 'BACK'}">
					        	<p style="text-align: center">내 수업 [백엔드]</p>
								<form action="${cpath}/learning/learning_list" class="btn_gap">
									<button id="learning_list" type="submit" class="form-control btn btn-light btn-sm">Back-End 강의</button>
								</form>
								<form action="${cpath}/board/list" class="btn_gap">
									<button id="list" type="submit" class="form-control btn btn-light btn-sm">Q&A</button>
								</form>									
								<form action="${cpath}/chat/chatGroup" class="btn_gap">
									<button id="chatGroup" type="submit" class="form-control btn btn-light btn-sm">오픈채팅</button>
								</form>	
								<form action="${cpath}/communication/communication_list" class="btn_gap">
									<button id="communication_list" type="submit" class="form-control btn btn-light btn-sm">커뮤니티</button>
								</form>	
											
					        </c:when>
					        <c:when test="${mvo.course == 'FRONT'}">
					        	<p style="text-align: center">내 교육과정 [프론트엔드]</p>
								<form action="${cpath}/learning/learning_list" class="btn_gap">
									<button id="learning_list" type="submit" class="form-control btn btn-light btn-sm">Front-End 강의</button>
								</form>
								<form action="${cpath}/board/list" class="btn_gap">
									<button id="list" type="submit" class="form-control btn btn-light btn-sm">Q&A</button>
								</form>				
								<form action="#" class="btn_gap">
									<button id="#" type="#" class="form-control btn btn-light btn-sm">오픈채팅</button>
								</form>							 
								<form action="#">
									<button id="#" type="#" class="form-control btn btn-light btn-sm">커뮤니티</button>
								</form>	
					        </c:when>
					        <c:when test="${mvo.course == 'DESIGN'}">
					        	<p style="text-align: center">내 교육과정 [UX/UI 디자인]</p>
								<form action="${cpath}/learning/learning_list" class="btn_gap">
									<button id="learning_list" type="submit" class="form-control btn btn-light btn-sm">UX/UI Design 강의</button>
								</form>
								<form action="${cpath}/board/list" class="btn_gap">
									<button id="list" type="submit" class="form-control btn btn-light btn-sm">Q&A</button>
								</form>			
								<form action="#" class="btn_gap">
									<button id="#" type="#" class="form-control btn btn-light btn-sm">오픈채팅</button>
								</form>							  
								<form action="#" class="btn_gap">
									<button id="#" type="#" class="form-control btn btn-light btn-sm">커뮤니티</button>
								</form>	
					        </c:when>
					        <c:when test="${mvo.course == 'DATA'}">
					        	<p style="text-align: center">내 교육과정 [데이터분석]</p>
								<form action="${cpath}/learning/learning_list">
									<button id="learning_list" type="submit" class="form-control btn btn-light btn-sm">Data Analysis 강의</button>
								</form><br>
								<form action="${cpath}/board/list">
									<button id="list" type="submit" class="form-control btn btn-light btn-sm">Q&A</button>
								</form><br>					
								<form action="#" class="btn_gap">
									<button id="#" type="#" class="form-control btn btn-light btn-sm">오픈채팅</button>
								</form>								   
								<form action="#">
									<button id="#" type="#" class="form-control btn btn-light btn-sm">커뮤니티</button>
								</form>
					        </c:when>
					    </c:choose>
					</c:if>
					

					<!-- 공통부분 -->
					<hr>
					<form action="${cpath}/member/memberUpdateForm" class="btn_gap">
						<button id="memberUpdateForm" class="form-control btn btn-outline-dark btn-sm">회원정보수정</button>
					</form>		
					
					<form action="${cpath}/member/passwordUpdateForm_passwordCheckForm" class="btn_gap">
						<button id="passwordUpdateForm" class="form-control btn btn-outline-dark btn-sm">비밀번호수정 및 탈퇴</button>
					</form>	
					<br>	
					
					<form action="${cpath}/member/logout" class="btn_gap">
						<button type="submit" class="form-control btn btn-outline-dark btn-sm">로그아웃</button>
					</form>
					
					

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
		}else if(currentPath == "/boot/communication/communication_list"){
			$("#communication_list").removeClass("btn-outline-dark");
			$("#communication_list").addClass("btn-custom");		
		}else if(currentPath == "/boot/member/memberUpdateForm_passwordCheckForm" || currentPath == "/boot/member/memberUpdateForm"){
			$("#memberUpdateForm").removeClass("btn-outline-dark");
			$("#memberUpdateForm").addClass("btn-custom");		
		}else if(currentPath == "/boot/member/passwordUpdateForm_passwordCheckForm" || currentPath == "/boot/member/passwordUpdateForm"){
			$("#passwordUpdateForm").removeClass("btn-outline-dark");
			$("#passwordUpdateForm").addClass("btn-custom");		
		}else if(currentPath == "/boot/chat/chatGroup"){
			$("#chatGroup").removeClass("btn-outline-dark");
			$("#chatGroup").addClass("btn-custom");		
		}
	    
	});
	
	
	</script>


</body>
</html>

