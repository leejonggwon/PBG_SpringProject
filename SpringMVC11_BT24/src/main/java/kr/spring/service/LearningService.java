package kr.spring.service;

import java.util.List;

import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.entity.Learning;

public interface LearningService {
	
	public List<Learning> getList(Criteria cri); //게시글 전체조회
	
	public void register(Learning vo); //게시글 등록 	

	public Learning get(Long idx); //게시글 상세보기
 
	public void delete(Long idx, String role); //삭제기능

	public void update(Learning vo); //수정기능

	public void boardCount(Long idx); //카운트+1

	public void reply(Learning vo); //답글기능

	public int totalCount(Criteria cri); //전체게시글수

	


	
}


























