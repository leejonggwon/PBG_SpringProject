<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>2026 HANKUK MARATHON</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/css/btnStyle.css">

<style>
/* 1. 게시글 제목 링크를 누를 때 검은 테두리 제거 */
	#view a:focus,
	#view a:active,
	#view a:hover {
		outline: none !important;
		text-decoration: none; /* 누를 때 밑줄 생기는 것도 방지 */
	}

	/* 2. 하단 페이징 번호(◀ 1 2 ▶)를 누를 때 검은 테두리 제거 */
	.pagination > li > a:focus,
	.pagination > li > a:active {
		outline: none !important;
		box-shadow: none !important;
	}

	/* 3. 닫기, 수정화면, 삭제 등 모든 버튼을 누를 때 검은 테두리 제거 */
	.btn:focus,
	.btn:active,
	.btn:focus:active {
		outline: none !important;
		box-shadow: none !important;
	}
</style>
</head>

<body> 
	<div class="container">
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include> <!--공통헤더-->	
	
		<div class="panel panel-default">
			<div class="panel-heading">공지사항</div>
			<div class="panel-body">
				<table id="boardList" class="table table-bordered table-hover" style="table-layout: fixed; width: 100%;">
					<tr class="active">
						<th style="width: 8%; text-align: center;">번호</th>
					    <th style="width: 50%; text-align: center;">제목</th>
					    <th style="width: 15%; text-align: center;">작성자</th>
					    <th style="width: 17%; text-align: center;">작성일</th>
					    <th style="width: 10%; text-align: center;">조회수</th>
					</tr>
					<tbody id="view">
						<!--리스트-->
					</tbody>
					
					<!--로그인상태--> 
					<c:if test="${not empty mvo}">
						<tr>
							<td colspan="5">
								<button onclick="goForm()" class="btn btn-custom btn-sm">글쓰기</button>
							</td>
						</tr>		
					</c:if>
				</table>
						
				<!-- 페이징기능 -->
				<div style="text-align: center">			
				  <ul class="pagination">
				  	<!--페이지내용 -->
				   </ul>
				  
				  <form id="pageFrm">
				  	<input type="hidden" id="page" name="page" value="${pageMaker.cri.page != null ? pageMaker.cri.page : 1}">
				  	<input type="hidden" id="perPageNum" name="perPageNum" value="${pageMaker.cri.perPageNum != null ? pageMaker.cri.perPageNum : 10}">			 	
				  </form>
				</div><!--end 페이징기능-->
				
			</div><!--end panel-body -->
			
			<!--글쓰기폼-->
			<div class="panel-body" id="wform" style="display: none">
				<form id="frm" method="post" enctype="multipart/form-data">
					<input type="hidden" name="memID" value="${mvo.memID}">			
					
					<table class="table">
						<tr>
							<td style="text-align: center; width: 120px;">제목</td>
							<td><input type="text" name="title" class="form-control"></td>
						</tr>
						<tr>
							<td style="text-align: center">내용</td>
							<td><textarea name="content" rows="7" class="form-control"></textarea></td>
						</tr>
						<tr>
							<td style="text-align: center">첨부파일</td>
							<td><input type="file" id="uploadFile_img" name="attached" accept="image/*" class="form-control"></td>
						</tr>
						<tr>
							<td style="text-align: center">작성자</td>
							<td><input readonly="readonly" type="text" value="${mvo.memName}" name="writer" class="form-control"></td>
						</tr>
						<tr>
						<td colspan="2" align="center"> 
							<button class="btn btn-custom btn-sm" type="button" onclick="goInsert()">등록</button>
							<button class="btn btn-default btn-sm" type="reset" id="fclear">취소</button>
							<button type="button" onclick="goList()" class="btn btn-default btn-sm">목록</button>
						</td>
						</tr>
					</table>
				</form>
			</div><!--end 글쓰기폼-->
			
			<!--공통바텀 -->
			<jsp:include page="/WEB-INF/views/common/bottom.jsp"></jsp:include> 
		</div>
	</div><!--end container -->
	
	
	<!-- 모달 -->
	<div class="modal fade" id="myMessage" role="dialog">
	  <div class="modal-dialog"> 
	    <div id="messageType" class="modal-content">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title" id="modalTitle"></h4> 
	      </div>
	      <div class="modal-body">
	        <p id="modalBody"></p> 
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
   
	<script type="text/javascript">
		$(document).ready(function(){ 
			
			$(document).on("click", ".paginate_button a", function(e){
				e.preventDefault(); 
				var page = $(this).attr("href");
				
				$("#page").val(page); 
				
				loadList(); 
			});

			loadList();
		});
	
		//게시글 리스트 가져오기 기능
		function loadList() {
			var page = $("#page").val();
			var perPageNum = $("#perPageNum").val();

			if (!page) page = 1;
			if (!perPageNum) perPageNum = 10;

			$.ajax({
				url : "board/all",    
				type: "get",          
				data: { "page": page, "perPageNum": perPageNum },
				dataType: "json",     
				success: makeView,    
				error: function(){ 
					alert("게시글리스트 로드 실패"); 
				}
			});
		}
		
		// 게시글 목록 출력 및 페이징 연동
		function makeView(data){
			var listHtml = "";
			
			// data.list 게시글 목록 들어있음
			$.each(data.list, function(index, obj){ 
				listHtml += "<tr>";
				listHtml += `<td style='text-align:center'>\${data.pageMaker.totalCount - ((data.pageMaker.cri.page - 1) * data.pageMaker.cri.perPageNum + index)}</td>`;
				
				//제목:t
				listHtml += "<td id='t" + obj.idx + "'>";  
				listHtml += "<a href='javascript:goContent(" + obj.idx + ")'>" + obj.title + "</a>";
				listHtml += "</td>";
				
				//작성자:w
				listHtml += "<td style='text-align: center' id='w" + obj.idx + "'>" + obj.writer + "</td>"; 
				
				//작성일
				var formattedDate = obj.indate.substring(0, 16); 
				listHtml += `<td style='text-align: center'>\${formattedDate}</td>`;
				
				//작성자:count
				listHtml += "<td style='text-align: center' id='count" + obj.idx + "'>" + obj.count + "</td>";
				listHtml += "</tr>";
				
				// 내용 상세보기 영역: c
				listHtml += "<tr id='c" + obj.idx + "' style='display : none'>"; 
				listHtml += "<td style='text-align: center'>내용</td>";
				listHtml += "<td colspan='4'>";
				
				
				var currentAttached = obj.attached ? obj.attached : "";
				listHtml += "<input type='hidden' name='originAttached' id='originAttached" + obj.idx + "' value='" + currentAttached + "'>";
				
			
				//이미지
				if (obj.attached && obj.attached !== "") {               
				    listHtml += "<img id='img"+ obj.idx + "' src='${contextPath}/board_upload/" + obj.attached + "' style='max-width: 50%; margin-bottom: 10px !important;'>";
				}
				
				//본문:ta
				listHtml += "<textarea id='ta" + obj.idx + "' readonly rows='8' class='form-control' style='margin-top: 5px; margin-bottom: 5px;'></textarea>";
				
				//첨부파일 삭제버튼
				if(obj.attached && obj.attached != ""){     
					listHtml += "<button id='attachedDeleteBtn" + obj.idx + "' type='button' class='btn btn-sm btn-default' onclick='deleteAttached(" + obj.idx + ")' style='display: none; margin-top: 5px; margin-bottom: 10px;'>" + obj.attached + "</button>";
				}
				
				//첨부파일 //fileInput.files[0])로 저장된다
				listHtml += "<input type='file' id='attached" + obj.idx + "' accept='image/*' class='form-control' style='display: none;'><br>";
		
				//계정아이디와 게시글작성자 같은경우
				if("${mvo.memID}" === obj.memID){
					//'수정화면'버튼 ub
					listHtml += "<span id='ub" + obj.idx + "'>";
					
					//'수정화면'버튼 idx와 attached 넘긴다
					listHtml += "<button onclick='goUpdateForm(" + obj.idx + ", \"" + obj.attached + "\")' class='btn btn-sm btn-custom' style='margin-right: 5px;'>수정화면</button>"; 
					listHtml += "</span>";
					//'삭제'버튼
					listHtml += "<button id='deleteBtn" + obj.idx + "' onclick='goDelete(" + obj.idx + ")' class='btn btn-sm btn-default' style='margin-right: 5px;'>삭제</button>"; 					
					//'수정취소'버튼
					listHtml += "<button id='reloadBtn"+ obj.idx +"' onclick='loadList()' class='btn btn-sm btn-default' style='display: none;'>수정취소</button>";
				}
				
				//닫기버튼
				listHtml += "<button id='closeBtn"+ obj.idx +"' onclick='goContent(" + obj.idx + ")' class='btn btn-sm btn-default'>닫기</button>"; 
				 
				listHtml += "</td></tr>";
			});
			
			$("#view").html(listHtml);   
			
			// 하단 페이징 버튼
			makePagination(data.pageMaker);
		}//end makeView
		
		
		
		// 페이징 버튼을 자바스크립트로 동적 갱신하는 함수
		function makePagination(pageMaker) {
			if(!pageMaker) return;
			
			var pageHtml = "";
			
			// 1. 이전 페이지 세트 (◀)
			if(pageMaker.prev) {
				pageHtml += "<li class='paginate_button'><a href='" + (pageMaker.startPage - 1) + "'>◀</a></li>";
			}
			
			// 2. 숫 버튼 반복 처리
			for(var i = pageMaker.startPage; i <= pageMaker.endPage; i++) {
				if(pageMaker.cri.page == i) {
					pageHtml += "<li class='paginate_button active'><a href='" + i + "'>" + i + "</a></li>";
				} else {
					pageHtml += "<li class='paginate_button'><a href='" + i + "'>" + i + "</a></li>";
				}
			}
			
			// 3. 다음 페이지 세트 (▶)
			if(pageMaker.next) {
				pageHtml += "<li class='paginate_button'><a href='" + (pageMaker.endPage + 1) + "'>▶</a></li>";
			}
			
			$(".pagination").html(pageHtml);
		}

		//글쓰기 버튼
		function goForm(){
			$("#boardList").hide();//테이블폼
			$("#wform").show(); //글쓰기폼 페이지보이기
			$(".pagination").hide();
		}
		
		//목록
		function goList(){
			$("#boardList").css("display", ""); //"block" → "" :빈칸을 줌으로서 속성 자체를 제거해 버린다
			$("#wform").css("display", "none"); 
		}
		
		//등록하기 
		function goInsert(){
			var formData = new FormData($("#frm")[0]);
			
			var file = $("#uploadFile_img")[0].files[0];
			
			if (file) {         
			        if (!file.type.startsWith("image/")) {
			            alert("'이미지첨부'는 이미지 파일만 등록할 수 있습니다");
			            $("#uploadFile_img").val(""); 
			            return false; 
			        }
			    }
			
			$.ajax({
				url : "board/new",
				type : "post",
				data : formData, 
				processData: false, 
		        contentType: false,
				success : function(data){ 					
					if(data === "success") {	               
		                $("#messageType").attr("class", "modal-content panel-primary");	               
		                $("#modalTitle").text("성공메세지");	                
		                $("#modalBody").text("게시글 등록이 등록되었습니다");
				    }
					
		        	$("#myMessage").modal("show");
		        	
					loadList(); //게시글 가져오는 기능
					goList(); //게시판보기 기능
				}, 
				error : function(){ alert("등록 실패")}
			});
			$("#fclear").trigger("click");
		}
		
		
		//게시글 상세보기
		function goContent(idx){
			if($("#c" + idx).css("display") == "none"){ 
				$.ajax({
					url: "board/" + idx,
					type: "get",
					dataType: "json",
					success : function(data) {
						$("#ta" + idx).val(data.content); 
						attachedName(idx);
					},
					error : function() { alert("error");}
				});
				$("#c" + idx).css("display", "table-row"); 
			}else{
				$("#c" + idx).css("display", "none"); 
				$.ajax({
					url:"board/count/" + idx, 
					type: "put",
					success : function() {
		                // ⭕ 1단계에서 만든 id="count+idx" 태그를 찾아옴
		                var countTd = $("#count" + idx);
		                
		                // 현재 화면에 적힌 조회수 숫자를 가져와서 정수로 변환
		                var currentCount = parseInt(countTd.text());
		                
		                // 화면의 조회수 숫자를 1 더한 값으로 바로 변경!
		                countTd.text(currentCount + 1);
		            },
					error: function() { alert("error"); }
				});
			}
		}
		
		
		function goDelete(idx){
			if (confirm("정말로 삭제하시겠습니까?")) {
			
				$.ajax({
					url : "board/" + idx, 
					type : "delete",      
					data : { "idx" : idx },  
					success : loadList,      
					error : function(){ alert("게시글삭제 실패")}
				});
			
			} else {
		        // [취소]를 눌렀을 때 실행되는 영역 (아무것도 안 적으면 그냥 팝업창이 닫힘!)
		        return false;
		    }
		}
		
		function goUpdateForm(idx, attached){
			//내용
			$("#ta" + idx).attr("readonly", false); 
			
			//제목
			var title = $("#t"+ idx).text();
			var newTitle = "<input id='nt" +idx+ "' value='" +title+ "' type='text' class='form-control'>";		
			$("#t" + idx).html(newTitle); 

			//이미지숨기기
			$("#img"+ idx).hide(); 
			
			//첨부이미지 있는 경우
			if (attached !== "null" && attached !== "undefined" && attached !== "") { 
		        $("#attachedDeleteBtn" + idx).show(); //첨부된파일버튼보이기
		        $("#attached" + idx).hide();          //업로드숨기기
		    } else {
		        $("#attachedDeleteBtn" + idx).hide();  //첨부된파일버튼숨기기
		        $("#attached" + idx).show();           //업로드보이기
		    }
			
			var newBtn = "<button onclick='goUpdate(" + idx + ")' class='btn btn-custom btn-sm' style='margin-right: 5px;'>수정하기</button>";
			$("#ub" + idx).html(newBtn);
			
			$("#deleteBtn" + idx).hide(); //삭제버튼
			$("#closeBtn" + idx).hide();  //닫기버튼
			$("#reloadBtn" + idx).show(); //수정취소버튼
		}
		
		//수정기능
		function goUpdate(idx) { 		    
		    var formData = new FormData();
		    formData.append("idx", idx);
		    formData.append("title", $("#nt" + idx).val());
		    formData.append("content", $("#ta" + idx).val());     
		    
		    var fileInput = $("#attached" + idx)[0];
		    var originAttached = $("#originAttached" + idx).val();
		    
		    if (fileInput.files.length > 0) {
		        formData.append("attached", fileInput.files[0]);
		    }else{
		    	formData.append("originAttached", originAttached);
		    }
		   
		    
		    $.ajax({
		        url : "board/update",
		        type : "post", 
		        data : formData, 
		        processData : false, 
		        contentType : false, 
		        success : function(data){ 
		            loadList();
		            //goContent(idx)
		        }, 
		        error : function(){ 
		            alert("수정기능실패");
		        }
		    });
		}
		
		
		function deleteAttached(idx){	
			$("#attached" + idx).show(); //업로드		
			$("#originAttached" + idx).val(""); //기존 파일명을 지워버려서 서버에 빈 값이 가도록 처리		
			alert("첨부된 파일 삭제되었습니다");		
			$("#attachedDeleteBtn"+idx).hide();
			
		}
		
		//첨부파일 삭제버튼 데이터이름 삭제
		function attachedName(idx){	
			var attached_data = $("#attachedDeleteBtn" + idx).text();
			var new_attached_data = ""; 
			
			if (attached_data && attached_data.includes("_")) { 
				new_attached_data = attached_data.substring(attached_data.indexOf("_") + 1);
				$("#attachedDeleteBtn" + idx).text("첨부파일 삭제하기( " + new_attached_data + " )");
 			}
		}
		
		
		
		
	</script>
</body>
</html>