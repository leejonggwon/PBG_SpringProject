<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- context path 값을 내장객체 변수로 저장한다: contextPath라는 변수를 만들고, 현재 애플리케이션의 context path 값을 저장한다-->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Spring MVC06</title>
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
		<h3>Spring MVC06</h3>	
		<div class="panel panel-default">
			<div>
				<img style="width:100%; height:400px;" src="${contextPath}/resources/images/main.jpg"> <!--views 폴더 아래 있으면 resouces 위치와 똑같다고 보면 된다-->
			</div>
			<div class="panel-body">
			
				<ul class="nav nav-tabs">
					<li class="active"><a data-toggle="tab" href="#home">Home</a></li>
					<li><a data-toggle="tab" href="#menu1">게시판</a></li>
					<li><a data-toggle="tab" href="#menu2">공지사항</a></li>
				    <li><a data-toggle="tab" href="#menu3">Menu3</a></li>
				</ul>
		
			    <div class="tab-content">
				    <div id="home" class="tab-pane fade in active">
				      <h3>HOME</h3>
				      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
				    </div>
				    <div id="menu1" class="tab-pane fade">
				      <h3>게시판</h3>
				      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
				    </div>
				    <div id="menu2" class="tab-pane fade">
				      <h3>공지사항</h3>
				      <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
				    </div>
				    <div id="menu3" class="tab-pane fade">
				      <h3>Menu 3</h3>
				      <p>Eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>
				    </div>
			    </div>
			    
			</div>
			<div class="panel-footer">
				스프링-이종권
			</div>
		</div>	
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
















