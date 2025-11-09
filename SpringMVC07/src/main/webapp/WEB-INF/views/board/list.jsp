<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- 변수 선언, 조건문, 반복문, 페이지 이동 등 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><!-- 줄바꿈, 날짜일정문자 잘라내는 기능들이 있다 --> 

<!-- fmt 태그는 주로 날짜/시간, 숫자, 메시지 포맷 처리에 사용 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 문자열 다루기(길이, 포함, 자르기 등) -->

<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring MVC07</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<h2>Spring MVC07</h2>
		<div class="panel panel-default">
			<div class="panel-heading">
			
			<c:if test="${empty mvo}"> <!-- session 정보 없을때(로그아웃상태) 로그인창이 보인다 -->
				<form class="form-inline" action="${cpath}/login/loginProcess" method="post">
					<div class="form-group">
						<label for="id">ID:
						<input type="text" class="form-control" id="id" name="memID">
					</div>
					<div class="form-group">
						<label for="pwd">Password:</label>
						<input type="password" class="form-control" id="pwd" name="memPwd">
					</div>
					
					<button type="submit" class="btn btn-defult">로그인</button>
				</form>
			</c:if>
			
			<c:if test="${not empty mvo}"> <!-- session 정보 있을때 -->
				<form class="form-inline" action="${cpath}/login/logoutProcess" method="post">
					<div class="form-group">
						<label>${mvo.memName}님 방문을 환영합니다</label>
					</div>
					<button type="submit" class="btn btn-default">로그아웃</button>
				</form>
			</c:if>
			</div>
			<div class="panel-body">
				<table class= "table table-bordered table-hover">
					<thead> <!-- thead: 테이블헤더를 구분해주는 영역태그 -->
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody> <!-- tbody: 테이블안에 영역구분하기 위한 태그 -->
						<c:forEach items="${list}" var="vo" varStatus="i"> <!-- model.addAttribute("list", list) -->
				            <tr>
				                <td>${list.size() - i.index}</td> <!--i.count:1부터, i.index:0부터 <td>${i.count}</td>-->			              			             
				                <td>
				                	<!-- 삭제하는 경우  -->
				                	<c:if test="${vo.boardAvailable == 0}"> 
				                		<a href="javascript:alert('삭제된 게시글 입니다')">
					                		<c:if test="${vo.boardLevel > 0}">
						                		<c:forEach begin="0" end="${vo.boardLevel}" step="1">
						                			<span style="padding-left: 10px"></span>
						                		</c:forEach>
						                		ㄴ[댓글]
						                	</c:if>
				                			삭제된 게시글 입니다.
				                		</a>
				                	</c:if>
				                	<!-- 삭제아닌 경우  -->
					                <c:if test="${vo.boardAvailable == 1}"> 
						                <a href="${cpath}/board/get?idx=${vo.idx}">
						                	<c:if test="${vo.boardLevel > 0}">
						                		<c:forEach begin="0" end="${vo.boardLevel}" step="1">
						                			<span style="padding-left: 10px"></span>
						                		</c:forEach>
						                		ㄴ[댓글]
						                	</c:if>
						                		${vo.title}
						                </a>
						             </c:if>   
				                </td> 
				                <td>${vo.writer}</td>
				                <td>
				                	<fmt:formatDate value="${vo.indate}" pattern="yyyy-MM-dd"/>			             
				                </td>
				                <td>${vo.count}</td>
				            </tr>
				        </c:forEach>
					</tbody>
					<c:if test="${not empty mvo}"><!-- 로그인시 글쓰기 버튼 노출 -->
					<tr>
						<td colspan="5">
							<button id="regBtn" class="btn bts-xs btn-info pull-right">글쓰기</button>
						</td>
					</tr>		
					</c:if>	
				</table>
			</div>
			<div class="panel-footer">스프링게시판 - 이종권</div>
		</div>
	</div>
	

   <!--성공시 띄워줄 모달창 -->
   <div class="modal fade" id="myMessage" role="dialog">
     <div class="modal-dialog">
       <!-- 모달내용-->
       <div id="messageType" class="modal-content">
         <div class="modal-header panel-heading"> <!-- panel-heading을 넣어야 헤더 스타일이 적용된다 -->
           <button type="button" class="close" data-dismiss="modal">&times;</button>
           <h4 class="modal-title">Modal Header</h4>
         </div>
         <div class="modal-body">  
         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
         </div>
       </div>
     </div>
   </div>
	

	<script type="text/javascript">
		//페이지가 다 로드 되면 함수를 실행하겠다 
		$(document).ready(function() {
			
			var result = "${result}"; //rttr.addFlashAttribute("result", vo.getIdx())에서 받아온다
			checkModal(result); //checkModal()함수로 이동 
			
			$("#regBtn").click(function(){
				//클릭하면 클쓰기 페이지 이동
				location.href="${cpath}/board/register"; 
				//GET방식: 글쓰기 화면(register.jsp)로 이동
			});
		});
		
		function checkModal(result){
			if(result == ''){
				return; //함수끝
			}
			if(parseInt(result) > 0){
				$(".modal-body").text("게시글 " + result + "번이 등록되었습니다"); //class="modal-body"
				$("#myMessage").modal("show"); //id="myMessage" 모달 실행
			}
		}
	</script>
</body>
</html>





