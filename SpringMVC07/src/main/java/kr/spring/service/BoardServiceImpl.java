package kr.spring.service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.spring.entity.Board;
import kr.spring.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	
	//Service에서 BD를 요청하기 위해 mapper가 필요하다 
	@Autowired
	private BoardMapper mapper;

	//인터페이스의 추상메서드를 구현한다
	@Override
	public List<Board> getList() {
		//게시글 전체목록 가져오기 기능
		List<Board> list = mapper.getList();
		return list;
	}
}














