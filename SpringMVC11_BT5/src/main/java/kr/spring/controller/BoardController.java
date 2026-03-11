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
	
	
	//게시글등록
	@PostMapping("/register")
	public String register(Board vo, @RequestParam("uploadFile") MultipartFile file, RedirectAttributes rttr) {

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
	            return "redirect:/board/register";
	        }
	    }

	    // DB 저장 실행
	    service.register(vo);
	    rttr.addFlashAttribute("result", vo.getIdx());

	    return "redirect:/board/list";
	}
	
	
	
	
	//다운로드버튼
		@GetMapping("/download/{fileName:.+}") // :.+ : 파일 이름 뒤에 붙는 마침표(.)와 확장자까지 잘리지 않게 다 가져와라는 명령
		public ResponseEntity<Resource> downloadFile(@PathVariable String fileName) {
		    try {
		        // 실제 profile 이미지가 저장된 물리적 경로
		        String uploadDir = "C:/boot_upload/board_upload/"; 
		        //path: 네비게이션 역할
		        Path path = Paths.get(uploadDir + fileName); //C:\boot_upload\profile_upload\ + a1b2c3d4...abc_test.jpg
		        //path에 찍힌 주소를 보고, 실제로 그 위치에 가서 파일이라는 '물건'을 집어 올리는 동작"
		        Resource resource = new UrlResource(path.toUri());

		        if (!resource.exists()) {
		            return ResponseEntity.notFound().build(); //없으면 404에러 뜬다
		        }

		        // 1. UUID가 붙은 파일명에서 실제 이름만 추출 (예: uuid_test.jpg -> test.jpg)
		        String downloadName = fileName;
		        if (fileName.contains("_")) { 									  //_가 들어가 있나?
		            downloadName = fileName.substring(fileName.indexOf("_") + 1); //_가 들어가 있는 +1번째 글자부터 끝까지 잘라라!
		        }

		        // 2. 한글 파일명 깨짐 방지 인코딩
		        String encodedFileName = UriUtils.encode(downloadName, StandardCharsets.UTF_8);
		        
		        // 3. 다운로드 헤더 설정 (다운로드방식과, 최종 파일 이름을 지정)
		        //  1. attachment: 첨부형태로 다운로드방식
		        //  2. filename=\"" + encodedFileName + "\" : UUID 떼고 한글인코딩 파일이름 지정
		        String contentDisposition = "attachment; filename=\"" + encodedFileName + "\"";
		        
		        //서버가 준비한 택배 상자(파일)를 브라우저에게 최종적으로 던져주는 동작
		        return ResponseEntity.ok() //파일찾기 성공했다는 상태확인 
		                .header(HttpHeaders.CONTENT_DISPOSITION, contentDisposition) //행동 지시 라벨 부착
		                .contentType(MediaType.APPLICATION_OCTET_STREAM) //내용물 종류 선언
		                .body(resource);

		    } catch (Exception e) {
		        e.printStackTrace();
		        return ResponseEntity.internalServerError().build();
		    }
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


























