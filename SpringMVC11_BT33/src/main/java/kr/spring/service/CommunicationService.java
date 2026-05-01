package kr.spring.service;

import java.util.List;

import kr.spring.entity.Communication;
import kr.spring.entity.Criteria;

public interface CommunicationService {
	
	public List<Communication> getList(Criteria cri); //게시글 전체조회
	
	public void register(Communication vo); //게시글 등록 	

	public Communication get(Long idx); //게시글 상세보기
 
	public void delete(Long idx, String role); //삭제기능

	public void update(Communication vo); //수정기능

	public void boardCount(Long idx); //카운트+1

	public void reply(Communication vo); //답글기능

	public int totalCount(Criteria cri); //전체게시글수

	


	
}


























