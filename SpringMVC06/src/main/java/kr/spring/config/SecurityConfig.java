package kr.spring.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import kr.spring.security.MemberUserDetailsService;

//**Spring Security 환경설정(보안설정)하는 클래스
@Configuration //WebConfig.java가 SecurityConfig을 가져다 쓴다, WebConfig.java에서 SecurityConfig를 읽어오기 위한 어노테이션
@EnableWebSecurity //Web에서 Security를 쓰겠다 (porm.xml에서 spring-security-web 추가한것을 가져다 사용한것임) 
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	//WebSecurityConfigurerAdapter: 스프링 시큐리티의 기본 보안 설정(로그인, 로그아웃, 권한 검사 등)을 개발자가 원하는 대로 오버라이딩해서 바꿀 수 있게 해주는 클래스
	// :요청에 대한 보안 설정을 해주는 클래스
	
	//MemberUserDetailsService역할: Spring Security에서 mapper파일을 연결하기 위해 설정해놓은 클래스
	//MemberUser역할: 우리가 만든 memberVO를  Security에 넣어주기위해 만든 클래스
	@Bean //우리가 만들어놓은 MemberUserDetailsService 메모리로 올려 사용하겠다
	public UserDetailsService memberUserDetailsService() {  //memberUserDetailsService는 UserDetailsService를 상속받았다 
		return new MemberUserDetailsService();
	}
	
	//Spring Security가 MemberUserDetailsService 가져다 쓰려면 암호화를 복호화하는 기술들이 필요하다
	//Alt + Shift + S → Overide/implement Methods → configure(AuthenticationManagerBuilder)
	//로그인할 때 유저 정보를 어디서 불러오고, 비밀번호는 어떤 방식으로 검사할지 알려주는 설정 메서드
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		//내가 만든 MemberUserDetailService와 암호화 및 복호화를 해주는 패스워드 인코더를 
		//Spring Security에 등록하는 메소드 (auth에 등록한다)
		auth
			.userDetailsService(memberUserDetailsService()) 
			/*userDetailsService: Spring Security에 userDetailsService를 등록하는 부분*/
			.passwordEncoder(passwordEncoder()); 
			/*우리가 만든 passwordEncoder를 등록하는 부분*/
	}

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
	
		// 보안 3단계 기능추가
		// 클라이어트가 요청을 했을때 회원인증부분을 권한설정을 한다 
		// → 이러한 설정은 http에 원하는 보안설정을 해야 보안이 적용이된다
		http 
			/*권한설정*/
			.authorizeRequests()  /* 요청에 따른 권한을 처리하겠다 선언하는 거 그 뒤에 붙는 .antMatchers(), .permitAll() 같은 게 실제 규칙*/
			.antMatchers("/")     /* 사이트 루트 경로("/")로 왔을때 권한처리를 적용하겠다*/
				.permitAll()      /* 누구나 접근 가능하게 허용한다 */
				.and()            /* 권한을 추가하겠다 */
			/*로그인 보안기능 추가 (스프링내부에서 쓰는 loginForm 말고 우리가 만든 loginForm 사용 할것이다) */	
			.formLogin()                         /* 로그인 보안기능 추가하겠다*/
				.loginPage("/loginForm.do")      /* Spring Security 에서 제공하는 로그인 폼 대신, 우리가 만든 로그인 폼을 사용하겠다 */
				.loginProcessingUrl("/login.do") /* 해당 login.do로 요청이 들어왔을때 Spring Security의 자체 로그인 기능을 수행하겠다(로그인기능 우리가 안만든다 */
				.permitAll()                     /* 누구나 로그인은 사용해야하기 때문에 권한은 모두 준다 */
				.and()                          
			/*로그아웃 기능*/	
			.logout()                       
				.invalidateHttpSession(true) /* 로그아웃 시 세션을 강제로 만료시키겠다 */
				.logoutSuccessUrl("/")       /* 로그아웃 성공이후 이동할 URL */
				.and()
			/*접근 제한 처리*/	
			.exceptionHandling().accessDeniedPage("/access-denied"); //access-denied.jsp로 이동 
			/* 로그인도 안하고 특정페이지에 접근하려고 할떄 설정한 URL로 막기*/				
	}
	
	//**비밀번호 암호화 환경설정
	@Bean //@Bean: 패스워드 인코딩 기능을 객체형태로 만들어서 메모리에 올리는 작업 
	public PasswordEncoder passwordEncoder() { //passwordEncoder()는 MemberController에서 @Autowired로 주입받아 사용된다
		//비밀번호 암호화 메소드(비밀번호를 특정소수로 곱한다음 64bit로 인코딩 시킨다)
		return new BCryptPasswordEncoder(); //비밀번호 암호화(해시) 클래스
	}//→ 이렇게 하면 필요할때 마다 @Autowired로 PasswordEncoder인 비밀번호 암호화해주는 객체를 주입받아서 쓸 수 있다 
	
	
	


}
