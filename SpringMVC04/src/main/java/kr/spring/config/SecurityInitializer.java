package kr.spring.config;

import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;

//*목적: Spring Security를 작동할 수 있는 클래스
//*spring Security를 사용하기 위한 클래스(스프링보안 사용하겠다 선언클래스이다)
public class SecurityInitializer extends AbstractSecurityWebApplicationInitializer{
	//AbstractSecurityWebApplicationInitializer
	// : 웹 애플리케이션의 보안을 초기화하기 위한 추상 클래스
	// : 상속받으면 자동으로 보인관련 객체들이 생성되어서 스프링 켄테이너(IOC컨테이너 메모리공간)으로 올라간다

}
