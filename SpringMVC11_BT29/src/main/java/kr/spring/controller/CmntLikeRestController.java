package kr.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.entity.Board;
import kr.spring.entity.CmntLike;
import kr.spring.entity.Like;
import kr.spring.service.CmntLikeService;
import kr.spring.service.LearnLikeService;
import kr.spring.service.LikeService;

@RestController
@RequestMapping("/cmntLike/*")
public class CmntLikeRestController {
	
	@Autowired
	private CmntLikeService service;

	
	//likeCount +1 
	@PostMapping("/likePlus")
	public void likePlus( @RequestParam Long idx){
		System.out.println("좋아요+1 기능 실행");
		service.likePlus(idx);
	}
	
	//Like객체 존재여부확인
	@GetMapping("/likeHave")
	public int likeHave(CmntLike like){
		System.out.println("Like객체 존재여부확인");
		return service.likeHave(like);
	}
	
	//Like객체생성 생성 
	@RequestMapping("/insertLike")
	public void insertLike(CmntLike like){
		System.out.println("like객체생성 실행");
		service.insertLike(like);
	}
	
	//like_available=1 로 수정하기
	@RequestMapping("/updateLike")
	public void updateLike(CmntLike like){
		System.out.println("like객체생성 실행");
		service.updateLike(like);
	}
	
	
	
	//Like객체 likeAvailable 불러오기
	@GetMapping("/selectLike")
	@ResponseBody
	public int selectLike(CmntLike like){
		System.out.println("like_available값 불러오기");
		return service.selectLike(like);
	}
	
	//likeCount -1
	@PostMapping("/unLike")
	public void unLike(@RequestParam Long idx) {
		System.out.println("좋아요-1 실행");
		service.unLike(idx);
	}
	
	
	//like_available=0 로 수정하기
	@PostMapping("/updateLike_0")
	public void updateLike_0(CmntLike like){
		System.out.println("like_available=0 로 수정하기 기능");
		service.updateLike_0(like);
	}
	
	
	
}
