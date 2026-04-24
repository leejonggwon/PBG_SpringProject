package kr.spring.service;

import kr.spring.entity.CmntLike;

public interface CmntLikeService {
	

	//like_count +1
	void likePlus(Long idx);

	//Like객체 존재여부확인
	int likeHave(CmntLike like);
	
	//Like 객체생성하는 기능
	void insertLike(CmntLike like);
	
	//like_available=1 로 수정하기
	void updateLike(CmntLike like);

	//like_availavle 값 불러오기
	int selectLike(CmntLike like);

	//like_count -1
	void unLike(Long idx);

	//like_available=0 로 수정하기
	void updateLike_0(CmntLike like);
		
	//like 객체삭제
	void deleteLike(CmntLike like);

	


	

	

	

}
