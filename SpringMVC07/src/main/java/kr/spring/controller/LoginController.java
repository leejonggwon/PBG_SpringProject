package kr.spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.entity.Member;
import kr.spring.service.BoardService;

@Controller
@RequestMapping("/login/*") //login으로 해서 들어오는것들은 LoginController에서 받아드린다 
public class LoginController {
	
	//MemberService를 따로 만들어야하지만 로그인,로그아웃 기능만 사용하므로 BoardService 가져다 사용한다 
	@Autowired
	private BoardService service;
	
	
	//로그아웃
	@RequestMapping("/logoutProcess")
	public String logout(HttpSession session) {
		session.invalidate(); //세션만료(3tier가지 않는다)
		return "redirect:/board/list";
	}
		
	
	//로그인
	@RequestMapping("/loginProcess")
	public String login(Member vo, HttpSession session) { //id와 password Member vo에 담김
		
		Member mvo = service.login(vo); //일치하면 Member 형태로 로그인한 회원의 모든 정보들어있다
		
		if(mvo != null) {
			session.setAttribute("mvo", mvo); //세션저장
		}

		return "redirect:/board/list";
	}
	
	
}



















