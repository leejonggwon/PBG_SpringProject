package kr.spring.config;

import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;
//Spring Security를 작동할 수 있는 클래스를 만들어줘야한다(어디에 만들든 상관은 없다)

//**spring Security를 사용하기 위한 클래스(스프링보안 사용하겠다 선언클래스 밖에 안된다)
public class SecurityInitializer extends AbstractSecurityWebApplicationInitializer{
	//AbstractSecurityWebApplicationInitializer
	// :springSecurityFilterChain을 자동 등록 → 로그인, 권한 체크, 세션 관리 같은 보안 기능이 모든 요청에 적용됨
	// :상속만 받으면 자동으로 보인관련 객체들이 생성되어서 스프링 켄테이너(메모리공간)으로 올라간다
	

}
