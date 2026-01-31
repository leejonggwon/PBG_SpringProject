package kr.spring;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("kr.spring.mapper")
public class SpringMvc11_BTApplication {

	public static void main(String[] args) {
		//Spring Boot를 구동 및 실행하는 클래스 
		SpringApplication.run(SpringMvc11_BTApplication.class, args);
	} 
}


