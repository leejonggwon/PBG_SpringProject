<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Spring Security 관련 태그라이브러리(JSTL방식)-->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="cpath" value="${pageContext.request.contextPath}"/>

<!-- 로그인한 계정정보 EL식-->
<c:set var="user" value="${SPRING_SECURITY_CONTEXT.authentication.principal}" />
<!-- 권한정보 EL식-->
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}" />

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="${cpath}/resources/css/btnStyle.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<style>
.table-cnt {
    text-align: center;
}
</style>

<body>
 
  <div class="card">
    <div class="card-header">
	    <!-- 카드헤더부분 -->
    	<%@ include file="/WEB-INF/common/header_common.jsp" %>
    </div>
    <div class="card-body">
    	<div class="row">
    		<!-- 첫번째칸 -->
    		<%@ include file="/WEB-INF/common/left_common.jsp" %>
    		
    		<!-- 두번째칸 -->
    		<div class= "col-lg-5">
    			<div class="card" style="min-height: 500px; max-height: 1000px;">
    				<div class="card-body">
    					<form action="${cpath}/member/imageUpdate" method="post" enctype="multipart/form-data">
							<table style="text-align: center;" class="table table-bordered">					
								<tr>
									<td style="width: 150px; vertical-align: middle;">프로필업로드</td>
									<td>
										<span class="btn btn-default">										
											<input type="file" name="profile">
										</span>
									</td>
								</tr>						
								<tr>
									<td colspan="2">							
										<input type="submit" class="btn btn-custom" value="프로필업로드">										
									</td>
								</tr>
							</table>		
						</form>			
    				</div>
    			</div>
    		</div>
    		
    		<!-- 세번째칸 -->
    		<div class= "col-lg-5">
    			<div class="card" style="min-height: 500px; max-height: 1000px;">
    				<div class="card-body">
    					<form action="${cpath}/member/fileUpdate" method="post" enctype="multipart/form-data">
		
							<table style="text-align: center; border : 1px solid #dddddd" class="table table-bordered">
								<tr>
									<td style="width: 150px; vertical-align: middle;">아이디</td>
									<td><sec:authentication property="principal.member.username"/></td>
								</tr>
								
								<tr>
									<td style="width: 150px; vertical-align: middle;">파일업로드</td>
									<td>
										<span class="btn btn-default">
											파일을 업로드하세요.
											<br>
											<input type="file" name="profile">
										</span>
									</td>
								</tr>
								
								<tr>
									<td colspan="2">
										<span id="passMessage" style="color:red;"></span>
										<input type="submit" class="btn btn-primary btn-sm pull-right" value="이미지등록">										
									</td>
								</tr>
							</table>		
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
	   
  	});//ready
  	

  	
  </script>

</body>
</html>

