<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><!-- 줄바꿈, 날짜일정문자 잘라내는 기능들이 있다 --> 

<!-- fmt 태그는 주로 날짜/시간, 숫자, 메시지 포맷 처리에 사용 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="cpath" value="${pageContext.request.contextPath}"/>
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
			<form id="frm">  <!-- POST방식: 작성한 글 등록 -->	
			
			<table class="table table-hover table-bordered">
			<input id="memID" type="hidden" name="memID" value="${mvo.memID}">
			
			<input type="hidden" id="page" name="page" value="${cri.page}">
			<input type="hidden" id="perPageNum" name="perPageNum" value="${cri.perPageNum}">
			
				<tr>
					<td>제목</td>
					<td><input id="idx" type="text" name="title" class="form-control"></td>
				</tr>	
				<tr>	
					<td>내용</td>
					<td><textarea id="content" rows="10" cols="" name="content" class="form-control"></textarea></td>
				</tr>
				<tr>
					<td>파일</td>
					<td><input id="file" type="file" name="imgpath" class="form-control"></td>
				</tr>			
				<tr>
					<td>작성자</td>
					<td><input id="writer" type="text" name="writer" class="form-control" value="${mvo.memName}" readonly="readonly"></td>
				</tr> 
				<tr>
					<td colspan="2" style="text-align:center">
						<button data-btn="register" type="button" class="btn btn-primary btn-sm">등록</button>
						<button type="reset" class="btn btn-default btn-sm">취소</button>
						<button data-btn="list" type="button" class="btn btn-sm btn-warning">목록</button>
					</td>
				</tr>	
			</table>
			
			
			
		</form>
		</div>
		<div class="panel-footer">스프링게시판 - 이종권</div>
	  </div>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("button").on("click", function(e) {
				var formData = $("#frm");
				var btn = $(this).data("btn");
				
				if(btn == "list"){
					formData.attr("action", "${cpath}/board/list");
					formData.find("#idx").remove();
					formData.attr("method", "get");
					
					formData.find("#memID").remove();
					formData.find("#title").remove();
					formData.find("#content").remove();
					formData.find("#writer").remove();	
								
					
				}else if(btn == "register"){			
					formData.attr("action", "${cpath}/board/register");
					formData.attr("method", "post");
					formData.attr("enctype", "multipart/form-data");		
					
					formData.find("#page").remove();
					formData.find("#perPageNum").remove();
					}
				formData.submit();
			});
		});
	</script>
	
</body>
</html>
