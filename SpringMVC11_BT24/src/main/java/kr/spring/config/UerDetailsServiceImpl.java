package kr.spring.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.spring.entity.CustomUser;
import kr.spring.entity.Member;
import kr.spring.repository.MemberRepository;
//** 시큐리티로그인 기능으로 MemberRepository를 사용해 DB에 접근해서 username과 일치하는 회원을 찾아와서 AuthenticationManagerBuilde에게 반환하는 기능
//로그인을 시도할때 스프링시큐리티가 username을 가진 정보를 요청을 하면 수행하는 클래스
@Service //Service로 작동해야한다 
public class UerDetailsServiceImpl implements UserDetailsService{

	@Autowired
	private MemberRepository memberRepository; 
	
	//로그인 성공한 사람의 username이 넘어온다 
	//Member 형태가 아닌 userDetails 형태로 돌려준다 //CustomUser(Member형태를 변환) - User - User는 UserDetail 상속받는다
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
			
		//해당일치하는 아이디를 찾는다 
		//get을 쓰면 Optional 에서 해당되는 VO형태로 받아온다 
		Member member = memberRepository.findById(username).get();
		
		//입력한 아이디(username)에 해당하는 사용자가 없다는 것을 스프링시큐리티에게 알리는 예외 
		if(member == null) {
			//입력한 아이디가 DB에 없을 때 발생
			throw new UsernameNotFoundException(username + "없음"); //admin없음
		}
		
		if (!member.isEnabled()) {
			//계정이 비활성화됨 (탈퇴, 관리자가 정지 등)
		    throw new DisabledException("탈퇴 처리된 계정입니다. 고객센터에 문의하세요.");
		}

		//return에 member를 돌려줄수 없고 UserDetails 형태로 돌려줘야한다
		// CustomUser는 User를 상속받고 User는 UserDetail에 상속받는다
		return new CustomUser(member);
	}
}




