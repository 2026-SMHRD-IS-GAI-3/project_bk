검도 / 리히테나워 자세 교정 MVC 예제

이 프로젝트는 Java Eclipse에서 실행할 수 있는 콘솔 기반 MVC 예제입니다.
모든 Java 코드에 주석을 추가했습니다.

패키지 구조
- com.kendo.controller
  - PoseController.java : 프로그램 실행 흐름 담당

- com.kendo.model
  - PoseDTO.java : 자세 분석 데이터 저장용 객체
  - PoseDAO.java : 자세 분석 결과 저장/조회 담당
  - PoseAnalyzer.java : 각도 기준으로 자세 피드백 생성

- com.kendo.view
  - PoseView.java : 메뉴 출력, 사용자 입력, 결과 출력 담당

실행 방법
1. Eclipse에서 Java Project를 생성합니다.
2. src 폴더 안에 com/kendo/controller, model, view 패키지를 만듭니다.
3. 각 Java 파일을 같은 위치에 넣습니다.
4. PoseController.java를 실행합니다.

참고
- 현재는 DB 없이 ArrayList에 임시 저장합니다.
- Eclipse에서 실행을 종료하면 저장된 데이터는 사라집니다.
- 나중에 Oracle DB, MyBatis, JSP/Servlet으로 확장할 수 있습니다.
