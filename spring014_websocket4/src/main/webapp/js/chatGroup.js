//TODO 014

var ws = null;
var url = null;
var nick = null;
var pageClosed = true;

$(document).ready(function(){
	
	console.log("그룹 채팅 로딩...");
	url = location.href;
	var wsUrl = "ws:" + url.substring(url.indexOf("//"), url.lastIndexOf("/")+1)+"wsChatGr.do"; 
	var nick = document.querySelector("#nickName>b").textContent;
	var group = document.getElementById("group").textContent;
	console.log("요청주소", wsUrl);
	console.log("아이디", nick);
	console.log("그룹", group);
	
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
			//TODO 016 참여 목록창 REST 처리, 입장/퇴장 시 목록을 갱신
			viewList(group); 
			
		}else if(msg.startsWith("[나]"))	{
			$(".resive_msg").append($("<div class='sendTxt'>")).append($("<span class='send_img'>").text(msg)).append("<br><br>");     
		}else{
			$(".resive_msg").append($("<div class='resiveTxt'>")).append($("<span class='resiver_msg'>").text(msg)).append("<br><br>"); 
		}
		
		$(".resive_msg").scrollTop($(".resive_msg")[0].scrollHeight);
	}
	
	ws.onclose=function(){
		alert("서버와 연결이 종료되었습니다. 채팅방이 삭제 됩니다");
	}
	
	$(".chat_btn").bind("click", function(){
		if($(".chat").val() == ""){
			alert("내용을 입력해주세요");
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
		
		roomClose(); //채팅방이 종료 참여자 목록 갱신
		ws.close();
		return '내용이 저장되지 않음';
	});
	
});

var roomClose = function(){
	alert("채팅방종료");
	$.ajax({
		url:"./socketOut.do",
		type:"post",
		async:true,
		success:function(){
			pageClosed = false;
			self.close();
		}
	});
}

//TODO 017 서버 호출
function viewList(grid){
	$(".memList").children().remove();
	$.ajax({
		url:"./viewChatList.do",
		type:"post",
		data:"gr_id=" + grid,
		dataType: "json",
		success:function(result){
			console.log(result.list);
			for(let str in result.list){
				if(grid == result.list[str]){
					$(".memList").prepend("<p style='border-bottom:0.5px solid #4b4b4b;'>"+str+"</p>");
				}
			}
		}
		
	});
}















