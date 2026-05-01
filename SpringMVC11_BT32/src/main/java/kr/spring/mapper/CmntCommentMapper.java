package kr.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.spring.entity.CmntComment;

@Mapper
public interface CmntCommentMapper {

	//댓글작성
	//void cmtInsert(Comment cmt);
	void cmtInsertSelectKey(CmntComment cmt);

	//댓글조회하기
	List<CmntComment> loadCmt(Long idx);

	//댓글삭제하기
	void cmtDelete(@Param("cmt_idx") int cmt_idx, @Param("role") String role);
	
	//대댓글 상세보기 
	CmntComment cmtRead(int cmt_idx);

	//새로운 답글이 들어올 때 기존의 댓글 순서를 +1 하는 기능
	void cmtcmtSeqUpdate(CmntComment parent);

	//대댓글저장기능
	void cmtcmtInsert(CmntComment cmt);

	//cmt_group 가져오기 기능
	int getCmt_group(int cmt_idx);
	
	//대댓글리스트 기능수행
	List<CmntComment> loadCmtcmt(CmntComment cmt);

	//cmt_cmt_count +1하는 기능
	void cmt_cmt_countUpdate(CmntComment parent);

	//cmt_cmt_count값 가져오기 기능
	int getCmt_cmt_count(int cmt_idx);
	
	
}











