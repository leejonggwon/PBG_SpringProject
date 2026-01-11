package kr.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.entity.Board;
import kr.spring.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/list")
	public String list(Model model) { //게시글 전체조회	
		List<Board> list = boardService.getList(); 
		model.addAttribute("list",list);
		return "list";
	}
	
	//게시글 등록
	@PostMapping("/register")
	public String register(Board vo) {
		boardService.register(vo);
		return "redirect:/list";
	}
	
	//게시글 상세보기
	//일반 Controller에서 비동기방식 응답해야하는 메소드가 있다면
	// RestController를 만들거나 ResponseBody 어노테이션을 붙여줘야한다
	//Board의 idx는 Long 타입이다 
	@GetMapping("/get")
	public @ResponseBody Board get(@RequestParam("idx") Long idx ) {
		Board vo = boardService.get(idx);
		return vo;
	}
	
	//삭제기능
	@GetMapping("/remove")
	public String remove(@RequestParam("idx") Long idx) {
		boardService.delete(idx);
		return "redirect:/list";
	}
	
	//수정기능
	@PostMapping("/modify")
	public String modify(Board vo) {
		boardService.update(vo);
		return "redirect:/list";
	}
	
	
}


























