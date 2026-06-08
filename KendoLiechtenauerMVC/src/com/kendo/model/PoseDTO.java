package com.kendo.model;

/*
 * DTO 클래스
 * ---------------------------------------
 * DTO는 Data Transfer Object의 줄임말이다.
 *
 * 사용자가 입력한 자세 분석 정보를 하나의 객체로 묶어서
 * Controller, DAO, View 사이에서 전달할 때 사용한다.
 */
public class PoseDTO {

    // 자세 분석 번호
    // DAO에서 저장할 때 자동으로 번호를 붙여준다.
    private int poseId;

    // 사용자 ID
    private String userId;

    // 검술 종류
    // KENDO: 대한검도
    // LIECHTENAUER: 리히테나워 검술
    private String styleType;

    // 자세 이름
    // 예: 중단세, 머리치기, VomTag, Pflug 등
    private String poseName;

    // 어깨 각도
    private double shoulderAngle;

    // 팔꿈치 각도
    private double elbowAngle;

    // 무릎 각도
    private double kneeAngle;

    // 자세 분석 결과
    // 예: 어깨 각도 양호, 팔꿈치가 너무 굽혀져 있습니다 등
    private String result;

    // 기본 생성자
    // 객체를 비어 있는 상태로 만들 때 사용한다.
    public PoseDTO() {
    }

    // 사용자 정의 생성자
    // 객체를 만들 때 값을 한 번에 넣고 싶을 때 사용한다.
    public PoseDTO(int poseId, String userId, String styleType, String poseName,
                   double shoulderAngle, double elbowAngle, double kneeAngle, String result) {
        this.poseId = poseId;
        this.userId = userId;
        this.styleType = styleType;
        this.poseName = poseName;
        this.shoulderAngle = shoulderAngle;
        this.elbowAngle = elbowAngle;
        this.kneeAngle = kneeAngle;
        this.result = result;
    }

    // poseId 값을 가져오는 getter
    public int getPoseId() {
        return poseId;
    }

    // poseId 값을 수정하는 setter
    public void setPoseId(int poseId) {
        this.poseId = poseId;
    }

    // userId 값을 가져오는 getter
    public String getUserId() {
        return userId;
    }

    // userId 값을 수정하는 setter
    public void setUserId(String userId) {
        this.userId = userId;
    }

    // styleType 값을 가져오는 getter
    public String getStyleType() {
        return styleType;
    }

    // styleType 값을 수정하는 setter
    public void setStyleType(String styleType) {
        this.styleType = styleType;
    }

    // poseName 값을 가져오는 getter
    public String getPoseName() {
        return poseName;
    }

    // poseName 값을 수정하는 setter
    public void setPoseName(String poseName) {
        this.poseName = poseName;
    }

    // shoulderAngle 값을 가져오는 getter
    public double getShoulderAngle() {
        return shoulderAngle;
    }

    // shoulderAngle 값을 수정하는 setter
    public void setShoulderAngle(double shoulderAngle) {
        this.shoulderAngle = shoulderAngle;
    }

    // elbowAngle 값을 가져오는 getter
    public double getElbowAngle() {
        return elbowAngle;
    }

    // elbowAngle 값을 수정하는 setter
    public void setElbowAngle(double elbowAngle) {
        this.elbowAngle = elbowAngle;
    }

    // kneeAngle 값을 가져오는 getter
    public double getKneeAngle() {
        return kneeAngle;
    }

    // kneeAngle 값을 수정하는 setter
    public void setKneeAngle(double kneeAngle) {
        this.kneeAngle = kneeAngle;
    }

    // result 값을 가져오는 getter
    public String getResult() {
        return result;
    }

    // result 값을 수정하는 setter
    public void setResult(String result) {
        this.result = result;
    }
}
