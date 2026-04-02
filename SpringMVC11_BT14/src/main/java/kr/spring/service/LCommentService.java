package kr.spring.service;

import java.util.List;
import kr.spring.entity.LComment;

public interface LCommentService {

	//댓글작성
	void cmtInsert(LComment cmt);

	//댓글조회
	List<LComment> loadCmt(Long idx);

	//댓글삭제
	void cmtDelete(int cmt_idx, String role);

	//대댓글등록
	void cmtcmtInsert(LComment cmt);
	

}
