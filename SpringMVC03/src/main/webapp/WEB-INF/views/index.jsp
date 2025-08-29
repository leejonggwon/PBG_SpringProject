<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Spring MVC03</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<!-- 공통 메뉴바:
		     JSP에서 다른 JSP 파일을 현재 페이지에 포함시키는 기능 -->
		<jsp:include page="common/header.jsp"></jsp:include> 
		<h3>Spring MVC03</h3>
		<p>In this example, the navigation bar is hidden on small screens
			and replaced by a button in the top right corner (try to re-size this
			window).
		<p>Only when the button is clicked, the navigation bar will be
			displayed.</p>
	</div>
	
	
	<!-- 회원가입 성공시 띄워줄 모달창 -->
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
   	$(document).ready(function(){
   		if(${not empty msgType}){ //EL식
			if(${msgType eq "성공메세지"}){ //EL식
				$("#messageType").attr("class", "modal-content panel-success");
			}
		$("#myMessage").modal("show"); //모달창 실행
		}
   		
   	});
   
   </script>
   

</body>
</html>
















