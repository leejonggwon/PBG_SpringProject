package com.min.edu.socket;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;
//TODO 005 WebSocket 객체를 생성하는 Bean 
@Component(value ="wsChat.do")
@Slf4j
public class MySocketHandler_ToMany extends TextWebSocketHandler {
	
	private ArrayList<WebSocketSession> list; //웹소켓 전체 세션을 담아주는 객체(채팅의 대상을 담음)
	private Map<WebSocketSession, String> map = new HashMap<WebSocketSession, String>(); //웹소캣 세션에 해당이름
	
	public MySocketHandler_ToMany() {
		list = new ArrayList<WebSocketSession>();
	}

	// TODO 006 웹소캣을 화면에서 생성했을 경우 생성되는 Websocket 객체가 처음에 호출되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("웹소캣 Connection 객체생성, afterConnectionEstablished & WebSocketSession 생성");
		log.info("방금 참여한 websocket Session Open: {}",session.getId() );
		super.afterConnectionEstablished(session);
		list.add(session); //전체 메시지를 보낼때 사용되는 websocket 참여 객체의 모음 list
		log.info("현재참여하고 있는 객체의 수 :{}", list.size());
		
		Map<String, Object> map = session.getAttributes();
		log.info("-------session.getAttributes------{}", map);
	}

	//TODO 007 화면에서 onclose를 통해서 Websocket를 닫을 경우 (005) List객체에서 삭제해주는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("웹소캣 세션 객체 삭제 afterConnectionClosed");
		super.afterConnectionClosed(session, status);
		log.info("웹소캣 세션 삭제 대상: {}", session);
		list.remove(session);
		log.info("현재침여하고 있는 객체의수 closed: {}", list.size());
		
		//화면에 메시지 보내주기 
		SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd HH24:mm:ss");
		String out = sdf.format(new Date());
		for(WebSocketSession webSocketSession: list) {
			webSocketSession.sendMessage(new TextMessage("<font style='color:tomato; font-size:8px;'>"+map.get(session)+"님이 방을 나갔습니다"+out+"</font>"));
		}
		log.info("웹소캣 이름 삭제:{}", map.get(session));
		map.remove(session);
	}
	
	//TODO 008 WebSocke에 참여하는 대상자에게 메세지를 전달
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {	
		log.info("웹소캣 전달 메시지 : handleTextMessage");
		
		String msg = message.getPayload();
		String msgToString = message.toString();
		
		log.info("전달된 메시지의 getPayLoad:{}", msg);
		log.info("전달된 메시지의 toString:{}", msgToString);
		
		if(msg != null && !msg.equals("")) {
			if(msg.indexOf("#$nick_")!= -1) { //WebSocket 이 생성되고 nick을 send 받았을때
				map.put(session, msg.replace("#$nick_", ""));
				
				for (WebSocketSession webSocketSession : list) {
					SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd HH24:mm:ss");
					String out = sdf.format(new Date());
					webSocketSession.sendMessage(new TextMessage("<font style='color:green; font-size:8px;'>"+map.get(session)+"님이 방을 입장하셨습니다("+out+")</font>"));
				}
			}else { //채팅내용
				for (WebSocketSession webSocketSession : list) {
					webSocketSession.sendMessage(new TextMessage("<font style='color:black;'>"+msg+"</font>"));
				}
			}
		}
		log.info("채팅참여자들: {}" + map);
		super.handleTextMessage(session, message);
	}

}
