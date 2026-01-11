package kr.spring.service;

import java.util.List;

import kr.spring.entity.Board;

public interface BoardService {
	
	public List<Board> getList(); //게시글 전체조회
	
	public void register(Board vo); //게시글 등록 	

	public Board get(Long idx); //게시글 상세보기
 
	public void delete(Long idx); //삭제기능

	public void update(Board vo); //수정기능
	
}


























