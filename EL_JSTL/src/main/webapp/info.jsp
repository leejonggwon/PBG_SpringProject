<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="result.jsp" method ="post">
		내가 좋아하는 음식
		<input type="text" name="food">
		
		<!-- 동일한 name으로 여러개값을 보냈을때 어떻게 꺼낼까? -->
		<br>
		좋아하는 생선 :  
		참치 <input type="checkbox" name="fish" value="참치">
		전어 <input type="checkbox" name="fish" value="전어">
		광어 <input type="checkbox" name="fish" value="광어">
		우럭 <input type="checkbox" name="fish" value="우럭">
		<br>
		<input type="submit">
	</form>
</body>
</html>