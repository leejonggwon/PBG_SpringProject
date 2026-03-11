package kr.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.entity.Member;
import kr.spring.service.MemberService;

@Controller
@RequestMapping("/member/*") //member로 들어오는것 처리한다 
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PasswordEncoder passwordEncoder; 
	//사용자의 비밀번호를 안전하게 해싱(Hashing)해서 저장하거나, 로그인할 때 입력한 비밀번호가 DB에 있는 거랑 맞는지 비교할 때 쓰는 도구
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	//회원가입폼 이동
	@GetMapping("/joinForm")
	public String joinForm() {
		return "member/joinForm";
	}
	
	//회원가입 기능
	@PostMapping("/join")
	public String join(Member m) {
		m.setPassword(passwordEncoder.encode(m.getPassword()));
		memberService.join(m);
		return "index";
	}

}


