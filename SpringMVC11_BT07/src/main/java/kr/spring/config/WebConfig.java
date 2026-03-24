package kr.spring.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
	//외부인은 절대 못 들어오는 서버의 비밀 창고(C드라이브 폴더)에 가짜 문(가상 경로)을 하나 만들어주는 역할
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {	
        registry.addResourceHandler("/profile_upload/**") 		     
			    	//가상 경로(가짜 주소) 설정
                     //브라우저가 서버에 /profile_upload/test.jpg 를 요청할 때 사용하는 주소
			    	 //**는 그 뒤에 어떤 파일 이름이 와도 다 받아주겠다는 의미
                .addResourceLocations("file:///C:/boot_upload/profile_upload/");	    
			    	//실제 경로(진짜 위치) 연결: 
                     //브라우저가 가짜 주소로 요청을 보내면, 서버는 내부적으로 C:/boot_upload/...을 연결한다
			         // common.jsp에서 /upload/ 로 요청이 오면 C:/boot_upload/profile_upload/로 파일을 찾는다 
        
        registry.addResourceHandler("/board_upload/**")
        // 윈도우라면 file:/// 다음에 드라이브 명이 바로 오는 이 형식을 가장 추천해
        .addResourceLocations("file:///C:/boot_upload/board_upload/");
        
    }
}



