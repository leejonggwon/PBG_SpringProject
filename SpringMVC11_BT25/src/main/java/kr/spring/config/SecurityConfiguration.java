package kr.spring.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration //환경설정파일 설정
public class SecurityConfiguration {
	
	//로그인기능을 해주는 기능
	// 로그인 창에 입력된 아이디(username)를 들고 DB로 달려가서 유저의 정보를 싹 긁어오는 담당자
	@Autowired
	private UerDetailsServiceImpl userService; 
	
	//비밀번호 인코딩 기능
	// 사용자가 입력한 생짜 비밀번호와 DB에 저장된 암호화된 비밀번호가 일치하는지 확인하는 기계
	@Bean
	public PasswordEncoder passwordEncoder() { 
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
	
	//보안 정책 설계도
	//HttpSecurity는 모든 요청을 받아드린다
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		 http.csrf().disable(); //CSRF(사이트 간 요청 위조) 보호 기능을 비활성화한다 
		 
		 http.authorizeHttpRequests() //사용자의 요청에 따른 권한을 처리하겠다 
		 	.antMatchers("/", "/member/**").permitAll()
		 	// "/" 또는 "member" 하위의 모든 접근을 허용하겠다(로그인 안해도 가능) 
		 	.antMatchers("/board/**").authenticated()
		 	.antMatchers("/learning/**").authenticated()
		 	// board로 접근하는 모든 경우는 인증된(로그인한)사용자만 허용한다
		 	.and() 
		 	.formLogin() 
		 	.loginPage("/member/login") 
		 	//시큐리티가 제공하는 기본창 말고 우리가만든 별도의 로그인 폼을 사용하겠다
		 	//로그인 페이지는 member/login를 사용한다  
		 	.defaultSuccessUrl("/learning/learning_list") //로그인 성공시 "board/list"로 이동하겠다
		 	.and() 
		 	.logout() 
		 	.logoutUrl("/member/logout") 
		 	//Spring Security에서 제공하는 기본 로그아웃을 사용하겠다 
		 	//로그아웃 실행하고 싶다면 "member/logout"으로 요청하겠다 
		 	.logoutSuccessUrl("/member/login"); //로그아웃하고 "/" 로 이동하겠다 
		 
		 //로그인할 때 사용자정보조회는 userService 사용한다라고 Spring Security에 알려주는 설정
		 //로그인 검사를 할 때, DB에서 유저 정보를 꺼내오는 담당자로 userService를 지정한다'는 뜻
		 http.userDetailsService(userService);
		 
		return http.build(); //내부환경설정을 적용시키겠다 
	}
	
}


