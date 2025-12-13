package kr.spring.mapper;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.entity.Member;

@Mapper
public interface BoardMapper {
	
	public List<Board> getList(Criteria cri); //게시글 전체보기 기능
	
	public void insert(Board vo); //id, 제목, 내용, 이름은 Board 형태로 넘긴다
	
	public void insertSelectKey(Board vo); //동적쿼리기술


	public Board read(int idx); //게시글상세보기

	public void update(Board vo); //게시글수정

	public void delete(int idx);

	//새로운 댓글이 들어올 때 기존의 댓글 순서를 +1 하는 기능
	public void replySeqUpdate(Board parent);

	//답글저장기능 
	public void replyInsert(Board vo);

	//전체 게시글 수 
	public int totalCount(Criteria cri);

	//조회수
	public void boardCount(int idx);




	

}


















