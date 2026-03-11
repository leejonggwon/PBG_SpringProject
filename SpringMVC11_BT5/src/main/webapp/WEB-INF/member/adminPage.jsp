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
<body>
 
  <div class="card">
    <div class="card-header">
	    <div class="jumbotron jumbotron-fluid">
		  <div class="container">
		    <h1>Spring MVC11</h1>
		    <p>Java → HTML → CSS → JSP&Servlet → Spring F/W → Spring Boot</p>
		  </div>
		</div>
    </div>
    <div class="card-body">
    	<div class="row">
    		<!-- 첫번째칸 -->
    		<%@ include file="/WEB-INF/common/common.jsp" %>
    		
    		<!-- 두번째칸 -->
    		<div class= "col-lg-5">
    			<div class="card" style="min-height: 500px; max-height: 1000px;">
    				<div class="card-body">
    					<table class="table table-bordered table-hover">
    						<thead>
    							<th>번호</th>
    							<th>아이디</th>
    							<th>이름</th>
    							<th>현재권한</th>						
    							<th>변경할권한</th>
    							<th>변경</th>
    						</thead>
    						<tbody id="view">
    							<!-- 비동기 방식으로 가져온 게시글 나오게할 부분-->
    						</tbody>
    						
    					</table>
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
    	</div>
    </div> 
    <div class="card-footer">스프링 - 이종권</div>
  </div>
  
  <script type="text/javascript">
  	$(document).ready(function(){
  		
  		loadRoleList(); //회원권한조회

  	});//ready
  	
  	
  
  	
  	//회원권한조회
	function loadRoleList() {	
			$.ajax({
				url : "${cpath}/member/roleAll",    
				type: "get",  
				dataType : "json",
				success: function(list){ 
					makeView(list);	
				},   
				error: function(){ alert("회원권한조회실패"); }
			});
		}
  	
		
		function makeView(data){
			var listHtml = "";
			
			//jQuary반목문
			$.each(data, function(index, obj){ //index:순서 표시자
				listHtml += "<tr>";
				listHtml += "<td>" + (index+1) + "</td>";		
				listHtml += "<td>" + obj.username + "</td>";
				listHtml += "<td>" + obj.name + "</td>";
				listHtml += "<td>" + obj.role + "</td>";
				
				listHtml += "<td>";
				listHtml += "  <select id='role_" + obj.username + "' class='form-control'>";
				// 각 옵션들을 추가하고, 현재 권한과 일치하면 selected 속성 부여
				listHtml += "<option value='PROFESSOR' " 
				         + (obj.role === 'PROFESSOR' ? "selected style='color:red;font-weight:bold;'" : '') 
				         + ">PROFESSOR</option>";
				
				listHtml += "<option value='STUDENT' " 
				         + (obj.role === 'STUDENT' ? "selected style='color:red;font-weight:bold;'" : '') 
				         + ">STUDENT</option>";
				
				listHtml += "<option value='GUEST' " 
				         + (obj.role === 'GUEST' ? 'selected' : '') 
				         + ">GUEST</option>";
				
				
				listHtml += "  </select>";
				listHtml += "</td>";
				
				
				listHtml += "<td>";
				
				listHtml += "<button type='button' class='btn btn-warning btn-sm' "			
						 + "onclick=\"roleUpdate('" + obj.username + "')\">변경</button>";	
				//문자열이면 JS는 변수로 인식한다 		 
				listHtml += "</td>";
				
				listHtml += "</tr>";
				
				//onclick='roleUpdate(" + obj.username + ")'

			});
			
			$("#view").html(listHtml);	
			
			//goList();
		}
		
		//권한수정
		function roleUpdate(username){
			
			var role = $("#role_" + username).val();
		    
		    
			$.ajax({
				url : "${cpath}/member/roleUpdate",   
				type : "post",
				data : { "username" : username , "role" : role },
				success : function(member){ 
					
					alert(member.username + "님 " + member.role + "로 권한변경 되었습니다");
					loadRoleList();
				},
				error : function(){ alert("error") }
			});
		}
		
		
		
		
		
  </script>

</body>
</html>

