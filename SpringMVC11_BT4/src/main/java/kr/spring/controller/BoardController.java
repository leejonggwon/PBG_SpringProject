package kr.spring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.entity.PageMaker;
import kr.spring.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	//게시글 전체조회	
	//Criteria: 현재 몇 번째 페이지를 보고 있는지, 한 페이지에 몇 개의 게시글을 보여줄 것인지에 대한 정보가 필요하다
	//PageMaker: 몇 번 페이지에 하단에 보여줄 페이지 버튼을 몇 개  만들지, 이전/다음 버튼을 표시할지 등 '계산기' 같은 역할
	@RequestMapping("/list")
	public String list(Model model, Criteria cri) { 
		
		List<Board> list = service.getList(cri); 
		
		PageMaker pageMaker = new PageMaker();
		
		//tempEndPage를 계산하기 위해 Criteria 정보를 참조한다
		pageMaker.setCri(cri);	
		
		//천체게시글수를 구한다
		pageMaker.setTotalCount(service.totalCount(cri));
		
		model.addAttribute("list", list);
		
		//페이지 정보를 가지고 있는 객체를 전달한다(Criteria정보, 총게시글수)
		model.addAttribute("pageMaker", pageMaker);
		
		return "board/list";
	}
	
	@PostMapping("/register") //게시글 등록
	public String register(Board vo) {
		service.register(vo);
		return "redirect:/board/list";
	}
	
	//비동기
	//게시글 상세보기
	//일반 Controller에서 비동기방식 응답해야하는 메소드가 있다면
	// RestController를 만들거나 ResponseBody 어노테이션을 붙여줘야한다
	//Board의 idx는 Long 타입이다 
	@GetMapping("/get")
	public @ResponseBody Board get(@RequestParam("idx") Long idx) {
		Board vo = service.get(idx);
		service.boardCount(idx); //조회수+1 가능
		
		return vo;
	}
	//삭제기능
	@GetMapping("/remove") 
	public String remove(@RequestParam("idx") Long idx, Criteria cri, RedirectAttributes rttr) {
		service.delete(idx);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/board/list";
	}
	//수정기능
	//RedirectAttributes: redirect 할 때 데이터를 담아서 보내는 용도 
	@PostMapping("/modify") 
	public String modify(Board vo, Criteria cri, RedirectAttributes rttr) {
		service.update(vo);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	//비동기
	//조회수실시간반영
	@GetMapping("/showCount")
	public @ResponseBody Board showCount(@RequestParam("idx") Long idx) {
		
		Board vo = service.get(idx);			
		return vo;
	}
	
	//댓글기능
	@PostMapping("/reply")
	public String reply(Board vo, Criteria cri, RedirectAttributes rttr) {
		service.reply(vo);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	
}


























