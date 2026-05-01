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
  <link rel="stylesheet" href="${cpath}/resources/css/btnStyle.css">
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

/*type이 radio 경우*/
input[type="radio"] {
    margin-left: 7px;   /* (버튼을 기준)왼쪽 간격 */
    margin-right: 1px;  /* (버튼을 기준)라디오 버튼과 글자 사이 간격 */
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
    					
    					<!-- 프로필업로드 -->
    					<form id="imageUpdateForm">
    						<input type="hidden" name="username" value="${user.member.username}"> 
							<table style="text-align: center;" class="table table-bordered">					
								<p>※이미지 형식의 파일만 등록할 수 있습니다</p>
								<tr>
									<td style="width: 150px; vertical-align: middle;">프로필업로드</td>
									<td>
										<span class="btn btn-default">										
											<input type="file" id="profile" name="profile" accept="image/*">
										</span>
									</td>
								</tr>						
								<tr>
									<td colspan="2">	
										<button type="button" data-oper="imageUpdate" class="btn btn-custom" id="profileBtn" disabled>프로필업로드</button> &nbsp;					
										<button type="button" data-oper="imageDelete" class="btn btn-outline-secondary">삭제</button>																							
									</td>
								</tr>
							</table>		
						</form>		
						<br>
							
						<!-- 닉네임수정 -->
						<form id="nick_nameForm">
							<input type="hidden" name="username" value="${user.member.username}"> 
							<table style="text-align: center; border : 1px solid #dddddd" class="table table-bordered">						
								<tr>
									<td style="width: 110px; vertical-align: middle;">닉네임</td>
									<td><input value="${user.member.nick_name}" required="required" type="text" name="nick_name" id="nick_name" class="form-control" required="required" maxlength="20"></td>
									<td style="width: 180px;"><button type="button" onclick="nick_nameCheck()" class="btn btn-outline-secondary">닉네임 중복확인</button></td>				
								</tr>										
								<tr>
									<td colspan="3">								
										<button type="button" data-oper="nick_name" class="btn btn-custom pull-right" >닉네임수정</button>									
									</td>
								</tr>
							</table>		
						</form>
					
						<br>					
						<!-- 회원정보수정 -->
						<form id="member_updateForm">
							<input type="hidden" name="username" value="${user.member.username}">
							<table style="text-align: center; border : 1px solid #dddddd" class="table table-bordered">										
								<tr>
									<td style="width: 110px; vertical-align: middle;">이름</td>
									<td colspan ="2"><input value="${user.member.name}" required="required" type="text" name="name" id="name" class="form-control" required="required" maxlength="20"></td>				
								</tr>									
								<tr>
									<td style="width: 110px; vertical-align: middle;">성별</td>
									<td colspan="2">
									<c:if test="${user.member.gender eq '남자'}">
										<input type="radio" name="gender" value="남자" checked="checked"> 남자
									    <input type="radio" name="gender" value="여자"> 여자		
									</c:if>
									<c:if test="${user.member.gender eq '여자'}">
										<input type="radio" name="gender" value="남자"> 남자
									    <input type="radio" name="gender" value="여자" checked="checked"> 여자		
									</c:if>	
									</td>
								</tr>											
								<tr>
									<td style="width: 110px; vertical-align: middle;">이메일</td>
									<td colspan ="2"><input value="${user.member.email}" required="required" type="email" name="email" id="email" class="form-control" maxlength="50"></td>				
								</tr>												
								<tr>
									<td colspan="2">								
										<button type="button" data-oper="member_update" class="btn btn-custom pull-right">회원정보수정</button>										
									</td>
								</tr>
							</table>		
						</form>   	
						
    				</div>
    			</div>
    		</div>
    		
    		<!-- 세번째칸 -->
    		<div class= "col-lg-5">
    			<div class="card" style="min-height: 636px; max-height: 1000px;">
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
	  
	  
  	  const profile = $("#profile");
      const profileBtn = $("#profileBtn");
      //프로필사진 등록시 '파일업로드'버튼 활성화 기능
	      //.on(): 이벤트 감시하는 역할 역할
	      //change : 바뀌면 다음동작실행
	  profile.on("change", function() {
	      // jQuery 객체에서 파일을 찾으려면 [0]을 붙여서 원본 엘리먼트에 접근한다
	      if(profile[0].files.length > 0) {
	          profileBtn.prop("disabled", false); // .prop()으로 속성 제어
	      } else {
	          profileBtn.prop("disabled", true);
	      }
	  });
	  

	  const nick_nameForm = $("#nick_nameForm");
	  const passwordForm = $("#passwordForm");
	  const member_updateForm = $("#member_updateForm");
	  const close_accountForm = $("#close_accountForm");
	  const imageUpdateForm = $("#imageUpdateForm");
	  
	  $("button[data-oper]").on("click", function(){
		  const oper = $(this).data("oper"); 
		  //닉네임
		  if(oper == "nick_name"){ 
				if($("#nick_name").val() == "${user.member.nick_name}"){
					
					$("#checkMessage").text("현재 사용중인 닉네임 입니다");
					$("#checkType").find(".modal-header").addClass("bg-danger text-white");
					$("#openModal").click();
					$("#username").focus(); 
					
					$("#nick_name").focus(); //다시 내용입력란에 포커스적용 
					return false;
				}else if($("#nick_name").val().trim() == ""){
					$("#checkMessage").text("닉네임을 입력해주세요");
					$("#checkType").find(".modal-header").addClass("bg-secondary text-white");
					$("#openModal").click();	
					
					$("#nick_name").focus(); // 아이디 입력창으로 커서를 자동한다
					return false;
				}	
	   
				nick_nameForm.attr("action", "${cpath}/member/update_nick_name");
				nick_nameForm.attr("method", "post");
				nick_nameForm.submit();
				
		  	
		   }else if(oper =="member_update"){
			   if($("#name").val().trim() == ""){
				    $("#checkMessage").text("이름을 입력해주세요");
					$("#checkType").find(".modal-header").addClass("bg-warning text-white");
					$("#openModal").click();					
					$("#name").focus(); // 아이디 입력창으로 커서를 자동한다
					return false;
			   }else if($("#email").val().trim() == ""){
				    $("#checkMessage").text("이메일을 입력해주세요");
					$("#checkType").find(".modal-header").addClass("bg-warning text-white");
					$("#openModal").click();	
					$("#email").focus(); // 아이디 입력창으로 커서를 자동한다
					return false;
			   }
			   member_updateForm.attr("action", "${cpath}/member/member_update");
			   member_updateForm.attr("method", "post");
			   member_updateForm.submit();
			   
		   }else if(oper == "imageUpdate"){   
		   
			   imageUpdateForm.attr("action", "${cpath}/member/imageUpdate");
			   imageUpdateForm.attr("method", "post");
			   imageUpdateForm.attr("enctype", "multipart/form-data");
			   imageUpdateForm.submit();   
			   
		   }else if(oper == "imageDelete"){   
			   if(!confirm("프로필 이미지를 삭제하시겠습니까?\n삭제 후에는 기본 이미지로 변경됩니다")) {
			        return; //취소를 누르면 함수종료 된다
			    }
			   imageUpdateForm.attr("action", "${cpath}/member/imageDelete");
			   imageUpdateForm.attr("method", "post");	  
			   imageUpdateForm.submit();   
		   }
  
	  });

  	});//ready
  	
  	

  	

	 //닉네임 중복체크
	 function nick_nameCheck() {
		 const nick_name = $("#nick_name").val(); //val(): 입력한 값을 가져온다  
		
		if(nick_name == ""){
			$("#checkMessage").text("닉네임을 입력해주세요");
			$("#checkType").find(".modal-header").addClass("bg-danger text-white");
			$("#openModal").click();
			$("#nick_name").focus(); // 아이디 입력창으로 커서를 자동한다
			return false; //아래코드로 실행되지 않고 함수종료된다 
		}
		
		if(nick_name == "${user.member.nick_name}"){
			$("#checkMessage").text("현재 사용중인 닉네임 입니다");
			$("#checkType").find(".modal-header").addClass("bg-danger text-white");
			$("#openModal").click();		
			$("#nick_name").focus(); // 아이디 입력창으로 커서를 자동한다
			return false; //아래코드로 실행되지 않고 함수종료된다
		}
		
		$.ajax({
			url:"${cpath}/member/nick_nameCheck", 
													
			type:"post",
			data:{"nick_name": nick_name},
			dataType: 'json',
			success:function(data){ //data결과값 받아온다
				//중복유무확인 → (data=1 사용가능, data=0 사용불가능)
				if(data == 1){
					$("#checkMessage").text("'" + nick_name + "' 는 이미 사용중인 닉네임 입니다");
					$("#checkType").find(".modal-header").addClass("bg-danger text-white");
				}else{
					$("#checkMessage").text("'" + nick_name + "' 는 사용 가능한 닉네임 입니다");			
					$("#checkType").find(".modal-header").addClass("bg-primary text-white");
				}			
				$("#openModal").click();
			
			},
			error: function(){ alert("닉네임 중복확인 실패"); }
		});
	 }; //end 닉네임중복체크
	 

  	
  	
  	
  </script>

</body>
</html>

