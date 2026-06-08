package com.kendo.model;

/*
 * PoseAnalyzer 클래스
 * ---------------------------------------
 * 사용자가 입력한 어깨, 팔꿈치, 무릎 각도를 기준으로
 * 간단한 자세 교정 피드백을 만들어주는 클래스이다.
 *
 * 지금은 임시 기준값으로 분석한다.
 * 나중에 실제 검도/리히테나워 기준 자세 데이터를 넣어서 수정하면 된다.
 */
public class PoseAnalyzer {

    /*
     * 자세 분석 메서드
     * PoseDTO 객체를 받아서 각도 값을 확인하고 피드백 문자열을 반환한다.
     */
    public String analyze(PoseDTO dto) {

        // 분석 결과 문장을 누적해서 저장할 변수
        String feedback = "";

        // 어깨 각도 분석
        // 70도보다 작으면 어깨가 너무 내려갔다고 판단
        if (dto.getShoulderAngle() < 70) {
            feedback += "어깨가 너무 내려가 있습니다. ";

        // 130도보다 크면 어깨가 너무 올라갔다고 판단
        } else if (dto.getShoulderAngle() > 130) {
            feedback += "어깨가 너무 올라가 있습니다. ";

        // 70도 이상 130도 이하이면 양호하다고 판단
        } else {
            feedback += "어깨 각도 양호. ";
        }

        // 팔꿈치 각도 분석
        // 80도보다 작으면 팔꿈치가 너무 굽혀졌다고 판단
        if (dto.getElbowAngle() < 80) {
            feedback += "팔꿈치가 너무 굽혀져 있습니다. ";

        // 160도보다 크면 팔꿈치가 너무 펴졌다고 판단
        } else if (dto.getElbowAngle() > 160) {
            feedback += "팔꿈치가 너무 펴져 있습니다. ";

        // 80도 이상 160도 이하이면 양호하다고 판단
        } else {
            feedback += "팔꿈치 각도 양호. ";
        }

        // 무릎 각도 분석
        // 100도보다 작으면 무릎이 너무 굽혀졌다고 판단
        if (dto.getKneeAngle() < 100) {
            feedback += "무릎이 너무 굽혀져 있습니다.";

        // 170도보다 크면 무릎이 너무 펴졌다고 판단
        } else if (dto.getKneeAngle() > 170) {
            feedback += "무릎이 너무 펴져 있습니다.";

        // 100도 이상 170도 이하이면 양호하다고 판단
        } else {
            feedback += "무릎 각도 양호.";
        }

        // 최종 분석 결과 반환
        return feedback;
    }
}
