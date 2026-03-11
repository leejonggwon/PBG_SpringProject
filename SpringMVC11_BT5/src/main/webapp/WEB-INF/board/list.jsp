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
	    <div class="jumbotron jumbotron-fluid">
		  <div class="container">
		    <h1>Spring MVC11</h1>
		    <p>Java → HTML → CSS → JSP&Servlet → Spring F/W → Spring Boot</p>
		  </div>
		</div>
    </div>
    <div class="card-body">
    	<div class="row">
    		<!-- 첫번째칸 -->
    		<%@ include file="/WEB-INF/common/common.jsp" %>
    		
    		<!-- 두번째칸 -->
    		<div class= "col-lg-5">
    			<div class="card" style="min-height: 500px; max-height: 1000px;">
    				<div class="card-body">
    					<table class="table table-bordered table-hover">
    						<thead class="table-cnt">
    							<th style="width: 10%;">번호</th>
    							<th style="width: 40%;">제목</th>
    							<th style="width: 10%;">작성자</th>
    							<th style="width: 25%;">작성일</th>
    							<th style="width: 10%;">조회수</th>
    						</thead>
    						<tbody>
    							<c:forEach var="vo" items="${list}" varStatus="i">
    								<tr>
    									<td class="table-cnt">${pageMaker.totalCount - ((pageMaker.cri.page - 1) * pageMaker.cri.perPageNum + i.index)}</td>					
    									<td>
    										<!-- 삭제인 경우 -->
	    									<c:if test="${vo.board_available == 0}"> 								    									
	    										<div style="cursor: pointer; color: gray;" onclick="alert('작성자에 의해 삭제된 게시글 입니다.');">
	    											<c:if test="${vo.board_level > 0}">
	    												<c:forEach begin="0" end="${vo.board_level}" step="1">
	    													<span style="padding-left:5px"></span>
	    												</c:forEach>
	    												ㄴ[답글]
	    											</c:if>
	    											작성자에 의해 삭제된 게시글 입니다.
	    										</div>
	    									</c:if>
    										<!-- 삭제가 아닌경우 -->
	    									<c:if test="${vo.board_available == 1}"> 								    									
	    										<a class="move" href="${vo.idx}" onclick="showCount('${vo.idx}')" >
	    											<c:if test="${vo.board_level > 0}">
	    												<c:forEach begin="0" end="${vo.board_level}" step="1">
	    													<span style="padding-left:5px"></span>
	    												</c:forEach>
	    												ㄴ[답글]
	    											</c:if>
	    											${vo.title}
	    										</a>
	    									</c:if>
    									</td> 		
    									<td class="table-cnt">${vo.writer}</td>					
    									<td class="table-cnt"><fmt:formatDate value="${vo.indate}" pattern="yyyy-MM-dd HH:mm"/></td>
    									<td class="table-cnt" id="cnt_${vo.idx}">${vo.count}</td>
    								</tr>
    							</c:forEach>
    						</tbody>
    						
    					</table>
    					
    					<!-- 검색옵션/키워드 -->
						<div class="container">
							<form class="form-inline justify-content-center" action="${cpath}/board/list" method="post"> 
								<!-- 검색옵션 -->
								<div class="form-group">
									<select name="type" class="form-control">
										<!-- 이름을 선택하면 <option value="writer" selected>이름</option> 이 자동 선택된다 -->
										<option value="writer" ${pageMaker.cri.type =='writer' ? 'selected' : ''} >이름</option> 
										<option value="title" ${pageMaker.cri.type =='title' ? 'selected' : ''} >제목</option>
										<option value="content" ${pageMaker.cri.type =='content' ? 'selected' : ''} >내용</option>
									</select>
								</div>
								<!-- 검색키워드 -->	
								<div class="form-group">
									<input type="text" value="${pageMaker.cri.keyword}" class="form-control" name="keyword">
								</div>
								<button type="submit" class="btn btn-success">검색</button>									
							</form>
						</div>
						<br>  				
    						<!-- 페이징버튼 -->									
	    					<div class="container">
							  <ul class="pagination justify-content-center">
							  	<!-- 이전버튼 -->
								<c:if test="${pageMaker.prev}">
									<li class="page-item"><a class="page-link" href="${pageMaker.startPage -1}">Previous</a></li> <!--page=10으로 이동-->  
								</c:if>							  
							    
							    <!-- 페이지번호 -->
							    <c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}" >						    
							    	<c:if test="${pageMaker.cri.page == pageNum}">
							    		<li class="page-item active"><a class="page-link" href="${pageNum}">${pageNum}</a></li>
							    	</c:if>
							    	<c:if test="${pageMaker.cri.page != pageNum}">
							    		<li class="page-item"><a class="page-link" href="${pageNum}">${pageNum}</a></li>
							    	</c:if>
							    </c:forEach>
							    
							    <!-- 다음버튼 -->
							    <c:if test="${pageMaker.next}">
									<li class="page-item">
										<a class="page-link" href="${pageMaker.endPage +1}">Next</a> <!--page=11으로 이동-->
									</li>
								</c:if>	
							  </ul> <!-- //페이징버튼 -->	
							  
							  <!-- 페이지 버튼을 클릭했을 때 페이지 이동을 처리하기 위한 숨겨진(form) 전송용 폼 -->
							  <form action="${cpath}/board/list" id="pageFrm">
								  <input type="hidden" id="page" name="page" value="${pageMaker.cri.page}">
								  <input type="hidden" id="perPageNum" name="perPageNum" value="${pageMaker.cri.perPageNum}">
								  
								  <input type="hidden" id="type" name="type" value="${pageMaker.cri.type}">
				  				  <input type="hidden" id="keyword" name="keyword" value="${pageMaker.cri.keyword}">
							  </form>
							  
							</div>					
    				</div>
    			</div>
    		</div>
    		
    		<!-- 세번째칸 -->
    		<div class= "col-lg-5">
    			<div class="card" style="min-height: 500px; max-height: 1000px;">
    				<div class="card-body">
						<form id="regForm" action="${cpath}/board/register" method="post">					
							<input type="hidden" id="idx" name="idx" value="">
							<input type="hidden" id="attached_data" name="attached_data" value="${vo.attached_data}">
							
							<input type="hidden" id="username" name="username" value="<sec:authentication property='principal.member.username'/>">
							<!-- 페이징정보 -->
							<input type="hidden" id="page" name="page" value="${pageMaker.cri.page}">
							<input type="hidden" id="perPageNum" name="perPageNum" value="${pageMaker.cri.perPageNum}">
							<!-- 검색정보 -->
							<input type="hidden" id="type" name="type" value="${pageMaker.cri.type}">
							<input type="hidden" id="keyword" name="keyword" value="${pageMaker.cri.keyword}">
						
    						<div class="form-group">
    							<label for="title">제목</label> 
    							<input type="text" class="form-control" id="title" name="title" placeholder="Enter Title" required>
    						</div>
    						<div class="form-group">
    							<label for="content">내용</label>
    							<textarea id="content" name="content" class="form-control" placeholder="Enter Content" rows="7" cols=""></textarea> 
    						</div>
    						
    						<div id="uploadFile" class="form-group">
    							<label>첨부파일</label>
    							<!-- name값과 VO의 필드명이 다르게한다 -->
    							<input type="file" name="uploadFile" class="form-control">
    						</div>
    						
    						<div id="download_btn" style="display: none;" class="mb-3">
    							<label>첨부파일</label><br>
    							<a id="download_link" href="#" class="btn btn-sm btn-warning"></a>					       
    						</div>
    							
    						<div class="form-group">
    							<label for="writer">작성자</label>
    							<input value="<sec:authentication property='principal.member.name'/>" 
    							type="text" class="form-control" id="writer" name="writer" readonly="readonly">
    						</div>
    						
    						<!-- 게시글등록시 버튼 -->
    						<div id="regDiv">  					
	    						<button type="button" data-oper="register" class="btn btn-sm btn-primary">등록</button> 						
	    						<button type="button" data-oper="reset" class="btn btn-sm btn-warning">취소</button> 						
    						</div>	
    						<!-- 게시글상세보기시 버튼 -->					
    						<div id="updateDiv" style="display: none;">
    							<span id="reply">
    								<button class="btn btn-sm btn-danger" data-oper="reply" type="button">답글쓰기</button>
    							</span>
    							
    							<span id="replyComplete" style="display: none;">
    								<button onclick="goReply()" class="btn btn-sm btn-info" type="button">답글등록</button>
    							</span>
		
    							<span id="update">
    								<button class="btn btn-sm btn-warning" data-oper="updateForm" type="button">수정</button>
    							</span>
    							
    							<span id="updateComplete" style="display: none;">
    								<button onclick='goUpdate()' class='btn btn-sm btn-info' type='button'>수정완료</button>
    							</span>
    							
    							<button class="btn btn-sm btn-success" data-oper="remove" type="button">삭제</button> 							
    							<button class="btn btn-sm btn-primary" data-oper="list" type="button">새로고침</button>
    						</div> 	
    									
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
  		 		
  		//**페이지 번호 클릭 시 이동하기 
		//form태그의 id=pageFrm 인 요소를 선택
		var pageFrm = $("#pageFrm");
		
		//<li class="page-item"의 a태그를 클릭하면 함수를 실행한다 
		$(".page-item a").on("click", function(e){ 			
			//e : 현재 클릭한 a태그 요소 차체를 의미한다			
			// board/5 → board/list?page=5&perPageNum=10
		 	e.preventDefault(); //a태그의 링크이동 기능을 막는다 
		 	
			var page = $(this).attr("href"); //클릭한 a 태그의 href 값을 읽어서 page 변수에 담는다
			
			//id=pageFrm인 form태그 안에서 
			// id=page 요소를 찾아서 value 변수에 page값(현재 클릭한 a태그의 href값)을 입력
			pageFrm.find("#page").val(page); 
			pageFrm.submit(); //form태그 제출된다 
		});		
  		
  		//form 태그에 대한 정보
  		var regForm = $("#regForm");
  		
  		//모든태그의 버튼의 클릭을 감지를 한다 
  		$("button").on("click", function(){
  			//클릭한 버튼의 data-oper 속성 값을 가져온다
  			var oper = $(this).data("oper");
  			
  			//현재페이지 번호
  			var currentPage = ${pageMaker.cri.page}
  			
  			if(oper == "register"){ //등록
  			    regForm.attr("enctype", "multipart/form-data");
  				regForm.submit();
  			}else if(oper == "reset"){ //취소
  				regForm[0].reset();
  			}else if(oper == "list"){ //목록
    
  			  	location.href ="${cpath}/board/list";
  			  
  			}else if(oper == "remove"){ //삭제
  				
  				regForm.attr("action", "${cpath}/board/remove");
  				regForm.attr("method", "get");
  			    regForm.submit();
  			}else if(oper == "updateForm"){ //수정기능
  								
  				regForm.find("#title").attr("readonly", false);
  				regForm.find("#content").attr("readonly", false);
  			 					
  				$("#update").hide();         // 수정 버튼 숨기기
  				$("#reply").hide(); // 답글쓰기 버튼 숨기기
  			    $("#updateComplete").show(); // 수정완료 버튼 보이기
				
  			}else if(oper =="reply"){
  				
  				// hidden 필드인 #idx에 저장된 부모 게시글의 번호를 가져온다
  			    var parentIdx = regForm.find("#idx").val();
  			  	var boardGroup = regForm.find("#board_group").val();
  				
  				regForm.find("#title").attr("readonly", false).val(""); // .val("") : 기존작성된내용 ""로 변경
  				regForm.find("#content").attr("readonly", false).val("");
  				regForm.find("#writer").val("${user.member.name}");
  				
  				$("#reply").hide(); // 답글쓰기 버튼 숨기기
  				$("#update").hide(); // 수정 버튼 숨기기
  			    $("#replyComplete").show(); // 수정완료 버튼 보이기
  								
  				$("#reply").html(replyBtn); //id="update"에 선택한 요소 안의 내용을 통째로 바꾸겠다		
  								
  				//$("#update").text(upBtn); 로 하면 텍스트가 바뀐다 
  			}
  			
  			
  		}); //버튼클릭
  		
  			
  		//상세보기기능
  		$(".move").on("click", function(e){
  			//a 태그의 기본 동작(href에 의한 페이지 이동)을 막는다
  			e.preventDefault(); 
  			
  			//클릭한 해당 요소의 href 속성값(idx)을 가져온다
  			// <td><a href="${vo.idx}">${vo.title}</a></td>
  			var idx = $(this).attr("href"); 
  			
  			$.ajax({
  				url : "${cpath}/board/get",
  				type : "get",
  				data : {"idx" : idx},
  				dataType : "json",
  				success : printBoard,
  				error : function(){ alert("error"); }
  			});//ajax	
  		});//a태그클릭
  		
  		counts(); //실시간조회수
	
  	});//ready
  	
  	
  	//상세보기 성공 후 게시글 정보를 폼에 출력하는 함수
  	function printBoard(vo){
  		var regForm = $("#regForm");
  		
  		//regForm기준으로 title을 찾는다 → vo.title 인 value값을 넣는다 
  		//regForm.find(...) : <input>이나 <textarea>같은 입력창의 value를 바꿀때 쓰는 방법
   		regForm.find("#title").val(vo.title);
  		regForm.find("#content").val(vo.content);
  		regForm.find("#writer").val(vo.writer);	
  			
  		
  		//regForm 안에 input, textarea 태그를 찾아서 readonly → true로 속성을 추가
  		regForm.find("input").attr("readonly", true);
  		regForm.find("textarea").attr("readonly", true);
  		
  		//파일이름 있는지 확인
  		if (vo.attached_data) {
  		    $("#download_link").attr("href", "${cpath}/board/download/" + vo.attached_data);
  		    
  		    //버튼 안의 글자를 파일명으로 바꿔줌 (text 이용)
  		    $("#download_link").text("첨부파일 다운로드 (" + vo.attached_data + ")");
  		    
  		    // 4. 숨겨져 있던 버튼을 화면에 보여줌
  		    $("#download_btn").show();
  		} else {
  		    // 파일이 없으면 버튼을 숨김
  		    $("#download_btn").hide();
  		}

  		$("#uploadFile").hide();  //첨부파일 안보인다
  		
  		
  		//display는 HTML 속성이 아니라 CSS속성이기 때문에 attr()로 안된다  
  		$("#regDiv").css("display", "none");     //등록 취소 안보인다 
  		$("#updateDiv").css("display", "block"); //답글쓰기 목록 수정 삭제 보인다 
  		
  		$("#update").show(); //수정 버튼 숨기기
		$("#updateComplete").hide(); //수정완료 버튼 보이기
		
		$("#reply").show(); //수정 버튼 숨기기
		$("#replyComplete").hide(); //수정완료 버튼 보이기
  		
  		regForm.find("#idx").val(vo.idx);           //idx값을 hidden 태그에 넣는다 
  		regForm.find("#username").val(vo.username); 
  		regForm.find("#attached_data").val(vo.attached_data); 
  		
  	
  		//EL식에서 가져온 스프링시큐리티 이름과 게시글 작성한 이름이 같다면 
  		// 수정 삭제 버튼 비활성화를 취소시키겠다 
  		if("${user.member.name}" == vo.writer){
  			//button 태그에 data-oper="updateForm" 접근한다 
  			$("button[data-oper='updateForm']").attr("disabled", false);
  			$("button[data-oper='remove']").attr("disabled", false);
  		}else{ //다르다면 수성삭제 버튼 비활성화 하겠다 
  			$("button[data-oper='updateForm']").attr("disabled", true);
  			$("button[data-oper='remove']").attr("disabled", true);
  		}
  		
  	}//printBoard
  	
  	
  	
  	
  	//수정기능
  	function goUpdate(){
  		var regForm = $("#regForm");
  		regForm.attr("action", "${cpath}/board/modify");
  		regForm.submit(); //제출
  		alert("수정이 완료되었습니다");
  	}
  	
  	//답글기능
  	function goReply(){
  		var regForm = $("#regForm");
  		regForm.attr("action", "${cpath}/board/reply");
  		regForm.submit(); //제출
  		alert("답글이 게시되었습니다");
  	}
  	
  	
  	
  	//조회수실시간반영
	function showCount(idx) {
    $.ajax({
        url: "${cpath}/board/showCount",    
        type: "get",
        data: {"idx": idx},
        success: function(vo) {   
            var newCount = vo.count +1; // 서버 Board 객체의 필드명이 count인 경우
            //id="cnt_${vo.idx}" 
            $("#cnt_" + idx).text(newCount);

        },
        error: function() { 
            alert("조회수실시간반영 실패"); 
        }
    });
}
  	
  </script>

</body>
</html>

