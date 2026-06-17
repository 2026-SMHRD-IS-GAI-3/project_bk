package com.kendo.controller.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.kendo.model.PoseDTO.AiRequest;

// AI 요청을 처리하는 컨트롤러
@RestController
@RequestMapping("/ai")
public class AiController {

    // AI 서버와 통신하는 기능을 가진 서비스 클래스
    @Autowired
    private AiService aiService;

    // /ai/predict 주소로 POST 요청이 들어오면 실행됨
    @PostMapping("/predict")
    public String predict(@RequestBody AiRequest request) {

        // 사용자가 선택한 종목
        // kendo = 대한검도
        // hema = 리히테나워
        String mode = request.getMode();

        // 사용자가 촬영해서 보낸 이미지 데이터
        String image = request.getImage();

        // Flask AI 서버에 종목과 이미지를 보내고 결과를 받음
        String result = aiService.requestAi(mode, image);

        // AI 분석 결과를 다시 화면으로 돌려줌
        return result;
    }
}