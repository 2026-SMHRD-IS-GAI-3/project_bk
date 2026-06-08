package com.kendo.view;

import java.util.ArrayList;
import java.util.Scanner;

import com.kendo.model.PoseDTO;

/*
 * View 클래스
 * ---------------------------------------
 * MVC 패턴에서 View는 사용자에게 화면을 보여주고
 * 사용자의 입력을 받는 역할을 한다.
 *
 * 이 프로젝트는 콘솔 프로그램이기 때문에
 * System.out.println으로 출력하고 Scanner로 입력받는다.
 */
public class PoseView {

    // 키보드 입력을 받기 위한 Scanner 객체
    private Scanner sc = new Scanner(System.in);

    /*
     * 메뉴 출력 메서드
     * 사용자에게 메뉴를 보여주고 선택한 번호를 int로 반환한다.
     */
    public int showMenu() {
        System.out.println();
        System.out.println("===== 검도 / 리히테나워 자세 교정 프로그램 =====");
        System.out.println("1. 자세 분석 등록");
        System.out.println("2. 전체 분석 결과 조회");
        System.out.println("3. 검도 분석 결과 조회");
        System.out.println("4. 리히테나워 분석 결과 조회");
        System.out.println("5. 종료");
        System.out.print("메뉴 선택 >> ");

        // 사용자가 입력한 메뉴 번호를 반환한다.
        return sc.nextInt();
    }

    /*
     * 자세 정보 입력 메서드
     * 사용자에게 ID, 검술 종류, 자세 이름, 각도를 입력받고
     * PoseDTO 객체로 만들어서 반환한다.
     */
    public PoseDTO inputPose() {

        // 사용자 ID 입력
        System.out.print("회원 ID 입력 >> ");
        String userId = sc.next();

        // 검술 종류 선택 메뉴 출력
        System.out.println("검술 종류 선택");
        System.out.println("1. 대한검도");
        System.out.println("2. 리히테나워 검술");
        System.out.print("선택 >> ");
        int styleMenu = sc.nextInt();

        // 검술 종류를 저장할 변수
        String styleType = "";

        // 1번을 선택하면 대한검도 데이터로 저장
        if (styleMenu == 1) {
            styleType = "KENDO";
            System.out.println("예시 자세: 중단세, 타격");

        // 2번을 선택하면 리히테나워 검술 데이터로 저장
        } else if (styleMenu == 2) {
            styleType = "LIECHTENAUER";
            System.out.println("예시 자세: VomTag, Pflug, Ochs, Alber,");

        // 그 외 번호를 입력하면 UNKNOWN으로 저장
        } else {
            styleType = "UNKNOWN";
        }

        // 자세 이름 입력
        System.out.print("자세 이름 입력 >> ");
        String poseName = sc.next();

        // 어깨 각도 입력
        System.out.print("어깨 각도 입력 >> ");
        double shoulderAngle = sc.nextDouble();

        // 팔꿈치 각도 입력
        System.out.print("팔꿈치 각도 입력 >> ");
        double elbowAngle = sc.nextDouble();

        // 무릎 각도 입력
        System.out.print("무릎 각도 입력 >> ");
        double kneeAngle = sc.nextDouble();

        // 입력받은 값들을 PoseDTO 객체에 담아서 반환한다.
        // poseId는 DAO에서 자동으로 넣어줄 것이므로 0으로 넣는다.
        // result는 아직 분석 전이라서 "분석 전"으로 넣는다.
        return new PoseDTO(0, userId, styleType, poseName,
                shoulderAngle, elbowAngle, kneeAngle, "분석 전");
    }

    /*
     * 분석 결과 목록 출력 메서드
     * DAO에서 받은 ArrayList를 화면에 출력한다.
     */
    public void showPoseList(ArrayList<PoseDTO> list) {
        System.out.println();
        System.out.println("===== 분석 결과 =====");

        // 저장된 데이터가 없으면 안내 문구 출력 후 메서드 종료
        if (list.size() == 0) {
            System.out.println("저장된 분석 결과가 없습니다.");
            return;
        }

        // 리스트에 들어있는 PoseDTO 객체를 하나씩 꺼내서 출력한다.
        for (PoseDTO dto : list) {
            System.out.println("번호 : " + dto.getPoseId());
            System.out.println("회원 ID : " + dto.getUserId());
            System.out.println("검술 종류 : " + dto.getStyleType());
            System.out.println("자세명 : " + dto.getPoseName());
            System.out.println("어깨 각도 : " + dto.getShoulderAngle());
            System.out.println("팔꿈치 각도 : " + dto.getElbowAngle());
            System.out.println("무릎 각도 : " + dto.getKneeAngle());
            System.out.println("교정 결과 : " + dto.getResult());
            System.out.println("-----------------------------");
        }
    }

    /*
     * 메시지 출력 메서드
     * Controller에서 전달받은 문자열을 화면에 출력한다.
     */
    public void showMessage(String msg) {
        System.out.println(msg);
    }
}
