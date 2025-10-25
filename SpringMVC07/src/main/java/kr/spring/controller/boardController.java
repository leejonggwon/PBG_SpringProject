package kr.spring.controller;
import java.security.Provider.Service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.entity.Board;
import kr.spring.service.BoardService;

@Controller //@Controller로 인식
@RequestMapping("/board/*") //URL 일치시키는 설정
public class boardController {
	
	//실질적인 일은 Service가 한다
	@Autowired
	private BoardService service;
	//BoardService는 인터페이스이다 
	//BoardService 구현한 클래스는 BoardServiceImpl을 가져다 사용한다 
	//BoardServiceImpl인데 BoardServiceImpl타입으로 들어가는 이유는
	//→ *객체가 부모타입인 BoardService로 업케스팅 된다(다형성을 이유로)


	//게시글 상세보기
	@GetMapping("/get")
	public String get(@RequestParam("idx") int idx, Model model) {
		//@RequestParam 쿼리스트링이나 폼 데이터에서 하나의 값을 가져올 때 사용하는 어노테이션
		Board vo = service.get(idx); //idx와 일치하는 상세게시글
		//받아온 Board 객체를 get.jsp에 사용하기 위해 Model에 담는다
		model.addAttribute("vo", vo); 
		return "board/get";
	}
	
	
	
	//POST 게시글입력
	@PostMapping("/register")
	public String register(Board vo, RedirectAttributes rttr) { 
		//RedirectAttributes: redirect 할 때 데이터를 전달하기 위한 객체
	    service.register(vo);
	    rttr.addFlashAttribute("result", vo.getIdx()); //(key, value)
	    // addFlashAttribute로 데이터를 넣어야 리다이렉트 이후 JSP에서 꺼내서 사용할 수 있음
	  
	    return "redirect:/board/list"; 
	}

	
	//글쓰기 페이지를 이동
	@GetMapping("/register")
	public String register() {
		return "board/register";
	}
	
	
	@GetMapping("/list")
	public String boardList(Model model) {
		List<Board> list = service.getList(); //자식에서 기능을 구현시켰고 업케이스팅하면 자식타입의 getList()가 실행된다	
		                                      //service에 기능요청
		model.addAttribute("list", list);
		return "board/list";
	}
	
	
	
	

	
	
	
}















