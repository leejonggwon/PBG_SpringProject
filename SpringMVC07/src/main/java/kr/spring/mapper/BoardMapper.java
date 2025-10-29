package kr.spring.mapper;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import kr.spring.entity.Board;
import kr.spring.entity.Member;

@Mapper
public interface BoardMapper {
	
	public List<Board> getList(); //게시글 전체보기 기능
	
	public void insert(Board vo); //id, 제목, 내용, 이름은 Board 형태로 넘긴다
	
	public void insertSelectKey(Board vo); //동적쿼리기술

	public Member login(Member vo);

	public Board read(int idx); //게시글상세보기

	public void update(Board vo); //게시글수정
}


















