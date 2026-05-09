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
  <link rel="stylesheet" href="${cpath}/resources/css/btnStyle.css">
  
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
  
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  
  
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  
</head>
<style>
.table-cnt {
	text-align: center;
}

/*type이 radio 경우*/
input[type="radio"] {
    margin-left: 7px;   /* (버튼을 기준)왼쪽 간격 */
    margin-right: 1px;  /* (버튼을 기준)라디오 버튼과 글자 사이 간격 */
}


/*모달 배경색 연하게*/
.modal-backdrop {
  opacity: 0.2 !important;
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
    		<div class= "col-lg-5">
    			<div class="card" style="min-height: 500px; max-height: 1000px;">
    				<div class="card-body">
    				<br>
    				<br>
    				<br>
    				<br>
    				<br>
    				<br>   			
						<!-- 현재비밀번호 -->
						<form id="passwordCheckForm">
							<p> ※ 본인 확인을 위해 비밀번호를 입력해 주세요 </p>
							<table style="text-align: center; border : 1px solid #dddddd" class="table table-bordered">						
								<tr>
									<td style="width: 180px; vertical-align: middle;">현재 비밀번호 입력</td>
									<td><input required="required" type="password" name="passwordCheck" id="passwordCheck" onkeypress="if(event.keyCode==13){$('#passwordCheckEnter').click()}" class="form-control" required="required" maxlength="20"></td>
									<td style="width: 200px;"><button id="passwordCheckBtn" type="button" onclick="pwdShow(event)" class="btn btn-custom"><i id="passwordCheckBtn_icon" class="fas fa-eye" style="color: rgb(255, 255, 255);"></i>&nbsp;&nbsp;<span id="passwordCheckBtn_text">비밀번호 보이기</span></button></td>				
								</tr>										
								<tr>
									<td colspan="3">								
										<button type="button" data-oper="passwordCheck" class="btn btn-custom pull-right" >확인</button>									
									</td>
								</tr>
							</table>		
						</form>
						
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
    <%@ include file="/WEB-INF/common/bottom_common.jsp" %>
  </div>
  
  
  <!-- 모달작동버튼 -->
  <div id="openModal" data-toggle="modal" data-target="#myModal"></div>
  
  <!-- Bootstrap 비밀번호체크 모달창 -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog">
      <div id="checkType" class="modal-content">
      
        <div class="modal-header">
          <h4 class="modal-title">메세지확인</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <div class="modal-body">
          <p id="checkMessage"></p> 
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-outline-dark" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  
  <!-- 모달작동버튼 -->
  <div id="myMessageOpenModal" data-toggle="modal" data-target="#myMessage"></div>
  
  <!-- 수정 실패시 띄워줄 모달창 -->
  <div class="modal fade" id="myMessage">
    <div class="modal-dialog">
      <div id="messageType" class="modal-content">
      
        <div class="modal-header">
          <h4 class="modal-title">${msgType}</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <div class="modal-body">
          <p style="white-space: pre-line;">${msg}</p> 
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-outline-dark" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>


<script type="text/javascript">
  $(document).ready(function(){
	  
	  if(${not empty msgType}){ //들어오는 msgType에 데이터가 감지되는경우
			if(${msgType eq "실패메세지"}){ //msgType 데이터가 "실패메세지" 인 경우
				$("#messageType").find(".modal-header").addClass("bg-danger text-white");
			}else{
				$("#messageType").find(".modal-header").addClass("bg-primary text-white");
			}
			$("#myMessageOpenModal").click(); //모달창 실행
		}

	  var passwordCheckForm = $("#passwordCheckForm");
	 
	  
	  $("button[data-oper]").on("click", function(){
		  var oper = $(this).data("oper"); 
		  //현재비밀번호
		  if(oper == "passwordCheck"){ 
				
			if($("#passwordCheck").val().trim() == ""){
				$("#checkMessage").text("비밀번호를 입력해주세요");
				$("#checkType").find(".modal-header").addClass("bg-danger text-white");
				$("#openModal").click();	
					
				$("#passwordCheck").focus(); // 아이디 입력창으로 커서를 자동한다
				return false;
			}	
			
			passwordCheckForm.attr("action", "${cpath}/member/passwordCheck");
			passwordCheckForm.attr("method", "post");
			passwordCheckForm.submit();
		   }
		  
	  });
	  
  	});//ready
  	
  	
  //비밀번호보이기 기능
	function pwdShow(e) {
  		
		e.preventDefault(); //버튼 클릭 시 <form>이 제출되는 기본 동작을 막는다
		
		const passwordCheck = $("#passwordCheck");	
		const btn = $("#passwordCheckBtn"); 
		const btn_icon = $("#passwordCheckBtn_icon"); 
		const btn_text = $("#passwordCheckBtn_text"); 
				
	    if (passwordCheck.attr("type") == "password") {      	
	    	passwordCheck.attr("type", "text");
	    	btn_text.text("비밀번호 숨기기");
	    	btn_icon.attr("class","fas fa-eye-slash").attr("style","color: rgb(0, 0, 0);");	    	
	        btn.attr("class","btn btn-light");	   	        
	    } else {     
	    	passwordCheck.attr("type", "password");    
	    	btn_text.text("비밀번호 보이기");   
	    	btn_icon.attr("class","fas fa-eye").attr("style","color: rgb(255, 255, 255);");
	        btn.attr("class","btn btn-custom");        
	    }
	}

  	
  </script>

</body>
</html>

