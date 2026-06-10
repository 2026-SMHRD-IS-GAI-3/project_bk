package com.kendo.model;

import java.util.ArrayList;

/*
 * DAO 클래스
 * ---------------------------------------
 * DAO는 Data Access Object의 줄임말이다.
 *
 * 원래 DAO는 DB에 데이터를 저장하거나 조회할 때 사용한다.
 * 지금은 DB 연결 전 단계라서 ArrayList를 임시 저장소로 사용한다.
 * 나중에 Oracle DB나 MyBatis로 바꿀 수 있다.
 */
public class PoseDAO {

    // 자세 분석 결과를 저장할 ArrayList
    // PoseDTO 객체들이 이 리스트 안에 저장된다.
    private ArrayList<PoseDTO> poseList = new ArrayList<PoseDTO>();

    // 분석 결과 번호를 자동으로 증가시키기 위한 변수
    // 첫 번째 데이터는 1번부터 시작한다.
    private int sequence = 1;

    /*
     * 자세 분석 결과 저장 메서드
     * Controller에서 분석이 끝난 DTO를 넘겨주면 리스트에 저장한다.
     */
    public void insertPose(PoseDTO dto) {

        // DTO에 자동 번호를 넣어준다.
        // sequence++는 현재 값을 넣고 나서 1 증가한다.
        dto.setPoseId(sequence++);

        // ArrayList에 DTO 객체를 저장한다.
        poseList.add(dto);
    }

    /*
     * 전체 분석 결과 조회 메서드
     * 저장된 모든 자세 분석 결과를 반환한다.
     */
    public ArrayList<PoseDTO> selectAllPose() {
        return poseList;
    }

    /*
     * 검술 종류별 분석 결과 조회 메서드
     * styleType 값이 KENDO 또는 LIECHTENAUER인 데이터만 골라서 반환한다.
     */
    public ArrayList<PoseDTO> selectByStyle(String styleType) {

        // 조건에 맞는 데이터만 담을 새로운 리스트 생성
        ArrayList<PoseDTO> resultList = new ArrayList<PoseDTO>();

        // 전체 저장 리스트를 하나씩 반복해서 확인한다.
        for (PoseDTO dto : poseList) {

            // DTO의 styleType 값이 매개변수 styleType과 같으면
            if (dto.getStyleType().equals(styleType)) {

                // 결과 리스트에 추가한다.
                resultList.add(dto);
            }
        }

        // 조건에 맞는 데이터만 담긴 리스트 반환
        return resultList;
    }
}
