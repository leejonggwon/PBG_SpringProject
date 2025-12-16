package com.min.edu.socket;

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
    private MySocketHandler_ToMany toManyHandler;

    @Autowired
    private MySocketHandler_Group groupHandler;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {

        // 1:다 채팅
        registry.addHandler(toManyHandler, "/wsChat.do")
                .addInterceptors(new HttpSessionHandshakeInterceptor())
                .setAllowedOrigins("*");

        // 그룹 채팅 ⭐⭐⭐
        registry.addHandler(groupHandler, "/wsChatGr.do")
                .addInterceptors(new HttpSessionHandshakeInterceptor())
                .setAllowedOrigins("*");
    }
}
