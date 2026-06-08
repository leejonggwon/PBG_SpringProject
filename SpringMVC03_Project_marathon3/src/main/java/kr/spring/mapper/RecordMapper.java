package kr.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.entity.Criteria;
import kr.spring.entity.Record;

@Mapper
public interface RecordMapper {

	//개인기록 리스트 조회하기
	public List<Record> recordList(Criteria cri);

	//기록갯수조회
	public int totalCount(Criteria cri);

}
