package kr.spring.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

//**Spring Security 보안에 대한 환경설정하는 클래스
@Configuration     //WebConfig(환경설정파일)가 SecurityConfig를 읽어오기 위한 어노테이션
@EnableWebSecurity //웹 보안을 적용하라고 알려주는 스위치로 필터, 인증, 권한 체크 같은 웹 보안 기능을 자동으로 등록한다. spring-security-web 모듈 안 기능들을 사용 가능하게 연결해주는 역할한다
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	//WebSecurityConfigurerAdapter: 스프링 시큐리티의 기본 보안 설정(로그인, 로그아웃, 권한 검사 등)을 개발자가 원하는 대로 오버라이딩해서 바꿀 수 있게 해주는 클래스
	// :요청에 대한 보안 설정을 해주는 클래스
	
	//WebSecurityConfigurerAdapter 메서드에 대한 오버라이드한다
	// :Alt + Shift + S → Override/Implement Method → configure(HttpSecurity) 
	
	// 요청에 대한 보안 설정하는 곳
	// HttpSecurity http 제일 먼저 들르므로 http에 설정해줘야한다 
	@Override
	protected void configure(HttpSecurity http) throws Exception { 
		//Spring Security 내부 공간에도 인코딩을 해줘야한다
		CharacterEncodingFilter filter = new CharacterEncodingFilter(); //문자 인코딩 처리를 담당
		filter.setEncoding("UTF-8"); 
		filter.setForceEncoding(true);
		http.addFilterBefore(filter, CsrfFilter.class); //http에 등록시키고 filter를 장착시키고 CsrfFilter에 적용하겠다 
	}
	
	
	
	


}
