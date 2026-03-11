package kr.spring.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.spring.entity.CustomUser;
import kr.spring.entity.Member;
import kr.spring.repository.MemberRepository;
//로그인기능
//** MemberUserDetailService와 같은 역할로 프로젝트 방식대로 MemberRepository를 사용해 DB 접근해서 username과 일치하는 회원을 찾아와서 
// AuthenticationManagerBuilder에게 반환한다 
@Service //Service로 작동해야한다 
public class UserDetailsServiceImpl implements UserDetailsService{ //스프링시큐리티 로그인을 하고 싶다면 반드시 UserDetailsService를 구현해야한다 

	@Autowired
	private MemberRepository memberRepository; //예전에는 memeberMapper였음
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		//**로그인기능
		//로그인 성공한 사람의 username이 넘어온다 
		
		//해당일치하는 아이디를 찾는다 
		//get을 쓰면 Optional 형태에서 해당되는 VO형태로 받아온다 
		Member member = memberRepository.findById(username).get();
		
		//입력한 아이디(username)에 해당하는 사용자가 없다는 것을 스프링시큐리티에게 알리는 예외 
		if(member == null) {
			throw new UsernameNotFoundException(username + "없음");
		}
		
		//UserDetails 형태로 돌려준다
		// CustomUser는 User를 상속받고 User는 UserDetail에 상속받는다
		return new CustomUser(member);
	}
}




