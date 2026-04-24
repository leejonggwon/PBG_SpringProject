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
import kr.spring.mapper.MemberMapper;
import kr.spring.repository.MemberRepository;
import kr.spring.service.BoardService;

@SpringBootTest
class SpringMvc11ApplicationTests {
	
	//DB관련 mapper 역할과 같다 
	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private MemberMapper mapper;
	
	//비밀번호 암호화 처리 
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private BoardService boardService;


	
	@Test
	void registerMoreMembers() {
		
		Member m1 = new Member();
		m1.setUsername("admin02");
		m1.setPassword(passwordEncoder.encode("!2qqqqqq"));
		m1.setRole(Role.ADMIN);
		m1.setCourse("BACK");
		m1.setName("코드아카데미 관리자");
		m1.setNick_name("코드아케미 관리자02");
		m1.setAge(30);
		m1.setGender("남자");
		m1.setEmail("codeAcademy02@gmail.com");
		m1.setProfile("");
		m1.setEnabled(true);
		m1.setUser_code(generateRandomCode(5));
		mapper.join(m1);
	}
	
	
	
	
	//User_code
	public String generateRandomCode(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        java.util.Random random = new java.util.Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            sb.append(characters.charAt(random.nextInt(characters.length())));
        }
        return sb.toString();
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


