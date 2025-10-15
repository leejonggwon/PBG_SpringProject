package kr.spring.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.spring.entity.Member;
import kr.spring.entity.MemberUser;
import kr.spring.mapper.MemberMapper;

public class MemberUserDetailsService implements UserDetailsService{
	//**역할: Spring Security에서 Mapper 파일을 연결하기위한 연결 클래스 → Service 
	//UserDetailsService는 Spring Security에서 사용자 인증(Authentication) 정보를 제공하는 인터페이스
	
	@Autowired //객체를 자동으로 찾아서 넣어주는(의존성 주입)
	private MemberMapper mapper; //회원의 정보를 연결할 mapper
	
	//**login.do요청하면 loadUserByUsername로 넘어온다 
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// //username에는 로그인성공한 id만 있다  
		// id(username이라한다)를 기준으로 로그인 정보를 가져오는 메소드 
		// 내부적으로 보이지는 않지만, 스프링 시큐리티가 해당 아이디를 가진 계정을 가져오고, 암호화된 비밀번호 비교까지 해서 로그인을 체크하는 메소드
		
		//로그인 처리하기
		//loadUserByUsername로 진행되면 이미 SpringSecurity가 알아서 로그인 기능을 다 끝마친 상태(비밀번호체크할 필요없다) 
		// 이제 개발자는 중간에 비밀번호를 알 수 있는 방법이 없다 
		Member mvo = mapper.login(username); 
		// Spring Security 내부 보안 규정상 우리가 직접만든 클래스 객체 (VO)
		// 직접만든 클래스(VO) 객체는 내부보안 규정상 바로 담을 수 없다 → 내가 원하는 VO를 담을 수 있게 변환해주는 User Class가 필요하다
		
		if(mvo != null) { //해당 사용자 존재한다는 의미
			return new MemberUser(mvo); //User가 UserDetails 클래스를 상속받고 
										//MemberUser가 User를 상속받으므로 MemberUser 형태로 돌려준다
		}else {
			//해당 사용자 없음 
			throw new UsernameNotFoundException("user with username" + username + "does not exit.");
		}
	}
	
}
