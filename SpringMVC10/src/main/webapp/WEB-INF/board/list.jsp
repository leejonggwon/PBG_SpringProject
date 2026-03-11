<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="cpath" value="${pageContext.request.contextPath}"/> <!--절대경로-->

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
 
  <div class="card">
    <div class="card-header">
	    <div class="jumbotron jumbotron-fluid">
		  <div class="container">
		    <h1>Spring MVC10</h1>
		    <p>Java → HTML → CSS → JSP&Servlet → Spring F/W → Spring Boot</p>
		  </div>
		</div>
    </div>
    <div class="card-body">
    	<div class="row"> <!-- 가로, 세로는 col을 사용한다 -->
    		<div class= "col-lg-2"> 
    			<div class="card" style="min-height: 500px; max-height: 1000px;">
    				<div class="card-body">
    					<h4 class="card-title">GUEST</h4>
    					<p class="card-text">회원님 Welcome!</p>
    					<form action="">
    						<div class="form-group">
    							<label for="memID">아이디</label>
    							<input type="text" class="form-control" id="memID" name="memID">
    						</div>
    						<div class="form-group">
    							<label for="memPwd">비밀번호</label>
    							<input type="password" class="form-control" id="memPwd" name="memPwd">
    						</div>
    						<button type="submit" class="form-control btn btn-sm btn-primary">로그인</button> 						
    					</form>
    				</div>
    			</div>
    		</div>
    		<div class= "col-lg-5">
    			<div class="card" style="min-height: 500px; max-height: 1000px;">
    				<div class="card-body">
    					<table class="table table-bordered table-hover">
    						<thead>
    							<th>번호</th>
    							<th>제목</th>
    							<th>작성일</th>
    							<th>조회수</th>
    						</thead>
    						<tbody>
    							<c:forEach var="vo" items="${list}" varStatus="i">
    								<tr>
    									<td>${i.count}</td>
    									<td><a href="${vo.idx}">${vo.title}</a></td>
    									<td><fmt:formatDate value="${vo.indate}" pattern="yyyy-MM-dd"/></td>
    									<td>${vo.count}</td>
    								</tr>
    							</c:forEach>
    						</tbody>
    						
    					</table>
    				</div>
    			</div>
    		</div>
    		<div class= "col-lg-5">
    			<div class="card" style="min-height: 500px; max-height: 1000px;">
    				<div class="card-body">
						<form id="regForm" action="${cpath}/register" method="post">					
							<input type="hidden" id="idx" name="idx" value=""> 
						
    						<div class="form-group">
    							<label for="title">제목</label> 
    							<input type="text" class="form-control" id="title" name="title" placeholder="Enter Title">
    						</div>
    						<div class="form-group">
    							<label for="content">내용</label>
    							<textarea id="content" name="content" class="form-control" placeholder="Enter Content" rows="7" cols=""></textarea> 
    						</div>
    						<div class="form-group">
    							<label for="writer">작성자</label>
    							<input type="text" class="form-control" id="writer" name="writer" placeholder="Enter Writer">
    						</div>
    						<div id="regDiv">  					
	    						<button type="button" data-oper="register" class="btn btn-sm btn-primary">등록</button> 						
	    						<button type="button" data-oper="reset" class="btn btn-sm btn-warning">취소</button> 						
    						</div>						
    						<div id="updateDiv" style="display: none;">
    							<button class="btn btn-sm btn-primary" data-oper="list" type="button">목록</button>
    							<span id="update">
    								<button class="btn btn-sm btn-warning" data-oper="updateForm" type="button">수정</button>
    							</span>
    							<button class="btn btn-sm btn-success" data-oper="remove" type="button">삭제</button>
    						</div> 						
    					</form>				
    				</div>
    			</div>
    		</div>
    	</div>
    </div>  
    <div class="card-footer">스프링 - 이종권</div>
  </div>
  
  <script type="text/javascript">
  	$(document).ready(function(){
  		//form 태그에 대한 정보
  		var regForm = $("#regForm");
  		
  		//모든태그의 버튼의 클릭을 감지를 한다 
  		$("button").on("click", function(){
  			//클릭한 버튼의 data-oper 속성 값을 가져온다
  			var oper = $(this).data("oper")
  			
  			if(oper == "register"){
  				regForm.submit();
  			}else if(oper == "reset"){
  				regForm[0].reset();
  			}else if(oper == "list"){
  				location.href ="${cpath}/list"; //list 주소로 이동	
  			}else if(oper == "remove"){
  				var idx = regForm.find("#idx").val();
  				location.href = "${cpath}/remove?idx="+idx;
  			}else if(oper == "updateForm"){ 
  				regForm.find("#title").attr("readonly", false);
  				regForm.find("#content").attr("readonly", false);
				
  				var upBtn = "<button onclick='goUpdate()' class='btn btn-sm btn-info' type='button'>수정완료</button>";
  				
  				$("#update").html(upBtn); //id="update"에 선택한 요소 안의 내용을 통째로 바꾸겠다		
  				//$("#update").text(upBtn); 로 하면 텍스트가 바뀐다 
  			}
  		}); //버튼클릭
  		
  		//상세보기 클릭
  		$("a").on("click", function(e){
  			//a 태그의 기본 동작(href에 의한 페이지 이동)을 막는다	
  			e.preventDefault(); 
  			
  			//클릭한 해당 요소의 href 속성값을 가져오겠다(idx값) //<a href="${vo.idx}">
  			var idx = $(this).attr("href"); 
  			
  			$.ajax({
  				url : "${cpath}/get",
  				type : "get",
  				data : {"idx" : idx},
  				dataType : "json", //{"idx": 1, "title": "안녕", "writer": "홍길동"}
  				success : printBoard,
  				error : function(){ alert("상세보기 error"); }
  			});//ajax
  			
  		});//a태그클릭
  		
  	});//ready
  	
  	//상세보기 서버 통신 성공 후 게시글 정보를 폼에 출력하는 함수
  	function printBoard(vo){
  		var regForm = $("#regForm");
  		
  		//regForm기준으로 title을 찾는다 → vo.title 인 value값을 넣는다 
  		regForm.find("#title").val(vo.title);
  		regForm.find("#content").val(vo.content);
  		regForm.find("#writer").val(vo.writer);	
  		
  		regForm.find("input").attr("readonly", true);
  		regForm.find("textarea").attr("readonly", true);
  		
  		//display는 HTML 속성이 아니라 CSS속성이기 때문에 attr()로 안된다  
  		$("#regDiv").css("display", "none"); //숨김
  		$("#updateDiv").css("display", "block");//보여주기
  		
  		//$("#regDiv").hide();    // 등록 폼 숨기기(제이쿼리가 제공하는 전용함수)
		//$("#updateDiv").show(); // 수정 폼 보이기
  		
  		regForm.find("#idx").val(vo.idx); //(삭제기능위해)hidden 타입으로 숨겨둔 idx에 vo.idx 값을 넣는다  			
  	}
  	
  	//수정기능
  	function goUpdate(){
  		var regForm = $("#regForm");
  		regForm.attr("action", "${cpath}/modify"); //action값을 바꿔준다
  		regForm.submit(); //제출
  	}
  	
  </script>

</body>
</html>

