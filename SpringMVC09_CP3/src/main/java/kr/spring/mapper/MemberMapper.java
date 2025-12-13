package kr.spring.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.entity.Board;
import kr.spring.entity.Member;

@Mapper
public interface MemberMapper {
	
	public Member login(Member vo);

	//프로필사진 업로드
	public void profileUpdate(Member vo);

	//업데이트
	public int update(Member m); 
}
