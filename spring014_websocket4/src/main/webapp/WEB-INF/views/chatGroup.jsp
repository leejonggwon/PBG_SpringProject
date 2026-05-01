<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>그룹채팅</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
  <script type="text/javascript">
	function goSocket(gr_id, mem_id) {
		//window.open: 새로운 브라우저
		window.open("./socketOpen.do?gr_id="+gr_id+"&mem_id="+mem_id, "그룹채팅","width=600px, height=800px, left=300px, top=50px")
	}
  </script>
  
</head>
<body>
	<!-- 그룹별로 구성되어 있는 화면 -->
	<!-- TODO 011 그룹 생성 로그인 group + id -->
	<div class="container">
		<fieldset>참여목록</fieldset>
		<div>
			<ul>
				<li><button class="btn btn-success" onclick="goSocket('S','super')">그룹:S | 사용자:super</button></li>
				<li><button class="btn btn-success" onclick="goSocket('S','higher')">그룹:S | 사용자:higher</button></li>
			</ul>
			<ul>
				<li><button class="btn btn-primary" onclick="goSocket('H','super')">그룹:H | 사용자:super</button></li>
				<li><button class="btn btn-primary" onclick="goSocket('H','top')">그룹:H | 사용자:top</button></li>
			</ul>
		</div>
	</div>
	
</body>
</html>


