<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>2025 SEOUL MARATHON</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body> 
	<div class="container">
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include> <!--context path는 views 아래와 같으므로 .. → /controller를 입력한다-->
		<h2>2025 SEOUL MARATHON</h2>
		<div class="panel panel-default">
			<div class="panel-heading">Community</div>
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
								<button onclick="goForm()" class="btn btn-primary btn-sm">글쓰기</button>
							</td>
						</tr>		
					</c:if>
				</table>		
			</div>
			
			<!-- 글쓰기 폼 -->
			<div class="panel-body" id="wform" style="display: none"> <!-- style="display: none":안보이게 한다 -->
				<form id="frm"> <!-- form 태그에 id를 지정하면, 내부 input 태그들의 값을 한 번에 가져올 수 있음 -->
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
			</div>
			
			
			<div class="panel-footer">2025 SEOUL MARATHON - All rights reserved</div>
		</div>
	</div>
	
	<script type="text/javascript">
	
		$(document).ready(function(){ 
			//HTML 요소들이 다 로딩되고나서 아래 loadList() 실행하겠다는 의미
			loadList();
		});
	
		//비동기방식으로 게시글 리스트 가져오기 기능
		function loadList() {
			//ajax 안에는 - 요청 url, 어떻게 데이터 받을지, 요청방식 등 ... → 객체형태로 넣어주면 된다 
			$.ajax({
				url : "board/all",    //이 주소로 비동기 요청을 보낸다, "boardList.do" → "board/all",
				type: "get",          
				dataType: "json",     //서버로부터 돌려받을 데이터 타입
				success: makeView,    //콜백함수:다른 함수의 인자로 전달되어, 특정 작업이 끝난 후 호출되는 함수
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
				listHtml += "<td id='t" + obj.idx + "'>"; 
				listHtml += "<a href='javascript:goContent(" + obj.idx + ")'>"; //a 태그 클릭 시 JS 메서드를 호출하며 idx 값을 전달해 해당 게시글을 표시 
				listHtml += obj.title;
				listHtml += "</a>";
				listHtml += "</td>";
				listHtml += "<td id='w" + obj.idx + "'>" + obj.writer + "</td>";
				listHtml += "<td>" + obj.indate + "</td>";
				listHtml += "<td>" + obj.count + "</td>";
				listHtml += "</tr>";
				
				//상세보기 화면
				listHtml += "<tr id='c" + obj.idx + "' style='display : none'>"; //display : none 으로 안보이게한다
				//게시글별 상세 내용을 구분할 수 있도록 게시글 번호를 포함한 id를 생성
				listHtml += "<td>내용</td>";
				listHtml += "<td colspan='4'>";
				listHtml += "<textarea id='ta" + obj.idx + "' readonly rows='4' class='form-control'>";
				listHtml += obj.content;
				listHtml += "</textarea>";
				
				//수정 삭제 화면 (내가 쓴글일때 보여준다)
				//문법: 조건문안에 EL식을 쓰고 싶다면 문자열로 감싸야한다
				if("${mvo.memID}" == obj.memID){
					listHtml += "<br>";
					listHtml += "<span id='ub" + obj.idx + "'>";
					listHtml += "<button onclick='goUpdateForm(" + obj.idx + ")' class='btn btn-sm btn-success'>수정화면</button></span> &nbsp;"; //&nbsp; 줄바꿈없이 띄어쓰기
					//'수정화면'을 누르면 해당위치의 제목, 작성자, 내용이 input 태그로 바뀐다
					listHtml += "<button onclick='goDelete(" + obj.idx + ")' class='btn btn-sm btn-warning'>삭제</button> &nbsp;"; 
				}else{
					listHtml += "<br>";
					listHtml += "<span id='ub" + obj.idx + "'>";
					listHtml += "<button disabled onclick='goUpdateForm(" + obj.idx + ")' class='btn btn-sm btn-success'>수정화면</button></span> &nbsp;"; //&nbsp; 줄바꿈없이 띄어쓰기
					//'수정화면'을 누르면 해당위치의 제목, 작성자, 내용이 input 태그로 바뀐다
					//disabled: 버튼이 동작을 못하게 하는 속성
					listHtml += "<button disabled onclick='goDelete(" + obj.idx + ")' class='btn btn-sm btn-warning'>삭제</button> &nbsp;"; 
				}
				
				listHtml += "</td>"; //상세보기와 같은 칸 사용
				listHtml += "</tr>";
			});
			
			$("#view").html(listHtml);	
			
			//goList();
		}
		
		//글쓰기버튼
		function goForm(){
			$("#boardList").css("display", "none"); //.css: css를 바꿀때 
			$("#wform").css("display", "block"); 
		}
		
		//목록버튼
		function goList(){
			$("#boardList").css("display", "block"); //.css: css를 바꿀때 
			$("#wform").css("display", "none"); 
		}
		
		//게시글 등록버튼
		function goInsert(){
			//3개값을 직렬화형태로 가져온다 //title="이건제목"&content="이건내용"&writer="이건작성자"
			var fData = $("#frm").serialize();
			
			$.ajax({
				url : "board/new",
				type : "post",
				data : fData, 
				success : function(){ 
					loadList(); 
					goList();
				}, 
				error : function(){ alert("error")}
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
		function goUpdateForm(idx){
			//내용 수정화면 
			 //textarea는 불러올때부터 수정된 데이터 idx가 있다 
			$("#ta" + idx).attr("readonly", false); //attr은 attribute 의미: HTML 요소의 속성을 읽거나 변경할 때 사용,readonly를 false로 변경하였음
			
			//제목 수정화면
			var title = $("#t"+ idx).text();//html하면 기존의 제목값이 사라지므로 기존의 제목 값을 가져올것이다
			var newTitle = "<input id='nt" + idx + "' value='" + title + "' type='text' class='form-control'>";
			 //값을 가져오기 위해서 id값을 줘야한다, 매개변수로 넘어온 idx를 사용한다
			$("#t" + idx).html(newTitle); //html하면 기존의 제목값이 사라진다
			
			//작성자 수정화면
			var writer = $("#w"+ idx).text();
			var newWriter = "<input id='nw" + idx + "' value='" + writer + "' type='text' class='form-control'>";
			$("#w" + idx).html(newWriter);
			
			//버튼 수정화면 → 수정으로 변경, 수정하기기능
			var newBtn = "<button onclick='goUpdate(" + idx + ")' class='btn btn-primary btn-sm'>수정하기</button>";
			$("#ub" + idx).html(newBtn);
		}
		
		
		function goUpdate(idx) { 
			var title = $("#nt" + idx).val(); //.val(): <input>이나 <textarea> 등의 값(value)을 가져오거나 설정할 때 사용
			var content = $("#ta" + idx).val();
			var writer = $("#nw" + idx).val();
			
			$.ajax({
				url : "board/update",
				type : "put", //post안에 put이라는 방식(다른요청방식로 하나의 url로 2개의 기능을 처리한다)
				contentType :"application/json; charset=utf-8", //비동기방식 + put방식 + 여러개 개체를 보낼때 사용한다
				data : JSON.stringify({"idx" : idx , "title" : title, "content" : content, "writer" : writer}), 
				//객체형태로 데이터를 보낸다 
				//JSON.stringify: JSON형태의 문자열로 변환해주는 함수
				success : loadList, 
				error : function(){ alert("error")}
			});
		}

	</script>
</body>
</html>





