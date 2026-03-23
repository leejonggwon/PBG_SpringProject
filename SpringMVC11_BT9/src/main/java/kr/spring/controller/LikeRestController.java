package kr.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.entity.Like;
import kr.spring.service.LikeService;

@RestController
@RequestMapping("/like/*")
public class LikeRestController {
	
	@Autowired
	private LikeService service;
	
	//likeCount +1 
	@PostMapping("/likePlus")
	public void likePlus( @RequestParam Long idx){
		System.out.println("좋아요+1 기능 실행");
		service.likePlus(idx);
	}
	
	//Like객체생성 생성 + like_availavle 불러오기
	@RequestMapping("/insertLike")
	@ResponseBody
	public int insertLike(Like like){
		System.out.println("like객체생성 실행");
		service.insertLike(like);
		
		System.out.println("like_available값");
		return service.selectLike(like);
	}
	
	
	
	
	
}
