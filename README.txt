KendoLiechtenauerMVC Maven 주석 버전

1. Eclipse Import 방법
File → Import → Maven → Existing Maven Projects → 이 폴더 선택 → Finish

2. Maven 구조
src/main/java       : Java 코드
src/main/resources  : MyBatis 설정, Mapper XML, db.properties
src/main/webapp     : JSP 화면
python_api          : Python Flask 서버 예시

3. DB 설정
src/main/resources/com/kendo/database/db.properties 파일에서
username, password를 본인 Oracle 계정으로 수정하세요.

4. 필요한 DB 시퀀스
CREATE SEQUENCE MEMBER_SEQ
START WITH 1
INCREMENT BY 1;

5. Git 브랜치 예시
브랜치 이름이 lwc라면:
git checkout -b lwc
git add .
git commit -m "Maven 구조 및 MyBatis 회원 연동 추가"
git push -u origin lwc
