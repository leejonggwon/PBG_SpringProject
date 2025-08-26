package kr.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.entity.Member;
import kr.spring.mapper.BoardMapper;
import kr.spring.mapper.MemberMapper;

@Controller
public class MemberController {
	
	//MemberMapper → 인터페이스 
	@Autowired
	private MemberMapper mapper; //SqlSessionFactoryBean → DB와 MyBatis 환경을 연결하는 설정 담당
									
	
	@RequestMapping("/joinForm.do")
	public String joinForm() {
		System.out.println("회원가입 페이지로 이동");
		return "member/joinForm"; //뷰네임을 돌려준다
	}
	
	//RestController가 아니면 비동기방식 메소드를 사용하기 위해서는 @ResponseBody 사용한다 
	@RequestMapping("/registerCheck.do")
	public @ResponseBody int registerCheck(@RequestParam("memID") String memID){
		System.out.println("아이디 중복체크");
		Member m = mapper.registerCheck(memID);
		//m == null → 아이디 중복가능
		//m != null → 아이디 사용 불가능
		if(m != null || memID.equals("")) {
			return 0;
		}else {
			return 1;
		}
	}
	
	
	
	

}
