package kr.spring;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.entity.Member;
import kr.spring.entity.Role;
import kr.spring.repository.MemberRepository;
import kr.spring.service.BoardService;

@SpringBootTest
class SpringMvc11ApplicationTests {
	
	//DB관련 mapper 역할과 같다 
	@Autowired
	private MemberRepository memberRepository;
	
	//비밀번호 암호화 처리 
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private BoardService boardService;

	@Test
	void contextLoads() {
		//회원가입 테스트 
		Member m = new Member();
		m.setUsername("admin");
		m.setPassword(passwordEncoder.encode("1234"));
		m.setName("관리자");
		m.setRole(Role.ADMIN);
		m.setEnabled(true); //계정활성화상태
		
		//회원가입 시킨다 
		//PK가 없으면 → 새 데이터라고 판단 → INSERT
		//PK가 있으면 → 기존 데이터 → UPDATE
		memberRepository.save(m); //INSERT
	}
	
	@Test
	void testGetList() {
		
		Criteria cri = new Criteria();
		
		List<Board> list = boardService.getList(cri);
		
		for(Board vo : list) {
			System.out.println(vo.toString());
		}
	}
	
}


