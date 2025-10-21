package kr.spring.mapper;

import java.sql.Connection;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.context.WebApplicationContext;

import kr.spring.entity.Board;
import kr.spring.service.BoardServiceImpl;
import lombok.extern.log4j.Log4j;

@Log4j //테스트 실행결과를 콘솔창에 나오는 역할
@RunWith(SpringJUnit4ClassRunner.class) //실행하기위해 스프링컨테이너에 올리는 코드 
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"}) //root-context.xml 경로를 잡아주는 과정 (스프링 컨테이너 만들 때, 이 설정 파일을 참고해라)
@WebAppConfiguration //Servlet 컨테이너를 사용하기 위한 어노테이션, JUnit 테스트에서 웹 관련 객체를 사용할 수 있도록 웹 환경을 구성해준다
public class DataSouceTest {
	// root-context.xml이 이상없는지 test하는 클래스 
	
	//Connection이 잘되는지 테스트
	@Autowired //root-context.xml에 있는 id가 dataSource인 녀석을 사용하겠다 
	private DataSource dataSource; //javax.sql
	
	//mapper 테스트
	@Autowired
	private BoardMapper mapper;
	
	//Service 테스트
	@Autowired
	private BoardServiceImpl service;
	
	//콘트롤러 테스트
	@Autowired
	private WebApplicationContext ctx; 
	//Spring Container 메모리 공간 객체(Controller, ViewResolver 등 포함)
	
	private MockMvc mockMvc; 
	//가상의 MVC 웹 환경 만들어주는 객체(브라우저 없이 코드로 요청을 흉내내는 거야), 뷰, 핸들러, 맵핑 등등 실행해줌 
	
	
	
//	//Service 테스트
//	@Test
//	public void testGetList() {
//		List<Board> list = service.getList();
//		for(Board vo: list) {
//			System.out.println(vo.toString());
//		}
//	}
	
//  //mapper 테스트	
//	@Test
//	public void testGetList() {
//		List<Board> list = mapper.getList();
//		for(Board vo: list) {
//			System.out.println(vo.toString());
//		}
//	}
	
	//Test는 하나만 해야하므로 주석처리 한다 
//  //Connection 테스트
//	@Test
//	public void testConnection() {
//		try(Connection conn = dataSource.getConnection()){ //Connection를 가져온다 
//			log.info(conn); //이상없이 실행되면 info에 정보를 꺼낸다
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
//	}
	

}
