<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SpringBook</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<h2>SpringBook</h2>
		<div class="panel panel-default">
			<div class="panel-heading">SpringBook</div>
			
			<div class="panel-body">
				<table id="bookList" class="table table-bordered table-hover"> 
					<tr class="active">
						<td>번호</td>
						<td>제목</td>
						<td>작가</td>
						<td>출판사</td>
						<td>isbn</td>
						<td>보유도서수</td>
						<td>삭제</td>	
						<td>수정</td>					
					</tr>
					<tbody id="view">
						<!--비동기 방식으로 가져온 게시글 나오게할 부분-->		
					</tbody>
					<tr>
						<td colspan="8"> 
							<button onclick="goForm()" class="btn btn-primary btn-sm">도서등록</button>
						</td>
					</tr>
				</table>		
			</div>




			<!-- 글쓰기 폼 -->
			<div class="panel-body" id="wform" style="display: none"> <!--style="display: none":안보이게 한다-->
				<form id="wfrm"> 
				<table class="table">
					<tr>
						<td>제목</td>
						<td><input type="text" name="title" class="form-control"></td> 
					</tr>
					<tr>
						<td>작가</td>
						<td><input type="text" name="author" class="form-control"></td> 
					</tr>
					<tr>
						<td>출판사</td>
						<td><input type="text" name="company" class="form-control"></td> 
					</tr>
					<tr>
						<td>isbn</td>
						<td><input type="text" name="isbn" class="form-control"></td>
					</tr>
					<tr>
						<td>보유도서수</td>
						<td><input type="number" name="count" class="form-control"></td>
					</tr>
					<tr>
					<td colspan="2" align="center"> 
						<button class="btn btn-success btn-sm" type="button" onclick="goInsert()">등록</button>
						<button class="btn btn-warning btn-sm" type="reset" id="fclear">취소</button>
						<button onclick="goList()" class="btn btn-info btn-sm">리스트로가기</button> <!--onclick 함수를 통해 goList() 함수실행-->
					</td>
					</tr>
				</table>
				</form>
			</div>
			
			
			
			<!-- 업데이트 화면 폼 -->
			<div class="panel-body" id="uform" style="display: none"> <!--style="display: none":안보이게 한다-->
				<form id="ufrm"> 
				<input type="hidden" name="num">
				<table class="table">
					<tr>
						<td>제목</td>
						<td><input readonly="readonly" type="text" name="title" class="form-control"></td>
					</tr>
					<tr>
						<td>작가</td>
						<td><input readonly="readonly" type="text" name="author" class="form-control"></td> 
					</tr>
					<tr>
						<td>출판사</td>
						<td><input readonly="readonly" type="text" name="company" class="form-control"></td> 
					</tr>
					<tr>
						<td>isbn</td>
						<td><input readonly="readonly" type="text" name="isbn" class="form-control"></td>
					</tr>
					<tr>
						<td>보유도서수</td>
						<td><input type="number" name="count" class="form-control"></td>
					</tr>
					
					<tr>
					<td colspan="2" align="center"> 
						<button class="btn btn-success btn-sm" type="button" onclick="goUpdate()">수정</button>
						<button class="btn btn-warning btn-sm" type="reset" id="fclear">취소</button>
						<button onclick="goList()" class="btn btn-info btn-sm">리스트로가기</button> <!--onclick 함수를 통해 goList() 함수실행-->
					</td>
					</tr>
				</table>
				</form>
			</div>

			
			<div class="panel-footer">스프링도서관 - 이종권</div>
		</div>
	</div>
	
	
	<script type="text/javascript">
		//페이지 로딩 끝나면 바로 loadList() 실행해서 화면에 목록 띄운다
		$(document).ready(function(){ 
			loadList(); //비동기방식으로 게시글 리스트 가져오기 기능
		});
		
		
	
		//비동기방식으로 게시글 리스트 가져오기 기능
		function loadList() {
			$.ajax({
				url : "book/all",    
				type: "get",          
				dataType: "json",   //서버로부터 돌려받을 데이터 타입
				success: makeView,  //콜백함수:다른 함수의 인자로 전달되어, 특정 작업이 끝난 후 호출되는 함수
				error: function(){ alert("error"); }
			});
		}
		
		
		//서버로부터 비동기방식통신을 하고 성공했을때 작동하는 함수, 게시글의 정보를 받아온다
		function makeView(data){
			var listHtml = "";
			
			//jQuary반목문
			$.each(data, function(index, obj){ //index:순서 표시자
				listHtml += "<tr>";
				listHtml += "<td>" + (index+1) + "</td>";
				listHtml += "<td>" + obj.title + "</td>";
				listHtml += "<td>" + obj.author + "</td>";
				listHtml += "<td>" + obj.company + "</td>";
				listHtml += "<td>" + obj.isbn + "</td>";
				listHtml += "<td>" + obj.count + "</td>";
				
				listHtml += "<td>";
				listHtml += "<button type='button' class='btn btn-primary btn-sm' onclick='goDelete(" + obj.num + ")'>삭제</button>";
				listHtml += "</td>";
				
				listHtml += "<td>";
				listHtml += "<button onclick='goUpdateForm(" + obj.num + ")' class='btn btn-warning btn-sm'>수정</button>";
				listHtml += "</td>";

				listHtml += "</tr>";
			});
			
			$("#view").html(listHtml);	
		}
		

		//게시글작성폼 요소만 보이게 한다 
		function goForm(){
			$("#wform").css("display", "block");   //요소를 보이게 한다
			$("#bookList").css("display", "none"); //요소를 숨긴다
			$("#uform").css("display", "none"); 
		}

		
		//게시글리스트 화면으로 이동
		function goList(){
			$("#bookList").css("display", "block"); 
			$("#wform").css("display", "none"); 
			$("#uform").css("display", "none"); 
			
		}
		
		//업데이트폼화면
		function goUpdateForm(num){
			 $("#uform").show();    //업데이트폼
			 $("#bookList").hide(); //게시글리스트
			 $("#wform").hide();    //글쓰기폼
			
			$.ajax({
				url : "book/" + num, 
				type : "get",      
				data : { "num" : num },  
				success: function(vo) {
				      // 서버에서 받아온 값으로 input 채우기
				      $("#uform input[name='num']").val(vo.num);
				      $("#uform input[name='title']").val(vo.title);
				      $("#uform input[name='author']").val(vo.author);
				      $("#uform input[name='company']").val(vo.company);
				      $("#uform input[name='isbn']").val(vo.isbn);
				      $("#uform input[name='count']").val(vo.count);
				} ,      
				error : function(){ alert("error")}
				
			})
		}
		

		//게시글 등록버튼
		function goInsert(){
			//값을 직렬화형태로 가져온다
			var fData = $("#wfrm").serialize();
			console.log("fData:", fData);
			
			$.ajax({
				url : "book/new",
				type : "post",
				data : fData, 
				success : function(){ 
					loadList(); //비동기방식으로 게시글 리스트 가져오기 기능
					goList();   //게시글 이동하는 
				}, 
				error : function(){ alert("error")}
			});
			$("#fclear").trigger("click");
			//등록 후 폼을 초기 상태로 돌리기 위해 클릭 이벤트를 강제로 실행
		}
		
		

		//삭제버튼
		function goDelete(num){
			//비동기방식 - 게시글 등록기능 	
			$.ajax({
				url : "book/" + num,    // @DeleteMapping("/{num}")
				type : "delete",        //HTTP DELETE 요청을 서버로 보낸다
				data : { "num" : num }, //보낼 데이터는 JSON 형태로 보낸다
				success : function(){ 
					loadList(); //비동기방식으로 게시글 리스트 가져오기 기능
					goList();   //게시글 이동하는 
				},      
				error : function(){ alert("error")}
			});
		}
		
		

		
		function goUpdate() { 
			var num = parseInt($("#ufrm input[name='num']").val(), 10);
			//id가 ufrm 인 폼안의 name='num'인 input 요소의 값 문자열에서 정수로 변환
			var count = parseInt($("#ufrm input[name='count']").val(), 10);
			
			$.ajax({
				url : "book/update", 
				type : "put",
				contentType :"application/json; charset=utf-8",
				data : JSON.stringify({"num" : num , "count" : count}),
				success : function(){ 
					loadList(); //비동기방식으로 게시글 리스트 가져오기 기능
					goList();   //게시글 이동하는 
				}, 
				error : function(){ alert("error")}
			});
		}
		

	</script>
</body>
</html>





