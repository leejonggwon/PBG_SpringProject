<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 스프링보안 태그라이브러리(JSTL방식)-->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="cpath" value="${pageContext.request.contextPath}"/>

<!-- Spring Security 로그인한 계정정보 EL식-->
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
.role-textSt-instructor {
	color: #e75c59;
    /*background-color: #f6dede;*/
    /*font-weight: bold;*/
}
.role-textSt-admin {    
    color: #1d517b;
    /*background-color: #eff5fa;*/
    /*font-weight: bold;*/
}
/*강사 답글텍스트 색상*/
.reply-textSt{
	color: #e75c59;
}

/*작성자 글씨효과*/
.writer-link {
   color: #000000; /* 원하는 색상 코드 */
   text-decoration: none; /* 밑줄 없애고 싶을 때 */
}
/*작성자 글씨 호버효과*/  
.writer-link:hover {
   /*text-decoration: none;*/ /* 밑줄 없애고 싶을 때 */
}

/*제목 글씨효과*/
.title-link {
   color: #000000; /* 원하는 색상 코드 */
   text-decoration: none; /* 밑줄 없애고 싶을 때 */
}
.title-link:hover  {
   /*text-decoration: none;*/ /* 밑줄 없애고 싶을 때 */
}


/*모달 배경색 연하게*/
.modal-backdrop {
  opacity: 0.2 !important;
}

/*모달창 카드처럼*/
#writerType {
  background: #ffffff;
  border-radius: 15px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}

.modal-body {
  background-color: #f8f9fa;
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
    		
    		<!-- PENALTY 경우  -->
    		<c:if test="${user.member.role =='PENALTY'}">
	    		<div class= "col-lg-10">
	    			<div class="card" style="min-height: 500px; max-height: 1000px;">
	    				<div class="card-body" style="display: flex; align-items: center; justify-content: center;">
	    					<p>※ ${user.member.nick_name} 님은 운영 정책에 따라 현재 <strong>이용제한</strong> 상태입니다. 관리센터에 문의 주세요.</p>
	    				</div>
	    			</div>			
	    		</div>		   			
    		</c:if>
    		
    		<!-- GUEST 경우  -->
    		<c:if test="${user.member.role =='GUEST'}">
	    		<div class= "col-lg-10">
	    			<div class="card" style="min-height: 500px; max-height: 1000px;">
	    				<div class="card-body" style="display: flex; align-items: center; justify-content: center;">
	    					<p>※ ${user.member.nick_name} 님은 현재 <strong>승인대기상태</strong> 입니다. 관리자의 승인 후 서비스 이용이 가능합니다</p>
	    				</div>
	    			</div>			
	    		</div>		
	    			
    		</c:if>
    		
			<!-- GUEST, PENALTY 제외 -->
    		<c:if test="${user.member.role !='GUEST' && user.member.role !='PENALTY'}">
    		    <!-- 두번째칸 -->
	    		<div class= "col-lg-5">
	    			<div class="card" style="min-height: 500px; max-height: 2000px;">
	    				<div class="card-body">
	    				<p>※ [백엔드] Q&A 게시판입니다. 욕설 및 모욕적인 표현이 포함된 게시글은 운영 정책에 따라 삭제됩니다.</p>
	    				<!-- 검색옵션/키워드 -->
						<div class="container">
							<form class="form-inline justify-content-center" action="${cpath}/board/list" method="post"> 
								<!-- 검색옵션 -->
								<div class="form-group">
									<select name="type" class="form-control">
										<!-- 이름을 선택하면 <option value="writer" selected>이름</option> 이 자동 선택된다 -->
										<option value="lecture" ${pageMaker.cri.type =='lecture' ? 'selected' : ''} >과목</option>
										<option value="writer" ${pageMaker.cri.type =='writer' ? 'selected' : ''} >작성자</option> 
										<option value="title" ${pageMaker.cri.type =='title' ? 'selected' : ''} >제목</option>
										<option value="content" ${pageMaker.cri.type =='content' ? 'selected' : ''} >내용</option>
									</select>
								</div>
								&nbsp;
								<!-- 검색키워드 -->	
								<div class="form-group">
									<input type="text" value="${pageMaker.cri.keyword}" class="form-control" name="keyword">
								</div>
								&nbsp;<button type="submit" class="btn btn-custom">검색</button>	
								&nbsp;<a href="${cpath}/board/list" class="btn btn-outline-dark"><i class="fas fa-redo" style="color: rgb(0, 0, 0);"></i> 새로고침</a>									
							</form>
						</div>
						<br>
		
	    					<table class="table table-bordered table-hover">
	    						<thead class="table-cnt">
	    							<th style="width: 8%;">번호</th>
	    							<th style="width: 4%;">강의</th>
	    							<th style="width: 33%;">제목</th>
	    							<th style="width: 8%;">공감</th>
	    							<th style="width: 13%;">작성자</th>
	    							<th style="width: 11%;">권한</th>
	    							<th style="width: 15%;">작성일</th>
	    							<th style="width: 8%;">조회</th>
	    						</thead>
	    						<tbody>
	    							<c:forEach var="vo" items="${list}" varStatus="i">
	    								<tr>
	    									<td class="table-cnt">${pageMaker.totalCount - ((pageMaker.cri.page - 1) * pageMaker.cri.perPageNum + i.index)}</td>					
	    									<!-- 강의 -->
	    									<td class="table-cnt">${vo.lecture}</td>
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
		    										<a class="move title-link" href="${vo.idx}" onclick="showCount('${vo.idx}')" >
		    											<c:if test="${vo.board_level > 0}">
		    												<c:forEach begin="0" end="${vo.board_level}" step="1">
		    													<span style="padding-left:5px"></span>
		    												</c:forEach>
		    												<span class="reply-textSt">
		    													ㄴ[답글]
		    												</span>
		    											</c:if>
		    											${vo.title}
		    										</a>
		    									</c:if>
	    									</td> 		
	    									<!-- 공감수 -->
	    									<td class="table-cnt" id="likeCnt_${vo.idx}">${vo.like_count}</td>					
	    									
	    									<!-- 작성자 -->    										    									
	    									<td class="table-cnt writer" data-writer="${vo.username}">
											   <a href="#" class="writer-link"> ${vo.writer}</a>
											</td>			
	    									
	    									<td class="table-cnt">
											    <c:choose>
											        <c:when test="${vo.role == 'ADMIN'}">
											        	<span class="role-textSt-admin">관리자</span>
											        </c:when>
											        <c:when test="${vo.role == 'INSTRUCTOR'}">
											        	<span class="role-textSt-instructor">강사</span>
											        </c:when>									       
											        <c:otherwise>수강생</c:otherwise>
											    </c:choose>
											</td>		
														
	    									<td class="table-cnt"><fmt:formatDate value="${vo.indate}" pattern="yyyy.MM.dd HH:mm"/></td>
	    									<td class="table-cnt" id="cnt_${vo.idx}">${vo.count}</td>
	    								</tr>
	    							</c:forEach>
	    						</tbody>
	    						
	    					</table>

							
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
	    		</div><!-- end두번째칸 -->
	    		
	    		<!-- 세번째칸 -->
	    		<div class= "col-lg-5">
	    			<div class="card" style="min-height: 500px; max-height: 50000px;">
	    				<div class="card-body">
							<form id="regForm">					
								<input type="hidden" id="idx" name="idx" value="">
								<input type="hidden" id="attached_data" name="attached_data" value="${vo.attached_data}">
								<input type="hidden" id="attached_data2" name="attached_data2" value="${vo.attached_data2}">
								<input type="hidden" id="attached_data3" name="attached_data3" value="${vo.attached_data3}">
															
								<input type="hidden" id="username" name="username" value="<sec:authentication property='principal.member.username'/>">
								<input type="hidden" id="role" name="role" value="<sec:authentication property='principal.member.role'/>">
								
								<!-- 페이징정보 -->
								<input type="hidden" id="page" name="page" value="${pageMaker.cri.page}">
								<input type="hidden" id="perPageNum" name="perPageNum" value="${pageMaker.cri.perPageNum}">
								<!-- 검색정보 -->
								<input type="hidden" id="type" name="type" value="${pageMaker.cri.type}">
								<input type="hidden" id="keyword" name="keyword" value="${pageMaker.cri.keyword}">
								
								<!-- 강의선택 -->				
								<div class="form-group">
									<label for="lecture"></label> 
									<div class="form-inline justify-content-start"> 
										<select id="lecture" name="lecture" class="form-control">
											<option value="">강의선택</option>
									        <option value="Spring">Spring</option>
									        <option value="JSP&Servlet">JSP&Servlet</option>
									        <option value="Java">Java</option>
									        <option value="DataBase">DataBase</option>
										</select>
									</div>
								</div>	
														
	    						<div class="form-group">
	    							<label for="title">제목</label> 
	    							<input type="text" class="form-control" id="title" name="title" placeholder="Enter Title">
	    						</div>
	    						
	    						  						
	    						<div class="form-group">
	    							<label for="content">내용</label>	
	    							<!-- 이미지 --> 	
	    							<div id="img_container" style="display: none;" class="form-group">
			    						<img id="img_src" alt="attached-img" style="width: 100%; height: auto;">					    
									</div>							
	    							<textarea id="content" name="content" class="form-control" placeholder="Enter Content" rows="7" cols=""></textarea> 
	    						</div>
	    							    		
	    						<!-- 첨부된 파일삭제버튼 -->								
	    						<div id="delete_attached_data_btn" class="form-group" style="display: none">				
	    							<button onclick="delete_attached_data()" type="button" ></button> 	
	    						</div>	
	    						
	    						<!-- 첨부된 파일2삭제버튼 -->								
	    						<div id="delete_attached_data_btn2" class="form-group" style="display: none">				
	    							<button onclick="delete_attached_data2()" type="button" ></button> 	
	    						</div>
	    						
	    						<!-- 첨부된 파일2삭제버튼 -->								
	    						<div id="delete_attached_data_btn3" class="form-group" style="display: none">				
	    							<button onclick="delete_attached_data3()" type="button" ></button> 	
	    						</div>
						
	    						
	    						<div id="uploadFile" class="form-group">
	    							<label>이미지업로드 (※이미지 형식의 파일만 등록할 수 있습니다)</label>
	    							<input type="file" id="uploadFile_img" name="uploadFile" accept="image/*" class="form-control">    							
		    					</div>
	    						
	    						<div class="row">
	    							<div class="col">	
	    								<div id="uploadFile2" class="form-group">
			    							<label>첨부파일</label>
			    							<!-- name값과 VO의 필드명이 다르게한다 -->
			    							<input type="file" name="uploadFile2" class="form-control">    							
		    							</div>
	    							</div>	
	    							<div class="col">
	    								<label></label><br>
	    								<button id="addUploadFile_btn" type="button" onclick="addUploadFile()" class="btn btn-sm btn-outline-dark"> 첨부파일 추가</button> 	
	    							</div>		    						
	    						</div>    											    						
	    						
	    						<div id="uploadFile3" class="form-group" style="display: none;">
	    							<label>첨부파일2</label>
	    							<!-- name값과 VO의 필드명이 다르게한다 -->
	    							<input type="file" name="uploadFile3" class="form-control">
	    						</div>
	    						
	    						<div id="download_btn" style="display: none;" class="mb-3">
	    							<label>이미지첨부</label><br>
	    							<a id="download_link" href="#"></a>					       
	    						</div>
	    						
	    						<div id="download_btn2" style="display: none;" class="mb-3">
	    							<label>첨부파일</label><br>
	    							<a id="download_link2" href="#"></a>					       
	    						</div>
	    						
	    						<div id="download_btn3" style="display: none;" class="mb-3">
	    							<label>첨부파일2</label><br>
	    							<a id="download_link3" href="#"></a>					       
	    						</div>
	    							
	    						<div class="form-group">
	    							<label for="writer">작성자</label>
	    							<input value="<sec:authentication property='principal.member.nick_name'/>" 
	    							type="text" class="form-control" id="writer" name="writer" readonly="readonly">
	    						</div>
	    						
	    						<!-- 게시글등록시 버튼 -->
	    						<div id="regDiv">  					
		    						<button type="button" data-oper="register" class="btn btn-sm btn-custom">등록</button> 						
		    						<button type="button" data-oper="reset" class="btn btn-sm btn-outline-dark">취소</button> 						
	    						</div>	
	    						<!-- 게시글상세보기시 버튼 -->					
	    						<div id="updateDiv" style="display: none;">
		    						<c:if test="${user.member.role =='ADMIN' || user.member.role =='INSTRUCTOR'}">
		    							<span id="reply">
		    								<button class="btn btn-sm btn-outline-dark" data-oper="reply" type="button">답글쓰기</button>
		    							</span>
	    							</c:if>
	    							
	    							<span id="replyComplete" style="display: none;">
	    								<button onclick="goReply()" class="btn btn-sm btn-custom" type="button">답글등록</button>
	    							</span>
			
	    							<span id="update">
	    								<button class="btn btn-sm btn-outline-dark" data-oper="updateForm" type="button">수정</button>
	    							</span>
	    							
	    							<span id="updateComplete" style="display: none;">
	    								<button onclick='goUpdate()' class='btn btn-sm btn-custom' type='button'>수정완료</button>
	    							</span>
	    							    								
	    							<button id="likeBtn" class="btn btn-sm btn-outline-danger" type="button" onclick="likePlus()">♡ 좋아요</button>	
	    							<button class="btn btn-sm btn-outline-dark" data-oper="remove" type="button">삭제</button> 					
	    							<button class="btn btn-sm btn-outline-dark" data-oper="list" type="button">글쓰기</button>
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
												<button class="btn btn-custom btn-sm" type="button" onclick="cmtInsert()">댓글 등록</button>											
											</td>
										</tr>		                        
									</table>
								</form>	<!--end id="cmtForm" -->	
							</div> 
							
							<!-- 댓글리스트폼 -->
							<div class="card-body">
							    <div class="table-responsive" style="max-height: 1000px;"> <!-- 부트스트랩에서 제공하는 반응형 테이블 클래스, 화면이 작아지면 자동으로 가로 스크롤을 만들어준다 -->
							        <table id="cmtList" class="table table-bordered table-hover"> 	
							            <tbody id="cmtView">
							                </tbody>				
							        </table>
							    </div>
							</div>
						</div><!-- end댓글 -->
	
	    			</div>
	    		</div><!--세번째칸 -->
    		</c:if> <!--end GUEST 아닌경우 -->
    		
    	</div>
    </div> 
    <%@ include file="/WEB-INF/common/bottom_common.jsp" %>
  </div>
  
  <!-- 모달작동버튼 -->
  <div id="openModal" data-toggle="modal" data-target="#myModal"></div>
  
  <!-- Bootstrap 비밀번호체크 모달창 -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog">
      <div id="checkType" class="modal-content">
      
        <div class="modal-header">
          <h4 class="modal-title">메세지확인</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <div class="modal-body">
          <p id="checkMessage"></p> 
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-outline-dark" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  

  <!-- 모달작동버튼 -->
  <div id="myMessageOpenModal" data-toggle="modal" data-target="#myMessage"></div>
  
  <!-- 수정 실패시 띄워줄 모달창 -->
  <div class="modal fade" id="myMessage">
    <div class="modal-dialog">
      <div id="messageType" class="modal-content">
      
        <div class="modal-header">
          <h4 class="modal-title">${msgType}</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <div class="modal-body">
          <p style="white-space: pre-line;">${msg}</p> 
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-outline-dark" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  
  
  <!-- 프로필정보 모달작동버튼 -->
  <div id="writerOpenModal" data-toggle="modal" data-target="#myWriterModal"></div>
  
  <!-- 프로필정보 모달창 -->
  <div class="modal fade" id="myWriterModal">
    <div class="modal-dialog">
      <div class="modal-content" id="writerType" >
      
        <div class="modal-header">
          <h4 class="modal-title">작성자정보</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <div class="modal-body d-flex flex-column align-items-center justify-content-center">
          <img class="rounded-circle" id="writerImg" width="200" height="200"  src="#" >   
          <br>  
	        <p id="writerRole" style="font-size:18px; margin-bottom: 2px;"></p>
	        <p id="writerNick_name" style="font-size:18px; margin-bottom: 2px; font-weight: bold;"></p>  
	        <p id="writerName" style="font-size:18px; margin-bottom: 2px;"></p>
	        <p id="writerUsername" style="font-size:18px; margin-bottom: 2px;"></p>           
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-outline-dark" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  
  
  <script type="text/javascript">
  	$(document).ready(function(){
  		
  		if(${not empty msgType}){ //들어오는 msgType에 데이터가 감지되는경우
			if(${msgType eq "실패메세지"}){ //msgType 데이터가 "실패메세지" 인 경우
				$("#messageType").find(".modal-header").addClass("bg-danger text-white");
			}else{
				$("#messageType").find(".modal-header").addClass("bg-primary text-white");
			}
			$("#myMessageOpenModal").click(); //모달창 실행
		}
  		
  		 		
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
		
  		
  		//<form> 태그에 대한 정보
  		var regForm = $("#regForm");
  		
  		//모든태그의 버튼의 클릭을 감지를 한다 
  		$("button[data-oper]").on("click", function(){
  			
  			var oper = $(this).data("oper"); //클릭한 버튼의 data-oper 속성 값을 가져온다		
  			var currentPage = ${pageMaker.cri.page} //현재페이지 번호
  			
  			if(oper == "register"){ //등록
  				
  				var file = $("#uploadFile_img")[0].files[0];
				var lecture = $("#lecture").val();	
  				
  				if(!lecture){
  					alert("강의종류의 선택해주세요");
  					$("#lecture").focus();
  					return false; 
  				}
  			 	
  				// *먼저 파일이 있을 때만 영상 파일인지 체크해야한다	
  			    if (file) {         
  			        if (!file.type.startsWith("image/")) {
  			            alert("'이미지첨부'는 이미지 파일만 등록할 수 있습니다");
  			            $("#uploadFile_img").val(""); 
  			            return false; 
  			        }
  			    }
  				
  				if($("#title").val().trim() == "" || $("#content").val().trim() == ""){
					alert("제목 또는 내용이 입력되지 않았습니다");
					$("#title").focus(); //다시 내용입력란에 포커스적용 
  					return false;
  				}			
  				regForm.attr("action", "${cpath}/board/register");
  				regForm.attr("method", "post");
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
  			}else if(oper == "updateForm"){ //게시글 수정폼			
  				$("#lecture").prop("disabled", false);
  			
  				regForm.find("#title").attr("readonly", false);
  				regForm.find("#content").attr("readonly", false);
  				
				var attached_data = regForm.find("#attached_data").val();
				var attached_data2 = regForm.find("#attached_data2").val();
				var attached_data3 = regForm.find("#attached_data3").val();

								
  			    //'='부분을 제거한다 
	  			if (attached_data.includes("=")) { // Java의 contains 대신 includes 사용
	  				attached_data = attached_data.substring(attached_data.indexOf("=") + 1);
	  			}

	  			if (attached_data2.includes("=")) { // Java의 contains 대신 includes 사용
	  				attached_data2 = attached_data2.substring(attached_data2.indexOf("=") + 1);
	  			}

	  			if (attached_data3.includes("=")) { // Java의 contains 대신 includes 사용
	  				attached_data3 = attached_data3.substring(attached_data3.indexOf("=") + 1);
	  			}

  				if(attached_data){
  					$("#delete_attached_data_btn").show(); //'첨부파일삭제'버튼보이기 
  					$("#delete_attached_data_btn button").attr("class", "btn btn-sm btn-dark").text(" 이미지 첨부파일 삭제 ( " + attached_data + " )" );				
  				} 
  				
  				if(attached_data2){
  					$("#delete_attached_data_btn2").show(); //'첨부파일삭제'버튼보이기 
  					$("#delete_attached_data_btn2 button").attr("class", "btn btn-sm btn-dark").text(" 첨부파일 삭제 ( " + attached_data2 + " )" );				
  				}
  				
  				if(attached_data3){
  					$("#delete_attached_data_btn3").show(); //'첨부파일삭제'버튼보이기 
  					$("#delete_attached_data_btn3 button").attr("class", "btn btn-sm btn-dark").text(" 첨부파일2 삭제 ( " + attached_data3 + " )" );				
  				}
  				
  				$("#img_container").hide(); // 이미지숨기기
  				$("#update").hide(); // '수정' 버튼 숨기기
  				$("#reply").hide();  // '답글쓰기' 버튼 숨기기
  			    $("#updateComplete").show(); // 수정완료 버튼 보이기
  			    $("#likeBtn").hide();  // '좋아요' 버튼 숨기기
  			    
  			    $("#download_btn").hide(); // 파일다운 버튼 보이기
  			    $("#download_btn2").hide(); // 파일다운2 버튼 보이기
  			    $("#download_btn3").hide(); // 파일다운3 버튼 보이기
  			    $("#uploadFile").show();    // 파일첨부 보이기 		    
  			    $("#uploadFile2").show();   // '파일첨부2' 보이기
  			    $("#uploadFile3").hide();   // '파일첨부3'숨기기
  			    
  			 	$("#addUploadFile_btn").show();   // '첨부파일추가하기' 버튼 보이기
  			    
  				$("#cmt").hide(); //댓글전체폼 숨긴다  
  				
  			}else if(oper =="reply"){	
  				
  				var lecture = $("#lecture").val();			 				
  				regForm.find("#lecture").val(lecture);
  				regForm.find("#title").attr("readonly", false).val(""); // .val("") : 기존작성된내용 ""로 변경
  				regForm.find("#content").attr("readonly", false).val("");
  				regForm.find("#writer").val("${user.member.nick_name}");
  				regForm.find("#username").val("${user.member.username}"); //usrname을 변경해줘야한다
  				 				
  				$("#delete_attached_data_btn").hide(); //'첨부파일삭제버튼' 숨기기
  				$("#delete_attached_data_btn2").hide(); //'첨부파일삭제2버튼' 숨기기
  				$("#delete_attached_data_btn3").hide(); //'첨부파일삭제2버튼' 숨기기
  				
  			    //<form>태그 hidden에 있는 attached_data를 삭제한다
  				regForm.find("input[name='attached_data']").remove();
  				regForm.find("input[name='attached_data2']").remove();
  				regForm.find("input[name='attached_data3']").remove();
  				
  				$("#img_container").hide();
  				
  				$("#reply").hide(); // '답글쓰기' 버튼 숨기기
  				$("#update").hide(); // '수정' 버튼 숨기기
  			    $("#replyComplete").show(); // '답글등록' 버튼 보이기
  			    $("#likeBtn").hide();  // '좋아요' 버튼 숨기기		    
  		    	$("#download_btn").hide(); // '파일다운' 보이기
  		    	$("#download_btn2").hide(); // '파일다운' 보이기
  		    	$("#download_btn3").hide(); // '파일다운' 보이기
			    $("#uploadFile").show();   // '파일첨부' 버튼 보이기
			    $("#uploadFile2").show();   // '파일첨부' 버튼 보이기
			    $("#uploadFile3").hide();   // '파일첨부2' 버튼 보이기
			    
			    $("#addUploadFile_btn").show();   // '첨부파일추가하기' 버튼 보이기
			    
  				$("#cmt").hide(); //댓글폼 전체를 숨긴다
  			}		
  			
  		}); //버튼클릭
  			
  		//상세보기기능
  		$(".move").on("click", function(e){ 			
  			e.preventDefault(); //a 태그의 기본 동작(href에 의한 페이지 이동)을 막는다
  			
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
  		
  		
  		
  		//게시글 작성자 클릭시 username를 도출하는 기능
		//이전것: $(".writer").on("click", function(e) {		
		//  댓글 작성자 클릭하면 이미 게시글 작성자와 바인딩시점차이로 프로필모달이 생성하지 않는다 
		//  부모인 document가 .writer 들어오면 코드를 실행한다
		$(document).on("click", ".writer", function(e) {	
			e.preventDefault();
		    var username = $(this).data("writer");
		   
		    $.ajax({
		         url: "${cpath}/member/writerInfo",
		         type: "get",
		         data: { "username" : username},
		         dataType: "json",
		         success: function(writerInfo) {	        			        	
		         	
		         	$("#writerUsername").text("[ID] " + writerInfo.username);
		         	$("#writerName").text("[Name] " + writerInfo.name);
		         	$("#writerNick_name").text("[Nick Name] " + writerInfo.nick_name);
		         	         	
		         	$("#writerImg").attr("src",  writerInfo.profile            
			            		? "${cpath}/profile_upload/" + writerInfo.profile 
			            		: "${cpath}/resources/images/default.png");	
		         	 		         	 
		         	const roleMap = {
		         	        'STUDENT': '수강생',
		         	        'INSTRUCTOR': '강사',
		         	        'ADMIN': '관리자'		     
		         	    };
		         	
		         	var roleKorean = roleMap[writerInfo.role] || writerInfo.role;	         	
		         	$("#writerRole").text("[Role] " + roleKorean);
		         	
		            
		         	$("#writerOpenModal").click();
		         },
		         error: function() {
		             alert("작성자 정보를 가져오는데 실패했습니다.");
		         }
		    });
		   
		});
  		

  	});//end ready

  	//상세보기 성공 후 게시글 정보를 폼에 출력하는 함수
  	function printBoard(vo){
  		
  		var regForm = $("#regForm"); //등록글
  		var cmtForm = $("#cmtForm"); //댓글
  		
  		var selectedLecture = vo.lecture; 
  		
  		//.val(selectedLecture): selectedLecture가 "Java"라면, <option value="Java">를 자동으로 찾아간다
  		//.prop("selected", true): 선택된 요소의 속성중 selected 상태를 true로 설정한다 
   	    $("#lecture").val(selectedLecture).prop("selected", true);
   	    $("#lecture").prop("disabled", true); //폼을 submit 하면 disabled 된 요소의 값은 서버로 전송되지 않는다 
  		
  		
  		//regForm기준으로 title을 찾는다 → vo.title 인 value값을 넣는다 
  		//regForm.find(...) : <input>이나 <textarea>같은 입력창의 value를 바꿀때 쓰는 방법
   		regForm.find("#title").val(vo.title);
  		regForm.find("#content").val(vo.content);
  		regForm.find("#writer").val(vo.writer);	
  		
  		//regForm 안에 input, textarea 태그를 찾아서 readonly → true로 속성을 추가한다
  		regForm.find("input").attr("readonly", true);
  		regForm.find("textarea").attr("readonly", true);
  		
  		
  		//attached_img에 이미지가 있는지 확인
  		if (vo.attached_data) {	
  		    $("#img_src").attr("src", "${cpath}/board_upload/" + vo.attached_data);	    
  		    $("#img_container").show();
  		} else {	  
  		    //이미지를 숨긴다
  		    $("#img_container").hide();
  		}
  		

  		//파일이름 있는지 확인
  		if (vo.attached_data) {
  		    $("#download_link").attr("href", "${cpath}/board/download/" + vo.attached_data);		    
  		   
  		    var attached_data = vo.attached_data;
	  		
  		    if (attached_data.includes("=")) { 
		 		attached_data = attached_data.substring(attached_data.indexOf("=") + 1);
			}
  		    
  		    //download_link <a>태그에 text 표시한다 
  		    $("#download_link").text(attached_data);
  		    
  		    //숨겨져 있던 버튼을 화면에 보여줌
  		    $("#download_btn").hide();
  		} else {
  		    // 파일이 없으면 버튼을 숨김
  		    $("#download_btn").hide();
  		}
  		
  		//파일이름 있는지 확인2
  		if (vo.attached_data2) {
  		    $("#download_link2").attr("href", "${cpath}/board/download/" + vo.attached_data2);		    
  		   
  		    var attached_data2 = vo.attached_data2;
	  		
  		    if (attached_data2.includes("=")) { 
		 		attached_data2 = attached_data2.substring(attached_data2.indexOf("=") + 1);
			}
  		    
  		    //download_link <a>태그에 text 표시한다 
  		    $("#download_link2").text(attached_data2);
  		    
  		    //숨겨져 있던 버튼을 화면에 보여줌
  		    $("#download_btn2").show();
  		} else {
  		    // 파일이 없으면 버튼을 숨김
  		    $("#download_btn2").hide();
  		}
  		
  		
  	//파일이름 있는지 확인2
  		if (vo.attached_data3) {
  		    $("#download_link3").attr("href", "${cpath}/board/download/" + vo.attached_data3);		    
  		   
  		    var attached_data3 = vo.attached_data3;
	  		
  		    if (attached_data3.includes("=")) { 
		 		attached_data3 = attached_data3.substring(attached_data3.indexOf("=") + 1);
			}
  		    
  		    //download_link <a>태그에 text 표시한다 
  		    $("#download_link3").text(attached_data3);
  		    
  		    //숨겨져 있던 버튼을 화면에 보여줌
  		    $("#download_btn3").show();
  		} else {
  		    // 파일이 없으면 버튼을 숨김
  		    $("#download_btn3").hide();
  		}
		
  		$("#delete_attached_data_btn").hide(); //'첨부파일삭제버튼' 숨기기 		
  		$("#delete_attached_data_btn2").hide(); //'첨부파일2삭제버튼' 숨기기 		
  		$("#delete_attached_data_btn3").hide(); //'첨부파일2삭제버튼' 숨기기 		
  		
  		$("#uploadFile").hide();  //첨부파일폼 안보인다
  		$("#uploadFile2").hide();  //첨부파일2폼 안보인다
  		$("#uploadFile3").hide();  //첨부파일3폼 안보인다
  		$("#addUploadFile_btn").hide();  //첨부파일 안보인다
  		
  		//display는 HTML 속성이 아니라 CSS속성이기 때문에 attr()로 안된다  
  		$("#regDiv").css("display", "none");     //'등록' '취소' 안보인다 
  		$("#updateDiv").css("display", "block"); //'답글쓰기' '목록' '수정' '삭제' 보인다 	
  		$("#update").show();         //'수정' 버튼 보이기
		$("#updateComplete").hide(); //'수정완료' 버튼 숨기기	
		$("#reply").show();         //'답글쓰기'버튼 보이기
		$("#replyComplete").hide(); //'답글등록'버튼 숨기	
		$("#cmt").show(); //'답글등록'버튼 숨기기
  		
  		regForm.find("#idx").val(vo.idx);           //idx값을 hidden 태그에 넣는다 
  		regForm.find("#username").val(vo.username); 
  		regForm.find("#attached_data").val(vo.attached_data); 
  		regForm.find("#attached_data2").val(vo.attached_data2); 
  		regForm.find("#attached_data3").val(vo.attached_data3); 
  		
  		//댓글작성에 입력되는 값
  		cmtForm.find("#idx").val(vo.idx); 
  		
  		loadCmt(); //댓글리스트을 불러오는 기능	
  		
  		$("#likeBtn").attr("onclick", "likePlus('" + vo.idx + "')");
		
  		//like_available 조회하기
  		likeHave(vo.idx);
  		
  		//EL식에서 가져온 스프링시큐리티 이름과 게시글 작성한 이름이 같다면 
  		// 수정버튼 비활성화를 취소시키겠다 
  		if("${user.member.nick_name}" == vo.writer){
  			//button 태그에 data-oper="updateForm" 접근한다 
  			$("button[data-oper='updateForm']").attr("disabled", false);		
  		}else{ //다르다면 수성삭제 버튼 비활성화 하겠다 
  			$("button[data-oper='updateForm']").attr("disabled", true);
  		}
  		
  		//EL식에서 가져온 스프링시큐리티 이름과 게시글 작성한 이름이 같거나 역할이 "ADMIN"이면 
  		// 삭제버튼 비활성화를 취소시키겠다 
  		if("${user.member.role}" == "ADMIN"){
  			$("button[data-oper='remove']").attr("disabled", false);
  		}else if("${user.member.nick_name}" == vo.writer){
  			$("button[data-oper='remove']").attr("disabled", false);
  		}
  		else{ //다르다면 수성삭제 버튼 비활성화 하겠다 
  			$("button[data-oper='remove']").attr("disabled", true);
  		}
  		
  	}//printBoard

  	
  	//수정기능
  	function goUpdate(){
  		
  		var lecture = $("#lecture").val();	
		
		if(!lecture){
			alert("강의종류의 선택해주세요");
			$("#lecture").focus();
			return false; 
		}

  		var regForm = $("#regForm");
  		regForm.attr("action", "${cpath}/board/modify");
  		regForm.attr("method", "post");
		regForm.attr("enctype", "multipart/form-data");
  		regForm.submit(); //제출
  		alert("수정이 완료되었습니다");
  	}
  	
  	//답글기능
  	function goReply(){
  		
  		//disabled을 ture를 하면 서버에 전송되지 않으므로 전송직전에 false로 풀어준다 
  		$("#lecture").prop("disabled", false); 	
  		
  		if($("#title").val().trim() == "" || $("#content").val().trim() == ""){
			alert("제목 또는 내용이 입력되지 않았습니다");
			$("#title").focus();;
				return false;
		}
  		
  		var regForm = $("#regForm");
  		regForm.attr("action", "${cpath}/board/reply");
  		regForm.attr("method", "post");
  		regForm.attr("enctype", "multipart/form-data");
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

//댓글----------------------------------------------------------------------------------------- 

	//댓글리스트 가져오는 기능 
	function loadCmt() {
		var idx = $("#regForm #idx").val();
		//alert("loadCmt의 idx값: " + idx);
		
	    $.ajax({
	        url : "${cpath}/comment/loadCmt", 
	        type: "get",
	        data : { "idx" : idx },
	        dataType: "json",
	        success: function(data) {         
	        	cmtView(data);
	        },             
	        error: function() {         
	            alert("댓글로드 실패");
	        }
	    });
	}
	
	//댓글당 대댓글 수 가져오는 기능
	function cmt_groupCnt(cmt_group) {
		var idx = $("#regForm #idx").val();
		//alert("loadCmt의 idx값: " + idx);
		
	    $.ajax({
	        url : "${cpath}/comment/cmt_groupCnt", 
	        type: "get",
	        data : { "idx" : idx , "cmt_group" : cmt_group },
	        dataType: "json",
	        success: cmtView, // 데이터를 받아서 화면에 그려주는 함수              
	        error: function() {         
	            alert("댓글당 대댓글 수 가져오기 실패");
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
               
            listHtml += "<td style='text-align:center; vertical-align:middle; width:1px;'>"
            listHtml += "<img style='width:55px; height:55px;' class='rounded-circle' src='" + imgSrc + "' />";
            listHtml += "</td>";  
               
			listHtml += "<td class='writer' data-writer='" + obj.username + "' style='text-align:center; vertical-align:middle; width:100px;'>";
			listHtml += "<a href='#' class='writer-link'>" + obj.nick_name + "</a></td>";
		
    
			
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
			listHtml += "<td style='text-align:center; vertical-align:middle; width:85px;'>";	
			listHtml += "<button id='cmt_cmt_count_btn_" + obj.cmt_idx + "' type='button' class='btn btn-custom btn-sm'"; 		
			listHtml += "onclick='cmtComment(" + obj.cmt_idx + ")'>대댓글 " + obj.cmt_cmt_count + "</button>";		
			
			listHtml += "</td>";
			
			//삭제된 게시물이면 삭제버튼 비활성화한다
			listHtml += "<td style='text-align:center; vertical-align:middle; width:70px;'>";					
			var username = "${user.member.username}"; //현재로그인된 username
			
			if (obj.cmt_available != 1) { 	//1이아니면 삭제된 표시상태								
				listHtml += "<button disabled type='button' class='btn btn-default btn-sm'>삭제완료</button>"; //				
			} else if (obj.cmt_available == 1 && (username == obj.username || "${user.member.role}" == "ADMIN")) {				
				listHtml += "<button type='button' class='btn btn-secondary btn-sm'"; 		
				listHtml += "onclick='cmtDelete(" + obj.cmt_idx + ")'>삭제</button>";		
			} 
			listHtml += "</td>";
					
	
			listHtml += "</tr>";
			
			// 현재 로그인한 '진짜 내 정보'
		    const c_username = "${user.member.username}";
		    const c_name = "${user.member.name}";
		    const c_nick_name = "${user.member.nick_name}";
		    const c_profile = "${user.member.profile}";
		    const c_role = "${user.member.role}";

		    
			//대댓글폼	
			//백틱으로 할때는 백슬러시를 가져온다 
			listHtml += `
				<tr id="cmt_\${obj.cmt_idx}" style="display:none;">
					<td colspan="6">
						<table class="table table-bordered table-hover">
							<tbody id="cmtCmtView_\${obj.cmt_idx}">
								<!--비동기 방식으로 가져온 대댓글 리스트 나오게할 부분-->		
							</tbody>
						</table>	
						<form class="cmtcmtForm"> 
							<input type="hidden" name="idx" value="\${obj.idx}"> 
							<input type="hidden" name="cmt_idx" value="\${obj.cmt_idx}"> 							
							<input type="hidden" name="username" value="\${c_username}">					
							<input type="hidden" name="name" value="\${c_name}">					
							<input type="hidden" name="nick_name" value="\${c_nick_name}">				
							<input type="hidden" name="profile" value="\${c_profile}">				
							<input type="hidden" name="role" value="\${c_role}">													
							
							<table id="cmtcmtTbl" class="table table-bordered table-hover">
								<tr>				
									<td>
										<textarea name="cmt_content" class="form-control" rows="2" cols="" placeholder="대댓글을 입력해주세요."></textarea>
									</td> 
									<!-- 중복문제를 해결하기 위해 this를 사용한다-->
									<td style="text-align:center; vertical-align:middle; width:80px;"> 
										<button class="btn btn-custom btn-sm" type="button" onclick="cmtCmtInsert(this)">대댓글등록</button> 								
									</td>
								</tr>
							</table>	
						</form>	
						
					</td>
				</tr>
			
			`;	
		}); //end $.each()
		
		$("#cmtView").html(listHtml);	
	};	//end cmtView
		
	
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
	
	//대댓글삭제기능
	function cmtCmtDelete(cmt_group, cmt_idx, parent_idx){
		//alert("delete에 들어간 cmt_idx " + cmt_idx +" 부모idx값: " +parent_idx );		
		var role = "${user.member.role}";	
		
		if(!confirm("대댓글을 삭제하겠습니까?")) {
	        return; //취소를 누르면 함수종료 된다
	    }	
	
		$.ajax({
			url : "${cpath}/comment/cmtDelete", 
			type : "get",        
			data : { "cmt_idx" : cmt_idx, "role" : role }, 
			success : function(){  	
				loadCmtcmt(cmt_group, parent_idx); 		
			},      
			error : function(){ alert("댓글삭제기능 오류")}
		});
	};
	

	//대댓글전송
	function cmtCmtInsert(btn){	
		//<button class="btn btn-custom btn-sm" type="button" onclick="cmtCmtInsert(this)">대댓등록</button> 값이 넘어갔다
		// 1. 클릭된 버튼(btn)에서 가장 가까운 .cmtcmtForm을 찾아!
	    var form = $(btn).closest(".cmtcmtForm");
	    var fData = form.serialize();	    
	    var contentField = form.find("textarea[name='cmt_content']"); // name속성으로 찾는다
	    var cmt_idx = form.find("input[name='cmt_idx']").val(); // name속성으로 찾는다 
	    
	    if (contentField.val().trim() == "") {
	        alert("대댓글 내용이 입력되지 않았습니다");
	        contentField.focus(); // 커서도 깜빡임
	        return false;
	    }
	    
	    console.log("전송될 데이터: ", fData);
		$.ajax({
			url : "${cpath}/comment/cmtcmtInsert",
			type : "post",
			data : fData, 
			success : function(){ 
				form.find("textarea").val("");//중복이 될수 있으므로 class값으로 접근한다 
			
				getCmt_group(cmt_idx); //비동기방식으로 댓글리스트 가져오기 기능	
				getCmt_cmt_count(cmt_idx);
				//loadCmt();
			}, 
			error : function(){ alert("대댓글등록실패");}
		});
		//$("#fclear").trigger("click");
		//등록 후 폼을 초기 상태로 돌리기 위해 클릭 이벤트를 강제로 실행
	};//end cmtCmtInsert
	
	
	//댓글당 대댓글수를 나오게 하는 기능
	function getCmt_cmt_count(cmt_idx){
		var cmt_idx = cmt_idx;
		//alert("도착한 cmt_idx값: " + cmt_idx);
		
		$.ajax({
			url : "${cpath}/comment/getCmt_cmt_count",
			type : "get",
			data: {"cmt_idx": cmt_idx},
			dataType: 'json',
			success : function(data){ 			
				//alert("성공: "+ data);
				$("#cmt_cmt_count_btn_" + cmt_idx).text("대댓글 " + data);
			}, 
			error : function(){ alert("댓글당 대댓글수를 나오게 하는 기능 실패");}
		});
	};

	
	//대댓글 작성폼 나오게 하는 기능
	function cmtComment(cmt_idx){
		//toggle()은 대상의 보임/숨김 상태를 자동으로 반전시켜 주는 함수다
		var idx = cmt_idx;
		//alert("토글할 cmt_idx값: " + cmt_idx);
		getCmt_group(cmt_idx); //cmt_group가져오는 기능
		
		$("#cmt_" + cmt_idx).toggle(); //id="cmt_\${obj.cmt_idx}" 로 토글실행한다
	};
	
	//Cmt_group가져오는 기능
	function getCmt_group(cmt_idx) {	
		//alert("group에 넘어온 cmt_idx값: " + cmt_idx);
		
		$.ajax({
	        url: "${cpath}/comment/getCmt_group",    
	        type: "get",
	        data: {"cmt_idx": cmt_idx},
	        dataType: 'json',
	        success: function(cmt_group) {   
	        	//alert("group값 가져오기함수 성공! group값: " + cmt_group + " cmt_idx값: " + cmt_idx); 
	        	loadCmtcmt(cmt_group, cmt_idx);
	        	//cmt_groupCnt(cmt_group);
	        },
	        error: function() { 
	            alert("Cmt_group가져오기 실패"); 
	        }
	    });
	}
	
	
	//대댓글리스트 가져오는 기능 
	function loadCmtcmt(cmt_group, cmt_idx) {
		var idx = $("#regForm #idx").val();
		var cmt_group = cmt_group;
		//alert("대댓글리스트 가져오는 함수 idx값: " + idx + " group값: " + cmt_group);	
		
		 $.ajax({
		        url : "${cpath}/comment/loadCmtcmt", 
		        type: "get",
		        data : { "idx" : idx, "cmt_group" : cmt_group},
		        dataType: "json",
		        success: function(data) {       
		        	//alert("대댓글리스트 가져오기 성공: data: "+ data + "cmt_idx: "+ cmt_idx);	
		        	cmtCmtView(data, cmt_idx);
		        },
		        error: function() {         
		            alert("댓글로드 실패");
		        }
		 });
	}

	
	//대댓글 보이기
	function cmtCmtView(data, cmt_idx){   
		var listHtml = "";
		//alert("cmtcmtview 입성 cmt_idx값: " + cmt_idx);	
		
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
               
            listHtml += "<td style='text-align:center; vertical-align:middle; width:1px;'>"
            listHtml += "<img style='width:55px; height:55px;' class='rounded-circle' src='" + imgSrc + "' />";
            listHtml += "</td>";  
               
            listHtml += "<td class='writer' data-writer='" + obj.username + "' style='text-align:center; vertical-align:middle; width:100px;'>";
			listHtml += "<a href='#' class='writer-link'>" + obj.nick_name + "</a></td>";
    
			//삭제상태
			if (obj.cmt_available == 'ADMIN') {	//cmt_available == 'ADMIN' 경우
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
			
			//대댓글버튼(없음)
			//listHtml += "<td style='text-align:center; vertical-align:middle; width:70px;'>";	
			//listHtml += "</td>";
			
			//삭제된 게시물이면 삭제버튼 비활성화한다
			listHtml += "<td style='text-align:center; vertical-align:middle; width:70px;'>";					
			var username = "${user.member.username}"; //현재로그인된 username
			
			if (obj.cmt_available != 1) { 	//1이아니면 삭제된 표시상태								
				listHtml += "<button disabled type='button' class='btn btn-default btn-sm'>삭제완료</button>"; //대댓삭제					
			} else if (obj.cmt_available == 1 && (username == obj.username || "${user.member.role}" == "ADMIN")) {				
				listHtml += "<button type='button' class='btn btn-secondary btn-sm'"; 	
				//매개변수로 넘어온 cmt_idx는 부모idx값이고 obj.cmt_idx는 삭제할 idx값이다 
				listHtml += "onclick='cmtCmtDelete(" + obj.cmt_group + "," + obj.cmt_idx + "," + cmt_idx + ")'>삭제</button>"; //대댓삭제		
			} 
			listHtml += "</td>";
					
	
			listHtml += "</tr>";

		}); //end $.each()
		
		
		$("#cmtCmtView_" + cmt_idx).html(listHtml);
	};	
	
	
	

	//좋아요 기능 ----------------------------------------------------------------------------------------------------------------

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
					$("#likeBtn").text("♡ 좋아요").attr("onclick", "likePlus('"+idx+"')").attr("class","btn btn-sm btn-outline-danger");
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
		    $("#likeBtn").text("♡ 좋아요").attr("onclick", "unLike('"+idx+"')").attr("class", "btn btn-sm btn-danger");
		    //.removeClass() //기존의 모든 CSS 클래스를 삭제 하고 버튼속성을 교체한다
	        //.addClass("btn btn-danger btn-sm"); 
		}else{
			$("#likeBtn").text("♡ 좋아요").attr("onclick", "likePlus('"+idx+"')").attr("class","btn btn-sm btn-outline-danger");
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
	        url: "${cpath}/board/showLike_count",    
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
	
	
	
	//첨부된데이터삭제
	function delete_attached_data() {			
		$("#regForm").find("input[name='attached_data']").remove();
		alert("첨부된 데이터가 삭제되었습니다");
		
		//id="delete_attached_data_btn" 안에 button 태그에 접근한다
		//<input>태그의 경우는 .val()을 사용한다 
		$("#delete_attached_data_btn button").attr("class", "btn btn-sm btn-outline-dark").text("이미지 첨부파일 삭제 완료");
	}
	
	//첨부된데이터2삭제
	function delete_attached_data2() {			
		$("#regForm").find("input[name='attached_data2']").remove();
		alert("첨부된 데이터가 삭제되었습니다");
		
		//id="delete_attached_data_btn" 안에 button 태그에 접근한다
		//<input>태그의 경우는 .val()을 사용한다 
		$("#delete_attached_data_btn2 button").attr("class", "btn btn-sm btn-outline-dark").text("첨부파일 삭제 완료");
	}
	
	//첨부된데이터3삭제
	function delete_attached_data3() {			
		$("#regForm").find("input[name='attached_data3']").remove();
		alert("첨부된 데이터가 삭제되었습니다");

		$("#delete_attached_data_btn3 button").attr("class", "btn btn-sm btn-outline-dark").text("첨부파일2 삭제 완료");
	}
	
	//첨부파일추가하기 버튼
	function addUploadFile(){
		$("#uploadFile3").toggle();
		
		var btnText = $("#addUploadFile_btn").text().trim(); // trim()으로 앞뒤 공백 제거

		if (btnText === "첨부파일 추가") {
		    $("#addUploadFile_btn").text("첨부파일 접기");
		} else {
		    $("#addUploadFile_btn").text("첨부파일 추가");
		}
		
	}



	
  </script>

</body>
</html>

