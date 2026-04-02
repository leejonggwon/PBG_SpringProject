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
  <link rel="stylesheet" href="${cpath}/resources/css/logoStyle.css">
  
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
    				<p></p>
    					<table class="table table-bordered table-hover">
    						<thead class="table-cnt">
    							<th style="width: 8%;">번호</th>
    							<th style="width: 32%;">제목</th>
    							<th style="width: 10%;">공감수</th>
    							<th style="width: 15%;">작성자</th>		
    							<th style="width: 25%;">작성일</th>
    							<th style="width: 10%;">조회수</th>
    						</thead>
    						<tbody>
    							<c:forEach var="vo" items="${list}" varStatus="i">
    								<tr>
    									<td class="table-cnt">${pageMaker.totalCount - ((pageMaker.cri.page - 1) * pageMaker.cri.perPageNum + i.index)}</td>					
    									<td>
    										<!-- 삭제인 경우 -->
	    									<c:if test="${vo.board_available == 'ADMIN'}"> 								    									
	    										<div style="cursor: pointer; color: gray;" onclick="alert('관리자에 의해 삭제된 게시글 입니다.');">
	    											<c:if test="${vo.board_level > 0}">
	    												<c:forEach begin="0" end="${vo.board_level}" step="1">
	    													<span style="padding-left:5px"></span>
	    												</c:forEach>
	    												ㄴ[답글]
	    											</c:if>
	    											관리자에 의해 삭제된 게시글 입니다.
	    										</div>
	    									</c:if>
	    									
	    									<c:if test="${vo.board_available != 'ADMIN' && vo.board_available != '1'}">								    									
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
	    									<c:if test="${vo.board_available == '1'}"> 								    									
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
    									<!-- 공감수 -->
    									<td class="table-cnt" id="likeCnt_${vo.idx}">${vo.like_count}</td>					
    									<td class="table-cnt">${vo.writer}</td>																	
    									<td class="table-cnt"><fmt:formatDate value="${vo.indate}" pattern="yyyy.MM.dd HH:mm"/></td>
    									<td class="table-cnt" id="cnt_${vo.idx}">${vo.count}</td>
    								</tr>
    							</c:forEach>
    						</tbody>
    						
    					</table>
    					
    					<!-- 검색옵션/키워드 -->
						<div class="container">
							<form class="form-inline justify-content-center" action="${cpath}/learning/learning_list" method="post"> 
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
							  <form action="${cpath}/learning/learning_list" id="pageFrm">
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
    			<div class="card" style="min-height: 500px; max-height: 5000px;">
    				<div class="card-body">
						<form id="regForm">					
							<input type="hidden" id="idx" name="idx" value="">
							<input type="hidden" id="attached_data" name="attached_data" value="${vo.attached_data}">
							
							<input type="hidden" id="username" name="username" value="<sec:authentication property='principal.member.username'/>">
							<input type="hidden" id="role" name="role" value="<sec:authentication property='principal.member.role'/>">
							
							<!-- 페이징정보 -->
							<input type="hidden" id="page" name="page" value="${pageMaker.cri.page}">
							<input type="hidden" id="perPageNum" name="perPageNum" value="${pageMaker.cri.perPageNum}">
							<!-- 검색정보 -->
							<input type="hidden" id="type" name="type" value="${pageMaker.cri.type}">
							<input type="hidden" id="keyword" name="keyword" value="${pageMaker.cri.keyword}">
						
    						<div id="hide_title" class="form-group">
    							<label for="title">제목</label> 
    							<input type="text" class="form-control" id="title" name="title" placeholder="Enter Title" >
    						</div>
    						
    						<!-- 강의 비디오 -->
    						<div id="video_container" style="display: none;">
	    						<video video id="main_video" controls width="700" height="550">
								    <source id="video_src" type="video/mp4">
								    이 브라우저는 동영상 재생을 지원하지 않습니다
								</video>
							</div>
							<br>
    						<div class="form-group">
    							<label for="content">내용</label>
    							<textarea id="content" name="content" class="form-control" placeholder="Enter Content" rows="4" cols=""></textarea> 
    						</div>
    									
    						
    						<div id="uploadFile" class="form-group">
    							<label>첨부파일</label>
    							<!-- name값과 VO의 필드명이 다르게한다 -->
    							<input type="file" name="uploadFile" class="form-control">
    						</div>						
    						
    							
    						<div id="hide_title" class="form-group">
    							<label for="writer">작성자</label>
    							<input value="<sec:authentication property='principal.member.nick_name'/>" 
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
    							<button id="likeBtn" class="btn btn-sm btn-outline-dark" type="button" onclick="likePlus()">♡ 좋아요</button>						
    							<button class="btn btn-sm btn-primary" data-oper="list" type="button">새로고침</button>
    						</div> 										
    					</form>		
 			
    				</div> <!--end class="card-body" -->
    				
    				<!-- 댓글 -->
    				<div id="cmt" style="display: none">
    				<!-- 댓글작성폼 -->
						<div class="card-body"> 
							<form id="cmtForm"> 
								<input type="hidden" name="idx" id="idx" value="">
								<input type="hidden" name="username" id="username" value="${mvo.username}">					
								<input type="hidden" name="name" id="name" value="${mvo.name}">					
								<input type="hidden" name="nick_name" id="nick_name" value="${mvo.nick_name}">				
								<input type="hidden" name="profile" id="profile" value="${mvo.profile}">				
								<input type="hidden" name="role" id="role" value="${mvo.role}">				
								
								<table id="cmtTbl" class="table table-bordered table-hover">
									<tr>
										<p>※욕설 뿐 아니라 모욕적인 표현이 담긴 댓글은 삭제됩니다.</p>
										<td>
											<textarea placeholder="댓글을 입력해주세요." rows="2" cols="" id="cmt_content" name="cmt_content" class="form-control"></textarea>
										</td> 
										<td style="text-align:center; vertical-align:middle; width:80px;"> 
											<button class="btn btn-custom btn-sm" type="button" onclick="cmtInsert()">등록</button>											
										</td>
									</tr>		                        
								</table>
							</form>	<!--end id="cmtForm" -->	
						</div> 
						
						<!-- 댓글리스트폼 -->
						<div class="card-body">
							<table id="cmtList" class="table table-bordered table-hover"> 	
								<tbody id="cmtView">
									<!--비동기 방식으로 가져온 댓글 나오게할 부분-->		
								</tbody>				
							</table>		
						</div>
					</div><!-- end댓글 -->

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
  		$("button[data-oper]").on("click", function(){
  			//클릭한 버튼의 data-oper 속성 값을 가져온다
  			var oper = $(this).data("oper");
  			
  			//현재페이지 번호
  			var currentPage = ${pageMaker.cri.page}
  			
  			if(oper == "register"){ //등록
  				if ($("#title").val().trim() == "" || $("#content").val().trim() == "") {
  					//trim() : 빈칸을 자르는역할
  				    alert("제목 또는 내용이 입력되지 않았습니다");
  				    $("#title").focus(); //커서가 title로 이동한다 
  				    return false; 
  				}
  				regForm.attr("action", "${cpath}/learning/register");
  				regForm.attr("method", "post");
  			    regForm.attr("enctype", "multipart/form-data");
  				regForm.submit();
  			}else if(oper == "reset"){ //취소
  				regForm[0].reset();
  			}else if(oper == "list"){ //목록
    
  			  	location.href ="${cpath}/learning/learning_list";
  			  
  			}else if(oper == "remove"){ //삭제
  				
  				regForm.attr("action", "${cpath}/learning/remove");
  				regForm.attr("method", "get");
  			    regForm.submit();
  			}else if(oper == "updateForm"){ //수정기능
  								
  				regForm.find("#title").attr("readonly", false);
  				regForm.find("#content").attr("readonly", false);
  			 					
  				$("#update").hide(); // '수정' 버튼 숨기기
  				$("#reply").hide();  // '답글쓰기' 버튼 숨기기
  			    $("#updateComplete").show(); // 수정완료 버튼 보이기
  			    
  			    $("#download_btn").hide(); // 파일다운 버튼 보이기
  			    $("#uploadFile").show();   // 파일첨부 버튼 보이기 	
  			    
  				$("#cmt").hide(); //댓글전체폼 숨긴다
	    
				
  			}else if(oper =="reply"){
  				
  				// hidden 필드인 #idx에 저장된 부모 게시글의 번호를 가져온다
  			    //var parentIdx = regForm.find("#idx").val();
  			  	//var boardGroup = regForm.find("#board_group").val();
  				
  				regForm.find("#title").attr("readonly", false).val(""); // .val("") : 기존작성된내용 ""로 변경
  				regForm.find("#content").attr("readonly", false).val("");
  				regForm.find("#writer").val("${user.member.name}");
  				
  				
  				$("#reply").hide(); // '답글쓰기' 버튼 숨기기
  				$("#update").hide(); // '수정' 버튼 숨기기
  			    $("#replyComplete").show(); // '답글등록' 버튼 보이기
  			    
  		    	$("#download_btn").hide(); // '파일다운' 보이기
			    $("#uploadFile").show();   // '파일첨부' 버튼 보이기
  
  				$("#cmt").hide(); //댓글폼 전체를 숨긴다
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
  				url : "${cpath}/learning/get",
  				type : "get",
  				data : {"idx" : idx},
  				dataType : "json",
  				success : printBoard,
  				error : function(){ alert("error"); }
  			});//ajax	
  		});//a태그클릭
  		
  		
	
  	});//end ready
  	
  	

  	//상세보기 성공 후 게시글 정보를 폼에 출력하는 함수
  	function printBoard(vo){
  		
  		var regForm = $("#regForm"); //등록글
  		var cmtForm = $("#cmtForm"); //댓글
  		
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
  		    $("#video_src").attr("src", "${cpath}/board_upload/" + vo.attached_data);
 		    
  		    $("#main_video")[0].load();
  		    //비디오파일 화면에 보여준다
  		    $("#video_container").show();
  		    
  		    $("#hide_title").hide();
  		    $("#hide_writer").hide();
  		    
  		    
  		} else {
  		    // 파일이 없으면 버튼을 숨김
  		    $("#download_btn").hide();
  		}

  		
  		$("#uploadFile").hide();  //첨부파일 안보인다
  		
  		//display는 HTML 속성이 아니라 CSS속성이기 때문에 attr()로 안된다  
  		$("#regDiv").css("display", "none");     //'등록' '취소' 안보인다 
  		$("#updateDiv").css("display", "block"); //'답글쓰기' '목록' '수정' '삭제' 보인다 
  		
  		$("#update").show();         //'수정' 버튼 보이기
		$("#updateComplete").hide(); //'수정완료' 버튼 숨기기
		
		$("#reply").show();         //'답글쓰기'버튼 보이기
		$("#replyComplete").hide(); //'답글등록'버튼 숨기기
		
		$("#cmt").show(); //'답글등록'버튼 숨기기
  		
  		regForm.find("#idx").val(vo.idx);           //idx값을 hidden 태그에 넣는다 
  		regForm.find("#username").val(vo.username); 
  		regForm.find("#attached_data").val(vo.attached_data); 
  		
  		//댓글작성에 입력되는 값
  		cmtForm.find("#idx").val(vo.idx); 
  		loadCmt(); //댓글리스트을 불러오는 기능
  		
  		$("#likeBtn").attr("onclick", "likePlus('" + vo.idx + "')");
		
  		//like_available 조회하기
  		likeHave(vo.idx);
  		
  		
  		
  		//EL식에서 가져온 스프링시큐리티 이름과 게시글 작성한 이름이 같다면 
  		// 수정버튼 비활성화를 취소시키겠다 
  		if("${user.member.name}" == vo.writer){
  			//button 태그에 data-oper="updateForm" 접근한다 
  			$("button[data-oper='updateForm']").attr("disabled", false);		
  		}else{ //다르다면 수성삭제 버튼 비활성화 하겠다 
  			$("button[data-oper='updateForm']").attr("disabled", true);
  		}
  		//EL식에서 가져온 스프링시큐리티 이름과 게시글 작성한 이름이 같거나 역할이 "ADMIN"이면 
  		// 삭제버튼 비활성화를 취소시키겠다 
  		if("${user.member.role}" == "ADMIN" || "${user.member.name}" == vo.writer){
  			$("button[data-oper='remove']").attr("disabled", false);
  		}else{ //다르다면 수성삭제 버튼 비활성화 하겠다 
  			$("button[data-oper='remove']").attr("disabled", true);
  		}
  		
  	}//printBoard
  	
  	
  	
  	
  	//수정기능
  	function goUpdate(){
  		var regForm = $("#regForm");
  		regForm.attr("action", "${cpath}/learning/modify");
  		regForm.attr("method", "post");
		regForm.attr("enctype", "multipart/form-data");
  		regForm.submit(); //제출
  		alert("수정이 완료되었습니다");
  	}
  	
  	//답글기능
  	function goReply(){
  		var regForm = $("#regForm");
  		regForm.attr("action", "${cpath}/learning/reply");
  		regForm.attr("method", "post");
  		regForm.attr("enctype", "multipart/form-data");
  		regForm.submit(); //제출
  		alert("답글이 게시되었습니다");
  	}
  		
  	
  	//조회수실시간반영
	function showCount(idx) {	
	    $.ajax({
	        url: "${cpath}/learning/showCount",    
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

  	
	//댓글리스트 가져오는 기능 
	function loadCmt() {
		var idx = $("#regForm #idx").val();
		
	    $.ajax({
	        url : "${cpath}/comment/loadCmt", 
	        type: "get",
	        data : { "idx" : idx },
	        dataType: "json",
	        success: cmtView, // 데이터를 받아서 화면에 그려주는 함수              
	        error: function() {         
	            alert("댓글로드 실패");
	        }
	    });
	}

	
	//댓글의 정보를 받아온다
	//서버로부터 비동기방식통신을 하고 성공했을때 작동하는 함수, 
	function cmtView(data){
		
		var listHtml = "";
	
		//$.each: jQuary반목문
		//data: AJAX 요청에서 서버가 반환한 전체 데이터
		//index: 배열의 인덱스, obj: 배열의 해당 인덱스 값 data[index]
		$.each(data, function(index, obj){ //index:순서 표시자
			
			//1763895209000 → 2025-11-23 21:11 
			var date = new Date(obj.cmt_indate); //Data 객체로 변환
			//Date 객체에서 각 정보를 뽑아 보기 좋은 문자열로 변환
	        var formatted = date.getFullYear() + '.' +
	                        ('0' + (date.getMonth()+1)).slice(-2) + '.' +		                        
	                        // 11+1 → 12
	                        // '0' + 12 →'012' (문자열)
	                        // ('012').slice(-2)  → "12" :뒤에서 2자리만 가져오기 때문에 두 자리 확보
	                        // "12"+'-' → "12-"
	                        ('0' + date.getDate()).slice(-2) + ' ' +
	                        ('0' + date.getHours()).slice(-2) + ':' +
	                        ('0' + date.getMinutes()).slice(-2);
	        
	        //원본글이 아니면 배경색 회색을 적용한다    
	        if (obj.cmt_level == 0) {   
	        	listHtml += "<tr>";
	        }else{
	        	 listHtml += "<tr class='cmtBg'>";
	        }             
	       	
			//프로필 이미지가 있으면(true) 업로드 경로의 이미지를 사용하고, 없으면 기본 이미지를 사용한다
		    var imgSrc = obj.profile 
               ? "${cpath}/profile_upload/" + obj.profile 
               : "${cpath}/resources/images/default.png"; 
               
            listHtml += "<td style='text-align:center; vertical-align:middle; width:10px;'>"
            listHtml += "<img style='width:30px; height:30px;' class='rounded-circle' src='" + imgSrc + "' />";
            listHtml += "</td>";  
               
			listHtml += "<td style='text-align:center; vertical-align:middle; width:100px;'>" + obj.nick_name + "</td>";
    
			//삭제상태
			if (obj.cmt_available == 'ADMIN') {		
				if(obj.cmt_level > 0){ //삭제상태+대댓글상태
					listHtml += "<td><span class='form-control cmtBg' style='color: #999;'>[댓글] "; 
				}else{ 
					listHtml += "<td><span class='form-control' style='color: #999;'>"; 				
				}
				listHtml += "관리자에 의해 삭제된 댓글입니다.</span></td>";
			}else if (obj.cmt_available != 'ADMIN' && obj.cmt_available != '1') {		
				if(obj.cmt_level > 0){ //삭제상태+대댓글상태
					listHtml += "<td><span class='form-control cmtBg' style='color: #999;'>[댓글] "; 
				}else{ 
					listHtml += "<td><span class='form-control' style='color: #999;'>"; 				
				}
				listHtml += "작성자에 의해 삭제된 댓글입니다.</span></td>";
			} else if (obj.cmt_available == '1') {									
				if(obj.cmt_level > 0){		
					listHtml += "<td><span class='form-control cmtBg' style='height: auto; min-height: 38px; white-space: normal; word-break: break-all;'>[댓글] ";
				}else{
					listHtml += "<td><span class='form-control' style='height: auto; min-height: 38px; white-space: normal; word-break: break-all;'>";
				}
				
				var cleanContent = obj.cmt_content.replace(/\n/g, "<br>");
				
				listHtml += cleanContent + "</span></td>";
			}	
			
			
			
			//댓글날짜
			listHtml += "<td style='text-align:center; vertical-align:middle; width:100px;'>" + formatted + "</td>"; //댓글날짜		
			
			//대댓글버튼 (원본글만 댓글을 달수 있다 )
			listHtml += "<td style='text-align:center; vertical-align:middle; width:70px;'>";
			if(obj.cmt_level == 0 && obj.cmt_available != '1'){
				listHtml += "<button disabled type='button' class='btn btn-custom btn-sm'>댓글</button>";	
			}else if(obj.cmt_level == 0 && obj.cmt_available == '1'){
				listHtml += "<button type='button' class='btn btn-custom btn-sm'"; 		
				listHtml += "onclick='cmtComment(" + obj.cmt_idx + ")'>댓글</button>";
			}
			listHtml += "</td>";
			
			//삭제된 게시물이면 삭제버튼 비활성화한다
			listHtml += "<td style='text-align:center; vertical-align:middle; width:70px;'>";					
			var username = "${user.member.username}"; //현재로그인된 username
			
			if (obj.cmt_available != 1) { 	//1이아니면 삭제된 표시상태								
				listHtml += "<button disabled type='button' class='btn btn-default btn-sm'>삭제됨</button>";					
			} else if (obj.cmt_available == 1 && (username == obj.username || "${user.member.role}" == "ADMIN")) {				
				listHtml += "<button type='button' class='btn btn-secondary btn-sm'"; 		
				listHtml += "onclick='cmtDelete(" + obj.cmt_idx + ")'>삭제</button>";		
			} else if (obj.cmt_available == 1 &&  username != obj.username) {				
				//listHtml += "<button type='button' class='btn btn-secondary btn-sm' disabled"; 		
				//listHtml += "onclick='cmtDelete(" + obj.cmt_idx + ")'>삭제</button>";		
			}
			listHtml += "</td>";
					
	
			listHtml += "</tr>";
			
			// 현재 로그인한 '진짜 내 정보'
		    const cusername = "${user.member.username}";
		    const cname = "${user.member.name}";
		    const cnick_name = "${user.member.nick_name}";
		    const cprofile = "${user.member.profile}";
		    const crole = "${user.member.role}";
		 
		    
			//대댓글	작성폼	
			listHtml += `
				<tr id="cmt_\${obj.cmt_idx}" style="display:none;">
					<td colspan="6">
					
					<form class="cmtcmtForm"> 
						<input type="hidden" name="idx" value="\${obj.idx}"> 
						<input type="hidden" name="cmt_idx" value="\${obj.cmt_idx}"> 
						<input type="hidden" name="username" value="\${cusername}">					
						<input type="hidden" name="name" value="\${cname}">					
						<input type="hidden" name="nick_name" value="\${cnick_name}">				
						<input type="hidden" name="profile" value="\${cprofile}">				
						<input type="hidden" name="role" value="\${crole}">													
						
						<table id="cmtcmtTbl" class="table table-bordered table-hover">
							<tr>				
								<td>
									<textarea placeholder="대댓글을 입력해주세요." rows="2" cols="" id="cmtcmt_content" name="cmtcmt_content" class="form-control"></textarea>
								</td> 
								<td style="text-align:center; vertical-align:middle; width:80px;"> 
									<button class="btn btn-custom btn-sm" type="button" onclick="cmtcmtInsert(this)">등록</button>											
								</td>
							</tr>		                        
						</table>
					</form>	

					</td>
				</tr>
			`;	
		}); //end $.each()
		
		
		$("#cmtView").html(listHtml);	
	};	
		

	
	//댓글 등록버튼
	function cmtInsert(){
		if($("#cmt_content").val().trim() == ""){
			alert("댓글 내용이 입력되지 않았습니다");
			return false;
		}
		
		//form 안의 입력값들을 AJAX로 바로 보낼 수 있는 문자열로 변환해주는 함수		
		var fData = $("#cmtForm").serialize();
		//idx=123&memID=son&cmtContent=%EB%8C%93%EA%B8%80+%EB%82%B4%EC%9A%A9
		$.ajax({
			url : "${cpath}/comment/cmtInsert",
			type : "post",
			data : fData, 
			success : function(){ 
				$("#cmt_content").val(""); //입력창 비우기
				loadCmt(); //비동기방식으로 댓글리스트 가져오기 기능	
			}, 
			error : function(){ alert("댓글등록실패");}
		});
		//$("#fclear").trigger("click");
		//등록 후 폼을 초기 상태로 돌리기 위해 클릭 이벤트를 강제로 실행
	};
	
	
	//댓글삭제기능
	function cmtDelete(cmt_idx){
		//확인/취소창 
		var role = "${user.member.role}";
		
		if(!confirm("댓글을 삭제하겠습니까?")) {
	        return; //취소를 누르면 함수종료 된다
	    }	
		
		$.ajax({
			url : "${cpath}/comment/cmtDelete", 
			type : "get",        
			data : { "cmt_idx" : cmt_idx, "role" : role }, 
			success : function(){ 
				loadCmt(); 		
			},      
			error : function(){ alert("댓글삭제기능 오류")}
		});
	};
	
	
	//대댓글 작성폼 
	function cmtComment(cmt_idx){
		//alert(cmt_idx);
		//toggle()은 대상의 보임/숨김 상태를 자동으로 반전시켜 주는 함수
		$("#cmt_" + cmt_idx).toggle();
		
	};
		
		
	//대댓글전송
	function cmtcmtInsert(btn){
		if($("#cmtcmt_content").val().trim() == ""){
			alert("댓글 내용이 입력되지 않았습니다");
			return false;
		}
		
		// 1. 클릭된 버튼(btn)에서 가장 가까운 .cmtcmtForm을 찾아!
	    var form = $(btn).closest(".cmtcmtForm");
	    var fData = form.serialize();
	    
	    //console.log("전송될 데이터: ", fData);
		//idx=20&username=admin&name=%EA%B4%80%EB%A6%AC%EC%9E%90&nick_name=%EA%B4%80%EB%A6%AC%EC%9D%B8%EC%9E%85%EB%8B%88%EB%8B%A4&profile=b8a012a3-9aca-40ee-b0bc-11be0fe2ead8_youtubeMain.png&role=ADMIN&cmt_group=55&cmt_content=%EB%8C%80%EB%8C%93
		$.ajax({
			url : "${cpath}/comment/cmtcmtInsert",
			type : "post",
			data : fData, 
			success : function(){ 
				$("#cmtcmt_content").val(""); //입력창 비우기
				loadCmt(); //비동기방식으로 댓글리스트 가져오기 기능	
			}, 
			error : function(){ alert("대댓글등록실패");}
		});
		//$("#fclear").trigger("click");
		//등록 후 폼을 초기 상태로 돌리기 위해 클릭 이벤트를 강제로 실행
	};
	

	//===================================================================================좋아요
	
	
	
		
	//like_count +1 기능
	function likePlus(idx){
		//var idx = $("#regForm #idx").val();		
		//alert("likePlus - idx 값:"+ idx);
		
		$.ajax({
			url : "${cpath}/like/likePlus",    
			type: "post",      
			data : { "idx" : idx},  
			success: function(){	
				//alert("성공-likePlus - idx 값:" + idx);
				showLike_count(idx); //공감수 실시간반영
				likeHave2(idx); //Like객체 여부확인하는 기능		
		        },  
			error: function(){ alert("likeCount+1 실패"); }
		});
	};
	
	//Like객체 존재여부확인
	function likeHave2(idx){	
		var username = "${user.member.username}";
		//alert("likeHave - idx 값: "+ idx +" username값: " + username);
		
		$.ajax({
			url : "${cpath}/like/likeHave",    
			type: "get",      
			data : {"idx" : idx, "username" : username},  
			dataType: 'json',
			success: function(data){	
				//alert("likeHave 성공 - idx 값: "+ idx)
				if(data == 1){
					updateLike(idx); //LIKE객체 존재하면 available=0으로 수정
				}else{
					insertLike(idx); //LIKE객체 존재하지 않으면 객체생성한다
				}
				//likeCount();  //likeCount 불러오기
		        },  
			error: function(){ alert("Like객체 존재여부확인2 실패"); }
		});
	};
	
	

	//Like객체생생하기 
	function insertLike(idx){
		
		var username = "${user.member.username}";
		//alert("insertLike - idx 값: "+ idx +" username값: " + username);
		
		$.ajax({
			url : "${cpath}/like/insertLike",    
			type: "post",      
			data : {"idx" : idx, "username" : username},  
			success: function(){		
				//alert("insertLike 성공 - idx 값: "+ idx);
				selectLike(idx); //Like객체 like_available 불러오기
		        },  
			error: function(){ alert("Like객체생생실패"); }
		});
	};
	

	//like_available=1 로 수정하기
	function updateLike(){
		var idx = $("#regForm #idx").val();	
		var username = "${user.member.username}";
		
		//alert("updateLike - idx 값: "+ idx +" username값: " + username);
		$.ajax({
			url : "${cpath}/like/updateLike",    
			type: "post",      
			data : {"idx" : idx, "username" : username},  
			success: function(){	
				//alert("selectLike 성공 - idx 값: "+ idx);
				selectLike(idx); //Like객체 like_available 불러오기
		        },  
			error: function(){ alert("Like객체생생실패"); }
		});
	};
	
	
	//Like객체 존재여부확인
	function likeHave(idx){	
		var username = "${user.member.username}";
		//alert("likeHave - idx 값: "+ idx +" username값: " + username);
		
		$.ajax({
			url : "${cpath}/like/likeHave",    
			type: "get",      
			data : {"idx" : idx, "username" : username},  
			dataType: 'json',
			success: function(data){	
				//alert("likeHave 성공 - idx 값: "+ idx)
				if(data == 1){
					selectLike(idx); //LIKE객체 존재하면 available=0으로 수정
				}else{
					$("#likeBtn").text("♡ 좋아요").attr("onclick", "likePlus('"+idx+"')").attr("class","btn btn-sm btn-outline-dark");
				}
				//likeCount();  //likeCount 불러오기
		        },  
			error: function(){ alert("Like객체 존재여부확인 실패"); }
		});
	};
	
	
	//Like객체 like_vailable 불러오기
	function selectLike(idx){		
		var username = "${user.member.username}";
		//alert("selectLike- idx값: " + idx +" "+ "username값: " + username);
		
		$.ajax({
			url : "${cpath}/like/selectLike",    
			type: "get",      
			data : {"idx" : idx, "username" : username},
			dataType: 'json',
			success: function(data){	
				//alert("성공 selectLike - idx값: " + idx +" "+ "username값: " + username);
				//alert("성공 selectLike - data available값: " + data);
				likeView(data, idx); //버튼을 좋아요취소 상태로변경			
		        },  
			error: function(){ alert("like_available 불러오기 실패");}
		});
	};
	
	
	//사용자가 좋아요를 누른 상태라면 버튼을 좋아요취소 상태로 변경한다
	function likeView(data, idx){
		var idx = idx;
		//alert("likeView - idx값: " + idx); 
		//alert("likeView - data available값: " + data); 
		
		 //$(".move").attr("href",idx);
		 
		if (data == 1) {
			//text를 '♡'로 교체하고 속성들을 교체한다
		    $("#likeBtn").text("♡ 좋아요").attr("onclick", "unLike('"+idx+"')").attr("class", "btn btn-danger btn-sm");
		    //.removeClass() //기존의 모든 CSS 클래스를 삭제 하고 버튼속성을 교체한다
	        //.addClass("btn btn-danger btn-sm"); 
		}else{
			$("#likeBtn").text("♡ 좋아요").attr("onclick", "likePlus('"+idx+"')").attr("class","btn btn-sm btn-outline-dark");
		}
	};

	
	//like_count -1 기능
	function unLike(idx){
		//alert("unLike - idx값: " + idx); 	
		
		$.ajax({
			url : "${cpath}/like/unLike",    
			type: "post",      
			data : { "idx" : idx},  
			success: function(){	
				//alert("unLike 성공 - idx값: " + idx);
				showLike_count(idx);
				updateLike_0(idx); //like_available 0으로 수정
		        },  
			error: function(){ alert("likeCount-1 실패"); }
		});
	};
	
	
	//like_available 0으로 수정
	function updateLike_0(idx){	
		var username = "${user.member.username}";
		//alert("updateLike_0 - idx값: " + idx +" "+ "username값: " + username);
		
		$.ajax({
			url : "${cpath}/like/updateLike_0",    
			type: "post",      
			data : {"idx" : idx, "username" : username},
			success: function(){
				//alert("updateLike_0 성공 - idx값: " + idx );
				selectLike(idx);
		        },  
			error: function(){ alert("like_available 0으로 수정 실패"); }
		});
	};
	
	
	//공감수 실시간반영
	function showLike_count(idx) {	
		//alert("showLike_count idx값 : " + idx);
		
	    $.ajax({
	        url: "${cpath}/learning/showLike_count",    
	        type: "get",
	        data: {"idx": idx},
	        success: function(vo) {   
	            var newLike_count = vo.like_count;          
	            $("#likeCnt_" + idx).text(newLike_count);
	           
	        },
	        error: function() { 
	            alert("공감수 실시간반영 실패"); 
	        }
	    });
	}


	
  </script>

</body>
</html>

