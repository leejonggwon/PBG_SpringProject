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
	//로그인할 때 아이디로 사용자 정보를 DB에서 찾아오는 담당자
	@Autowired
	private UerDetailsServiceImpl userService; 
	
	//비밀번호 인코딩 기능
	@Bean
	public PasswordEncoder passwordEncoder() { 
		return PasswordEncoderFactories.createDelegatingPasswordEncoder(); //인코딩기능(외울필요없다)
	}
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		 http.csrf().disable(); //CSRF인증 토큰 비활성화한다 
		 
		 http.authorizeHttpRequests() //사용자의 요청을 핸들링
		 	.antMatchers("/", "/member/**").permitAll()
		 	// "/" 또는 "member" 하위의 모든 접근을 허용하겠다(로그인 안해도 가능) 
		 	.antMatchers("/board/**").authenticated()
		 	// board로 접근하는 모든 경우는 인증된(로그인한)사용자만 허용한다
		 	.and() //추가
		 	.formLogin() //별도의(우리가만든) 로그인 폼을 사용하겠다
		 	.loginPage("/member/login") //로그인 페이지는 member안에 login에서 하겠다 
		 	.defaultSuccessUrl("/board/list") //로그인 성공시 "board/list"로 이동하겠다
		 	.and() //로그아웃
		 	.logout() //Spring Security에서 제공하는 기본 로그아웃을 사용하겠다 
		 	.logoutUrl("/member/logout") //로그아웃 실행하고 싶다면 "member/logout"으로 요청하겠다 
		 	.logoutSuccessUrl("/"); //로그아웃하고 "/" 로 이동하겠다 
		 
		 //로그인할 때 사용자 정보 조회는 이 userService 써라 하고 Spring Security에 알려주는 설정
		 http.userDetailsService(userService);
		 
		return http.build(); //내부환경설정을 적용시키겠다 
	}
	
}


