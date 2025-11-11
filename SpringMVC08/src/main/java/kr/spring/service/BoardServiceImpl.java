package kr.spring.service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.entity.Member;
import kr.spring.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	
	//Service에서 BD를 요청하기 위해 mapper가 필요하다 
	@Autowired
	private BoardMapper mapper;

	//인터페이스의 추상메서드를 구현한다 
	@Override
	public List<Board> getList(Criteria cri) {
		//게시글 전체목록 가져오기 기능
		List<Board> list = mapper.getList(cri);
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

	
	//게시글삭제
	@Override
	public void remove(int idx) {
		mapper.delete(idx); 
	}

	//리플기능
	@Override
	public void reply(Board vo) {
		//답글기능만들기
		//vo 정보 : idx, 답글작성자ID, title, 답글내용, 답글작성자이름, indate=null, count=0, 
		// boardGroup=0, boardSequence=0, boardLevel=0, boardAvailable=0  
		System.out.println("vo 정보 : " + vo);
		
		//부모글의 idx를 기준으로 부모의 boardGroup값이 필요하다
		//부모글의 정보 가져오기 
		Board parent = mapper.read(vo.getIdx());
		
		//parent 정보 : idx, ID, title, contnent, writer, indate, count=0, 
		// boardGroup=11, boardSequence=0, boardLevel=0, boardAvailable=1
		System.out.println("parent 정보 : " + parent);
				
		//부모글의 BoardGroup값을 vo에 BoardGroup에 입력한다
		vo.setBoardGroup(parent.getBoardGroup()); 
		//시퀀스와 레벨은 부모글에 +1 해주면 된다 
		vo.setBoardSequence(parent.getBoardSequence() + 1);
		vo.setBoardLevel(parent.getBoardLevel() + 1);
		
		//현재 넣으려는 답글을 제외한 기존 같은 그룹의 댓글의
		// 시퀀스 값을 1씩 올려줘야한다 
		mapper.replySeqUpdate(parent);
		
		//답변저장기능 
		mapper.replyInsert(vo);
		
	}
	
	
	
	
}














