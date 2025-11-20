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
		 	<form id="frm">
				<table class="table table-bordered table-hover">
					<tr>
						<td>번호</td>
						<td><input id="idx" readonly="readonly" value="${vo.idx}" name="idx" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input id="title" value="<c:out value='${vo.title}'/>" name="title" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td>
							<textarea id="content" name="content" class="form-control" rows="10" cols=""><c:out value="${vo.content}"/></textarea>
						</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td><input id="writer" readonly="readonly" value="${vo.writer}" name="writer" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align:center">
						<!-- 로그인한 상태이고 로그인한 사람과 아이디와 게시글 쓴사람 아이디가 일치하면 수정삭제 버튼기능 활성화한다-->
						<c:if test="${not empty mvo && mvo.memID eq vo.memID }">
							<button data-btn="modify" type="button" class="btn btn-sm btn-primary">수정</button>
							<button data-btn="remove" type="button" class="btn btn-sm btn-success">삭제</button>   
						</c:if>
						
						<c:if test="${empty mvo or mvo.memID ne vo.memID }">
							<button disabled="disabled" type="button" class="btn btn-sm btn-primary">수정</button>
							<button disabled="disabled" type="button" class="btn btn-sm btn-success">삭제</button> 					  
						</c:if>									      					       
							<button data-btn="list" type="button" class="btn btn-sm btn-warning">목록</button>
						</td>
					</tr>
				</table>
	
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
		$(document).ready(function() {
			$("button").on("click", function (e) {
				var formData = $("#frm");
				var btn = $(this).data("btn");
				
				if(btn == "remove"){
					formData.attr("action", "${cpath}/board/remove");
					formData.attr("method", "get");
					
					formData.find("#title").remove();
					formData.find("#content").remove();
					formData.find("#writer").remove();
								
				}else if(btn == "list"){
					formData.attr("action", "${cpath}/board/list");
					formData.find("#idx").remove(); //목록으로 갈때는 idx가 필요가 없다
					formData.attr("method", "get");
					
					formData.find("#title").remove();
					formData.find("#content").remove();
					formData.find("#writer").remove();			
					
				}else if(btn == "modify"){
					formData.attr("action", "${cpath}/board/modify");
					formData.attr("method", "post");
				}
				formData.submit();
			});
		});
	</script>
	
</body>
</html>





