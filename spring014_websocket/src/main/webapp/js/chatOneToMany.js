/**
 * TODO 009 WebSocket 객체를 생성하는데 서버의 WebSocket와 연결 
 */

var ws = null; //웹소캣 객체
var url = null; //웹소캣 접속주소
var nick = null; //대화명

$(document).ready(function(){
	$("#nickName").focus();
	
	
	$("#join_room").bind('click',function(){
	console.log("닉네임 입력 유효성 검사");
	if($("#nickName").val() == ""){
		alert("참여 이름은 필수 입니다");
		$("#nickName").focus();
		return;
	}
	
	nick = $("#nickName").val(); //대화창에서 입력받은 닉네임 -> Server로 전송하여 (Map<WebSocketSession, nick>)
	console.log("참여이름 ", nick);
	
	$("#resive_msg").html("");
	$("#chat_div").show();
	$("#chat").focus();
	
	var url = location.href;
	console.log("location.href의 값:", url);
	var wsUrl = url.substring(url.indexOf("//"), url.lastIndexOf("/")+1);
	console.log("웹소캣 호출 주소: ", `ws:${wsUrl}wsChat.do`); //웹소캣 서버를 호출하는 주소
	
	ws= new WebSocket(`ws:${wsUrl}wsChat.do`);
	console.log("생성된 WebSocket 객체: ", ws);
	
	ws.onopen = function(){
		console.log("웹소캣 객체 open");
		ws.send("#$nick_" + nick);
	}
	ws.onmessage = function(event){
		$("#resive_msg").append(event.data + "<br>");
	}
	
	ws.onclose = function(){
		alert("웹소캣 서버와 연결이 종료되었습니다");
	}

	}); //#join_room에 관련
	
	$("#chat_btn").bind("click", function(){
		console.log("대화내용 전달");
		if($("#chat").val()==""){
			alert("대화내용을 입력해주세요");
			return;
		}else{
			ws.send("["+nick+"]"+$("#chat").val());
			$("#chat").val("");
			$("#chat").focus();
		}
	});
	
	
	
	window.addEventListener("beforeunload",(event)=>{
		event.preventDefault();
		event.returnValue="";
		ws.close();
		ws=null;
	})
	
});


function disconnection(){
		ws.close();
		ws = null;
		windows.close();
	}








