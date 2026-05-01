package kr.spring.controller.socket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

//이 클래스는 “/wsChat.do는 WebSocket이고, 이 핸들러로 처리해라”라고 서버에 알려주는 설정 파일

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Autowired
    private MySocketHandler_Group groupHandler;
    
    //**스프링부트 //**생성자 주입 (빈 이름이 wsChatGr.do인 객체를 가져옴)
    // 레거시 스프링에서는 websocket-context.xml 방식에서는 스프링이 XML 파일을 읽어서 wsChatGr.do라는 이름의 빈을 알아서 찾아 연결해 줬다 
    //  스프링 부트에서는 WebSocketConfig 클래스가 실행될 때 MySocketHandler_Group 객체가 반드시 필요하다 
    //   스프링 컨테이너에 있는 MySocketHandler_Group 빈을 가져오고, 그걸 groupHandler 변수에 담아서, registerWebSocketHandlers 메서드에서 사용할 수 있게 준비한다
    public WebSocketConfig(MySocketHandler_Group groupHandler) {
        this.groupHandler = groupHandler;
    }

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {

        // 그룹 채팅
        registry.addHandler(groupHandler, "/wsChatGr.do")
                .addInterceptors(new HttpSessionHandshakeInterceptor())
                .setAllowedOrigins("*");
    }
}
