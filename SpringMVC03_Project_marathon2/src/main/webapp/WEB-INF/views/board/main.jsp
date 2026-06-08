<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 현재 웹 애플리케이션의 루트 경로를 가져와서 cpath라는 이름의 변수에 저장 -->
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>2026 SEOUL MARATHON</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	
<link rel="stylesheet" href="${cpath}/resources/css/btnStyle.css">
</head>
<body> 
	<div class="container">
	
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		
		<div class="panel panel-default">
			<div class="panel-heading">Notice</div>
			<div class="panel-body">
				<table id="boardList" class="table table-bordered table-hover"> 
					<tr class="active">
						<td>번호</td>
						<td>제목</td>
						<td>작성자</td>
						<td>작성일</td>
						<td>조회수</td>
					</tr>
					<tbody id="view">
					<!-- 비동기 방식으로 가져온 게시글 나오게할 부분-->			
					</tbody>
					
					<!-- 로그인 했을때만 글쓰기 버튼이 보이게 한다(session에 mvo가 있으면 로그인한 상태) -->
					<c:if test="${not empty mvo}"> 
						<tr>
							<td colspan="5"> <!-- colspan="5": 5개의 열을 합쳐서 한 줄에 걸쳐 표시 -->
								<button onclick="goForm()" class="btn btn-custom btn-sm">글쓰기</button>
							</td>
						</tr>		
					</c:if>
				</table>		
				
				 
				
	
			</div><!--end panel-body -->
			
			<!-- 글쓰기 폼 -->
			<div class="panel-body" id="wform" style="display: none"> <!-- style="display: none":안보이게 한다 -->
				<form id="frm" method="post" enctype="multipart/form-data"> <!-- form 태그에 id를 지정하면, 내부 input 태그들의 값을 한 번에 가져올 수 있음 -->
				<input type="hidden" name="memID" value="${mvo.memID}"> <!-- 로그인한 사용자의 ID를 가져온다 -->			
				<table class="table">
					<tr>
						<td>제목</td>
						<td><input type="text" name="title" class="form-control"></td> <!--*name의 값과 Board에 있는 필드명이 같아야 한다-->
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea name="content" rows="7" cols="" class="form-control"></textarea></td>
					</tr>
					
					<tr>
						<td>첨부파일</td>
						<td><input type="file" id="attached" name="attached" accept="image/*" class="form-control"></td>
					</tr>
					
					<tr>
						<td>작성자</td>
						<td><input readonly="readonly" type="text" value="${mvo.memName}" name="writer" class="form-control"></td>
					</tr>
					<tr>
					<td colspan="2" align="center"> 
						<button class="btn btn-success btn-sm" type="button" onclick="goInsert()">등록</button>
						<button class="btn btn-default btn-sm" type="reset" id="fclear">취소</button>
						<button onclick="goList()" class="btn btn-info btn-sm">목록</button> <!--onclick 함수를 통해 goList() 함수실행-->
					</td>
					</tr>
				</table>
				</form>
			</div> <!-- end 글쓰기폼 -->
			
			
			<!-- 페이징 -->
			<div id="pagination" style="text-align: center">			
			  <ul class="pagination">
			  	
			  	<!-- 이전버튼처리 -->
			  	<c:if test="${pageMaker.prev}">
			  		<li class="paginate_button previous">
			  			<a href="${pageMaker.startPage - 1}">◀</a>
			  		</li>
			  	</c:if>
			  	
			  	<!-- 이전버튼처리(페이지용) -->
			  	<c:if test="${pageMaker.prevPage}">
			  		<li class="paginate_button previous">
			  			<a href="${pageMaker.cri.page - 1}">◁</a>
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
			    
			    
			    <!-- 다음버튼(페이지용) -->
			  	<c:if test="${pageMaker.nextPage}">
			  		<li class="paginate_button previous">
			  			<a href="${pageMaker.cri.page + 1}">▷</a>
			  		</li>
			  	</c:if>				  			 
			  			  				  		    
			    <!-- 다음버튼처리 -->
			  	<c:if test="${pageMaker.next}">
			  		<li class="paginate_button previous">
			  			<a href="${pageMaker.endPage + 1}">▶</a>
			  		</li>
			  	</c:if>				  				  		    
			  </ul>
			  
			  <!-- 페이지 버튼을 클릭했을 때 페이지 이동을 처리하기 위한 숨겨진(form) 전송용 폼 -->
			  <form action="board/all" id="pageFrm">
			  	<input type="hidden" id="page" name="page" value="${pageMaker.cri.page}">
			  	<input type="hidden" id="perPageNum" name="perPageNum" value="${pageMaker.cri.perPageNum}">	
			  	
			  	<!-- type과 keyword를 넘기기위한 부분 추가하면 결과값(type, keyword)이 유지된다 -->
			  	<input type="hidden" id="type" name="type" value="${pageMaker.cri.type}">
			  	<input type="hidden" id="keyword" name="keyword" value="${pageMaker.cri.keyword}">			  			  	
			  </form>
			 
			</div><!--end 페이징 -->	
			
			
			<div class="panel-footer">2026 HANKUK MARATHON - All rights reserved</div>
		</div>
	</div>
	
	<script type="text/javascript">
	
		$(document).ready(function(){ 
			//HTML 요소들이 다 로딩되고나서 아래 loadList() 실행하겠다는 의미
			loadList();
			attachedName();
		});
	
		//비동기방식으로 게시글 리스트 가져오기 기능
		function loadList() {
			//ajax 안에는 - 요청 url, 어떻게 데이터 받을지, 요청방식 등 ... → 객체형태로 넣어주면 된다 
			$.ajax({
				url : "board/all",    //이 주소로 비동기 요청을 보낸다, "boardList.do" → "board/all",
				type: "get",          
				dataType: "json",     //서버로부터 돌려받을 데이터 타입
				success: makeView,    //콜백함수:다른 함수의 인자로 전달되어, 특정 작업이 끝난 후 호출되는 함수
				error: function(){ 
					alert("error"); 
				}
			});
		}
		
		//서버로부터 비동기방식통신을 하고 성공했을때 작동하는 함수, 게시글의 정보를 받아온다
		function makeView(data){
			var listHtml = "";
			
			//jQuary반목문
			$.each(data, function(index, obj){ //index:순서 표시자
				listHtml += "<tr>";
				listHtml += "<td>" + (index+1) + "</td>";
				listHtml += "<td id='t" + obj.idx + "'>";  //제목
				listHtml += "<a href='javascript:goContent(" + obj.idx + ")'>"; //a 태그 클릭 시 JS 메서드를 호출하며 idx 값을 전달해 해당 게시글을 표시 
				listHtml += obj.title;
				listHtml += "</a>";
				listHtml += "</td>";
				listHtml += "<td id='w" + obj.idx + "'>" + obj.writer + "</td>"; //작성자
				listHtml += "<td>" + obj.indate + "</td>";
				listHtml += "<td>" + obj.count + "</td>";
				listHtml += "</tr>";
				
				//상세보기 화면
				listHtml += "<tr id='c" + obj.idx + "' style='display : none'>"; //display : none 으로 안보이게한다
				//게시글별 상세 내용을 구분할 수 있도록 게시글 번호를 포함한 id를 생성
				listHtml += "<td>내용</td>";
				listHtml += "<td colspan='4'>";
				//이미지
				if (obj.attached && obj.attached !== "") {			    	
				    listHtml += "<img id='img"+ obj.idx + "'src='${cpath}/board_upload/" + obj.attached + "' style='max-width: 50%; margin-top: 0px !important; margin-bottom: 10px !important;'>";
				}
				
				listHtml += "<textarea id='ta" + obj.idx + "' readonly rows='4' class='form-control'>"; //본문
				listHtml += obj.content;
				listHtml += "</textarea>";
				
				//첨부파일삭제버튼
				if(obj.attached != ""){		
					listHtml += `<button id="attachedDeleteBtn\${obj.idx}" type="button" class="btn btn-sm btn-default" onclick="deleteAttached(\${obj.idx})" style="display: none; margin-top: 5px; margin-bottom: 10px;">\${obj.attached}</button>`;
				}
				
				//첨부파일기능
				listHtml += "<input type='file' id='attached" + obj.idx + "' name='attached' accept='image/*' class='form-control' style='display: none;'><br>";

				if("${mvo.memID}" == obj.memID){
					listHtml += "<span id='ub" + obj.idx + "'>";
					listHtml += "<button onclick='goUpdateForm(" + obj.idx + ", \"" + obj.attached + "\")' class='btn btn-sm btn-custom'>수정화면</button></span> &nbsp;"; 
					listHtml += "<button id='deleteBtn"+ obj.idx +"' onclick='goDelete(" + obj.idx + ")' class='btn btn-sm btn-default'>삭제</button>";
					listHtml += "<button id='reloadBtn"+ obj.idx +"' onclick='loadList()' class='btn btn-sm btn-default' style='display: none;'>취소</button>";
					
				}
				
				listHtml += "</td>"; //상세보기와 같은 칸 사용
				
				listHtml += "</tr>";
			});
			
			$("#view").html(listHtml);	
			
			//goList();
		}
		

		//'글쓰기'버튼
		function goForm(){
			$("#boardList").css("display", "none"); //.css: css를 바꿀때
			$("#pagination").css("display", "none");  
			$("#wform").css("display", "block"); 
		}
		
		//'목록'버튼
		function goList(){
			$("#boardList").css("display", "block"); 
			$("#wform").css("display", "none"); 
		}
		
		//게시글 등록버튼
		function goInsert(){
			//3개값을 직렬화형태로 가져온다 //title="이건제목"&content="이건내용"&writer="이건작성자"
			var formData = new FormData($("#frm")[0]);
			alert(formData.get("title"));
			alert(formData.get("content"));
			alert(formData.get("attached"));
			
			
			$.ajax({
				url : "board/new",
				type : "post",
				data : formData, 
				processData: false, // jQuery가 데이터를 가공(문자열 화)하지 않도록 설정
		        contentType: false,
				success : function(){ 
					alert("성공");
					
					loadList(); 
					goList();
				}, 
				error : function(){ alert("등록error")}
			});
			$("#fclear").trigger("click");
		}
		
		
		//게시글 조회
		function goContent(idx){
			if($("#c" + idx).css("display") == "none"){ // 선택한 요소의 display 속성 값을 확인하여, 'none'이면 조건 실행
				$.ajax({
					url: "board/" + idx,
					type: "get",
					dataType: "json",
					success : function(data) {
						$("#ta" + idx).val(data.content); //게시글 번호 idx에 해당하는 <textarea>에 서버에서 받아온 content 내용을 넣어라
						attachedName(idx);
					},
					error : function() { alert("error");}
				});
				
				$("#c" + idx).css("display", "table-row"); 
				
			}else{
				$("#c" + idx).css("display", "none"); 
				$.ajax({
					url:"board/count/" + idx, //PathVariable방식: 경로 뒤에 붙여서 값 전달방식으로 보냈으므로 data는 필요없음
					type: "put",
					success : loadList,
					error: function() { alert("error"); }
				});
			}
		}
		
		//삭제버튼
		function goDelete(idx){
			//비동기방식 - 게시글 등록기능 	
			$.ajax({
				url : "board/" + idx, // @DeleteMapping("/{idx}")
				type : "delete",      //delete방식으로 요청해야지 삭제된다(외부에서 삭제 불가능하다)
				data : { "idx" : idx },  //보낼 데이터는 JSON 형태로 보낸다
				success : loadList,      //게시글정보 불러오기
				error : function(){ alert("error")}
			});
		}
		
		//수정화면
		function goUpdateForm(idx, attached){
			//내용 
			//textarea는 불러올때부터 수정된 데이터 idx가 있다 
			$("#ta" + idx).attr("readonly", false); //attr은 attribute 의미: HTML 요소의 속성을 읽거나 변경할 때 사용,readonly를 false로 변경하였음
			
			//제목
			var title = $("#t"+ idx).text();//html하면 기존의 제목값이 사라지므로 기존의 제목 값을 가져올것이다
			var newTitle = "<input id='nt" +idx+ "' value='" +title+ "' type='text' class='form-control'>";		
			 //값을 가져오기 위해서 id값을 줘야한다, 매개변수로 넘어온 idx를 사용한다
			$("#t" + idx).html(newTitle); //html하면 기존의 제목값이 사라진다
			
			
			//작성자 
			//var writer = $("#w"+ idx).text();
			//var newWriter = "<input id='nw" + idx + "' value='" + writer + "' type='text' class='form-control' disabled>";
			//$("#w" + idx).html(newWriter);

			//첨부된 이미지 숨겨진다
			$("#img"+ idx).hide(); 
			
			
			
			if (attached && attached !== "null" && attached !== "undefined" && attached !== "") {
		        $("#attachedDeleteBtn" + idx).show(); // 기존파일 삭제 버튼 등장!
		        $("#attached" + idx).hide();          // 새 파일 창은 대기
		    } else {
		        $("#attachedDeleteBtn" + idx).hide(); // 삭제 버튼 숨김
		        $("#attached" + idx).show();          // 바로 새 파일 등록 창 등장!
		    }
			
			//버튼 수정화면 → 수정으로 변경, 수정하기기능
			var newBtn = "<button onclick='goUpdate(" + idx + ")' class='btn btn-custom btn-sm'>수정하기</button>";
			$("#ub" + idx).html(newBtn);
			
			$("#reloadBtn"+ idx).show();
			$("#deleteBtn"+ idx).hide();
			
		}
		
		//수정하기
		function goUpdate(idx) { 		    
		    var formData = new FormData();

		    formData.append("idx", idx);
		    formData.append("title", $("#nt" + idx).val());
		    formData.append("content", $("#ta" + idx).val());  	   
		    
		    // 3. ⭐ 새롭게 선택된 파일 데이터를 가져와서 FormData에 주입
		    // 파일 선택창 뒤에 idx 붙인 아이디에서 진짜 파일([0].files[0])을 꺼내옴
		    var fileInput = $("#attached" + idx)[0];
		    if (fileInput && fileInput.files.length > 0) {
		        formData.append("attached", fileInput.files[0]);
		    }
		    
		    $.ajax({
		        // 404 방지를 위해 앞에 ${contextPath} 붙이는 게 안전해!
		        url : "board/update",
		        type : "post", 
		        data : formData, 
		        
		        // ⭐ FormData(파일) 전송을 위한 필수 옵션 2가지 설정!
		        processData : false, 
		        contentType : false, 
		        
		        success : function(){ 
		            alert("수정기능성공");
		            loadList();
		        }, 
		        error : function(){ 
		            alert("수정기능실패");
		        }
		    });
		}
		
		//첨부파일 삭제기능
		function deleteAttached(idx){		
			
			$("#attached" + idx).show();	
			alert("첨부된 파일 삭제되었습니다");		
			$("#attachedDeleteBtn"+idx).hide();
		}
		
		//첨부파일명 조정하기
		function attachedName(idx){	
			var attached_data = $("#attachedDeleteBtn" + idx).text();
		
			if (attached_data.includes("_")) { 
				new_attached_data = attached_data.substring(attached_data.indexOf("_") + 1);
  			}
			
			$("#attachedDeleteBtn" + idx).text("첨부파일 삭제하기( " + new_attached_data + " )");
		}

	</script>
</body>
</html>





