<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
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

<!-- 디자인 전용 스타일 -->
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">
<style>
	body {
		font-family: 'Nanum Gothic', sans-serif;
		/*background-color: #f6f7f2;*/ /*배경*/
	}

	h2 {
		text-align: center;
		color: #2d4739;
		margin-top: 20px;
		font-weight: bold;
	}

	.panel {
		border: none;
		border-radius: 16px;
		box-shadow: 0 4px 10px rgba(0,0,0,0.1);
		margin-top: 30px;
		background-color: #ffffff;
	}

	.panel-heading {
		background-color: #588157 !important; /*도서목록*/
		color: #fff !important;
		font-size: 18px;
		font-weight: bold;
		text-align: center;
		border-radius: 16px 16px 0 0;
	}

	.panel-footer {
		background-color: #dad7cd !important;
		text-align: center;
		color: #3a5a40;
		font-weight: bold;
		border-radius: 0 0 16px 16px;
	}

	.table {
		background-color: #fff;
		border-radius: 12px;
		overflow: hidden;
	}

	.table th, .table td {
		text-align: center;
		vertical-align: middle !important;
	}

	tr.active {
		background-color: #e9f5ee;
		font-weight: bold;
	}

	tr:hover {
		background-color: #f3f8f4;
		transition: 0.2s;
	}

	button {
		border-radius: 20px !important;
	}

	.btn-primary { background-color: #3a5a40; border: none; }
	.btn-primary:hover { background-color: #2d4739; }

	.btn-success { background-color: #588157; border: none; }
	.btn-success:hover { background-color: #3a5a40; }

	.btn-warning { background-color: #dda15e; border: none; }
	.btn-warning:hover { background-color: #bc6c25; }

	.btn-info { background-color: #40916c; border: none; }
	.btn-info:hover { background-color: #2d6a4f; }

	.btn-danger { background-color: #d62828; border: none; }
	.btn-danger:hover { background-color: #a4161a; }

	input.form-control {
		border-radius: 10px;
		box-shadow: none;
	}

	#bookList, #wform, #uform {
		animation: fadeIn 0.3s ease-in-out;
	}

	@keyframes fadeIn {
		from { opacity: 0; transform: translateY(8px); }
		to { opacity: 1; transform: translateY(0); }
	}
</style>
</head>
<body>
	<div class="container">
		<h2>📚 한국도서관 도서관리시스템</h2>
		<div class="panel panel-default">
			<div class="panel-heading">도서 목록</div>
			
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
							<button onclick="goForm()" class="btn btn-primary btn-sm">+ 도서등록</button>
						</td>
					</tr>
				</table>		
			</div>

			<!-- 글쓰기 폼 -->
			<div class="panel-body" id="wform" style="display: none">
				<form id="wfrm"> 
				<table class="table">
					<tr><td>제목</td><td><input type="text" name="title" class="form-control"></td></tr>
					<tr><td>작가</td><td><input type="text" name="author" class="form-control"></td></tr>
					<tr><td>출판사</td><td><input type="text" name="company" class="form-control"></td></tr>
					<tr><td>isbn</td><td><input type="text" name="isbn" class="form-control"></td></tr>
					<tr><td>보유도서수</td><td><input type="number" name="count" class="form-control"></td></tr>
					<tr>
						<td colspan="2" align="center"> 
							<button class="btn btn-success btn-sm" type="button" onclick="goInsert()">등록</button>
							<button class="btn btn-warning btn-sm" type="reset" id="fclear">취소</button>
							<button onclick="goList()" class="btn btn-info btn-sm">리스트로가기</button>
						</td>
					</tr>
				</table>
				</form>
			</div>
			
			<!-- 업데이트 화면 폼 -->
			<div class="panel-body" id="uform" style="display: none">
				<form id="ufrm"> 
				<input type="hidden" name="num">
				<table class="table">
					<tr><td>제목</td><td><input readonly="readonly" type="text" name="title" class="form-control"></td></tr>
					<tr><td>작가</td><td><input readonly="readonly" type="text" name="author" class="form-control"></td></tr>
					<tr><td>출판사</td><td><input readonly="readonly" type="text" name="company" class="form-control"></td></tr>
					<tr><td>isbn</td><td><input readonly="readonly" type="text" name="isbn" class="form-control"></td></tr>
					<tr><td>보유도서수</td><td><input type="number" name="count" class="form-control"></td></tr>
					<tr>
						<td colspan="2" align="center"> 
							<button class="btn btn-success btn-sm" type="button" onclick="goUpdate()">수정</button>
							<button class="btn btn-warning btn-sm" type="reset" id="fclear">취소</button>
							<button onclick="goList()" class="btn btn-info btn-sm">리스트로가기</button>
						</td>
					</tr>
				</table>
				</form>
			</div>

			<div class="panel-footer">© Library of Hanguk. All rights reserved.</div>
		</div>
	</div>
	
<!-- 광고용 모달 -->
<div id="adModal" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document" style="max-width:500px;">
    <div class="modal-content">
      <div class="modal-header" style="background:#588157; color:white;">
        <h4 class="modal-title">안내</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body" style="text-align:center;">
        <img src="${contextPath}/resources/images/springbook.png" style="width:50%; border-radius:10px;">
        <p style="margin-top:10px;">새 도서가 입고되었습니다</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
	

	
	<!-- 기능 스크립트: 원본 그대로 유지 -->
	<script type="text/javascript">
		$(document).ready(function(){ 
			loadList();
			 //$('#adModal').modal('show'); //모달창 
		});
	
		function loadList() {
			
			
			$.ajax({
				url : "book/all",    
				type: "get",          
				dataType: "json",
				success: makeView,
				error: function(){ alert("error"); }
			});
		}
		
		function makeView(data){
			var listHtml = "";
			$.each(data, function(index, obj){
				listHtml += "<tr>";
				listHtml += "<td>" + (index+1) + "</td>";
				listHtml += "<td>" + obj.title + "</td>";
				listHtml += "<td>" + obj.author + "</td>";
				listHtml += "<td>" + obj.company + "</td>";
				listHtml += "<td>" + obj.isbn + "</td>";
				listHtml += "<td>" + obj.count + "</td>";
				listHtml += "<td><button type='button' class='btn btn-danger btn-sm' onclick='goDelete(" + obj.num + ")'>삭제</button></td>";
				listHtml += "<td><button onclick='goUpdateForm(" + obj.num + ")' class='btn btn-warning btn-sm'>수정</button></td>";
				listHtml += "</tr>";
			});
			$("#view").html(listHtml);	
		}

		function goForm(){
			$("#wform").css("display", "block");
			$("#bookList").css("display", "none");
			$("#uform").css("display", "none"); 
		}

		function goList(){
			$("#bookList").css("display", "block"); 
			$("#wform").css("display", "none"); 
			$("#uform").css("display", "none"); 
		}

		function goUpdateForm(num){
			 $("#uform").show();
			 $("#bookList").hide();
			 $("#wform").hide();
			
			$.ajax({
				url : "book/" + num, 
				type : "get",
				data : { "num" : num },
				success: function(vo) {
				      $("#uform input[name='num']").val(vo.num);
				      $("#uform input[name='title']").val(vo.title);
				      $("#uform input[name='author']").val(vo.author);
				      $("#uform input[name='company']").val(vo.company);
				      $("#uform input[name='isbn']").val(vo.isbn);
				      $("#uform input[name='count']").val(vo.count);
				},
				error : function(){ alert("error") }
			})
		}

		function goInsert(){
			var fData = $("#wfrm").serialize();
			$.ajax({
				url : "book/new",
				type : "post",
				data : fData,
				success : function(){ 
					loadList();
					goList();
				}, 
				error : function(){ alert("error") }
			});
			$("#fclear").trigger("click");
		}

		function goDelete(num){
			$.ajax({
				url : "book/" + num,
				type : "delete",
				data : { "num" : num },
				success : function(){ 
					loadList();
					goList();
				},
				error : function(){ alert("error") }
			});
		}

		function goUpdate() { 
			var num = parseInt($("#ufrm input[name='num']").val(), 10);
			var count = parseInt($("#ufrm input[name='count']").val(), 10);
			$.ajax({
				url : "book/update",
				type : "put",
				contentType :"application/json; charset=utf-8",
				data : JSON.stringify({"num" : num , "count" : count}),
				success : function(){ 
					loadList();
					goList();
				}, 
				error : function(){ alert("error") }
			});
		}
	</script>
</body>
</html>
