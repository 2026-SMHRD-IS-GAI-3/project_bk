package com.kendo.controller.web;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class AiService {

    private final String FLASK_URL = "http://localhost:5000/predict";

    public String requestAi(String mode, String base64Image) {

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String jsonBody = String.format(
            "{\"mode\":\"%s\", \"image\":\"%s\"}",
            mode,
            base64Image
        );

        HttpEntity<String> entity = new HttpEntity<>(jsonBody, headers);

        ResponseEntity<String> response =
                restTemplate.postForEntity(FLASK_URL, entity, String.class);

        return response.getBody();
    }
}