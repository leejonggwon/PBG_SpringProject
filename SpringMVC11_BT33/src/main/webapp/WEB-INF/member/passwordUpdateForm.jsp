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
    				
	    				<!-- 비밀번호수정 -->
	    				<p>※ 비밀번호 변경시 자동으로 로그아웃이 됩니다.</p>		 
    					<form id="passwordForm">
    					<input type="hidden" name="username" value="${user.member.username}">
    					<input type="hidden" name="password" id="password" value="" >
							<table style="text-align: center; border : 1px solid #dddddd" class="table table-bordered">						
								<tr>
									<td style="width: 110px; vertical-align: middle;">새 비밀번호</td>
									<td><input class="form-control" type="password" name="password1" id="password1" onkeyup="passwordCheck()" maxlength="20" required="required" placeholder="비밀번호 입력 (영문 숫자 특수문자 포함 8~20자)"></td>									
									<td style="width: 200px;"><button id="password1CheckBtn" type="button" onclick="pwdShow()" class="btn btn-custom"><i id="password1CheckBtn_icon" class="fas fa-eye" style="color: rgb(255, 255, 255);"></i>&nbsp;&nbsp;<span id="password1CheckBtn_text">비밀번호 보이기</span></button></td>
								</tr>	
								<tr>
									<td style="width: 110px; vertical-align: middle;">새 비밀번호확인</td>
									<td colspan ="2"><input class="form-control" type="password" name="password2" id="password2" onkeyup="passwordCheck()" maxlength="20" required="required" placeholder="비밀번호를 확인하세요"></td>					
								</tr>
								<tr>
									<td style="width: 200px; vertical-align: middle;">비밀번호일치 여부 확인</td>
									<td  colspan ="2" style="text-align: center">
										<span id="passMessage"></span> <!-- 비밀번호 일치 여부 메시지 표시-->															
									</td>
								</tr>							
								<tr>
									<td colspan="3">								
										<button type="button" data-oper="password" class="btn btn-custom pull-right" >비밀번호수정</button>										
									</td>
								</tr>
							</table>		
						</form>
					
						<br>
						<br>
						
						<p>※ 탈퇴한 아이디는 본인과 타인 모두 재사용 및 복구가 불가하오니 신중하게 선택하시기 바랍니다</p>
						<form id="close_accountForm">	
						<input type="hidden" id="username" name="username" value="${user.member.username}">			
							<table style="text-align: center; border : 1px solid #dddddd" class="table table-bordered">									
								<tr>
									<td>												
										<button type="button" data-oper="close_account" class="btn btn-custom pull-right">회원탈퇴하기</button>										
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

	  var nick_nameForm = $("#nick_nameForm");
	  var passwordForm = $("#passwordForm");
	  var member_updateForm = $("#member_updateForm");
	  var close_accountForm = $("#close_accountForm");
	  var imageUpdateForm = $("#imageUpdateForm");
	  
	  $("button[data-oper]").on("click", function(){
		  var oper = $(this).data("oper"); 
		  
		  const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/;
		  var password = $("#password").val(); //비밀번호
		  var password1 = $("#password1").val(); 
		  var password2 = $("#password2").val(); 
			
		  	if(oper == "password"){
		  		
		  		if (!passwordRegex.test(password)) {
		  			 $("#checkMessage").text("영문, 숫자, 특수문자를 조합하여 8~20자로 입력해주세요.");
				     $("#checkType").find(".modal-header").addClass("bg-warning text-white");
					 $("#openModal").click();
				     
					 
				     $("#password").val(""); //비밀번호
				     $("#password1").val(""); 
				     $("#password2").val(""); 
			         return false;	        			  
				} 		   
			   
			   if($("#password").val().trim() == ""){
				    $("#checkMessage").text("비밀번호를 입력해주세요");
					$("#checkType").find(".modal-header").addClass("bg-warning text-white");
					$("#openModal").click();	
					
					$("#password1").focus(); // 아이디 입력창으로 커서를 자동한다
					return false;
			   }
			   
			   if(password != password1 || password1 != password2){
				    $("#checkMessage").text("비밀번호가 서로 일치하지 않습니다");
				    $("#checkType").find(".modal-header").addClass("bg-danger text-white");
					$("#openModal").click();
					
				    $("#password").val(""); 
					$("#password1").val(""); 
					$("#password2").val(""); 
		
					$("#password1").focus(); // 아이디 입력창으로 커서를 자동한다
					return false;
			   }

			   passwordForm.attr("action", "${cpath}/member/update_password");
			   passwordForm.attr("method", "post");
			   passwordForm.submit();	   
			   
			   $("#checkMessage").text("비밀번호 변경이 정상적으로 처리되었습니다");
			   $("#checkType").find(".modal-header").addClass("bg-warning text-white");
			   $("#openModal").click();

		   }else if(oper == "close_account"){
			   
			   if(!confirm("${user.member.username}" + "님 정말 탈퇴하시겠습니까? \n탈퇴 후 데이터 복구 및 동일 아이디 재가입은 불가능합니다.")) {
			        return; //취소를 누르면 함수종료 된다
			    }	
			   
			   close_accountForm.attr("action", "${cpath}/member/close_account");
			   close_accountForm.attr("method", "post");
			   close_accountForm.submit();     
		   }
  
	  });

  	});//ready
  	
  	

	//비밀번호중복체크
	function passwordCheck() {
		var password1 = $("#password1").val();
		var password2 = $("#password2").val();
		
		if(password1 != password2){
			$("#passMessage").html("비밀번호가 서로 일치하지 않습니다")
			$("#passMessage").css("color", "red");
		}else{
			$("#passMessage").html("비밀번호가 서로 일치합니다")
			$("#passMessage").css("color", "blue");
			
			//입력한 두 비밀번호 일치했을 때, password2 입력한 비밀번호가 hidden태그의 value에 값이 들어간다
			$("#password").val(password2); 
		}		
	};

  	
  	
	//비밀번호보이기 기능
	function pwdShow() {
		const password1 = $("#password1");	
		const btn = $("#password1CheckBtn"); 
		const btn_icon = $("#password1CheckBtn_icon"); 
		const btn_text = $("#password1CheckBtn_text"); 
				
	    if (password1.attr("type") == "password") {      	
	    	password1.attr("type", "text");
	    	btn_text.text("비밀번호 숨기기");
	    	btn_icon.attr("class","fas fa-eye-slash").attr("style","color: rgb(0, 0, 0);");	    	
	        btn.attr("class","btn btn-light");	   	        
	    } else {     
	    	password1.attr("type", "password");    
	    	btn_text.text("비밀번호 보이기");   
	    	btn_icon.attr("class","fas fa-eye").attr("style","color: rgb(255, 255, 255);");
	        btn.attr("class","btn btn-custom");        
	    }
	}
  	
  	
  	
  	
  	
  </script>

</body>
</html>

