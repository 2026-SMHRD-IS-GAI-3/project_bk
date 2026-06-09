package com.kendo.controller.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kendo.model.media.MediaPipeClient;
import com.kendo.model.media.MediaPoseResult;

/*
 * 자세 분석 요청을 받는 Servlet
 *
 * 나중에 JSP에서 이미지/영상을 업로드하면 이 Servlet이 요청을 받고,
 * Python Flask 서버에 보내서 MediaPipe/OpenCV 분석 결과를 받아오게 만들 수 있다.
 */
@WebServlet("/AnalyzePoseServlet")
public class AnalyzePoseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // 현재는 파일 업로드 구현 전이므로 임시 경로 사용
        String filePath = "sample.jpg";

        // Python MediaPipe 서버와 통신하는 클래스 호출
        MediaPipeClient client = new MediaPipeClient();
        MediaPoseResult result = client.analyzeImage(filePath);

        // 분석 결과를 request에 담아서 JSP로 전달
        request.setAttribute("poseResult", result);
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}
