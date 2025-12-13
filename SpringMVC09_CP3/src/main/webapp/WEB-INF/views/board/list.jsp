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
<title>Spring MVC09</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
	<!-- 정적 include 이라서 WEB-INF 안에 있는 JSP를 직접 읽어올 수 있다 -->
	<%@ include file="/WEB-INF/views/common/header.jsp" %> 

		<h2>Spring MVC09</h2>
		<div class="panel panel-default">
			<div class="panel-heading">
			
			<c:if test="${empty mvo}"> <!-- session 정보 없을때(로그아웃상태) 로그인창이 보인다 -->
				<form class="form-inline" action="${cpath}/member/loginProcess" method="post">
					<div class="form-group">
						<label for="id">ID:
						<input type="text" class="form-control" id="id" name="memID">
					</div>
					<div class="form-group">
						<label for="pwd">Password:</label>
						<input type="password" class="form-control" id="pwd" name="memPassword">
					</div>
					
					<button type="submit" class="btn btn-defult">로그인</button>
				</form>
			</c:if>
			
			<c:if test="${not empty mvo}"> <!-- session 정보 있을때 -->
				<form class="form-inline" action="${cpath}/member/logoutProcess" method="post">
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
				                <td>${pageMaker.totalCount - ((pageMaker.cri.page - 1) * pageMaker.cri.perPageNum + i.index)}</td>
				                <td>
				                	<!-- 삭제하는 경우  -->
				                	<c:if test="${vo.boardAvailable == 0}"> 
				                		<a href="javascript:alert('작성자에 의해 삭제된 게시글 입니다')">
					                		<c:if test="${vo.boardLevel > 0}">
						                		<c:forEach begin="0" end="${vo.boardLevel}" step="1">
						                			<span style="padding-left: 10px"></span>
						                		</c:forEach>
						                		ㄴ[댓글]
						                	</c:if>
				                			작성자에 의해 삭제된 게시글 입니다.
				                		</a>
				                	</c:if>
				                	<!-- 삭제아닌 경우  -->
					                <c:if test="${vo.boardAvailable == 1}"> 
						                <a class="move" href="${vo.idx}">                                                                                          
						                	<c:if test="${vo.boardLevel > 0}">
						                		<c:forEach begin="0" end="${vo.boardLevel}" step="1">
						                			<span style="padding-left: 10px"></span>
						                		</c:forEach>
						                		ㄴ[댓글]
						                	</c:if>
						                		<c:out value="${vo.title}"></c:out>				              
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
							<button id="regBtn" class="btn btn-sm btn-primary pull-right">글쓰기</button>
						</td>
					</tr>		
					</c:if>	
				</table>
				
				<!-- **검색메뉴 -->	
				<div style="text-align:center">
					<form class="form-inline" action="${cpath}/board/list" method="post"> 
						<div class="form-group">
							<select name="type" class="form-control">
								<option value="writer" ${pageMaker.cri.type=='writer' ? 'selected' : ''} >이름</option> 
								<!-- 이름을 선택하면 → <option value="writer" selected>이름</option> 자동선택된다 -->
								<option value="title" ${pageMaker.cri.type=='title' ? 'selected' : ''} >제목</option>
								<option value="content" ${pageMaker.cri.type=='content' ? 'selected' : ''} >내용</option>
							</select>
						</div>	
						<div class="form-group">
							<input type="text" value="${pageMaker.cri.keyword}" class="form-control" name="keyword">
						</div>
						<button type="submit" class="btn btn-success">검색</button>									
					</form>
				</div>
				
				
				<!-- **페이징버튼 -->	
				<div style="text-align: center">			
				  <ul class="pagination">
				  	
				  	<!-- 이전버튼처리 -->
				  	<c:if test="${pageMaker.prev}">
				  		<li class="paginate_button previous">
				  			<a href="${pageMaker.startPage - 1}">◀</a>
				  		</li>
				  	</c:if>
				  
				    <!-- 페이지번호 처리하기 -->
				    <c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}" >
				    	<c:if test="${pageMaker.cri.page == pageNum}">
				    		<li class="paginate_button active"><a href="${pageNum}">${pageNum}</a></li>	
				    	</c:if>
				    				
				    	<c:if test="${pageMaker.cri.page != pageNum}">
				    		<li class="paginate_button"><a href="${pageNum}">${pageNum}</a></li>	
				    	</c:if>				 
				    </c:forEach>					   
				    
				    <!-- 다음버튼처리 -->
				  	<c:if test="${pageMaker.next}">
				  		<li class="paginate_button previous">
				  			<a href="${pageMaker.endPage + 1}">▶</a>
				  		</li>
				  	</c:if>				  				  		    
				  </ul>
				  
				  <!-- 페이지 버튼을 클릭했을 때 페이지 이동을 처리하기 위한 숨겨진(form) 전송용 폼 -->
				  <form action="${cpath}/board/list" id="pageFrm">
				  	<input type="hidden" id="page" name="page" value="${pageMaker.cri.page}">
				  	<input type="hidden" id="perPageNum" name="perPageNum" value="${pageMaker.cri.perPageNum}">	
				  	
				  	<!-- type과 keyword를 넘기기위한 부분 추가하면 결과값(type, keyword)이 유지된다 -->
				  	<input type="hidden" id="type" name="type" value="${pageMaker.cri.type}">
				  	<input type="hidden" id="keyword" name="keyword" value="${pageMaker.cri.keyword}">			  			  	
				  </form>
				 
				</div>	 							
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
			
			//**페이지 번호 클릭 시 이동하기 
			//form태그의 id=pageFrm 인 요소를 선택
			var pageFrm = $("#pageFrm");
			
			//<li class="paginate_button"의 a태그를 클릭하면 함수를 실행한다 
			$(".paginate_button a").on("click", function(e){ 			
				//e : 현재 클릭한 a태그 요소 차체를 의미한다			
				// board/5 → board/list?page=5&perPageNum=10
			 	e.preventDefault(); //a태그의 링크이동 기능을 막는다 
			 	
				var page = $(this).attr("href"); //클릭한 a 태그의 href 값을 읽어서 page 변수에 담는다
				
				//id=pageFrm인 form태그 안에서 
				// id=page 요소를 찾아서 value 변수에 page값(현재 클릭한 a태그의 href값)을 입력
				pageFrm.find("#page").val(page); 
				pageFrm.submit(); //form태그 제출된다 
			});
			
			
			//**상세보기 클릭 시 이동
			//class="move"의 a태그를 클릭하면 함수를 실행한다
			$(".move").on("click", function(e){
				e.preventDefault(); //a태그의 링크이동 기능을 막는다 
				
				//게시글 클릭한 a태그의 href값(idx) 가져오기
				var idx = $(this).attr("href"); 
				
				//idx 정보를 넘길 hidden input 태그 생성
				var tag = "<input type='hidden' name='idx' value='" + idx + "'>";
				
				pageFrm.append(tag); //id=pageFrm인 form태그에 hidden input 태그 추가한다
				
				//form이 데이터를 전송할 URL을 바꾼다
				pageFrm.attr("action", "${cpath}/board/get");
				pageFrm.submit();
			});
						
			var result = "${result}"; //rttr.addFlashAttribute("result", vo.getIdx())에서 받아온다
			checkModal(result); //checkModal()함수로 이동 
			
			$("#regBtn").click(function(){
				//클릭하면 클쓰기 페이지 이동
				location.href="${cpath}/board/register?page=${pageMaker.cri.page}&perPageNum=${pageMaker.cri.perPageNum}"; 
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





