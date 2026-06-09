package com.kendo.model.media;

/*
 * Python MediaPipe/OpenCV 서버에서 받은 결과를 담는 클래스
 */
public class MediaPoseResult {

    private double shoulderAngle;
    private double elbowAngle;
    private double kneeAngle;
    private String result;

    public MediaPoseResult() {
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
