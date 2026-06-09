package com.kendo.controller;

import com.kendo.model.PoseAnalyzer;
import com.kendo.model.PoseDTO;

/*
 * 콘솔 또는 일반 Java 실행용 Controller
 * 웹에서는 controller.web 패키지의 Servlet을 사용하면 된다.
 */
public class PoseController {

    public static void main(String[] args) {

        // 테스트용 DTO 생성
        PoseDTO dto = new PoseDTO("KENDO", "중단세", 90, 120, 150, null);

        // 분석 객체 생성
        PoseAnalyzer analyzer = new PoseAnalyzer();

        // 분석 결과 출력
        String result = analyzer.analyze(dto);
        System.out.println(result);
    }
}
