package kr.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.entity.Criteria;
import kr.spring.entity.PageMaker;
import kr.spring.entity.Record;
import kr.spring.mapper.RecordMapper;

@Controller
@RequestMapping("/record/*") 
public class RecordController {
	@Autowired
	private RecordMapper mapper;
	
	
	//개인기록 조회페이지
	@RequestMapping("/recordSearch.do") 
	public String recordSearch() {
	    System.out.println("개인기록 조회페이지로 이동");

	    return "record/recordSearch";                                                             
	}
	
	
	// 개인기록 리스트 조회하기
	@RequestMapping("/recordList.do") 
	public String recordList(Model model, Criteria cri) {
	    System.out.println("개인기록 조회하기 기능 실행");
	    
	    List<Record> list = mapper.recordList(cri);
	
	    PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    
	    int totalCount = mapper.totalCount(cri); 
	    pageMaker.setTotalCount(totalCount);
	    
	    // 4. JSP 화면으로 데이터 전달
	    model.addAttribute("list", list);
	    model.addAttribute("pageMaker", pageMaker);
	    
	    return "record/recordList";                                                             
	}
	
	

}
