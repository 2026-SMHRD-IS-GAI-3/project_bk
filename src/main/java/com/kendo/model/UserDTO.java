package com.kendo.model;

import java.sql.Date;

/*
 * 회원 정보를 담는 DTO 클래스
 * DTO는 DB 테이블의 한 행(row)을 Java 객체로 옮겨 담는 역할을 한다.
 *
 * DB 테이블: MEMBER
 * 컬럼: M_NUM, ID, PW, NAME, GOODS, AGE, GENDER, K_GRADE, L_GRADE, ADMIN_M, POINT, J_DATE
 */
public class UserDTO {

    // 회원번호 PK
    private int mNum;

    // 회원 아이디
    private String id;

    // 회원 비밀번호
    private String pw;

    // 회원 이름
    private String name;

    // 회원 칭호
    private String goods;

    
    // 회원 나이
    private int age;

    // 회원 성별
    private String gender;

    // 검도 등급
    private int kGrade;

    // 리히테나워 등급
    private int lGrade;

    // 관리자 권한 0 일반회원, 1 관리자 식으로 사용 가능
    private int adminM;

    // 포인트
    private int point;

    // 가입일자
    private Date jDate;
    
    //초기 프로필 설정 여부
    private String profileSet;
    
    // 기본 생성자: MyBatis가 객체를 만들 때 사용한다.
    public UserDTO() {
    }

    // 회원가입할 때 주로 사용할 생성자
    public UserDTO(String id, String pw, String name, String goods, int age, String gender,
                   int kGrade, int lGrade, int adminM, int point) {
        this.id = id;
        this.pw = pw;
        this.name = name;
        this.goods = goods;
        this.age = age;
        this.gender = gender;
        this.kGrade = kGrade;
        this.lGrade = lGrade;
        this.adminM = adminM;
        this.point = point;
    }

    // 로그인할 때 사용할 생성자
    public UserDTO(String id, String pw) {
        this.id = id;
        this.pw = pw;
    }

    public int getmNum() {
        return mNum;
    }

    public void setmNum(int mNum) {
        this.mNum = mNum;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPw() {
        return pw;
    }

    public void setPw(String pw) {
        this.pw = pw;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGoods() {
        return goods;
    }

    public void setGoods(String goods) {
        this.goods = goods;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public int getkGrade() {
        return kGrade;
    }

    public void setkGrade(int kGrade) {
        this.kGrade = kGrade;
    }

    public int getlGrade() {
        return lGrade;
    }

    public void setlGrade(int lGrade) {
        this.lGrade = lGrade;
    }

    public int getAdminM() {
        return adminM;
    }

    public void setAdminM(int adminM) {
        this.adminM = adminM;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public Date getjDate() {
        return jDate;
    }

    public void setjDate(Date jDate) {
        this.jDate = jDate;
    }

    public String getProfileSet() {
        return profileSet;
    }

    public void setProfileSet(String profileSet) {
        this.profileSet = profileSet;
    }
    
    
    
    
}
