package kr.spring.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

//**Spring Security 환경설정(보안설정)하는 클래스
@Configuration //WebConfig.java가 SecurityConfig을 가져다 쓴다, WebConfig.java에서 SecurityConfig를 읽어오기 위한 어노테이션
@EnableWebSecurity //Web에서 Security를 쓰겠다 (porm.xml에서 spring-security-web 추가한것을 가져다 사용한것임) 
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	//WebSecurityConfigurerAdapter: 스프링 시큐리티의 기본 보안 설정(로그인, 로그아웃, 권한 검사 등)을 개발자가 원하는 대로 오버라이딩해서 바꿀 수 있게 해주는 클래스
	// :요청에 대한 보안 설정을 해주는 클래스
	
	
	//WebSecurityConfigurerAdapter에 있는 메서드 오버라이드한다: Alt + Shift + S → Override/Implement Method → configure(HttpSecurity) 
	@Override
	protected void configure(HttpSecurity http) throws Exception { //HttpSecurity: 전체적인 보안을 담당한다 
		// 요청에 대한 보안 설정하는 곳
		
		//Spring Security 내부 공간에도 한글 인코딩을 해줘야한다
		CharacterEncodingFilter filter = new CharacterEncodingFilter(); //요청(request)과 응답(response)의 문자 인코딩을 강제로 지정해주는 역할
		filter.setEncoding("UTF-8"); 
		filter.setForceEncoding(true);
		
		//인코딩 등록하기
		http.addFilterBefore(filter, CsrfFilter.class); 
		//기준 필터 앞에 내가 만든 필터를 실행시켜라(UTF-8 인코딩 강제 적용, CSRF 토큰 검증을 담당하는 필터) → CsrfFilter 실행 전에 내가 만든 CharacterEncodingFilter를 끼워 넣어라 
	}
	
	//**비밀번호 암호화 환경설정
	@Bean //@Bean: 패스워드 인코딩 기능을 객체형태로 만들어서 메모리에 올리는 작업 
	public PasswordEncoder passwordEncoder() { //passwordEncoder()는 MemberController에서 @Autowired로 주입받아 사용된다
		//비밀번호 암호화 메소드(비밀번호를 특정소수로 곱한다음 64bit로 인코딩 시킨다)
		return new BCryptPasswordEncoder(); //비밀번호 암호화(해시) 클래스
	}//→ 이렇게 하면 필요할때 마다 @Autowired로 PasswordEncoder인 비밀번호 암호화해주는 객체를 주입받아서 쓸 수 있다 
	
	
	


}
