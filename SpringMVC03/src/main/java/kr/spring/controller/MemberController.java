package kr.spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	//RestController가 아니고 비동기방식 메소드를 사용하기 위해서는 @ResponseBody 사용한다
	//@ResponseBody: 리턴값을 JSP 같은 뷰 이름으로 해석하지 않고, 클라이언트에게 바로 값(데이터)으로 보낸다.
	@RequestMapping("/registerCheck.do")
	public @ResponseBody int registerCheck(@RequestParam("memID") String memID){ //변수명이 다르면 @RequestParam("memID")로 매핑해야 한다
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
	
	@RequestMapping("/join.do")
	public String join(Member m, RedirectAttributes rttr, HttpSession session) { // 넘어오는 name 값과 Member 필드명이 같으면, 하나로 묶은 Member로 받을 수 있다
		                                                                         // HttpSession 사용자별 데이터를 서버에 잠깐 저장하고 관리하는 공간
		System.out.println("회원가입 기능요청");
		
		// 유효성검사: 백엔드 개발자는 필수적으로 유효성 검사를 해야 한다
		// → 값이 null 이거나 빈 문자열("")인 경우, 또는 숫자가 0인 경우를 체크한다
		if(m.getMemID() == null || m.getMemID().equals("") || //m.getMemID() == null는 jsp name값이 틀렸다는 의미
		   m.getMemPassword() == null || m.getMemPassword().equals("") ||
		   m.getMemName() == null || m.getMemName().equals("") ||
		   m.getMemAge() == 0 ||
		   m.getMemEmail() == null || m.getMemEmail().equals("") 
		   ) {
			//회원가입을 할 수 없는 부분, 하나라도 누락되어 있기 때문에 
			
			//실패시 joinForm.do로 msgType과 msg 내용을 보내함
			//msgType: "실패메세지", msg: "모든 내용을 입력하세요" 보낼것임 
			
			//리다이렉트 방식은 model을 사용할 수 없다(포워딩방식만 가능하다) → 그러므로 RedirectAAttributtes 사용한다
			// RedirectAAttributtes - 리다이렉트 방식으로 이동할때 보낼 데이를 저장하는 객체
			// RedirectAAttributtes 저장데이터는 해당 jsp에 page context에 저장된다
			// addFlashAttribute는 리다이렉트할 때 1회성으로 데이터를 전달하는 메서드
			rttr.addFlashAttribute("msgType", "실패메세지"); 
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요");
			
			return "redirect:/joinForm.do"; //다시 회원가입 입력하는 폼으로 다시 요청하도록 시킨다 	
			
		}else {
			//누락된것이 없으므로 회원가입을 시도할 수 있는 부분	
			m.setMemProfile(""); //null을 넣고 싶지 않을 때 빈 문자열로 초기화
			int cnt = mapper.join(m); //cnt가 1이면 회원가입성공, 0이면 실패  
			
			if(cnt == 1) {
				System.out.println("회원가입 성공");
				rttr.addFlashAttribute("msgType", "성공메세지"); 
				rttr.addFlashAttribute("msg", "회원가입에 성공했습니다");
				//회원가입 성공 시 로그인 처리까지 시키기
				//로그인 정보 저장 (m에 Member 정보가 저장되어 있다)
				session.setAttribute("mvo", m); 
				//세션 유지 → session.setMaxInactiveInterval(60*60); // 1시간(초 단위)
				//로그아웃 처리 → session.invalidate(); 
				return "redirect:/";
			}else {
				System.out.println("회원가입 실패");
				rttr.addFlashAttribute("msgType", "실패메세지"); 
				rttr.addFlashAttribute("msg", "회원가입에 실패했습니다");
				return "redirect:/joinForm.do";
			}
		}
	}
	
	//로그아웃
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) { //매개변수에 HttpSession 쓰면 쓸수 있다
		session.invalidate();
		return "redirect:/";
	}
	
	//로그인폼
	@RequestMapping("/loginForm.do")
	public String loginForm() { 
		return "member/loginForm";
	}
	
	
	//로그인
	@RequestMapping("/login.do")
	public String login(Member m, RedirectAttributes rttr, HttpSession session) { 
		 Member userInfo = mapper.login(m); //로그인을 하고 회원정보를 돌려받아야한다
		 
		 if(userInfo != null) {
			 System.out.println("로그인 성공");
			 	session.setAttribute("mvo", userInfo); //header.jsp에서 "mvo"로 판단하므로 "mvo"로 이름을 준다
			 	
				rttr.addFlashAttribute("msgType", "성공메세지"); 
				rttr.addFlashAttribute("msg", "로그인에 성공했습니다");
				return "redirect:/";
		 }else{
			 System.out.println("로그인 실패");
				rttr.addFlashAttribute("msgType", "실패메세지"); 
				rttr.addFlashAttribute("msg", "로그인에 실패했습니다");
				return "redirect:/loginForm.do";
		 }

	}
	
	
	
}
