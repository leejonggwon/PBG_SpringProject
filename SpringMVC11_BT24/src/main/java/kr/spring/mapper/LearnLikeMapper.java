package kr.spring.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.entity.Like;

@Mapper
public interface LearnLikeMapper {

	
	//like_count +1 기능
	void likePlus(Long idx);

	//Like객체 존재여부확인
	int likeHave(Like like);
	
	//Like객체생성하기
	void insertLike(Like like);
	
	//like_available=1 로 수정하기
	void updateLike(Like like);

	//like_available 값 불러오기
	int selectLike(Like like);

	//like_count -1 기능
	void unLike(Long idx);

	//Like객체삭제
	void deleteLike(Like like);


	//like_available=1 로 수정하기
	void updateLike_0(Like like);

	

	

	
	
}
