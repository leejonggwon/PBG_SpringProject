package kr.spring.controller;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletContext;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat/*")
public class ChatController  {
	
	private ServletContext servletContext; //서버가 준 ServletContext를 나중에 계속 쓰려고 보관하는 변수

    //서블릿이 생성될 때 서버가 호출하고, 웹 애플리케이션 전체 정보를 담은 ServletContext를 멤버 변수에 저장하는 역할을 한다.
	// 생성자에서 주입받기 (Spring Boot가 자동으로 넣어줌)
    public ChatController(ServletContext servletContext) {
        this.servletContext = servletContext;
        System.out.println("컨트롤러 생성 시점 ServletContext 주입 확인: " + servletContext);
    }


	//TODO 010 그룹 채팅 이동화면
	@GetMapping("/chatGroup")
	public String chatGroup() {
		log.info("ChatController 그룹 구성을 위한 화면이동");
		System.out.println("ChatController 그룹 구성을 위한 화면이동");
		return "chat/chatGroup";
	}

	//TODO 012 사용자의 아이디와 그룹은 session에 담는다. 채팅참여자의 전체 목록을 servletContext에 담아준다   
	@GetMapping("/socketOpen")	
	public String socketOpen(String gr_id, String mem_id, HttpSession session) {
		//Parameter 정보를 HttpSession에 담는 작업으로 자동으로 Bean의 HandShake_Handler에 의해서 WebSocketSession에 담아준다 
		//참여자를 HttpSession에 담는다
		
		session.setAttribute("gr_id", gr_id); //로그인정보를 담는것과 같다
		session.setAttribute("mem_id", mem_id);
		
		//서버 전체에 계속해서 참여자의 정보를 담기위해서 ServletContext를 사용한다 
		Map<String, String> chatList = (Map<String, String>)servletContext.getAttribute("chatList");
		
		if(chatList == null) {
			chatList = new HashMap<String, String>();
			chatList.put(mem_id, gr_id);
			servletContext.setAttribute("chatList", chatList);
		}else {
			chatList.put(mem_id, gr_id);
			servletContext.setAttribute("chatList", chatList);
		}
		
		log.info("ChatController 웹소캣 목록:{}", servletContext.getAttribute("chatList"));
		
		return "chat/chatGroupView"; //이 화면에서 세션을 가져와서 담아주는 작업은 bean으로 만든다
	}
	
	
	
	//TODO 018 채팅을 닫은 후에 자동으로 참여목록을 삭제해주는 REST
	@PostMapping("/socketOut")
	@ResponseBody
	public void socketOut(HttpSession session) {
		log.info("socketOut Spring Websocket 참여자 리스트를 삭제");
		String mem_id = (String)session.getAttribute("mem_id");
		Map<String, String> chatList = (Map<String, String>)servletContext.getAttribute("chatList");
		
		log.info("기존 접속 회원 리스트:{}", chatList);
		
		if(chatList != null) {
			chatList.remove(mem_id);
		}
		log.info("갱신 접속 회원 리스트 : {}", chatList);
		
		servletContext.setAttribute("chatList", chatList);
		
	}
	

	//TODO 019 입장과 퇴실시 호출되어 servletContext에 있는 리스트를 조회하여 JSON으로 반환
	@PostMapping("/viewChatList")
	@ResponseBody
	public Map<String, Map<String, String>>viewChatList(){
		Map<String, Map<String, String>> map = new HashMap<String, Map<String, String>>();
		Map<String, String> chatList = (Map<String, String>)servletContext.getAttribute("chatList");
		map.put("list", chatList);
		log.info("접속 회원 전체 조회 리스트 : {}", map);
		return map;
	}

}
