<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 스크립트릿과 표현식을 사용해서 input에 입력한 
		 좋아하는 음식을 웹페이지에 표현하시오 -->
		 <%
		 	request.setCharacterEncoding("UTF-8"); //post방식의 인코딩
		 
		 	String food = request.getParameter("food"); 
		 	//info.jsp에서 name과 value형식으로 result.jsp로 전달한다 
		 	//web에서 key와 value 형태로 데이터를 전달하는 방식은 Parameter형식이라고 한다
		 	//그 Parameter값을 가져오니까 request.getParameter
		 %>
		 <%= food %><br>
		 
		 <!-- EL식 -->
		 ${param.food} <br>
		 ${param["food"]} <br>
		 
		 <!-- EL은 동일한 name으로 여러개값을 보냈을때 어떻게 꺼낼까? -->
		 ${paramValues.fish[0]}
		 ${paramValues.fish[1]}
		 ${paramValues.fish[2]}
		 ${paramValues.fish[3]}
		
</body>
</html>