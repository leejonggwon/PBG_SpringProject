package kr.spring.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.entity.Like;

@Mapper
public interface LikeMapper {
	
	//likeCount +1 기능
	void likePlus(Long idx);

	//Like객체생성하기
	void insertLike(Like like);

	//like_available 값 불러오기
	int selectLike(Like like);

	
	
}
