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
    text-align: center;   /* 가로 중앙 */
    line-height: 40px;    /* 세로 중앙 (height와 같은 값) */
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
    		<div class= "col-lg-10">
    			<div class="card" style="min-height: 500px; max-height: 1000px;">
    				<div class="card-body">
    					<br>
    					
    				
	    				<!-- 검색옵션/키워드 -->
						<div class="container">
							<div class="form-inline justify-content-center"> 
								<!-- 검색옵션 -->
								<div class="form-group">
									<select name="type" class="form-control">
										<option value="nick_name">닉네임</option>
										<option value="username" >아이디</option> 
										<option value="name">이름</option>
									</select>
								</div>
								&nbsp;
								<!-- 검색키워드 -->	
								<div class="form-group">
									<input type="text" class="form-control" name="keyword">
								</div>
								&nbsp;
								<button type="button" onclick="search()" class="btn btn-custom">검색</button>	
								&nbsp;&nbsp;
								<form action="${cpath}/member/adminPage">
									<button type="submit" class="btn btn-outline-dark">새로고침</button>
								</form>								
							</div>
						</div>					
						<br>
						<p style="text-align: center">※ 전체 회원 리스트를 보시려면 [새로고침] 버튼을 눌러주세요</p>

    					<br>
    					<table class="table table-bordered table-hover">
    						<thead class="table-cnt">
    							<th style="width: 5%;">번호</th>
    							<th style="width: 9%;">아이디</th>
    							<th style="width: 7%;">회원번호</th>
    							<th style="width: 7%;">이름</th>
    							<th style="width: 10%;">닉네임</th>
    							<th style="width: 7%;">탈퇴여부</th>
    							<th style="width: 9%;">권한</th>						
    							<th style="width: 15%;">권한 수정</th>
    							<th style="width: 7%;">교육과정</th>						
    							<th style="width: 17%;">교육과정 수정</th>
    							<th style="width: 7%;"></th>
    						</thead>
    						<tbody id="view">
    							<!-- 비동기 방식으로 가져온 회원정보테이블 나오게할 부분-->
    						</tbody>					
    					</table>
    					<br>
    					
    					<!-- 페이지네이션 -->
    					<div id="paginationBtn" class="container" >
    						<!-- 비동기 방식으로 페이지네이션 나오게할 부분-->
    					</div>

    				</div>
    			</div>
    		</div>		
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
  
  <!-- 회원가입 실패시 띄워줄 모달창 -->
  <div class="modal fade" id="myMessage">
    <div class="modal-dialog">
      <div id="messageType" class="modal-content">
      
        <div class="modal-header">
          <h4 id="msgType" class="modal-title"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <div class="modal-body">
          <p id="msg" style="white-space: pre-line;"></p> 
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-outline-dark" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
 
  
  <script type="text/javascript">
  	$(document).ready(function(){
  		loadMemberList(); //가입한 회원리스트		
  	});//end ready
  	
  	
  	//가입한 회원조회
	function loadMemberList() {	
		$.ajax({
			url : "${cpath}/member/memberList",    
			type: "get",  
			dataType : "json",
			success: function(data){ 
				makeView(data.list); //가입한회원정보	
				makePagination(data.pageMaker);//페이지네이션정보
			},   
			error: function(){ alert("회원권한조회실패"); }
		});
	}
  
  	
	//가입한회원정보 테이블로 나타내기	
	function makeView(data){		
		var listHtml = "";

		$.each(data, function(index, obj){ //index:순서 표시자
			listHtml += "<tr>";
			listHtml += "<td class='table-cnt'>" + (index+1) + "</td>";		
			listHtml += "<td class='table-cnt'>" + obj.username + "</td>";
			listHtml += "<td class='table-cnt'>" + obj.user_code + "</td>";
			listHtml += "<td class='table-cnt'>" + obj.name + "</td>";
			listHtml += "<td class='table-cnt'>" + obj.nick_name + "</td>";		
			
			listHtml += `<td class="table-cnt">
			   				 \${obj.enabled ? '이용 중' : '탈퇴'} 
			             </td>`;	
			             
			listHtml += "<td class='table-cnt'>" + obj.role + "</td>";
			listHtml += "<td>";
			listHtml += "  <select id='role_" + obj.username + "' class='form-control'>";
			// 각 옵션들을 추가하고, 현재 권한과 일치하면 selected 속성 부여한다
			listHtml += "<option value='INSTRUCTOR' " 
			         + (obj.role === 'INSTRUCTOR' ? "selected style='color:blue;font-weight:bold;'" : '') 
			         + ">INSTRUCTOR (강사)</option>";		
			listHtml += "<option value='STUDENT' " 
			         + (obj.role === 'STUDENT' ? "selected style='color:blue;font-weight:bold;'" : '')  
			         + ">STUDENT (수강생)</option>";		
			listHtml += "<option value='GUEST' " 
			         + (obj.role === 'GUEST' ? "selected style='color:blue;font-weight:bold;'" : '')
			         + ">GUEST (승인대기)</option>";	         
	         listHtml += "<option value='PENALTY' " 
			         + (obj.role === 'PENALTY' ? "selected style='color:blue;font-weight:bold;'" : '')
			         + ">PENALTY (이용제한)</option>";         
			listHtml += "  </select>";
			listHtml += "</td>";
			
			listHtml += "<td class='table-cnt'>" + obj.cource + "</td>";		
			listHtml += "<td>";
			listHtml += "  <select id='cource_" + obj.username + "' class='form-control'>";
			listHtml += "<option value='BACK' " 
			         + (obj.cource === 'BACK' ? "selected style='color:blue;font-weight:bold;'" : '') 
			         + ">BACK (백엔드)</option>";		
	        listHtml += "<option value='FRONT' " 
		             + (obj.cource === 'FRONT' ? "selected style='color:blue;font-weight:bold;'" : '') 
		             + ">FRONT (프론트엔드)</option>";		
            listHtml += "<option value='DESIGN' " 
		             + (obj.cource === 'DESIGN' ? "selected style='color:blue;font-weight:bold;'" : '') 
		             + ">DESIGN (UX/UI 디자인)</option>";		         
            listHtml += "<option value='DATA' " 
		             + (obj.cource === 'DATA' ? "selected style='color:blue;font-weight:bold;'" : '') 
		             + ">DATA (데이터분석)</option>";        
			listHtml += "  </select>";
			listHtml += "</td>";
	
			listHtml += "<td class='table-cnt'>";		
			listHtml += "<button type='button' class='btn btn-custom' "			
					 + "onclick=\"roleCourceUpdate('" + obj.username + "')\">변경</button>";			 
			listHtml += "</td>";			
			listHtml += "</tr>";	
		});		
		$("#view").html(listHtml);		
	}
	

	//권한/교육과정 수정기능
	function roleCourceUpdate(username){		
		var role = $("#role_" + username).val();
		var cource = $("#cource_" + username).val();
		
		var page = $("#page").val();
	
		$.ajax({
			url : "${cpath}/member/roleCourceUpdate",   
			type : "post",
			data : { "username" : username , "role" : role, "cource" : cource },
			success : function(){			
				//alert(member.username + "님 회원정보가 변경되었습니다");			
				$("#messageType").find(".modal-header").attr("class", "modal-header bg-primary text-white");				
				$("#msgType").text("성공메세지");
				$("#msg").text("회원정보가 변경되었습니다");
				
				$("#myMessageOpenModal").click();
				
				pageMove(page);
				
			},
			error : function(){ alert("error") }
		});
	}
	
	
	//페이지네이션기능
	function makePagination(pageMaker) { 
	    let str = ""; 
	    str += "<ul class='pagination justify-content-center'>";
	    //이전버튼
	    if(pageMaker.prev){
	    	str += `<li class="page-item"><a class="page-link" href="javascript:pageMove(\${pageMaker.startPage - 1})">Previous</a></li>`;
	    }
	    
	    //페이징버튼
	    for (var i = pageMaker.startPage; i <= pageMaker.endPage; i++) {          
	    	//현재페이지값과 i값이 같으면 active 변수에 active 값을 입력한다
	        let active = (pageMaker.cri.page == i) ? "active" : "";
	        // href에 직접 숫자를 넣는 대신 pageMove 함수 호출한다
	        str += `<li class="page-item \${active}"><a class="page-link" href="javascript:pageMove(\${i})">\${i}</a></li>`;
    	}
	    
	 	 //다음버튼
	    if(pageMaker.next){
	    	str += `<li class="page-item"><a class="page-link" href="javascript:pageMove(\${pageMaker.endPage + 1})">Next</a></li>`;
	    }
	    
	    str += "</ul>";    
	    str += `
	      <form id="pageFrm">
            <input type="hidden" id="page" name="page" value="\${pageMaker.cri.page}">
            <input type="hidden" id="perPageNum" name="perPageNum" value="\${pageMaker.cri.perPageNum}">
          </form>`;
	    $("#paginationBtn").html(str);
	}
		
	
	//페이지 버튼클릿시 페이지 이동하는 기능
	function pageMove(page) {
	    // 변경된 현재페이지 번호값을 넣는다
	    $("#page").val(page);
	    
	    let type = $("select[name='type']").val();
	    let keyword = $("input[name='keyword']").val();

	    var page = $("#page").val();
	    var perPageNum = $("#perPageNum").val();

	    
	    // 비동기(AJAX) 방식이라면 폼 제출 대신 다시 loadMemberList를 다시 호출한다
	    // 만약 동기 방식(페이지 새로고침)을 원하면 $("#pageFrm").submit();
	    //var formData = $("#pageFrm").serialize(); // page=2&perPageNum=10 형태 생성

 
	    $.ajax({
	        url : "${cpath}/member/memberList",   
	        type: "get",  
	        data: { "page" : page , "perPageNum" : perPageNum, "type" : type , "keyword" : keyword}, // 파라미터 전달
	        dataType : "json",
	        success: function(data){ 
	            makeView(data.list); //회원테이블로드
	            makePagination(data.pageMaker); //페이지네이션
	        },
	        error : function(){alert("페이지 이동 error")}
	    });
	}
	
	
	
	//페이지 버튼클릿시 페이지 이동하는 기능
	function search() {
		
	    let type = $("select[name='type']").val();
	    let keyword = $("input[name='keyword']").val();
	    
	    $.ajax({
			url : "${cpath}/member/memberList",    
			type: "get",  
			data: { "type" : type , "keyword" : keyword},
			dataType : "json",
			success: function(data){ 
				makeView(data.list); //가입한회원정보	
				makePagination(data.pageMaker);//페이지네이션정보
				
			},   
			error: function(){ alert("회원검색실패"); }
		});
	    
	}
	
	
		
		
		
  </script>

</body>
</html>

