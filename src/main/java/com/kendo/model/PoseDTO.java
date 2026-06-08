package com.kendo.model;

/*
 * 자세 분석 결과를 임시로 담는 DTO
 * 현재 DB에는 자세 분석 테이블이 없으므로 DB 저장용이 아니라 화면/분석 결과 전달용으로 사용한다.
 */
public class PoseDTO {

    private String styleType;      // KENDO 또는 LIECHTENAUER
    private String poseName;       // 자세 이름
    private double shoulderAngle;  // 어깨 각도
    private double elbowAngle;     // 팔꿈치 각도
    private double kneeAngle;      // 무릎 각도
    private String result;         // 분석 결과 문구

    public PoseDTO() {
    }

    public PoseDTO(String styleType, String poseName, double shoulderAngle,
                   double elbowAngle, double kneeAngle, String result) {
        this.styleType = styleType;
        this.poseName = poseName;
        this.shoulderAngle = shoulderAngle;
        this.elbowAngle = elbowAngle;
        this.kneeAngle = kneeAngle;
        this.result = result;
    }

    public String getStyleType() {
        return styleType;
    }

    public void setStyleType(String styleType) {
        this.styleType = styleType;
    }

    public String getPoseName() {
        return poseName;
    }

    public void setPoseName(String poseName) {
        this.poseName = poseName;
    }

    public double getShoulderAngle() {
        return shoulderAngle;
    }

    public void setShoulderAngle(double shoulderAngle) {
        this.shoulderAngle = shoulderAngle;
    }

    public double getElbowAngle() {
        return elbowAngle;
    }

    public void setElbowAngle(double elbowAngle) {
        this.elbowAngle = elbowAngle;
    }

    public double getKneeAngle() {
        return kneeAngle;
    }

    public void setKneeAngle(double kneeAngle) {
        this.kneeAngle = kneeAngle;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }
}
