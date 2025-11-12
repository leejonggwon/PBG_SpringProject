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
import kr.spring.entity.Criteria;
import kr.spring.entity.PageMaker;
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
	
	
	//댓글등록기능
	//Board vo = 부모글 번호, 작성ID, 제목, 답글, 작성자 이름
	@PostMapping("/reply")
	public String reply(Board vo) {  
		service.reply(vo);
		return "redirect:/board/list";
	}
	
	
	//댓글기능 페이지 이동기능
	@GetMapping("/reply")
	public String reply(@RequestParam("idx") int idx, Model model) {
		//idx는 답글을 달고 싶어하는 게시글 번호를 의미한다 
		// service.get(idx)은 답글을 달고싶은 게스글 정보를 가져온다  
		Board vo = service.get(idx);
		model.addAttribute("vo", vo); 
		return "board/reply";
	}
	
	
	
	//삭제기능
	@GetMapping("/remove")
	public String remove(@RequestParam("idx") int idx) {
		service.remove(idx);
		return "redirect:/board/list";
	}

	//게시글 수정화면 
	@GetMapping("/modify")
	public String modify(@RequestParam("idx") int idx, Model model) {
		//수정화면에는 새로 DB를 조회하므로 service.get(idx)을 그대로 사용한다
		Board vo = service.get(idx);  
		model.addAttribute("vo", vo); 
		return "board/modify";
	}
	
	
	//게시글 수정기능
	//같은 이름의 메소드: 오버로딩
	@PostMapping("/modify")
	public String modify(Board vo) {
		//보통 서비스까지 메소드명과 URL요청값을 동일하게 한다
		service.modify(vo); 
		return "redirect:/board/list"; //DB변경이 있으면 redirect 사용
	}
	

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
		System.out.println("전 " + vo.getIdx());
		
	    service.register(vo);
	    rttr.addFlashAttribute("result", vo.getIdx()); //(key, value)형태로 
	    // addFlashAttribute로 데이터를 넣어야 리다이렉트 이후 JSP에서 꺼내서 사용할 수 있음
	    
	    System.out.println("후 " + vo.getIdx()); //selectKey태그의 order="BEFORE"때문에 쿼리문 실행전에 getIdx값이 나온다
	    return "redirect:/board/list"; 
	}

	
	//글쓰기 페이지를 이동
	@GetMapping("/register")
	public String register() {
		return "board/register";
	}
	
	
	@GetMapping("/list")
	public String boardList(Model model, Criteria cri) {
		//이제는 페이지 정보를 알고 있는 Criteria 객체를 Service에게 전달해준다
		List<Board> list = service.getList(cri); 
		
		//페이징 처리에 필요한 PageMaker 객체도 생성해야한다
		PageMaker pageMaker = new PageMaker();
		
		//PageMaker가 페이징 기법을 하기위해 Criteria 정보가 필요하다 
		pageMaker.setCri(cri);       
		
		//totalCount는 서비스를 통해 totalCount 메소드를 통해 구한다
		pageMaker.setTotalCount(service.totalCount()); 
		
		model.addAttribute("list", list);
		
		//페이징 정보를 알고있는 객체를 전달한다 
		//pageMaker에는 Criteria 정보, 총 게시글 수 정보를 가지고 있다
		model.addAttribute("pageMaker", pageMaker);
		
		return "board/list";
	}
	
	
	
	

	
	
	
}















