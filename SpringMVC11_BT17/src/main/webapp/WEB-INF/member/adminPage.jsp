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
    text-align: center;   /* 가로 중앙 */
    line-height: 40px;    /* 세로 중앙 (height와 같은 값) */
}
}
</style>
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
    		<div class= "col-lg-10">
    			<div class="card" style="min-height: 500px; max-height: 1000px;">
    				<div class="card-body">
    					<table class="table table-bordered table-hover">
    						<thead class="table-cnt">
    							<th>번호</th>
    							<th>아이디</th>
    							<th>회원번호</th>
    							<th>이름</th>
    							<th>닉네임</th>
    							<th>탈퇴여부</th>
    							<th>권한</th>						
    							<th>권한 수정</th>
    							<th>교육과정</th>						
    							<th>교육과정 수정</th>
    							<th></th>
    						</thead>
    						<tbody id="view">
    							<!-- 비동기 방식으로 가져온 게시글 나오게할 부분-->
    						</tbody>
    						
    					</table>
    				</div>
    			</div>
    		</div>
    		
   
    		
    		
    		
    	</div>
    </div> 
    <%@ include file="/WEB-INF/common/bottom_common.jsp" %>
  </div>
  
  <script type="text/javascript">
  	$(document).ready(function(){
  		
  		loadRoleList(); //회원권한조회
  		loadCourceList(); //회원교육과정조회

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
  	
  	
  	
	//조회한권한 테이블로 나타내기	
	function makeView(data){
		var listHtml = "";
		
		//jQuary반목문
		$.each(data, function(index, obj){ //index:순서 표시자
			listHtml += "<tr>";
			listHtml += "<td class='table-cnt'>" + (index+1) + "</td>";		
			listHtml += "<td class='table-cnt'>" + obj.username + "</td>";
			listHtml += "<td class='table-cnt'>" + obj.user_code + "</td>";
			listHtml += "<td class='table-cnt'>" + obj.name + "</td>";
			listHtml += "<td class='table-cnt'>" + obj.nick_name + "</td>";		
			listHtml += `<td class="table-cnt">
			    \${obj.enabled ? '이용 중' : '탈퇴'}
			</td>`;	
			listHtml += "<td class='table-cnt'>" + obj.role + "</td>";
			
			listHtml += "<td>";
			listHtml += "  <select id='role_" + obj.username + "' class='form-control'>";
			// 각 옵션들을 추가하고, 현재 권한과 일치하면 selected 속성 부여
			listHtml += "<option value='INSTRUCTOR' " 
			         + (obj.role === 'INSTRUCTOR' ? "selected style='color:blue;font-weight:bold;'" : '') 
			         + ">INSTRUCTOR (강사)</option>";
			
			listHtml += "<option value='STUDENT' " 
			         + (obj.role === 'STUDENT' ? "selected style='color:blue;font-weight:bold;'" : '')  
			         + ">STUDENT (수강생)</option>";
			
			listHtml += "<option value='GUEST' " 
			         + (obj.role === 'GUEST' ? "selected style='color:blue;font-weight:bold;'" : '')
			         + ">GUEST (게스트)</option>";
			         
	         listHtml += "<option value='PENALTY' " 
		         + (obj.role === 'PENALTY' ? "selected style='color:blue;font-weight:bold;'" : '')
		         + ">PENALTY (이용제한)</option>";         
			listHtml += "  </select>";
			listHtml += "</td>";
			
			listHtml += "<td class='table-cnt'>" + obj.cource + "</td>";
			
			listHtml += "<td>";
			listHtml += "  <select id='cource_" + obj.username + "' class='form-control'>";
			// 각 옵션들을 추가하고, 현재 권한과 일치하면 selected 속성 부여
			listHtml += "<option value='BACK' " 
			         + (obj.cource === 'BACK' ? "selected style='color:blue;font-weight:bold;'" : '') 
			         + ">BACK (백엔드)</option>";
			
	        listHtml += "<option value='FRONT' " 
		             + (obj.cource === 'FRONT' ? "selected style='color:blue;font-weight:bold;'" : '') 
		             + ">FRONT (프론트엔드)</option>";
			
            listHtml += "<option value='DESIGN' " 
		             + (obj.cource === 'DESIGN' ? "selected style='color:blue;font-weight:bold;'" : '') 
		             + ">DESIGN (UX/UI 디자인)</option>";
			         
            listHtml += "<option value='DATA' " 
		             + (obj.cource === 'DATA' ? "selected style='color:blue;font-weight:bold;'" : '') 
		             + ">DATA (데이터분석)</option>";        
			listHtml += "  </select>";
			listHtml += "</td>";

			
			listHtml += "<td class='table-cnt'>";
			
			listHtml += "<button type='button' class='btn btn-custom' "			
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
		var cource = $("#cource_" + username).val();
    
		$.ajax({
			url : "${cpath}/member/roleUpdate",   
			type : "post",
			data : { "username" : username , "role" : role, "cource" : cource },
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

