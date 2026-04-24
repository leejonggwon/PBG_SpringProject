package kr.spring.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.entity.Communication;
import kr.spring.entity.Criteria;
import kr.spring.mapper.CommunicationMapper;

@Service
public class CommunicationServiceImpl implements CommunicationService {
	
	//@Autowired
	//private BoardRepository boardRepository;
	
	@Autowired
	private CommunicationMapper mapper;

	//게시글출력
	@Override
	public List<Communication> getList(Criteria cri) {
		//게시글 전체목록 가져오기 기능
		List<Communication> list = mapper.getList(cri);
		return list;
	}

	//게시글등록
	@Override
	public void register(Communication vo) {
	    //mapper.register(vo);  
		mapper.insertSelectKey(vo);
	}

	//게시글 상세보기
	@Override
	public Communication get(Long idx) {
		Communication vo = mapper.read(idx);
		return vo;
		
	}

	//게시글 삭제
	@Override
	public void delete(Long idx, String role) {
		mapper.delete(idx, role);
	}

	//게시글수정
	@Override
	public void update(Communication vo) {
		//JAP의 save 메소드는
		// 전달된 데이터에 PK값이 없으면 새데이터로 판단하여 insert 기능을 
		// 이미 기존에 존재하는 PK값이 들어온다면 update를 실행한다 
		mapper.update(vo); 
	}

	//조회수+1
	@Override
	public void boardCount(Long idx) {
		mapper.boardCount(idx);
	}

	//답글등록
	@Override
	public void reply(Communication vo) {
		
		Communication parent = mapper.read(vo.getIdx());
		
		vo.setBoard_group(parent.getBoard_group());
		vo.setBoard_sequence(parent.getBoard_sequence() +1);
		vo.setBoard_level(parent.getBoard_level() +1);
		
		//부모글 parent 기준으로 기존의 답글들의 시퀀스 값을 1씩 올려준다 
		mapper.replySeqUpdate(parent);
		
		//답변저장기능 
		mapper.replyInsert(vo); 
		
		
	}

	//전체게시글수
	@Override
	public int totalCount(Criteria cri) {
		return mapper.totalCount(cri);
	}

	
}











