package com.kendo.model;

import java.util.Map;

/*
 * 자세 분석 로직을 담당하는 클래스
 * 지금은 간단한 예시 로직만 넣어두고,
 * 실제 분석은 Python Flask + MediaPipe/OpenCV에서 받은 결과로 바꾸면 된다.
 */
public class AiResponseDTO {

    private String pose;
    private double probability;
    private double pose_score;
    private double angle_score;
    private double final_score;
    private String status;

    private Map<String, Double> angles;
    private Map<String, Double> diff;

    // getters/setters
}