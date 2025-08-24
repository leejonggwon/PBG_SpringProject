<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring MVC02</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> <!--CSS파일-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> <!--jQuey라이브러리-->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> <!--Bootstrap JavaScript-->
</head>
<body>
	<div class="container">
		<h2>Spring MVC02 비동기방식</h2>
		<div class="panel panel-default">
			<div class="panel-heading">Board</div>
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
					<tr>
						<td colspan="5"> <!-- colspan="5": 5개의 열을 합쳐서 한 줄에 걸쳐 표시 -->
							<button onclick="goForm()" class="btn btn-primary btn-sm">글쓰기</button>
						</td>
					</tr>
				</table>		
			</div>
			
			<!-- 글쓰기 폼 -->
			<div class="panel-body" id="wform" style="display: none"> <!-- style="display: none":안보이게 한다 -->
				<form id="frm"> <!-- form 태그에 id를 지정하면, 내부 input 태그들의 값을 한 번에 가져올 수 있음 -->
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
						<td>작성자</td>
						<td><input type="text" name="writer" class="form-control"></td>
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
			</div>
			
			
			<div class="panel-footer">스프링게시판 - 이종권</div>
		</div>
	</div>
	
	<script type="text/javascript">
	
		$(document).ready(function(){ 
			//HTML 요소들이 다 로딩되고나서 아래 loadList() 실행하겠다는 의미
			loadList();
		});
	
		function loadList() {
			//비동기방식으로 게시글 리스트 가져오기 기능
			//ajax 안에는 - 요청 url, 어떻게 데이터 받을지, 요청방식 등 ... → 객체형태로 넣어주면 된다 
			$.ajax({
				url : "boardList.do", //이 주소로 비동기 요청을 보낸다
				type: "post",          //요청방식
				dataType: "json",     //서버로부터 받을 데이터 타입
				success: makeView,    //성공시 makeView 함수 호출한다, 콜백함수:다른 함수의 인자로 전달되어, 특정 작업이 끝난 후 호출되는 함수
				error: function(){ alert("error"); }
			});
		}
		
		//서버로부터 비동기방식통신을 하고 성공했을때 작동하는 함수, 게시글의 정보를 받아온다
		function makeView(data){
			var listHtml = "";
			
			//jQuary반목문
			$.each(data, function(index, obj){ //index:순서 표시자
				listHtml += "<tr>";
				listHtml += "<td>" + (index + 1) + "</td>"; //$.each의 index는 숫자타입이다
				listHtml += "<td>" + obj.title + "</td>";
				listHtml += "<td>" + obj.writer + "</td>";
				listHtml += "<td>" + obj.indate + "</td>";
				listHtml += "<td>" + obj.count + "</td>";
				listHtml += "</tr>";
				
				// 상세보기 화면추가 하기 (하나의 화면에 보이게 하기) 
				listHtml += "<tr>";
				listHtml += "<td>내용</td>";
				listHtml += "<td colspan='4'>";
				listHtml += "<textarea rows='3' class='form-control'>"; //form-control이 적용되어 textarea가 기본적으로 100% 너비로 표시된다
				listHtml += obj.content;
				listHtml += "</textarea>";
				listHtml += "</td>";
				listHtml += "</tr>"; 
			});
			
			$("#view").html(listHtml);	
			goList();//게시글 목록보기
		}
		
		//글쓰기버튼
		function goForm(){
			$("#boardList").css("display", "none"); //.css: css를 바꿀때 
			$("#wform").css("display", "block"); 
		}
		
		//목록버튼
		function goList(){
			$("#boardList").css("display", "block"); 
			$("#wform").css("display", "none"); 
		}
		
		//등록버튼
		function goInsert(){
			//비동기방식 - 게시글 등록기능 
			//3개값을 직렬화형태로 가져온다 //title="이건제목"&content="이건내용"&writer="이건작성자"
			var fData = $("#frm").serialize();
			
			$.ajax({
				url : "boardInsert.do",
				type : "post",
				data : fData,         //보낼데이터 
				success : loadList(), //게시글정보 불러오기
				error : function(){ alert("error") }
			});
			
			$("#fclear").trigger("click"); // 글 작성 후 '글쓰기' 버튼을 눌러도 이전에 입력한 내용이 남아 있을 수 있으므로,
										   // 사용자가 버튼을 실제로 클릭하지 않아도 클릭 이벤트를 실행해 폼을 초기화
		}
		
	</script>
</body>
</html>





