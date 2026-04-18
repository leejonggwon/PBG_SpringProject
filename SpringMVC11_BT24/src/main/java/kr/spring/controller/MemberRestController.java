package kr.spring.controller;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.entity.Comment;
import kr.spring.entity.Member;
import kr.spring.service.CommentService;
import kr.spring.service.MemberService;

@RestController
@RequestMapping("/member/*")
public class MemberRestController {
	
	@Autowired
	private MemberService service;
	
	
	//@ResponseBody: 리턴값을 JSP 같은 뷰 이름으로 해석하지 않고, 클라이언트에게 바로 값(데이터)으로 보낸다.
	@PostMapping("/registerCheck")
	@ResponseBody 
	public int registerCheck(@RequestParam String username){ 
		System.out.println("아이디 중복체크 기능");
		
		int m = service.registerCheck(username);	
		//m != null → 기존에 아이디 사용하는 경우  불가능
		//username.equals("") :  username에 값이 없는경우 
		//m == null → 기존아이디가 있는경우
		if(m == 0) {
			return 0;
		}else {
			return 1;
		}
	}
	

	@PostMapping("/nick_nameCheck")
	@ResponseBody 
	public int nick_nameCheck(@RequestParam String nick_name){ 
		System.out.println("닉네임 중복체크 기능");
		
		int m = service.nick_nameCheck(nick_name);	
		
		if(m == 0 || nick_name.equals("")) {
			return 0;
		}else {
			return 1;
		}
	}	

}
