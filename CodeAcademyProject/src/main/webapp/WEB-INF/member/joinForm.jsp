<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	

<c:set var="cpath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
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
/*type이 radio 경우*/
input[type="radio"] {
	margin-left: 7px;   /* (버튼을 기준)왼쪽 간격 */
	margin-right: 1px;  /* (버튼을 기준)라디오 버튼과 글자 사이 간격 */
}

</style>

<body>

	<div class="container">
	<br>
	<div class="card">
		<div class="card-header">회원가입폼</div>
		<div class="card-body">
		<form action="${cpath}/member/join" method="post"> 
		<input type="hidden" name="enabled" value="true">
		<input type="hidden" name="password" id="password" value="" > <!-- 두 password 비교 후 이값을 넘길것이다 -->
		<input type="hidden" name="user_code" id="user_code"> 
		
			<table style="text-align: center; border: 1px solid #dddddd" class ="table table-bordered">
				<tr>
					<td style="width: 110px; vertical-align: middle;">아이디</td>
					<td><input required="required" type="text" name="username" id="username" class="form-control" maxlength="20" placeholder="아이디를 입력하세요"></td>	
					<td style="width: 180px;"><button type="button" onclick="registerCheck()" class="btn btn-custom">아이디 중복확인</button></td>
				</tr>			
				<tr>
					<td style="width: 110px; vertical-align: middle;">비밀번호</td>
					<td colspan ="2"><input class="form-control" type="password" name="password1" id="password1" onkeyup="passwordCheck()" maxlength="20" required="required" placeholder="비밀번호를 입력하세요"></td>									
				</tr>	
				<tr>
					<td style="width: 110px; vertical-align: middle;">비밀번호확인</td>
					<td colspan ="2"><input class="form-control" type="password" name="password2" id="password2" onkeyup="passwordCheck()" maxlength="20" required="required" placeholder="비밀번호를 확인하세요"></td>					
				</tr>
				
				<tr>
					<td style="width: 200px; vertical-align: middle;">비밀번호일치 여부 확인</td>
					<td colspan ="2" style="text-align: center">
						<span id="passMessage"></span> <!-- 비밀번호 일치 여부 메시지 표시-->															
					</td>
				</tr>
				
				<tr>
					<td style="width: 110px; vertical-align: middle;">이름</td>
					<td colspan ="2"><input required="required" type="text" name="name" id="name" class="form-control" required="required" maxlength="20" placeholder="이름을 입력하세요"></td>				
				</tr>
				
				<tr>
					<td style="width: 110px; vertical-align: middle;">닉네임</td>
					<td><input required="required" type="text" name="nick_name" id="nick_name" class="form-control" required="required" maxlength="20" placeholder="사용할 닉네임을 입력하세요"></td>				
					<td style="width: 180px;"><button type="button" onclick="nick_nameCheck()" class="btn btn-custom">닉네임 중복확인</button></td>
				</tr>
		
				<!-- 권한 체크박스 -->
				<tr>
					<td style="width: 110px; vertical-align: middle;">권한</td>
					<td colspan="2">
						<!-- value값은 컬럼과 같게 해야한다 -->
						<input type="radio" name="role" value="GUEST"> GUEST
					    <input type="radio" name="role" value="STUDENT"> STUDENT
					    <input type="radio" name="role" value="INSTRUCTOR"> INSTRUCTOR
					    <input type="radio" name="role" value="ADMIN"> ADMIN
					</td>
				</tr>				
				<tr>
					<td style="width: 110px; vertical-align: middle;">교육과정</td>
					<td colspan="2">	
						<!-- value값은 컬럼과 같게 해야한다 -->
						<input type="radio" name="cource" value="BACK" required="required"> 백엔드
					    <input type="radio" name="cource" value="FRONT"> 프론트엔드
					    <input type="radio" name="cource" value="DESIGN"> UX/UI 디자인
					    <input type="radio" name="cource" value="DATA"> 데이터분석
					</td>
				</tr>				
				<tr>
					<td style="width: 110px; vertical-align: middle;">나이</td>
					<td colspan ="2"><input required="required" type="number" name="age" id="age" class="form-control" maxlength="20" placeholder="나이를 입력하세요"></td>				
				</tr>			
				<tr>
					<td style="width: 110px; vertical-align: middle;">성별</td>
					<td colspan="2">
						<!-- value값은 컬럼과 같게 해야한다 -->
						<input type="radio" name="gender" value="남자" checked="checked"> 남자
					    <input type="radio" name="gender" value="여자"> 여자		
					</td>
				</tr>				
				<tr>
					<td style="width: 110px; vertical-align: middle;">이메일</td>
					<td colspan ="2"><input required="required" type="email" name="email" id="email" class="form-control" maxlength="50" placeholder="이메일을 입력하세요"></td>				
				</tr>
				
				<tr>
					<td colspan ="3" style="text-align: right">
						<input type="submit" class="btn btn-custom btn" value="회원가입">
						<input type="reset" class="btn btn-outline-dark" value="입력취소">												
						<button type="button" class="btn btn-secondary" onclick="location.href='${cpath}/member/login'">로그인로 페이지이동</button>						
					</td>
				</tr>	
				
											
			</table>
		</form>
		</div>

		<%@ include file="/WEB-INF/common/bottom_common.jsp" %>
	</div>
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
  
  <!-- 회원가입 실패시 띄워줄 모달창 -->
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
	  
	  user_code(); //사용자번호
	  
	  if(${not empty msgType}){ //들어오는 msgType에 데이터가 감지되는경우
			if(${msgType eq "실패메세지"}){ //msgType 데이터가 "실패메세지" 인 경우
				$("#messageType").find(".modal-header").addClass("bg-danger text-white");
			}
			$("#myMessageOpenModal").click(); //모달창 실행
		}
	  
  });//end ready
  
  
	//아이디 중복확인
	function registerCheck() {
		var username = $("#username").val(); //val(): 입력한 값을 가져온다  
		
		if(username == ""){
			$("#checkMessage").text("아이디를 입력해 주세요");
			$("#checkType").find(".modal-header").addClass("bg-danger text-white");
			$("#openModal").click();
			
			$("#username").focus(); // 아이디 입력창으로 커서를 자동한다
			return false; //아래코드로 실행되지 않고 함수종료된다 
		}
		
		$.ajax({
			url:"${cpath}/member/registerCheck", 
													
			type:"post",
			data:{"username": username},
			dataType: 'json',
			success:function(data){ //data결과값 받아온다
				//중복유무확인 → (data=1 사용가능, data=0 사용불가능)
				if(data == 1){
					$("#checkMessage").text(username + "는 이미 사용중인 아이디 입니다");
					$("#checkType").find(".modal-header").attr("class", "modal-header bg-danger text-white");
				}else if (data == 0){
					$("#checkMessage").text(username + " 는 사용 가능한 아이디 입니다");			
					$("#checkType").find(".modal-header").attr("class", "modal-header bg-primary text-white");
				}			
				$("#openModal").click();
			
			},
			error: function(){ alert("아이디 중복확인 실패"); }
		});
	};
  
  
  	//닉네임 중복체크
  	function nick_nameCheck() {
		var nick_name = $("#nick_name").val(); //val(): 입력한 값을 가져온다  
		
		if(nick_name == ""){
			$("#checkMessage").text("닉네임을 입력해 주세요");
			$("#checkType").find(".modal-header").attr("class", "modal-header bg-danger text-white");
			$("#openModal").click();
			
			$("#username").focus(); // 아이디 입력창으로 커서를 자동한다
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
					$("#checkMessage").text(nick_name + " 는 이미 사용중인 닉네임 입니다");;
					$("#checkType").find(".modal-header").attr("class", "modal-header bg-danger text-white");
					
				}else{
					$("#checkMessage").text(nick_name + " 는 사용 가능한 닉네임 입니다");		
					$("#checkType").find(".modal-header").attr("class", "modal-header bg-primary text-white");				
				}			
				$("#openModal").click();
			
			},
			error: function(){ alert("닉네임 중복확인 실패"); }
		});
  	};
  	
	//비밀번호체크
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
	
	//user_code 생성
	function generateRandomCode(length) {
	    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
	    let result = '';
	    for (let i = 0; i < length; i++) {
	        // chars 문자열에서 랜덤한 위치의 글자를 하나씩 선택
	        result += chars.charAt(Math.floor(Math.random() * chars.length));
	    }
	    return result;
	}
  
	//user_code 입력
	function user_code() {
		const myCode = generateRandomCode(5);
		$("#user_code").attr("value", myCode);
	}
	
  
  
  </script>

</body>




</html>