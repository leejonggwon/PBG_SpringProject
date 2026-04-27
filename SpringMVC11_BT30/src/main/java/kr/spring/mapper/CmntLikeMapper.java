package kr.spring.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.entity.CmntLike;

@Mapper
public interface CmntLikeMapper {

	
	//like_count +1 기능
	void likePlus(Long idx);

	//Like객체 존재여부확인
	int likeHave(CmntLike like);
	
	//Like객체생성하기
	void insertLike(CmntLike like);
	
	//like_available=1 로 수정하기
	void updateLike(CmntLike like);

	//like_available 값 불러오기
	int selectLike(CmntLike like);

	//like_count -1 기능
	void unLike(Long idx);

	//Like객체삭제
	void deleteLike(CmntLike like);


	//like_available=1 로 수정하기
	void updateLike_0(CmntLike like);

	

	

	
	
}
