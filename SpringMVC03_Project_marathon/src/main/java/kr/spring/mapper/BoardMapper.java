package kr.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.entity.Board;

@Mapper //MyBatis가 InterFace를 찾기위해 달아주는 부분
public interface BoardMapper {

	
// 인터페이스안에 직접 SQL문장을 다는 방식
//	@Select("SELECT * FROM BOARD ORDER BY INDATE DESC")
//	public List<Board> getLists();
	
	
	//(더많이쓰는방식)BoardMapper 인터페이스와 이 XML 파일을 연결방식
	public List<Board> getLists(); //SQL문을 전달하면, MyBatis가 알아서 기능을 구현한다, 게시글 전체보기 기능
	
	public void boardInsert(Board board);

	public Board boardContent(int idx);

	public void boardDelete(int idx);

	public void boardUpdate(Board vo);

	public void boardCount(int idx);
	

	
	
                            
}















