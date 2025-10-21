package kr.spring.controller;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.entity.Board;
import kr.spring.service.BoardService;

@Controller //@Controller로 인식
@RequestMapping("/board/*") //URL 일치시키는 설정
public class boardController {
	
	//실질적인 일은 Service가 한다
	@Autowired
	private BoardService service;
	//BoardService는 인터페이스이다 
	//구현한 클래스는 BoardServiceImpl이다. 객체가 부모타입인 BoardService로 업케스팅 된다 
	
	
	@GetMapping("/boardList.do")
	public String boardList(Model model) {
		List<Board> list = service.getList(); //자식에서 기능을 구현시켰고 업케이스팅하면
		                                      // 자식타입의 getList()가 실행된다
		model.addAttribute("list", list);
		return "board/list";
	}
	
	
	
	
	
}















