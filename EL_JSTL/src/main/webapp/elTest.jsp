<%@page import="com.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<% //JSP 태그: JSP 안에서 자바 코드를 삽입할때 사용하는 태그
	
		session.setAttribute("names", "leegonggwon"); //세션이라는 저장소에 "id"라는 이름으로 "leegonggwon"이라는 값을 저장해줘
		//session: 웹사이트가 너(사용자)를 기억하기 위해 만든 개인 저장공간
		//setAttribute: 이름 붙여서 값을 저장해
	%>
	
	<%--
		EL의 조건
		- EL은 java의 저장된 아무 변수의 값을 꺼내서 쓸 수 있는것이 아니라 
		  Scope에 저장된 값만 꺼내서 사용할 수 있다 
		  ※ Scope영역이란 - page(pageContext), request, session, application    
		    Socpe: JSP/서블릿에서 데이터를 저장하는 영역(범위)
		     page: 하나의 JSP 페이지만 담당하는 가장 작은 영역
		     request: 요청에 따라 확장 시킬수 있는 영역
		     session: 하나의 웹브라우저와 관련된 영역(로그인 사용자 단위)
		     application: 프로젝트 전체를 다같이 공유하는 영역(서버 전체공유)
	--%>
	
	<!-- session에 저장된 id라는 이름의 값을 웹페이지에 표현하시오 -->
	<%
		String id = (String)session.getAttribute("names"); //세션에 저장해둔 "id" 값을 꺼내서, String 타입으로 변수 id에 넣어라
	%>
	
	
	<%=//JSP 스크립틀릿(Java 코드): HTML 안에다가 Java 변수나 값을 직접 출력하고 싶을 때 써, 값을 출력할 때만 사용해.
		id 
	%> 
	
	<p>안녕하세요 <%= id %>님 환영합니다!</p>
	
	<!-- EL 표현식 -->
	<p>안녕하세요 ${names}님 환영합니다!</p>
	
	<%-- 
		EL의 다양한 연산자 
	--%>
	
	<%
		pageContext.setAttribute("num", 10); // page영역에 값을 저장
		pageContext.setAttribute("isCheck", true);
	%>
	
	
	${num} <br>
	${num + 10} <br>
	${num - 5} <br>
	${num * 3} <br>
	
	${num / 2} <br>
	${num div 2} <br> 
	
	${num % 3} <br>
	${num mod 3} <br>
	
	${num > 5 && num > 3} <br>
	${num > 5 and num > 3} <br>

	${num > 5 || num > 3} <br>
	${num > 5 or num > 3} <br>
	
	${isCheck} <br>
	
	${!isCheck} <br>
	${not isCheck} <br>
	
	${num > 3} <br> 
	${num gt 3} <!-- gt: greater than --><br>
	
	${num < 20} <br>
	${num lt 20} <!-- lt: less than ~보다 작다 --><br>
	
	${num >= 3} <br>
	${num ge 3} <!-- ge: less than ~보다 크거나 같다 --><br>
	
	${num <= 20} <br>
	${num le 20} <!-- le: less than ~보다 작거나 같다 --><br>
	
	${num == 10} <br>
	${num eq 10} <br>
	
	${num != 20} <br>
	${num ne 10} <br> <!-- not equal -->
	
	<%--
		EL에서 DTO, VO를 가져오면 어떻게 가져올까?
		
	 --%>
	
	
	<%
		MemberDTO dto = new MemberDTO("ljk", "1234", "이종권", "대한민국");
		pageContext.setAttribute("dto", dto); //스코프, pageContext에 저장 
	%>
	
	<!--  page영역에 저장된 dto의 아이디 값을 표현식을 사용하여 웹페이지에 표현하지오  -->
	
	<%  MemberDTO info = (MemberDTO)pageContext.getAttribute("dto"); 
	//값이 저장될때 Object로 저장이 되기 때문에 MemberDTO로 다운 캐스팅 해야한다 %> 
	
	<%=  info.getId() %> <br> <!-- 기존의 방식 -->
	
	<!-- 
		EL사용하여 dto안에 있는 private 필드값을 가져오기 위해서는 
		반드시 getter 메소드가 필요하다 
		(dto.id는 필드에 바로 접근하는것이 아니라 getter메서드의 id를 내부적 호출한 것이다) 
	 -->
	
	${dto.id} <br><!-- EL은 필드값을 쓰면 된다 -->
	${dto.pw} <br>
	${dto.nick} <br>
	${dto.addr} <br>
	
	
	<!-- 만약 EL로 없는 값을 가져오면 어떻게 될까? -->
	${empty good} <br> <!-- empty로 비어있는지 판단한다 -->
	${not empty good} <br> 
	
	
	<!-- 
		만약에 동일한 이름의 값이 여러 영역에 들어가있다면 
		EL에서는 어떻게 값을 가져올까?
		
		EL에서 값을 가져오겠다 예시) ${name}하게 되는 순간
		EL은 PageContext영역부터 name의 값이 있는지 찾게 된다  
		
		찾는순서 
		page -> request -> session -> application
		
		그런데 
		내가 EL에서 특정영역에서만 찾고자 할때 name앞에 특정영역Scope를 붙여준다 (sessionScope.name)
	 -->
	 
	 <%
	 	pageContext.setAttribute("name", "이종권");
	 	request.setAttribute("name", "홍의연");
	 	session.setAttribute("name", "홍승찬");
	 	application.setAttribute("name", "홍지호");
	 %>
	 
	 ${name} <br> <!-- page영역(가장작은영역)에 있는 값이 나온다 -->
	 ${sessionScope.name} <br> <!-- session의 name이 나온다 -->
	 
</body>
</html>