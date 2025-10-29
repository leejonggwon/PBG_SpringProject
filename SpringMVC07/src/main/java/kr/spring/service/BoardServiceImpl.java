package kr.spring.service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.spring.entity.Board;
import kr.spring.entity.Member;
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
	
	//로그인
	@Override
	public Member login(Member vo) {
		Member mvo = mapper.login(vo);
		return mvo; //서비스는 뷰네임이 아닌 데이터를 돌려준다
		            //컨트롤러는 받아온 데이터로 뷰를 만들어서 돌려준다
	}

	//게시글 입력
	@Override
	public void register(Board vo) {
		mapper.insertSelectKey(vo);
	}

	//게시글상세보기
	@Override
	public Board get(int idx) {
		Board vo = mapper.read(idx);
		return vo;
	}
	//대부분 Mapper는 DB에 관점에 이름을 지어주고 
	//Service, Controller는 클라이언트/업무 중심 이름을 지어주는것이 일반적이다

	//게시글 업데이트
	@Override
	public void modify(Board vo) {
		//보통 DB에 있는 키워드를 사용한다 	
		mapper.update(vo); 
	}
	
	
	
	
}














