package kr.spring;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;

import kr.spring.entity.Member;
import kr.spring.entity.Role;
import kr.spring.repository.MemberRepository;

@SpringBootTest
class SpringMvc11ApplicationTests {
	
	//DB관련 mapper 역할과 같다 
	@Autowired
	private MemberRepository memberRepository;
	
	//비밀번호 암호화 처리 
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Test
	void contextLoads() {
		//회원가입 테스트 
		Member m = new Member();
		m.setUsername("admin");
		m.setPassword(passwordEncoder.encode("1234"));
		m.setName("관리자");
		m.setRole(Role.ADMIN);
		m.setEbled(true); //계정활성화상태
		
		//회원가입 시킨다 
		//PK가 없으면 → 새 데이터라고 판단 → INSERT
		//PK가 있으면 → 기존 데이터 → UPDATE
		memberRepository.save(m); //INSERT
	}
}


