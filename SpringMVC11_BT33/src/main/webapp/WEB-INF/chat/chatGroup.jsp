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
  
  
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous"></head>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  
  
  
</head>

<body>
 
  <div class="card">
    <div class="card-header">
	    <!-- 카드헤더부분 -->
    	<%@ include file="/WEB-INF/common/header_common.jsp" %>
    </div>
    <div class="card-body">
    	<div class="row">
    		<!-- 첫번째칸 -->
    		<%@ include file="/WEB-INF/common/left_common.jsp" %>
    		
            <!-- 두번째칸 -->
            <!-- PENALTY 경우  -->
    		<c:if test="${user.member.role =='PENALTY'}">
	    		<div class= "col-lg-10">
	    			<div class="card" style="min-height: 500px; max-height: 1000px;">
	    				<div class="card-body" style="display: flex; align-items: center; justify-content: center;">
	    					<p>※ ${user.member.nick_name} 님은 운영 정책에 따라 현재 <strong>이용제한</strong> 상태입니다. 관리센터에 문의 주세요.</p>
	    				</div>
	    			</div>			
	    		</div>		   			
    		</c:if>
    		
    		<!-- GUEST 경우  -->
    		<c:if test="${user.member.role =='GUEST'}">
	    		<div class= "col-lg-10">
	    			<div class="card" style="min-height: 500px; max-height: 1000px;">
	    				<div class="card-body" style="display: flex; align-items: center; justify-content: center;">
	    					<p>※ ${user.member.nick_name} 님은 현재 <strong>승인대기상태</strong> 입니다. 관리자의 승인 후 서비스 이용이 가능합니다</p>
	    				</div>
	    			</div>			
	    		</div>		
	    			
    		</c:if>
    		
    		<!-- GUEST, PENALTY 제외 -->
    		<c:if test="${user.member.role !='GUEST' && user.member.role !='PENALTY'}">
	    		<div class= "col-lg-5">
	    			<div class="card" style="min-height: 500px; max-height: 1000px;">
	    				<div class="card-body" >							
		    				<div class="container">	
			    				<c:choose>
								    <c:when test="${user.member.role eq 'ADMIN'}">
								        <c:set var="roleName" value="관리자" />
								    </c:when>
								    <c:when test="${user.member.role eq 'STAFF'}">
								        <c:set var="roleName" value="운영부" />
								    </c:when>
								    <c:when test="${user.member.role eq 'INSTRUCTOR'}">
								        <c:set var="roleName" value="강사" />
								    </c:when>
								    <c:when test="${user.member.role eq 'STUDENT'}">
								        <c:set var="roleName" value="수강생" />
								    </c:when>
								    <c:otherwise>
								        <c:set var="roleName" value="${user.member.role}" />
								    </c:otherwise>
								</c:choose>
		    					
		    					<br>   					    					   					
		    					<br>   					    					   					
		    					<br>   					    					   					
								<div style="text-align: center">						
									<p style="margin-bottom: 25px;">※ 오픈채팅방입니다. 욕설이나 모욕적인 표현이 포함된 메시지는 운영 정책에 따라 이용이 제한될 수 있습니다.</p>											 							 
									<button class="btn btn-custom" onclick="goSocket('Back-End 단체오픈채팅','${user.member.nick_name}(${roleName})')">${user.member.nick_name}(${roleName}) &nbsp; 오픈채팅방에 입장하기</button>
								</div>
							</div>
	
	    				</div>
	    			</div>
	    		</div>	
    		
	    		<!-- 세번째칸 -->	
	    		<div class= "col-lg-5">
	    			<div class="card" style="min-height: 500px; max-height: 1000px;">
	    				<div class="card-body">
	    				
	    				</div>
	    			</div>
	    		</div>	
    		</c:if> <!--end GUEST 아닌경우 -->
    	</div>
    </div> 
    <%@ include file="/WEB-INF/common/bottom_common.jsp" %>
  </div>
  <script type="text/javascript">
		function goSocket(gr_id, mem_id) {
			//window.open: 새로운 브라우저
			window.open("${cpath}/chat/socketOpen?gr_id="+gr_id+"&mem_id="+mem_id, "그룹채팅","width=600px, height=800px, left=300px, top=50px")
		}
  </script>
  



</body>
</html>

