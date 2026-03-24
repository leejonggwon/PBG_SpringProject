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

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/btnStyle.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
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

			<table style="text-align: center; border: 1px solid #dddddd" class ="table table-bordered">
				<tr>
					<td style="width: 110px; vertical-align: middle;">아이디</td>
					<td><input type="text" name="username" id="username" class="form-control" maxlength="20" placeholder="아이디를 입력하세요"></td>	
					<td style="width: 110px;"><button type="button" onclick="registerCheck()" class="btn btn-custom">중복확인</button></td>
				</tr>			
				<tr>
					<td style="width: 110px; vertical-align: middle;">비밀번호</td>
					<td colspan ="2"><input required="required" type="password" 
					name="password" id="password" class="form-control" maxlength="20" placeholder="비밀번호를 입력하세요"></td>									
				</tr>	
				<tr>
					<td style="width: 110px; vertical-align: middle;">사용자이름</td>
					<td colspan ="2"><input required="required" type="text" 
					name="name" id="name" class="form-control" maxlength="20" placeholder="이름을 입력하세요"></td>				
				</tr>
				
				<tr>
					<td style="width: 110px; vertical-align: middle;">닉네임</td>
					<td colspan ="2"><input required="required" type="text" 
					name="nick_name" id="nick_name" class="form-control" maxlength="20" placeholder="사용할 닉네임을 입력하세요"></td>				
				</tr>
		
				<!-- 권한 체크박스 -->
				<tr>
					<td style="width: 110px; vertical-align: middle;">권한</td>
					<td colspan="2">
						<!-- value값은 컬럼과 같게 해야한다 -->
						<input type="radio" name="role" value="GUEST"> GUEST
					    <input type="radio" name="role" value="STUDENT"> STUDENT
					    <input type="radio" name="role" value="PROFESSOR"> PROFESSOR
					    <input type="radio" name="role" value="ADMIN"> ADMIN
					</td>
				</tr>	
				
				<tr>
					<td style="width: 110px; vertical-align: middle;">교육과정</td>
					<td colspan="2">
					
						<!-- value값은 컬럼과 같게 해야한다 -->
						<input type="radio" name="cource" value="백엔드"> 백엔드
					    <input type="radio" name="cource" value="프론트엔드"> 프론트엔드
					    <input type="radio" name="cource" value="UX/UI 디자인"> UX/UI 디자인
					    <input type="radio" name="cource" value="데이터분석"> 데이터분석
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
						<button type="button" class="btn btn-success btn" 
						onclick="location.href='${cpath}/'">로그인페이지이동</button>						
						<input type="submit" class="btn btn-primary btn" value="등록">
						<input type="reset" class="btn btn-warning btn" value="취소">												
					</td>
				</tr>	
							
			</table>
		</form>
		</div>
		<div class="card-footer">BT Academy - All rights reserved</div>
	</div>
	</div>
	
  <!-- Bootstrap 비밀번호체크 모달창 -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
    
      <!-- 모달내용 -->
      <div id="checkType" class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">메세지확인</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
         <div class="modal-body">
           <p id="checkMessage"></p> <!-- 내용 넣는부분 -->
         </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  
  
  
  <script type="text/javascript">
  $(document).ready(function(){
	  
	  
	  
  });//end ready
  
	//아이디 중복확인
	function registerCheck() {
		var username = $("#username").val(); //val(): 입력한 값을 가져온다  
		alert("registerCheck: " + username);
		
		$.ajax({
			url:"${cpath}/member/registerCheck", 
													
			type:"post",
			data:{"username": username},
			dataType: "json",
			success:function(data){ //data결과값 받아온다
				//중복유무확인 → (data=1 사용가능, data=0 사용불가능)
				if(data == 1){
					alert("사용할수 있는 아이디");
					$("#checkMessage").text(username +"는사용할 수 있는 아이디 입니다");
					$("#checkType").attr("class", "modal-content panel-success");
				}else{
					alert("사용할수 없는 아이디");
					$("#checkMessage").text("사용할 수 없는 아이디 입니다");
					$("#checkType").attr("class", "modal-content panel-warning");
				}
				$("#myModal").modal("show"); //.modal() 함수는 Bootstrap의 JavaScript 플러그인에서 제공하는 함수다
			},
			error: function(){ alert("아이디 중복확인 기능 error"); }
		});
	}
  
  
  
  </script>
  
	
	
</body>




</html>