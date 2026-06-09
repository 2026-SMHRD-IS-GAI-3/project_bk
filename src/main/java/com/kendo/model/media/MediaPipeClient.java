package com.kendo.model.media;

/*
 * Java에서 Python Flask 서버로 요청을 보내는 클래스
 *
 * 현재는 예시용 틀만 작성했다.
 * 실제 구현 시 HttpURLConnection 또는 Apache HttpClient로
 * http://localhost:5000/analyze 에 파일을 전송하면 된다.
 */
public class MediaPipeClient {

    public MediaPoseResult analyzeImage(String filePath) {

        // 임시 결과 객체 생성
        MediaPoseResult result = new MediaPoseResult();

        // 아직 실제 Flask 연동 전이므로 예시 값 입력
        result.setShoulderAngle(90.0);
        result.setElbowAngle(120.0);
        result.setKneeAngle(150.0);
        result.setResult("Python MediaPipe 연동 전 임시 분석 결과입니다.");

        return result;
    }
}
