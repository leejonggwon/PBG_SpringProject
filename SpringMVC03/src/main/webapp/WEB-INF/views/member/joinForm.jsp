<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><!-- 줄바꿈, 날짜일정문자 잘라내는 기능들이 있다 -->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring MVC03</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<jsp:include page="../common/header.jsp"></jsp:include>
	<div class="container">
		<h2>Spring MVC03</h2>
		<div class="panel panel-default">
			<div class="panel-heading">Board</div>
			<div class="panel-body">
			
			<form action="">
				<table style="text-align: center; border: 1px solid #dddddd" class ="table table-borderd">
					<tr>
						<td style="width: 110px; vertical-align: middle;">아이디</td>
						<td><input type="text" name="memID" id="memID" class="form-control" maxlength="20" placeholder="아이디를 입력하세요"></td>
						<td style="width: 110px;"><button type="button" onclick="registerCheck()" class="btn btn-primary">중복확인</button></td>						
					</tr>
					<tr>
						<td style="width: 110px; vertical-align: middle;">비밀번호</td>
						<td colspan ="2"><input type="password" onkeyup="passwordCheck()" name="memPassword1" id="memPassword1" class="form-control" maxlength="20" placeholder="비밀번호를 입력하세요"></td>					
						<!-- onkeyup: 키보드에서 손을 뗄 때 발생하는 이벤트 -->
					</tr>
					<tr>
						<td style="width: 110px; vertical-align: middle;">비밀번호확인</td>
						<td colspan ="2"><input type="password" onkeyup="passwordCheck()" name="memPassword2" id="memPassword2" class="form-control" maxlength="20" placeholder="비밀번호를 확인하세요"></td>					
					</tr>
					<tr>
						<td style="width: 110px; vertical-align: middle;">사용자이름</td>
						<td colspan ="2"><input type="text" name="memName" id="memName" class="form-control" maxlength="20" placeholder="이름을 입력하세요"></td>				
					</tr>
					<tr>
						<td style="width: 110px; vertical-align: middle;">나이</td>
						<td colspan ="2"><input type="number" name="memAge" id="memAge" class="form-control" maxlength="20" placeholder="나이를 입력하세요"></td>				
					</tr>
					
					<tr>
						<td style="width: 110px; vertical-align: middle;">성별</td>
						<td colspan ="2">
							<div class="form-group" style="text-align: center; margin:0 auto">
								<div class="btn-group" data-toggle="buttons"> 
									<label class="btn btn-primary active">
										<input type="radio" id="memGender" name="memGender" autocomplete="off" value="남자" checked="checked"> 남자
									</label>
									<label class="btn btn-primary">
										<input type="radio" id="memGender" name="memGender" autocomplete="off" value="여지"> 여자
									</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 110px; vertical-align: middle;">이메일</td>
						<td colspan ="2"><input type="email" name="memEmail" id="memEmail" class="form-control" maxlength="50" placeholder="이메일을 입력하세요"></td>				
					</tr>
					<tr>
						<td colspan ="3">
							<input type="submit" class="btn btn-primary btn pull-right" value="등록">
							<input type="reset" class="btn btn-warning btn pull-right" value="취소">						
						</td>
					</tr>
					
					
				</table>
			</form>
			</div>
			<div class="panel-footer">스프링게시판 - 이종권</div>
		</div>
	</div>
	<script type="text/javascript">
	
		//중복확인
		function registerCheck() {
			var memID = $("#memID").val(); //val(): 입력한 값을 가져온다  
			
			//동기방식: 브라우저가 서버에 요청을 보내면 서버 응답이 올 때까지 웹페이지 전체가 멈춤
			//비동기방식: 서버에 요청을 보내고 웹페이지는 멈추지 않고 계속 동작, 서버에서 필요한 데이터만 받아서 일부만 갱신 가능
			$.ajax({
				url:"${contextPath}/registerCheck.do",  // controller의 실행위치는 views바로 아래이므로 → ../registerCheck.do 으로 작성하면 불편하다 
														// JS에 EL, JSTL을 쓸 수 있다 
				type:"get",
				data:{"memID": memID},
				success:function(data){ //data결과값 받아온다
					//중복유무확인 → (data=1 사용가능, data=0 사용불가능)
					if(data == 1){
						alert("사용 가능한 아이디 입니다");
					}else{
						alert("사용 불가능한 아이디 입니다");
					}
				},
				error: function(){ alert("error"); }
			});
			
		}
		
		//비밀번호체크
		function passwordCheck() {
			
		}
	</script>
	
</body>
</html>





