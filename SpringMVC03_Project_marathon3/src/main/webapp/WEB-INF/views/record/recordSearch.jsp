<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 현재 웹 애플리케이션의 루트 경로를 가져와서 cpath라는 이름의 변수에 저장 -->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>2026 HANKUK MARATHON</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	
<link rel="stylesheet" href="${contextPath}/resources/css/btnStyle.css">
<style>

.btn:focus,
.btn:active,
.btn:focus:active {
	outline: none !important;
	box-shadow: none !important;
}

</style>


</head>
<body> 
	<div class="container">
	
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		
		<div class="panel panel-default">
			<div class="panel-heading">개인기록조회</div>
			<div class="panel-body">
			
				<div style="text-align:center">
					<form class="form-inline" action="${contextPath}/record/recordList.do" method="post"> 
						<div class="form-group">
							<select name="type" class="form-control">
								<option value="mrNumber" ${pageMaker.cri.type=='mrNumber' ? 'selected' : ''} >참가번호</option> 											
							</select>
						</div>	
						<div class="form-group">
							<input type="text" value="${pageMaker.cri.keyword}" class="form-control" name="keyword">
						</div>
						<button type="submit" class="btn btn-custom btn-sm">완주기록조회</button>	
						<br>
						<br>
						<p style="text-align: center">※2025년 6월 15일 개최된 2025 한국 마라톤 대회의 공식 완주 기록입니다</p>										
					</form>
				</div>

				
			
			</div><!--end panel-body -->

			
			<jsp:include page="/WEB-INF/views/common/bottom.jsp"></jsp:include>
		</div>
	</div>
	
	<script type="text/javascript">
	
		$(document).ready(function(){ 		
			
		});
	
	

	</script>
</body>
</html>





