<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--JSTL Core 라이브러리: JSP에서 조건문, 반복문, 변수 설정 등을 할 때 사용, 자바 코드 대신 JSTL 문법으로 표현 가능 -->     
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!-- JSTL Functions(함수) 라이브러리: 줄바꿈, 날짜일정문자 잘라내는 기능들이 있다 -->  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!--JSTL Formatting라이브러리: fmt 태그는 주로 날짜/시간, 숫자, 메시지 포맷 처리에 사용 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!-- ${cpath}/login/loginProcess 이렇게 쓰인다  -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring MVC09</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
	  <h2>Spring MVC09</h2>
	  <div class="panel panel-default">
		<div class="panel-heading">Board</div>
		<div class="panel-body">
			<table class="table table-bordered table-hover">
				<tr>
					<td>번호</td>
					<td>${vo.idx}</td>
				</tr>
				<tr>
					<td>제목</td>
					<td><c:out value="${vo.title}"/></td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<textarea class="form-control" readonly="readonly" rows="10" cols=""><c:out value="${vo.content}"/></textarea>
					</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td>${vo.writer}</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center">
						<c:if test="${not empty mvo}"> <!-- mvo가 비어있지 않는 상황: 로그인한 상황을 말한다 -->
						<button data-btn="reply" class="btn btn-sm btn-primary">답글</button>
						<button data-btn="modify" class="btn btn-sm btn-success">수정화면</button>   
						</c:if>
						
						<c:if test="${empty mvo}"> <!--로그인 안한 상황을 말한다 -->
						<button disabled="disabled" class="btn btn-sm btn-primary">답글</button>
						<button disabled="disabled" class="btn btn-sm btn-success">수정</button>   
						</c:if>
						
						<button data-btn="list" class="btn btn-sm btn-warning">목록</button>
					</td>
				</tr>
			</table>
			
			<form id="frm" method="get" action="">
				<input id="idx" type="hidden" name="idx" value="${vo.idx}" >
				<input type="hidden" name="page" value="${cri.page}">
				<input type="hidden" name="perPageNum" value="${cri.perPageNum}">	
					
				<!-- type과 keyword를 넘기기위한 부분 추가하면 결과값(type, keyword)이 유지된다 -->
			  	<input type="hidden" id="type" name="type" value="${cri.type}">
			  	<input type="hidden" id="keyword" name="keyword" value="${cri.keyword}">		
			</form>
			
		</div>
		<div class="panel-footer">스프링게시판 - 이종권</div>
	  </div>
	</div>
	
	<script type="text/javascript">
		//링크처리하기 
		$(document).ready(function() { //로딩되면 함수를 작동시키겠다 	
			$("button").on("click", function(e){ //버튼을 클릭하면 함수실행한다 
		
				var formData = $("#frm"); //form 태그 action값 주소를 바꿔주기위해 요소 가져오기 
				var btn = $(this).data("btn"); //현재 발생한 이벤트(클릭한 버튼요소)의 data-btn 속성값인
				                               // reply, modify, list 등 btn의 값을 가져온다  	 	
						                                                  
				if(btn == "reply"){ //답글버튼을 누르면
					formData.attr("action","${cpath}/board/reply"); //action 속성을 reply URL경로로 바꿔준다 
				}else if(btn == "modify"){
					formData.attr("action","${cpath}/board/modify"); 
				}else if(btn == "list"){
					formData.attr("action","${cpath}/board/list"); 
					formData.find("#idx").remove(); //id="frm"요소안에 id="idx"를 찾아서 삭제한다
				}
				
				formData.submit(); //form태그의 id="frm"에 submit을 작동한다 
			});
		});
		
	</script>
	
</body>
</html>















