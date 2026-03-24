package kr.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.entity.Comment;

@Mapper
public interface CommentMapper {

	//댓글작성
	//void cmtInsert(Comment cmt);
	void cmtInsertSelectKey(Comment cmt);

	//댓글조회하기
	List<Comment> loadCmt(Long idx);

	//댓글삭제하기
	void cmtDelete(int cmt_idx);
	
	//대댓글 상세보기 
	Comment cmtRead(int cmt_idx);

	//새로운 답글이 들어올 때 기존의 댓글 순서를 +1 하는 기능
	void cmtcmtSeqUpdate(Comment parent);

	//대댓글저장기능
	void cmtcmtInsert(Comment cmt);
	
	
	
	
}
