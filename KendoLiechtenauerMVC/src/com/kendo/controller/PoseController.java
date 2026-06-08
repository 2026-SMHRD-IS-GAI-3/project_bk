package com.kendo.controller;

// Model 패키지에 있는 분석기, DAO, DTO 클래스를 가져온다.
import com.kendo.model.PoseAnalyzer;
import com.kendo.model.PoseDAO;
import com.kendo.model.PoseDTO;

// View 패키지에 있는 화면 출력/입력 담당 클래스를 가져온다.
import com.kendo.view.PoseView;

/*
 * Controller 클래스
 * ---------------------------------------
 * MVC 패턴에서 Controller는 프로그램의 흐름을 담당한다.
 *
 * View  : 사용자에게 메뉴를 보여주고 입력을 받음
 * Model : 데이터를 저장하거나 분석함
 * Controller : View와 Model 사이를 연결함
 */
public class PoseController {

    // 자바 프로그램이 처음 실행되는 시작 지점
    public static void main(String[] args) {

        // 화면 출력과 입력을 담당하는 View 객체 생성
        PoseView view = new PoseView();

        // 자세 분석 결과를 저장하고 조회하는 DAO 객체 생성
        PoseDAO dao = new PoseDAO();

        // 입력된 각도를 기준으로 자세를 분석하는 객체 생성
        PoseAnalyzer analyzer = new PoseAnalyzer();

        // 프로그램을 계속 실행하기 위한 무한 반복문
        while (true) {

            // View에서 메뉴를 출력하고 사용자가 선택한 번호를 받아온다.
            int menu = view.showMenu();

            // 1번 메뉴: 자세 분석 등록
            if (menu == 1) {

                // 사용자에게 자세 정보를 입력받아서 DTO 객체로 만든다.
                PoseDTO dto = view.inputPose();

                // 입력받은 DTO를 분석기에 넣어서 교정 결과 문자열을 받는다.
                String result = analyzer.analyze(dto);

                // 분석 결과를 DTO 안에 저장한다.
                dto.setResult(result);

                // 분석이 끝난 DTO를 DAO에 저장한다.
                dao.insertPose(dto);

                // 사용자에게 저장 완료 메시지를 출력한다.
                view.showMessage("자세 분석 결과가 저장되었습니다.");

            // 2번 메뉴: 전체 분석 결과 조회
            } else if (menu == 2) {

                // DAO에 저장된 전체 자세 분석 결과를 View로 보내 출력한다.
                view.showPoseList(dao.selectAllPose());

            // 3번 메뉴: 검도 분석 결과만 조회
            } else if (menu == 3) {

                // styleType이 KENDO인 데이터만 조회해서 출력한다.
                view.showPoseList(dao.selectByStyle("KENDO"));

            // 4번 메뉴: 리히테나워 분석 결과만 조회
            } else if (menu == 4) {

                // styleType이 LIECHTENAUER인 데이터만 조회해서 출력한다.
                view.showPoseList(dao.selectByStyle("LIECHTENAUER"));

            // 5번 메뉴: 프로그램 종료
            } else if (menu == 5) {

                // 종료 메시지 출력
                view.showMessage("프로그램을 종료합니다.");

                // while 반복문을 빠져나가 프로그램을 종료한다.
                break;

            // 메뉴 번호를 잘못 입력한 경우
            } else {

                // 잘못된 입력이라는 메시지 출력
                view.showMessage("잘못된 메뉴입니다.");
            }
        }
    }
}
