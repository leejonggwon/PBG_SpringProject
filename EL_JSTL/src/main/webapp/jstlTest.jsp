<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- JSTL을 사용하기 위한 taglib추가해 줘야한다, taglib를 쓰기위해서는 taglib 지시자가 필요하다  -->    
<!-- JSTL 쓰기위한 이름이 길어서 c라는 접두어로 줄여서 쓰겠다는 의미 -->
<!-- 추가로 JSTL Lib를 프로젝트에 추가해줘야 한다 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- JSTL은 모든 Java코드를 태그화 시킨다  -->
	<!-- JSTL 사용하기 -->
	<!-- JSTL 사용하여 page영역에 값 넣기 -->
	<%-- <% pageContext.setAttribute("num", 100); %> --%>
	
	<!-- c:set 기본적으로 page영역에 저장이 된다 
		특정 영역에 저장하고 싶다면 scope속성활용
	-->
	<c:set var="num" value = "100" scope="session"/> <!--session에 저장된다 -->
	
	
	${num} <br>

	<!-- 바깥으로 표현할때 -->
	<c:out value="${num}" /> <br>
	
	<c:set var="text" value = "<script>alert('팝업창 공격');</script>" scope="session"/> <!--session에 저장된다 -->
	
	${text} <!-- 자바스크립트 공격을 해석해버림, 취약하다 -->
	
	<c:out value="${text}" /> <br> <!-- 자바스크립트 공격을 단순 값으로 인식해서 막아준다 -->
	
	
	
	<!-- JSTL을 활용한 조건문 -->
	<!-- num의 값이 100보다 크거나 같다면 100보다 크거나 같습니다 아니면 작습니다 출력 -->
	<c:if test="${num ge 100}">
		100보다 크거나 같습니다.
	</c:if>
	
	<c:if test="${num lt 100}">
		100보다 작습니다.
	</c:if>
	<br>
	
	<c:set var = "time" value = "점심" />
	<!-- 
		time 값이 
		아침 -> 토스트
		점심 -> 비빔밥
		저녁 -> 족발
		그외 -> 라면
	 -->
	 
	<!-- 다중if문 -->
	<!-- 스위치문과 같다 -->
	<c:choose> 
		<c:when test="${time eq '아침'}">
			토스트
		</c:when>
		<c:when test="${time == '점심'}">
			비빔밥
		</c:when>
		<c:when test="${time == '저녁'}">
			족발
		</c:when>
		<c:otherwise>
			라면
		</c:otherwise>
	</c:choose>
	<br>
	

	<!-- JSTL 반복문 -->
	<!-- for(int i = 1; i <= 10; i++) -->
	<!-- 변수i는 1부터 10까지 1씩 증가한다 -->
	<c:forEach var="i" begin="1" end="10" step="1"> 
		반복 ${i}<br>
	</c:forEach>
	<br>
	
	<table border ="1px">
		<c:forEach var="i" begin="2" end="5" step="1"> 
			<tr>
				<c:forEach var="j" begin="1" end="9" step="1"> 
					<td>
						${i} * ${j} = ${i * j}
					</td>
				</c:forEach>
			</tr>		
		</c:forEach>
	</table>
	
</body>
</html>