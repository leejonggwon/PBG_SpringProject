//TODO 014

var ws =null;
var url =null;
var nick =null;
var pageClosed = true;

$(document).ready(function(){
	
	console.log("그룹 채팅 로딩...");
	url = location.href;
	var wsUrl = "ws:" + url.substring(url.indexOf("//"), url.lastIndexOf("/")+1)+"wsChatGr.do"; 
	var nick = document.querySelector("#nickName>b").textContent;
	var group = document.getElementById("group").textContent;
	console.log("요청주소", wsUrl);
	console.log("아이디", nick);
	console.log("요청주소", group);
	
	$(".chat").focus();
	
	//웹소캣 객체 생성
	ws = new WebSocket(wsUrl);
	console.log("생성된 웹소객 객체:", ws);
	
	
	//객체 연결 후 open callback
	ws.onopen=function(){
		console.log("웹소캣 객체 오픈");
		ws.send("#$nickName_" + nick); //화면에서 로그인된 사용자 정보를 탐색된 값
	}
	
	//서버로 부터 전달받은 (handleTextMessage)의 전달된 값 확인 및 화면 출력
	ws.onmessage = function(event){
		var msg = event.data;
		console.log(event,msg);
		if(msg.startsWith("<font style")){ //입장과 퇴실 메시지
			$(".resive_msg").append($("<div class='noticeTxt'>")).append(msg+"<br>");
			
		//참여 목록창 REST 처리 
		}else if(msg.startsWith("[나]"))	{
			$(".resive_msg").append($("<div class='sendTxt'>")).append($("<span class='send_img'>").text(msg)).append("<br><br>");     
		}else{
			$(".resive_msg").append($("<div class='resiveTxt'>")).append($("<span class='resiver_msg'>").text(msg)).append("<br><br>"); 
		}
		
		$(".resive_msg").scrollTop($(".resive_msg")[0].scrollHeight);
	}
	
	ws.onclose=function(){
		alert("서버와 연결이 종료되었습니다 채팅방이 삭제 됩니다");
	}
	
	$(".chat_btn").bind("click", function(){
		if($(".chat").val() == ""){
			alert("내용을 입력하세요");
			return;
		}else{
			ws.send(nick + ":" + $(".chat").val());
			$(".chat").val("");
			$(".chat").focus();
		}		
	});
	
	$(window).on('beforeunload', function(event){
		event.preventDefault();
		event.returnValue="";
		
		//room.close(); 채팅방이 종료 참여자 목록 갱신
		ws.close();
		return '내용이 저장되지 않음';
	});
	
});








