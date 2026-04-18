package kr.spring.service;

import java.util.List;

import kr.spring.entity.Comment;

public interface CommentService {

	//댓글작성
	void cmtInsert(Comment cmt);

	//댓글조회
	List<Comment> loadCmt(Long idx);

	//댓글삭제
	void cmtDelete(int cmt_idx, String role);

	//대댓글등록
	void cmtcmtInsert(Comment cmt);

	//cmt_group 가져오기 기능
	int getCmt_group(int cmt_idx);

	//대댓글리스트 기능수행
	List<Comment> loadCmtcmt(Comment cmt);
	
	//cmt_cmt_count값 가져오기 기능
	int getCmt_cmt_count(int cmt_idx);
	

}
