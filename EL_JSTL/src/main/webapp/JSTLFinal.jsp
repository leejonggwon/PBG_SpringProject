<%@page import="com.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL을 쓰기위해 라이브러리를 추가해줘야 한다 -->    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		ArrayList<String> idol = new ArrayList<>();
		idol.add("지수");
		idol.add("제니");
		idol.add("로제");
		idol.add("리사");
		
		
		//pageContext는 만들지 않아도 내장객체로 존재한다 
		pageContext.setAttribute("idols", idol); //pageContext 객체의 영역(scope)에 "idols"이라는 이름으로 idol 값을 저장한다는 뜻
	%>
	
	<% for(String name : idol) { %>
	<%= name %>
	<% } %>
	<br>
	
	<%=idol.get(2)%>	
	<br>

	<c:forEach items="${idols}" var="name" >
    	${name}
	</c:forEach>
	<br>
	
	<%
		MemberDTO dto1 = new MemberDTO("kia","1234","타이거즈","광주");
		MemberDTO dto2 = new MemberDTO("lg","1234","트윈스","서울");
		MemberDTO dto3 = new MemberDTO("lotte","1234","자이언츠","부산");
		MemberDTO dto4 = new MemberDTO("ssg","1234","랜더스","인천");
		MemberDTO dto5 = new MemberDTO("samsung","1234","라이온즈","대구");
		
		ArrayList<MemberDTO> dto = new ArrayList<>(); 
		dto.add(dto1);
		dto.add(dto2);
		dto.add(dto3);
		dto.add(dto4);
		dto.add(dto5);
		
		//JSTL와 EL을 쓰려면 scope안에 저장이 되어야 쓸수 있다
		pageContext.setAttribute("list", dto);
	%>
	<br>
	
	
	<table border= "1px">
		<tr>
			<td>번호1</td>
			<td>번호2</td>
			<td>번호3</td>
			<td>팀이름</td>
			<td>비밀번호</td>
			<td>닉네임</td>
			<td>연고지</td>
		</tr>
		
		<c:set var="i" value ="1" /> <!-- 기본적으로 page영역에 저장이 된다 -->
		<c:forEach items="${list}" var="dto" varStatus="num" > <!-- varStatus: 현재반복문이 몇번째인지 기억한다 -->
			<tr>
				<td>${i}</td>
				<td>${num.index + 1}</td> <!-- 첫번째 항목 0일떄 -->
				<td>${num.count}</td>
				<td>${dto.id}</td>
				<td>${dto.pw}</td>
				<td>${dto.nick}</td>
				<td>${dto.addr}</td>
			</tr>
			<c:set var="i" value ="${i+1}" /> <!-- 돌면서 1씩 증가가 된다 -->
		</c:forEach>
		
	</table>
	
</body>
</html>