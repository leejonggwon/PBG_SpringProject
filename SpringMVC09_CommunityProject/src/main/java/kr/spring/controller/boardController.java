package kr.spring.controller;
import java.io.File;
import java.io.IOException;
import java.security.Provider.Service;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
	
	
	
	
	//test
		@GetMapping("/test")
		public String template() {
			return "board/test";
		}
	
	
	//댓글등록기능
	//Board vo = 부모글 번호, 작성ID, 제목, 답글, 작성자 이름
	@PostMapping("/reply")
	public String reply(Board vo, Criteria cri, RedirectAttributes rttr) {  
		service.reply(vo);
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	
	//댓글기능 페이지 이동기능
	@GetMapping("/reply")
	public String reply(@RequestParam("idx") int idx, Model model, @ModelAttribute("cri") Criteria cri) {
		//idx는 답글을 달고 싶어하는 게시글 번호를 의미한다 
		// service.get(idx)은 답글을 달고싶은 게스글 정보를 가져온다  
		Board vo = service.get(idx);
		model.addAttribute("vo", vo); 
		return "board/reply";
	}
	
	//삭제기능
	@GetMapping("/remove")
	public String remove(@RequestParam("idx") int idx, Criteria cri, RedirectAttributes rttr) {
		service.remove(idx);
		
		//page 이름으로 매개변수로 받아온 cri.page 값을 넣어준다 
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/board/list";
	}

	//게시글 수정화면 
	@GetMapping("/modify")
	public String modify(@RequestParam("idx") int idx, Model model, @ModelAttribute("cri") Criteria cri) {
		//수정화면에는 새로 DB를 조회하므로 service.get(idx)을 그대로 사용한다
		Board vo = service.get(idx);  
		model.addAttribute("vo", vo); 
		return "board/modify";
	}
	
	
	//게시글 수정기능
	//같은 이름의 메소드: 오버로딩
	@PostMapping("/modify")
	public String modify(Board vo, Criteria cri, RedirectAttributes rttr) {
		//보통 서비스까지 메소드명과 URL요청값을 동일하게 한다
		service.modify(vo); 
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/board/list"; //DB변경이 있으면 redirect 사용
	}
	

	//게시글 상세보기
	@GetMapping("/get")                                          // model.addAttribute(cri)와 같은역할 
	public String get(@RequestParam("idx") int idx, Model model, @ModelAttribute("cri") Criteria cri) {
		//@RequestParam 쿼리스트링이나 폼 데이터에서 하나의 값을 가져올 때 사용하는 어노테이션
		Board vo = service.get(idx); //idx와 일치하는 상세게시글
		//받아온 Board 객체를 get.jsp에 사용하기 위해 Model에 담는다

		model.addAttribute("vo", vo); 
		return "board/get";
	}

	
	@PostMapping("/register")
	public String register(Board vo, RedirectAttributes rttr, HttpServletRequest request) { 

	    // 파일 업로드 경로
	    String savePath = request.getServletContext().getRealPath("/resources/board");
	    File dir = new File(savePath);
	    if (!dir.exists()) dir.mkdirs();

	    MultipartRequest multi = null;
	    int fileMaxSize = 5000 * 1024 * 10;
	    DefaultFileRenamePolicy def = new DefaultFileRenamePolicy();

	    try {
	        multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", def);

	        // MultipartRequest에서 폼 값 읽기
	        vo.setMemID(multi.getParameter("memID"));
	        vo.setTitle(multi.getParameter("title"));
	        vo.setContent(multi.getParameter("content"));
	        vo.setWriter(multi.getParameter("writer"));

	        // 업로드된 파일명 가져오기
	        String filename = multi.getFilesystemName("imgpath");
	        vo.setImgpath(filename);

	    } catch (IOException e) {
	        e.printStackTrace();
	        rttr.addFlashAttribute("msg", "파일 업로드 실패");
	        return "redirect:/board/register";
	    }

	    // DB 저장
	    service.register(vo);
	    rttr.addFlashAttribute("result", vo.getIdx());

	    return "redirect:/board/list"; 
	}


	
	//글쓰기 페이지를 이동
	@GetMapping("/register")
	public String register() {
		return "board/register";
	}
	
	
	@RequestMapping("/list")
	public String boardList(Model model, Criteria cri) {
		//이제는 페이지 정보를 알고 있는 Criteria 객체를 Service에게 전달해준다
		List<Board> list = service.getList(cri); 
		
		//페이징 처리에 필요한 PageMaker 객체도 생성해야한다
		PageMaker pageMaker = new PageMaker();	
		
		//PageMaker가 페이징 기법을 하기위해 Criteria 정보가 필요하다 
		pageMaker.setCri(cri);       	
		//totalCount는 서비스를 통해 totalCount 메소드를 통해 구한다
		pageMaker.setTotalCount(service.totalCount(cri)); 
		
		model.addAttribute("list", list);
		
		//페이징 정보를 알고있는 객체를 전달한다 
		//pageMaker에는 Criteria 정보, 총 게시글 수 정보를 가지고 있다
		model.addAttribute("pageMaker", pageMaker);
		
		return "board/list";
	}

}















