package kr.spring.controller.socket;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

@Component(value = "wsChatGr.do")
@Slf4j
public class MySocketHandler_Group extends TextWebSocketHandler {
	
	private ArrayList<WebSocketSession>list; //websocket Session을 담는 객체
	
	//생성
	public MySocketHandler_Group() {
		list = new ArrayList<WebSocketSession>();
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("Group afterConnectionEstablished 접속 WebSocket Session 정보: {}", session);
		super.afterConnectionEstablished(session);
		
		list.add(session); //전체 접속자 리스트에 새로운 접속자를 추가 
		//bean 설정인 HttpSessionHandshakeInterceptor에 의해서 HttpSession의 값을 사용할 수 있다 
		Map<String, Object> sessionMap = session.getAttributes();
		
		String grSession = (String)sessionMap.get("gr_id");
		String memSession = (String)sessionMap.get("mem_id");
		
		log.info("Client WebSocket Session의 갯수:{}", list.size());
		log.info("현재 접속 Session의 아이디 {}", memSession);
		log.info("현재 접속 Session의 그룹 {}", grSession);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("메시지 전달 message: {}", message.getPayload());
		String msg = message.getPayload();
		String txt = "";
		
		//ChatController에서 HttpSession의 입력값 => HttpSessionHandshakeInterceptor Bean에 의해서 자동으로 등록됨
		Map<String, Object> mySession = session.getAttributes();
		String myGrSession = (String)mySession.get("gr_id");
		String myMemSession = (String)mySession.get("mem_id");
		log.info("내 정보 확인: 그룹 {}, 아이디 {} ", myGrSession, myMemSession);
		
		//msg를 구분하여 처리 
		if(msg.indexOf("#$nickName_")!= -1) { //처음 채팅방 입장
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String now = sdf.format(new Date());
			
			for (WebSocketSession s : list) {
				Map<String, Object> sessionMap = s.getAttributes();
				String otherGrSession = (String)sessionMap.get("gr_id");
				if(myGrSession.equals(otherGrSession)) {
					s.sendMessage(new TextMessage("<font style='color:gray; font-size:13px;'>"+myMemSession+"님이 입장하셨습니다("+now+")</font>"));
				}	
			}
		}else { //내용전달
			String msg2 = msg.substring(0,msg.indexOf(":")).trim();
			for (WebSocketSession s : list) {
				//WebSocket Session에 담겨있는 각 참여자의 아이디(mem_id)와 그룹(gr_id)를 가져옴
				Map<String, Object> sessionMap = s.getAttributes();
				String otherGrSession = (String)sessionMap.get("gr_id");
				String otherMemSession = (String)sessionMap.get("mem_id");
				
				if(myGrSession.equals(otherGrSession)) { //같은그룹
					if(msg2.equals(otherMemSession)) {
						String newMsg = "[나] " + msg.replace(msg.substring(0,msg.indexOf(":")+1),"");
						log.info("내가 쓴글 전달 내용: {}", newMsg);
						txt = newMsg;
					}else {
						String part1 = msg.substring(0,msg.indexOf(":")).trim(); //mem_id 값
						String part2 = "["+part1+"] " + msg.replace(msg.substring(0,msg.indexOf(":")+1),""); //mem_id + 내용
						txt = part2;
					}
					s.sendMessage(new TextMessage(txt));
				}
			}
		}
		super.handleTextMessage(session, message);
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("afterConnectionClosed WebSocket 세션 삭제");
		super.afterConnectionClosed(session, status);
		
		//현재사용자 삭제
		Map<String, Object> mySession = session.getAttributes();
		String myGrSession = (String)mySession.get("gr_id");
		String myMemSession = (String)mySession.get("mem_id");
		
		log.info("세션 삭제 전 확인:{}", list.contains(session));
		list.remove(session);
		log.info("세션 삭제후 확인:{}", list.contains(session));
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = sdf.format(new Date());
		
		//같은 그룹의 사용자에게 메시지 전달
		for (WebSocketSession s : list) {	
			Map<String, Object> sessionMap = s.getAttributes();
			String otherGrSession = (String)sessionMap.get("gr_id");
			if(myGrSession.equals(otherGrSession)) {
				s.sendMessage(new TextMessage("<font style='color:gray; font-size:13px;'>"+myMemSession+"님이 퇴실하셨습니다("+now+")</font>"));
			}
		}
	}
	
}








