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
<title>Boot Academy</title>
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
  
  
<style>
.carousel-inner > .item > img,
.carousel-inner > .item > a > img {
	width: 70%;
	margin: auto;
}
</style>
</head>
<body>

	<div class="container">
	<br>
		
		 <div class="card">
			<div class="card-header">Login</div>
			<div class="card-body">
				<div class="text-center">
					<!-- img-fluid : 이미지가 card-body 가로폭에 맞춰서 자동으로 최적화된다-->
					<img src="${cpath}/resources/images/mainImages/logo2.png" alt="Cinque Terre" class="img-fluid">
				</div>
			<br>
			<form action="${cpath}/member/login" method="post"> <!-- controller위치는 views 바로 아래에 있다 -->
				<table style="text-align: center; border: 1px solid #dddddd" class ="table table-borderd">
					<tr>
						<td style="width: 110px; vertical-align: middle;">아이디</td>
						<td colspan ="2"><input type="text" name="username" id="username" class="form-control" maxlength="20" placeholder="아이디를 입력하세요"></td>						
					</tr>
					<tr>
						<td style="width: 110px; vertical-align: middle;">비밀번호</td>
						<td><input required="required" type="password" name="password" id="password" class="form-control" maxlength="20" placeholder="비밀번호를 입력하세요"></td>								
						<td style="width: 200px;"><button id="passwordCheckBtn" type="button" onclick="pwdShow()" class="btn btn-custom"><i id="passwordCheckBtn_icon" class="fas fa-eye" style="color: rgb(255, 255, 255);"></i>&nbsp;&nbsp;<span id="passwordCheckBtn_text">비밀번호 보이기</span></button></td>
					</tr>
					<tr>
						<td colspan ="3">
							<span id="passMessage" style="text-align:center"></span> 
							<input type="submit" class="btn btn-custom" value="로그인">												
							<a type="button" class="btn btn-outline-dark" href="${cpath}/member/joinForm">회원가입</a>		
							&nbsp;													
							<a type="button" class="btn btn-secondary" href="${cpath}/">메인페이지</a>														
						</td>
					</tr>
				</table>
			</form> <!-- 로그인폼 -->
			
			
			<!-- 이미지 슬라이드 -->
			<div id="demo" class="carousel slide" data-ride="carousel">
			  <ul class="carousel-indicators">
			    <li data-target="#demo" data-slide-to="0" class="active"></li>
			    <li data-target="#demo" data-slide-to="1"></li>
			    <li data-target="#demo" data-slide-to="2"></li>
			  </ul>
			  <div class="carousel-inner" style="text-align: center;">
			    <div class="carousel-item active">
			      <img src="${cpath}/resources/images/mainImages/slide1.png" alt="Los Angeles" width="700" height="350">
			      <div class="carousel-caption">
			        <h3>Back-End</h3>
			        <p>We had such a great time in APPLE!</p>
			      </div>   
			    </div>
			    <div class="carousel-item">
			      <img src="${cpath}/resources/images/mainImages/slide2.png" alt="Chicago" width="700" height="350">
			      <div class="carousel-caption">
			        <h3>Front-End</h3>
			        <p>Thank you, SAMSUNG!</p>
			      </div>   
			    </div>
			    <div class="carousel-item">
			      <img src="${cpath}/resources/images/mainImages/slide3.png" alt="New York" width="700" height="350">
			      <div class="carousel-caption">
			        <h3>AI</h3>
			        <p>We love the NVIDIA!</p>
			      </div>   
			    </div>		    
			    <div class="carousel-item">
			      <img src="${cpath}/resources/images/mainImages/slide4.png" alt="New York" width="700" height="350">
			      <div class="carousel-caption">
			        <h3>Cloud</h3>
			        <p>TESLA, you have our hearts!</p>
			      </div>   
			    </div>
			  </div>
			  <a class="carousel-control-prev" href="#demo" data-slide="prev">
			    <span class="carousel-control-prev-icon"></span>
			  </a>
			  <a class="carousel-control-next" href="#demo" data-slide="next">
			    <span class="carousel-control-next-icon"></span>
			  </a>
			</div><!-- 이미지 슬라이드 -->
			
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
			
		}); //ready
		
		
		//비밀번호보이기 기능
		function pwdShow() {
			const password = $("#password");	
			const btn = $("#passwordCheckBtn"); 
			const btn_icon = $("#passwordCheckBtn_icon"); 
			const btn_text = $("#passwordCheckBtn_text"); 
					
		    if (password.attr("type") == "password") {      	
		    	password.attr("type", "text");
		    	btn_text.text("비밀번호 숨기기");
		    	btn_icon.attr("class","fas fa-eye-slash").attr("style","color: rgb(0, 0, 0);");	    	
		        btn.attr("class","btn btn-light");	   	        
		    } else {     
		    	password.attr("type", "password");    
		    	btn_text.text("비밀번호 보이기");   
		    	btn_icon.attr("class","fas fa-eye").attr("style","color: rgb(255, 255, 255);");
		        btn.attr("class","btn btn-custom");        
		    }
		}
	
	</script>

</body>
</html>