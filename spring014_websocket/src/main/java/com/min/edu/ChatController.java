package com.min.edu;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.context.ServletConfigAware;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatController implements ServletConfigAware {
	
	private ServletContext servletContext; //서버가 준 ServletContext를 나중에 계속 쓰려고 보관하는 변수

    //서블릿이 생성될 때 서버가 호출하고, 웹 애플리케이션 전체 정보를 담은 ServletContext를 멤버 변수에 저장하는 역할을 한다.
	@Override
	public void setServletConfig(ServletConfig servletConfig) {
		servletContext = servletConfig.getServletContext();
		System.out.println("setServletConfig 생성값 :" + servletContext);
	}
	
	@GetMapping(value="/chatOneToMany.do")
	public String chatOneToMany() {
		log.info("ChatController 일대다 화면이동 요청");
		return "chatOneToMany"; 
	}
	
	@GetMapping(value="/")
	public String index() {
		return "index"; 
	}
	

}
