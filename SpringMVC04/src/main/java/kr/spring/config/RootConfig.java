package kr.spring.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

//**root-context.xml을 대체할 클래스
@Configuration // WebConfig에서 설정파일로 인식될 수 있게 달아주는 어노테이션 
@MapperScan(basePackages = {"kr.spring.mapper"}) //*SqlSessionFactoryBean이 mapper를 찾아내기위한 위치를 설정, Mapper Interface를 메모리에 올리기위해 경로설정하는 부분
@PropertySource({"classpath:persistence-mysql.properties"}) //properties를 연결시킴 //경로가 src/main/resouces를 의미한다
public class RootConfig {

	//*hikaroConfig에는 연결하기위한 정보를 가지고 있고 DataSource를 생성할때 생성자 매게변수로 hikaroConfig를 사용하고 있다 
	
	@Autowired //자동으로 객체연결하는 어노테이션
	Environment env; //프로퍼티스 파일을 읽어오는 객체
	
	
	@Bean //메모리에 사용할 수 있게 로딩하는 어노테이션 
	public DataSource myDataSources() {
		HikariConfig hikaroConfig = new HikariConfig(); //hikaroConfig 객체 생성
		hikaroConfig.setDriverClassName(env.getProperty("jdbc.driver"));
		hikaroConfig.setJdbcUrl(env.getProperty("jdbc.url"));
		hikaroConfig.setUsername(env.getProperty("jdbc.user"));
		hikaroConfig.setPassword(env.getProperty("jdbc.password"));
		
		HikariDataSource myDataSource = new HikariDataSource(hikaroConfig); //DataSource가 hikaroConfig를 생성자 매개변수로 쓰인다 
		return myDataSource;
	}
	
	//SqlSessionFactoryBean 만들기, DataSource를 참조해서 만든다 
	@Bean
	public SqlSessionFactory sessionFactory() throws Exception{
		SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
		sessionFactory.setDataSource(myDataSources()); //DataSource 정보가 필요하므로 myDataSources()를 통해 가져온다 
		return (SqlSessionFactory)sessionFactory.getObject(); //sessionFactory에 있는 객체를 돌려준다
	}
	
}
