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

import kr.spring.entity.CmntComment;
import kr.spring.entity.Comment;
import kr.spring.service.CmntCommentService;
import kr.spring.service.CommentService;

@RestController
@RequestMapping("/cmntComment/*")
public class CmntCommentRestController {
	
	@Autowired
	private CmntCommentService service;
	
	
	//댓글삭제하기
	@GetMapping("/cmtDelete") 
	@ResponseBody
	public void cmtDelete(@RequestParam int cmt_idx, @RequestParam String role ) { 
		System.out.println("댓글 삭제 기능수행");
		service.cmtDelete(cmt_idx, role);
	}
	
	
	//@ResponseBody = 리턴값을 JSP로 보내지 말고, 그대로 HTTP Response로 보내라는 의미
	//@RequestParam은 GET/POST 요청에서 query string(파라미터)을 받을 때 사용되는 기본 어노테이션이다(동기비동기상관없다)
	//개별 값 단위로 받는 방식으로 단체로 받을 수 없고 여러개로 받을 수 있다 
	

	//댓글등록
	@PostMapping("/cmtInsert")  
	@ResponseBody
	public void cmtInsert(CmntComment cmt) { 
		
		System.out.println("댓글등록 기능수행");
		service.cmtInsert(cmt);
	
	}
	
	@GetMapping("/loadCmt")
    @ResponseBody
    public List<CmntComment> loadCmt(@RequestParam Long idx) {
		System.out.println("댓글리스트 기능수행");
		//System.out.println(service.loadCmt(idx));
        return service.loadCmt(idx);
    }

	
	//대댓글등록
	@PostMapping("/cmtcmtInsert")  
	@ResponseBody
	public void cmtcmtInsert(CmntComment cmt) { 
		
		System.out.println("대댓글등록 기능수행");
		service.cmtcmtInsert(cmt);
	}
	
	//cmt_group 가져오기 기능
	@GetMapping("/getCmt_group")
    @ResponseBody
    public int getCmt_group(@RequestParam int cmt_idx) {
		
		System.out.println("cmt_group 가져오기 기능");
        return service.getCmt_group(cmt_idx);
    }
	
	
	//대댓글리스트 기능수행
	@GetMapping("/loadCmtcmt")
    @ResponseBody
    public List<CmntComment> loadCmtcmt(CmntComment cmt) {
		
		System.out.println("대댓글리스트 기능수행");	
        return service.loadCmtcmt(cmt);
    }
	
	
	//cmt_cmt_count값 가져오기 기능
	@GetMapping("/getCmt_cmt_count")
    @ResponseBody
    public int getCmt_cmt_count(@RequestParam int cmt_idx) {		
		System.out.println("cmt_cmt_count값 가져오기기능");	
        return service.getCmt_cmt_count(cmt_idx);
    }
	
	
	
	
	
	
	
	
	
}
