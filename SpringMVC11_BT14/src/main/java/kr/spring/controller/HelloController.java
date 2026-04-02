package kr.spring.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

//비동기방식작동
@RestController
public class HelloController {
	
	@RequestMapping("/hello")
	//Sprnig Boot를 구동 및 실행하는 클래스 
	public String hello() {
		return "Hello!!Spring Boot!!";
	}
	
}


