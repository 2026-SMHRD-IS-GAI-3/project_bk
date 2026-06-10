package com.kendo.model.media;

import java.io.BufferedReader;
import java.io.OutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import com.kendo.util.SimpleJsonUtil;

/*
 * MediaPipeClient 클래스
 * ---------------------------------------
 * Java Servlet에서 Python Flask 서버로 이미지 경로를 보내고,
 * OpenCV + MediaPipe 분석 결과를 받아오는 클래스이다.
 *
 * 구조
 * JSP 업로드 화면
 *      ↓
 * AnalyzePoseServlet
 *      ↓
 * MediaPipeClient
 *      ↓ HTTP 요청
 * Python Flask 서버(OpenCV + MediaPipe)
 *      ↓ JSON 응답
 * JSP 결과 화면
 */
public class MediaPipeClient {

    // Python Flask 서버 주소
    // Python app.py를 실행하면 기본적으로 5000번 포트를 사용한다.
    private static final String API_URL = "http://127.0.0.1:5000/analyze";

    /*
     * 자세 분석 요청 메서드
     * filePath : Java 서버에 저장된 업로드 이미지 실제 경로
     * styleType : KENDO 또는 LIECHTENAUER
     * poseName : 중단세, 머리치기, Vom Tag 등
     */
    public MediaPoseResult analyze(String filePath, String styleType, String poseName) {

        MediaPoseResult result = new MediaPoseResult();

        try {
            URL url = new URL(API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            // POST 방식으로 Python 서버에 요청한다.
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setDoOutput(true);

            // Windows 경로의 \ 문자를 JSON에서 깨지지 않게 \\ 로 바꾼다.
            String safePath = filePath.replace("\\", "\\\\");

            // Python 서버로 보낼 JSON 데이터
            String jsonBody = "{"
                    + "\"filePath\":\"" + safePath + "\"," 
                    + "\"styleType\":\"" + styleType + "\"," 
                    + "\"poseName\":\"" + poseName + "\""
                    + "}";

            OutputStream os = conn.getOutputStream();
            os.write(jsonBody.getBytes("UTF-8"));
            os.flush();
            os.close();

            BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), "UTF-8"));

            StringBuilder sb = new StringBuilder();
            String line;

            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            br.close();

            String responseJson = sb.toString();

            // JSON 결과를 MediaPoseResult 객체에 저장한다.
            result.setSuccess(SimpleJsonUtil.getBoolean(responseJson, "success"));
            result.setShoulderAngle(SimpleJsonUtil.getDouble(responseJson, "shoulderAngle"));
            result.setElbowAngle(SimpleJsonUtil.getDouble(responseJson, "elbowAngle"));
            result.setKneeAngle(SimpleJsonUtil.getDouble(responseJson, "kneeAngle"));
            result.setResultImagePath(SimpleJsonUtil.getString(responseJson, "resultImagePath"));
            result.setFeedback(SimpleJsonUtil.getString(responseJson, "feedback"));
            result.setErrorMessage(SimpleJsonUtil.getString(responseJson, "errorMessage"));

        } catch (Exception e) {
            // Python 서버가 꺼져 있거나 통신 오류가 나면 이쪽으로 온다.
            result.setSuccess(false);
            result.setErrorMessage("Python MediaPipe 서버 연결 실패: " + e.getMessage());
        }

        return result;
    }
}
