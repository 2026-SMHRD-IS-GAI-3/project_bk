package com.genai.database;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionManager {
	
	// static 키워드는 객체가 생성되자마자 실행되는 구조
	// 실행과 동시에 DB의 정보를 읽어와 SqlSessionfactory를 구현
	
	public static SqlSessionFactory sqlSessionFactory;
	
	static {
		try {
			String resource = "com/genai/database/mybatis-config.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		}
		catch(Exception e) {
			
		}
	}
	
	// DB 접근시 사용하기 위한 sqlSession을 만드는 메소드 생성
	
	public static SqlSessionFactory getFactory(){
		return sqlSessionFactory;
		
	}
}
