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
	

}
