package kr.spring;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("kr.spring.mapper") //마이바티스(MyBatis) 매퍼 인터페이스가 어디 있는지 자동으로 찾아내서 빈(Bean)으로 등록해 주는 도구
public class SpringMvc11_BTApplication {

	public static void main(String[] args) {
		//Spring Boot를 구동 및 실행하는 클래스 
		SpringApplication.run(SpringMvc11_BTApplication.class, args);
	} 
}


