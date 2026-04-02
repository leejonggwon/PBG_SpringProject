package kr.spring.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.entity.LComment;
import kr.spring.mapper.LCommentMapper;


@Service
public class LCommentServiceImpl implements LCommentService {
	
	@Autowired
	private LCommentMapper mapper;

	//댓글작성
	@Override
	public void cmtInsert(LComment cmt) {	
		mapper.cmtInsertSelectKey(cmt);
	}

	//댓글조회
	@Override
	public List<LComment> loadCmt(Long idx) {
		return mapper.loadCmt(idx);
	}

	//댓글삭제하기
	@Override
	public void cmtDelete(int cmt_idx, String role) {
		mapper.cmtDelete(cmt_idx, role);
	}

	//대댓글등록
	@Override
	public void cmtcmtInsert(LComment cmt) {
		
		//cmt_idx부모댓글
		LComment parent = mapper.cmtRead(cmt.getCmt_idx());
		System.out.println("parent값 "+  parent);
		
		cmt.setCmt_group(parent.getCmt_group());
		cmt.setCmt_sequence(parent.getCmt_sequence() +1);
		cmt.setCmt_level(parent.getCmt_level() +1);
	
		//새로운 대댓글 들어올 때 기존의 댓글 순서를 +1 하는 기능(원본글은 제외)
		mapper.cmtcmtSeqUpdate(parent);
		
		//대댓글저장기능 
		mapper.cmtcmtInsert(cmt); 
	}
	
	
	

}
