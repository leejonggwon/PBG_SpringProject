package kr.spring.config;

import javax.servlet.Filter;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

//**web.xml을 대체할 클래스
//web.xml의 기능을 담고 있는 클래스를 상속받는다 
public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer { //상속받으니 빨간줄뜨면 - 추상크래스임(추상메서드가 있다는의미)

	//Alt + Shift + S → Override/Implement Method → AbstractDispatcherServletInitializer → getServletFilters()
	@Override
	protected Filter[] getServletFilters() { //필터설정
		// 문자 인코딩을 UTF-8로 강제 설정하는 부분(태그로 되어있는부분 코드로 쓰면된다)
		CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter(); //객체설정, 문자 인코딩을 강제로 지정해주는 역할
		encodingFilter.setEncoding("UTF-8");
		encodingFilter.setForceEncoding(true);
		return new Filter[] {encodingFilter};
	}

	//RootConfig(root-context.xml) 읽어오는 부분과 같다
	@Override
	protected Class<?>[] getRootConfigClasses() { 
		// DB 설정관련 RootConfig.java 파일을 가져온다
		// 리턴타입은 Class의 배열 형태이다 → 왜냐하면 나중에 설정파일이 여러개로 돌려줄 수 있기 떄문에 
		return new Class[] {RootConfig.class}; //RootConfig를 참조한다 root-context 자바파일을 만들어서 여기에 읽겠다는 의미
	}


	//DispatcherServlet을 설정하고 
	// ServletConfig(servlet-context.xml) 읽어오는 부분과 같다
	@Override
	protected Class<?>[] getServletConfigClasses() { //Class<?>[]: 클래스파일이 배열형태로 되어 있음
		//Servlet 설정 관련 있는 Sercletconfig.java 파일을 가져온다
		return new Class[] {ServletConfig.class}; //ServletConfig를 참조한다 ServletConfig 파일을 읽어와서 사용하겠다는 의미
	}

	
	//root url 뒤에 무엇으러 시작할 것인지 servlet-mapping 역할과 같다
	@Override
	protected String[] getServletMappings() {
		return new String[] {"/"}; //root-context URL시작점
	}
	
	

}
