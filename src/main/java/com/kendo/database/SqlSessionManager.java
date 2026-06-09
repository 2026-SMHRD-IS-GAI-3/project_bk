package com.kendo.database;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/*
 * MyBatis 연결을 관리하는 클래스
 *
 * 역할:
 * 1. mybatis-config.xml 파일을 읽는다.
 * 2. SqlSessionFactory 객체를 만든다.
 * 3. DAO에서 DB 작업할 수 있도록 SqlSessionFactory를 제공한다.
 */
public class SqlSessionManager {

    // SqlSessionFactory는 DB 연결을 만들 때 사용하는 핵심 객체
    private static SqlSessionFactory sqlSessionFactory;

    // static 블록은 이 클래스가 처음 사용될 때 한 번만 실행된다.
    static {
        try {
            // Maven 구조에서는 src/main/resources 안의 파일이 classpath로 잡힌다.
            String resource = "com/kendo/database/mybatis-config.xml";

            // 설정 파일을 InputStream으로 읽어온다.
            InputStream inputStream = Resources.getResourceAsStream(resource);

            // MyBatis 설정 파일을 바탕으로 SqlSessionFactory 생성
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

        } catch (Exception e) {
            // DB 설정 파일 경로가 틀렸거나 DB 정보가 틀리면 여기서 에러가 난다.
            e.printStackTrace();
        }
    }

    // DAO에서 SqlSessionFactory를 가져갈 때 사용하는 메서드
    public static SqlSessionFactory getFactory() {
        return sqlSessionFactory;
    }
}
