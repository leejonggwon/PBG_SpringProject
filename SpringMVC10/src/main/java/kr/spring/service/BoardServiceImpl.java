package kr.spring.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.entity.Board;
import kr.spring.repository.BoardRepository;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardRepository boardRepository;

	//게시글출력
	@Override
	public List<Board> getList() {
		List<Board> list = boardRepository.findAll(); 
		return list;
	}

	//게시글등록
	@Override
	public void register(Board vo) {
		boardRepository.save(vo); //save 메소는 JPA가 만든것
	}

	//게시글 상세보기
	@Override
	public Board get(Long idx) {
		//Optional: java.utill
		Optional<Board> vo = boardRepository.findById(idx);
		//vo는 Board형태가 아닌 Optional로 감싸져있는 형태
		//vo.get()하면 Optional 안에 있는 Board를 접근한다
		return vo.get();
	}

	//게시글 삭제
	@Override
	public void delete(Long idx) {
		boardRepository.deleteById(idx);
	}

	//게시글수정
	@Override
	public void update(Board vo) {
		//JAP의 save 메소드는
		// 전달된 데이터에 PK값이 없으면 새데이터로 판단하여 insert 기능을 
		// 이미 기존에 존재하는 PK값이 들어온다면 update를 실행한다 
		boardRepository.save(vo); 
	}
	
}











