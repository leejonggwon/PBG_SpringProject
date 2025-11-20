package kr.spring.service;

import java.util.List;

import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.entity.Member;

// Service 클래스에서 사용할 기능의 이름을 정의하는 인터페이스
public interface BoardService {
	
	//게시글 전체목록 보기 기능
	//Service는 Controller에게 view네임(String)이 아닌 데이터(게시글목록)을 돌려준다 
	public List<Board> getList(Criteria cri);

	//로그인 기능
	public Member login(Member vo);

	//게시글 등록
	public void register(Board vo);

	//게시글상세보기
	public Board get(int idx);

	//게시글 수정
	public void modify(Board vo);

	//게시글 삭제
	public void remove(int idx);

	//댓글등록기능
	public void reply(Board vo);

	//전체 게시글 수 
	public int totalCount(Criteria cri);


	
	
}


