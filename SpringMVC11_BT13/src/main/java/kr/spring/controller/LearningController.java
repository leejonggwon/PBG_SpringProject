package kr.spring.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriUtils;

import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.entity.Learning;
import kr.spring.entity.PageMaker;
import kr.spring.service.BoardService;
import kr.spring.service.LearningService;

@Controller
@RequestMapping("/learning/*")
public class LearningController {
	
	@Autowired
	private LearningService service;
	
	//게시글 전체조회	
	//Criteria: 현재 몇 번째 페이지를 보고 있는지, 한 페이지에 몇 개의 게시글을 보여줄 것인지에 대한 정보가 필요하다
	//PageMaker: 몇 번 페이지에 하단에 보여줄 페이지 버튼을 몇 개  만들지, 이전/다음 버튼을 표시할지 등 '계산기' 같은 역할
	@RequestMapping("/learning_list")
	public String list(Model model, Criteria cri) { 
		
		List<Learning> list = service.getList(cri); 
		
		PageMaker pageMaker = new PageMaker();
		
		//tempEndPage를 계산하기 위해 Criteria 정보를 참조한다
		pageMaker.setCri(cri);	
		
		//천체게시글수를 구한다
		pageMaker.setTotalCount(service.totalCount(cri));
		
		model.addAttribute("list", list);
		
		//페이지 정보를 가지고 있는 객체를 전달한다(Criteria정보, 총게시글수)
		model.addAttribute("pageMaker", pageMaker);
		
		return "learning/learning_list";
	}
	
	
	//게시글등록
	@PostMapping("/register")
	public String register(Learning vo, 
			@RequestParam("uploadFile") MultipartFile file, 
			RedirectAttributes rttr) {

	    if (file != null && !file.isEmpty()) {
	        try {
	            String savePath = "C:/boot_upload/board_upload/";
	            
	            //C:\boot_upload\board_upload
	            File dir = new File(savePath);
	            //mkdirs(): dir(경로)이 삭제되어 있으면 생성한다	    
	            if (!dir.exists()) dir.mkdirs();

	            String originalFilename = file.getOriginalFilename();
	            //파일 이름이 겹치지 않도록 고유한 이름을 만들어 저장한다 시간을 밀리초(ms) 단위로 반환한다 
	            //1773263966352_lee.png
	            //UUID.randomUUID().toString() + "_" + originalFilename; 방식도 있음
	            String saveFilename = System.currentTimeMillis() + "_" + originalFilename;
	            
	            // 저장경로에 파일 저장
	            file.transferTo(new File(savePath + saveFilename));

	            // DB에 저장할 '파일명'을 필드(attached_data)에 직접 넣어준다
	            vo.setAttached_data(saveFilename);

	        } catch (IOException e) {
	            e.printStackTrace();
	            rttr.addFlashAttribute("msg", "파일 업로드 실패");
	            return "redirect:/learning/learning_list";
	        }
	    } //if (file != null && !file.isEmpty())

	    // DB 저장 실행
	    service.register(vo);
	    return "redirect:/learning/learning_list";
	}
	


	//비동기
	//게시글 상세보기
	//일반 Controller에서 비동기방식 응답해야하는 메소드가 있다면
	// RestController를 만들거나 ResponseBody 어노테이션을 붙여줘야한다
	//Board의 idx는 Long 타입이다 
	@GetMapping("/get")
	public @ResponseBody Learning get(@RequestParam("idx") Long idx) {
		Learning vo = service.get(idx);
		service.boardCount(idx); //조회수+1 가능
		
		return vo;
	}
	
	//삭제기능
	@GetMapping("/remove") 
	public String remove(@RequestParam("idx") Long idx, @RequestParam("role") String role, Criteria cri, RedirectAttributes rttr) {
		service.delete(idx, role);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/learning/learning_list";
	}
	
	
	
	//수정기능
	//RedirectAttributes: redirect 할 때 데이터를 담아서 보내는 용도 
	@PostMapping("/modify") 
	public String modify(Learning vo, @RequestParam("uploadFile") MultipartFile file, Criteria cri, RedirectAttributes rttr) {
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		if (file != null && !file.isEmpty()) {
	        try {
	            String savePath = "C:/boot_upload/board_upload/";
	            File dir = new File(savePath);
	            if (!dir.exists()) dir.mkdirs();

	            String originalFilename = file.getOriginalFilename();
	            String saveFilename = System.currentTimeMillis() + "_" + originalFilename;

	            // 실제 파일 저장
	            file.transferTo(new File(savePath + saveFilename));

	            // 여기서 중요! 
	            // DB에 저장할 '파일명'을 VO의 String 필드(attached_data)에 직접 넣어줌
	            vo.setAttached_data(saveFilename);

	        } catch (IOException e) {
	            e.printStackTrace();
	            rttr.addFlashAttribute("msg", "파일 업로드 실패");
	            return "redirect:/learning/learning_list";
	        }
	    }
		
		rttr.addFlashAttribute("result", vo.getIdx());
		
		service.update(vo);

		return "redirect:/learning/learning_list";
	}
	

	
	//비동기
	//조회수실시간반영
	@GetMapping("/showCount")
	public @ResponseBody Learning showCount(@RequestParam("idx") Long idx) {
		
		Learning vo = service.get(idx);			
		return vo;
	}
	
	//공감수 실시간반영
	@GetMapping("/showLike_count")
	public @ResponseBody Learning showLike_count(@RequestParam("idx") Long idx){
		Learning vo = service.get(idx);			
		return vo;
	}	
	

	//댓글기능
	@PostMapping("/reply")
	public String reply(Learning vo, @RequestParam("uploadFile") MultipartFile file, Criteria cri, RedirectAttributes rttr) {
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		if (file != null && !file.isEmpty()) {
	        try {
	            String savePath = "C:/boot_upload/board_upload/";
	            File dir = new File(savePath);
	            if (!dir.exists()) dir.mkdirs();

	            String originalFilename = file.getOriginalFilename();
	            String saveFilename = System.currentTimeMillis() + "_" + originalFilename;

	            // 실제 파일 저장
	            file.transferTo(new File(savePath + saveFilename));

	            // 여기서 중요! 
	            // DB에 저장할 '파일명'을 VO의 String 필드(attached_data)에 직접 넣어줌
	            vo.setAttached_data(saveFilename);

	        } catch (IOException e) {
	            e.printStackTrace();
	            rttr.addFlashAttribute("msg", "파일 업로드 실패");
	            return "redirect:/learning/learning_list";
	        }
	    }
		
		rttr.addFlashAttribute("result", vo.getIdx());
		
		service.reply(vo);

		return "redirect:/learning/learning_list";
	}
	
	
}


























