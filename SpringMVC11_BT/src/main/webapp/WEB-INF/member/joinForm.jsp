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

<title>Insert title here</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container">
	<br>
	<div class="card">
		<div class="card-header">회원가입폼</div>
		<div class="card-body">
		<form action="${cpath}/member/join" method="post"> 
		<input type="hidden" name="ebled" value="true">

			<table style="text-align: center; border: 1px solid #dddddd" class ="table table-bordered">
				<tr>
					<td style="width: 110px; vertical-align: middle;">아이디</td>
					<td><input type="text" name="username" id="username" 
					class="form-control" maxlength="20" placeholder="아이디를 입력하세요"></td>	
				</tr>			
				<tr>
					<td style="width: 110px; vertical-align: middle;">비밀번호</td>
					<td colspan ="2"><input required="required" type="password" 
					name="password" id="password" class="form-control" maxlength="20" placeholder="비밀번호를 입력하세요"></td>									
				</tr>	
				<tr>
					<td style="width: 110px; vertical-align: middle;">사용자이름</td>
					<td colspan ="2"><input required="required" type="text" 
					name="name" id="name" class="form-control" maxlength="20" placeholder="이름을 입력하세요"></td>				
				</tr>
							
				<!-- 권한 체크박스 -->
				<tr>
					<td style="width: 110px; vertical-align: middle;">권한</td>
					<td colspan="2">
						<!-- value값은 컬럼과 같게 해야한다 -->
						<input type="radio" name="role" value="MEMBER"> MEMBER
					    <input type="radio" name="role" value="MANAGER"> MANAGER
					    <input type="radio" name="role" value="ADMIN"> ADMIN
					</td>
				</tr>	
				<tr>
					<td colspan ="3">
						<button type="button" class="btn btn-success btn float-right" 
						onclick="location.href='${cpath}/'">로그인페이지이동</button>						
						<input type="submit" class="btn btn-primary btn float-right" value="등록">
						<input type="reset" class="btn btn-warning btn float-right" value="취소">												
					</td>
				</tr>				
			</table>
		</form>
		</div>
		<div class="card-footer">스프링부트 - 이종권</div>
	</div>
	</div>
</body>




</html>