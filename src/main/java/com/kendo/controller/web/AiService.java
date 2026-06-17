package com.kendo.controller.web;

// Flask AI 서버와 HTTP 통신을 하기 위해 사용하는 라이브러리
import org.springframework.http.*;

// Spring이 관리하는 서비스 객체로 등록
import org.springframework.stereotype.Service;

// 외부 서버(Flask)에 요청을 보내기 위한 클래스
import org.springframework.web.client.RestTemplate;

@Service
public class AiService {

    // Flask AI 서버 주소
    // AI 분석 요청이 들어오면 이 주소로 데이터를 전송한다.
	private final String FLASK_URL = "http://192.168.219.47:5000/predict";

    /**
     * AI 서버에 이미지와 종목 정보를 보내고
     * 분석 결과를 받아오는 메서드
     *
     * @param mode
     * - kendo : 대한검도
     * - hema  : 리히테나워
     *
     * @param base64Image
     * 사용자가 촬영한 이미지를 Base64 문자열로 변환한 데이터
     *
     * @return
     * Flask AI 서버가 반환한 분석 결과(JSON)
     */
    public String requestAi(String mode, String base64Image) {

        // HTTP 요청을 보내기 위한 객체 생성
        RestTemplate restTemplate = new RestTemplate();

        // 요청 헤더 생성
        HttpHeaders headers = new HttpHeaders();

        // JSON 형식으로 데이터를 보내겠다고 설정
        headers.setContentType(MediaType.APPLICATION_JSON);

        // Flask 서버가 이해할 수 있도록 JSON 형태로 데이터 생성
        // mode : 훈련 종목
        // image : 사용자 이미지(Base64)
        String jsonBody = String.format(
            "{\"mode\":\"%s\", \"image\":\"%s\"}",
            mode,
            base64Image
        );

        // 헤더와 데이터를 하나의 요청 객체로 생성
        HttpEntity<String> entity = new HttpEntity<>(jsonBody, headers);

        // Flask AI 서버로 POST 요청 전송
        // 분석이 끝나면 결과를 문자열(JSON) 형태로 반환받음
        ResponseEntity<String> response =
                restTemplate.postForEntity(
                        FLASK_URL,
                        entity,
                        String.class
                );

        // AI 분석 결과 반환
        return response.getBody();
    }
}