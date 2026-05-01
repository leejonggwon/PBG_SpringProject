package kr.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.spring.entity.Communication;
import kr.spring.entity.Criteria;

@Mapper
public interface CommunicationMapper {

	void boardCount(Long idx);

	void register(Communication vo); //게시글등록
	
	void insertSelectKey(Communication vo); //게시글등록-동적쿼리기술

	//새로운 답글이 들어올 때 기존의 댓글 순서를 +1 하는 기능
	void replySeqUpdate(Communication parent);

	//답글저장기능
	void replyInsert(Communication vo);

	//게시글출력
	List<Communication> getList(Criteria cri);

	//게시글삭제
	void delete(@Param("idx") Long idx, @Param("role") String role);

	//전체게시글수 
	int totalCount(Criteria cri);

	//게시글 수정
	void update(Communication vo);

	//게시글 상세보기 
	Communication read(Long idx);

	
	
	

}



