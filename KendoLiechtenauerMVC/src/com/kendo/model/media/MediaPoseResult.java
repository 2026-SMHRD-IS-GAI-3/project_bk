package com.kendo.model.media;

/*
 * MediaPoseResult 클래스
 * ---------------------------------------
 * Python(OpenCV + MediaPipe) 서버에서 받은 자세 분석 결과를
 * Java에서 사용하기 쉽게 저장하는 DTO 역할의 클래스이다.
 *
 * Python에서 이미지/영상 분석을 하면
 * 어깨 각도, 팔꿈치 각도, 무릎 각도, 결과 메시지를 반환한다.
 * 그 값을 이 객체에 담아서 Servlet, JSP로 전달한다.
 */
public class MediaPoseResult {

    // 분석 성공 여부
    private boolean success;

    // 어깨 각도
    private double shoulderAngle;

    // 팔꿈치 각도
    private double elbowAngle;

    // 무릎 각도
    private double kneeAngle;

    // Python에서 저장한 결과 이미지 경로
    private String resultImagePath;

    // 자세 교정 피드백 메시지
    private String feedback;

    // 오류 메시지
    private String errorMessage;

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
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

    public String getResultImagePath() {
        return resultImagePath;
    }

    public void setResultImagePath(String resultImagePath) {
        this.resultImagePath = resultImagePath;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }
}
