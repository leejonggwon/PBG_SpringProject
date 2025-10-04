<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><!-- 줄바꿈, 날짜일정문자 잘라내는 기능들이 있다 -->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring MVC06</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	
	<div class="container">
	<jsp:include page="../common/header.jsp"></jsp:include>
		<h2>Spring MVC06</h2>
		<div class="panel panel-default">
			<div class="panel-heading">Login</div>
			<div class="panel-body">
			<!-- 파일 업로드 경우에는 쿼리스트링으로 csrf token 전달해줘야 한다 -->
			<form action="${contextPath}/imageUpdate.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data"> <!-- 이미지나 영상 이런걸로 보낼때는 인코딩방식을 바꿔줘야한다 
			                                                                                                                                     기본적으로 text보내는 형식에서 → multipart/form-data 형식으로 바꿔줘야한다 -->		
				<table style="text-align: center; border: 1px solid #dddddd" class ="table table-borderd">
					<tr>
						<td style="width: 110px; vertical-align: middle;">아이디</td>
						<td>${mvo.memID}</td>						
					</tr>
					<tr><!-- 사진업로드 -->
						<td style="width: 110px; vertical-align: middle;">사진업로드</td>
						<td>
							<span class="btn btn-default">
								이미지를 업로드하세요 <input type="file" name="memProfile">
							</span>
						</td>
					</tr>
					<tr>
						<td colspan ="2">
							<span id="passMessage" ></span> 
							<input type="submit" class="btn btn-primary btn pull-right" value="이미지등록">				
						</td>
					</tr>
					
				</table>
			</form>
			</div>
			<div class="panel-footer">스프링게시판 - 이종권</div>
		</div>
	</div>
	

   
   <!-- 회원가입 실패시 띄워줄 모달창 -->
   <div class="modal fade" id="myMessage" role="dialog">
     <div class="modal-dialog">
     
       <!-- 모달내용-->
       <div id="messageType" class="modal-content">
         <div class="modal-header panel-heading"> <!-- panel-heading을 넣어야 헤더 스타일이 적용된다 -->
           <button type="button" class="close" data-dismiss="modal">&times;</button>
           <h4 class="modal-title">${msgType}</h4> <!--MemberController에서 실패하면 joinForm에서 다시 이동할때 값을 보내준다 -->
         </div>
         <div class="modal-body">
           <p>${msg}</p> 
         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
         </div>
       </div>
   
     </div>
   </div>
   
	<script type="text/javascript">	
		//회원가입 실패시 띄워줄 모달창 실행
		//HTML 문서가 모두 로딩될 때까지 기다렸다가 그 안의 기능을 실행하겠다는 의미 
		$(document).ready(function(){
			if(${not empty msgType}){ //EL식
				if(${msgType eq "실패메세지"}){ //EL식
					$("#messageType").attr("class", "modal-content panel-warning");
				}else{
					$("#messageType").attr("class", "modal-content panel-success");
				}
			$("#myMessage").modal("show"); //모달창 실행
			}
		});
		
		
	</script>
	
</body>
</html>





