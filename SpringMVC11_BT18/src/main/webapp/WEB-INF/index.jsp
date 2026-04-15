<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
    
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="${cpath}/resources/css/btnStyle.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

  <div class="card" style="width: 600px; text-align: center; margin: 0px auto;">
   	<div class="jumbotron jumbotron-fluid">
  		<div class="container">
  			<h1>Spring Boot</h1>
  			<p>Main Page</p>
  		</div>
  	</div>
    <div class="card-body">
      <p class="card-text" style="text-align: left;">메뉴를 선택하세요</p> 	
      <div class="card-group">
      	<div class="card bg-warning">
      		<div class="card-body text-center">
      			<p class="card-text"><a href="${cpath}/board/list">글목록 보기</a></p>
      		</div>
      	</div>	
      	<div class="card bg-danger">
      		<div class="card-body text-center">
      			<p class="card-text"><a href="${cpath}/member/login">로그인</a></p>
      		</div>
      	</div>
      	<div class="card bg-default">
      		<div class="card-body text-center">
      			<p class="card-text"><a href="${cpath}/member/joinForm">회원가입</a></p>
      		</div>
      	</div>
      </div>
    </div>
  </div>
  
  <!-- 모달작동버튼 -->
  <div id="myMessageOpenModal" data-toggle="modal" data-target="#myMessage"></div>
  
  <!-- 회원가입 실패시 띄워줄 모달창 -->
  <div class="modal fade" id="myMessage">
    <div class="modal-dialog modal-lg">
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
				if(${msgType eq "성공메세지"}){ //msgType 데이터가 "실패메세지" 인 경우
					//$("#messageType").find(".modal-header").addClass("bg-danger text-white");
				}
				$("#myMessageOpenModal").click(); //모달창 실행
			}
		  
	  });//end ready
  </script>
  
  
</body>
</html>