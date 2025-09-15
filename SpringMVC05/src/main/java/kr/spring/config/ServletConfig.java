package kr.spring.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

//**servlet-context.xml을 대체할 클래스
@Configuration // WebConfig에서 설정파일로 인식될 수 있게 달아주는 어노테이션 
@EnableWebMvc  // config java 클래스가 Spring mvc 구조상에서 작동하기 위한 어노테이션
@ComponentScan(basePackages = {"kr.spring.controller"}) //*Handler Mapping에게 controller 위치잡아주는 component-scan 부분
public class ServletConfig implements WebMvcConfigurer { // WebMvcConfigurer: servlet-context.xml 기능을 가지고 있는 인터페이스

	//Alt + Shift + S → Override/Implement Method → configureViewResolvers
	//ViewResolver 설정 
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) { //여러 뷰 리졸버를 등록하고 관리하는 도구
		// servlet-context.sml에 있던 ViewResolver 설정부분을 의미
		InternalResourceViewResolver bean = new InternalResourceViewResolver(); //컨트롤러가 반환한 논리적 뷰 이름을 실제 JSP 파일 경로로 변환해주는 역할 
		bean.setPrefix("/WEB-INF/views/");
		bean.setSuffix(".jsp");
		registry.viewResolver(bean); //registry에 설정한 ViewResolver을 등록한다
	}

	//Alt + Shift + S → Override/Implement Method → addResourceHandlers
	//resouces 위치설정
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) { //registry에 리소스정보를 등록시켜야한다 
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/"); 
	} 
	
}


