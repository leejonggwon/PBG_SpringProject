package kr.spring.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.entity.LearnComment;
import kr.spring.mapper.LearnCommentMapper;



@Service
public class LearnCommentServiceImpl implements LearnCommentService {
	
	@Autowired
	private LearnCommentMapper mapper;

	//댓글작성
	@Override
	public void cmtInsert(LearnComment cmt) {	
		mapper.cmtInsertSelectKey(cmt);
	}

	//댓글조회
	@Override
	public List<LearnComment> loadCmt(Long idx) {
		return mapper.loadCmt(idx);
	}

	//댓글삭제하기
	@Override
	public void cmtDelete(int cmt_idx, String role) {
		mapper.cmtDelete(cmt_idx, role);
	}

	//대댓글등록
	@Override
	public void cmtcmtInsert(LearnComment cmt) {
		
		//cmt_idx부모댓글
		LearnComment parent = mapper.cmtRead(cmt.getCmt_idx());
		System.out.println("parent값 "+  parent);
		
		cmt.setCmt_group(parent.getCmt_group());
		cmt.setCmt_sequence(parent.getCmt_sequence() +1);
		cmt.setCmt_level(parent.getCmt_level() +1);
	
		//새로운 대댓글 들어올 때 기존의 댓글 순서를 +1 하는 기능(원본글은 제외)
		mapper.cmtcmtSeqUpdate(parent);
		
		//새로운 대댓글 들어올때 cmt_cmt_count+1 하는 기능
		mapper.cmt_cmt_countUpdate(parent);
		
		//대댓글저장기능 
		mapper.cmtcmtInsert(cmt); 
	}

	//cmt_group 가져오기 기능
	@Override
	public int getCmt_group(int cmt_idx) {
		return mapper.getCmt_group(cmt_idx);
	}

	//대댓글리스트 기능수행
	@Override
	public List<LearnComment> loadCmtcmt(LearnComment cmt) {
		return mapper.loadCmtcmt(cmt);
	}

	//cmt_cmt_count값 가져오기 기능
	@Override
	public int getCmt_cmt_count(int cmt_idx) {
		return mapper.getCmt_cmt_count(cmt_idx);
	}
	
	
	

}
