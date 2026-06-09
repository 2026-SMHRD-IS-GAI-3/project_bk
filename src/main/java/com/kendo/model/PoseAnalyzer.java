package com.kendo.model;

/*
 * 자세 분석 로직을 담당하는 클래스
 * 지금은 간단한 예시 로직만 넣어두고,
 * 실제 분석은 Python Flask + MediaPipe/OpenCV에서 받은 결과로 바꾸면 된다.
 */
public class PoseAnalyzer {

    public String analyze(PoseDTO dto) {

        // 예시: 각도 값이 0이면 아직 분석값이 없다고 판단
        if (dto.getShoulderAngle() == 0 && dto.getElbowAngle() == 0 && dto.getKneeAngle() == 0) {
            return "분석 결과가 없습니다.";
        }

        // 예시 결과 문구
        return "자세 분석이 완료되었습니다.";
    }
}
