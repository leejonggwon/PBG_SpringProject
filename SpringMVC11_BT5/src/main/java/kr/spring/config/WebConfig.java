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
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
    	//<img>태그로 화면에 사진을 보여줄때 사용된다 
    	//브라우저는 보안때문에 실제경로를 직접 열어볼 권한이 없다 그래서 가상경로를 만들어 연결한다
        // common.jsp에서 /upload/ 로 요청이 오면 C:/boot_upload/profile_upload/로 파일을 찾는다
        registry.addResourceHandler("/profile_upload/**") //가상경로
                .addResourceLocations("file:///C:/boot_upload/profile_upload/");
        
        
    }
}