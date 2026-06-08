package com.kendo.controller.web;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.kendo.model.media.MediaPipeClient;
import com.kendo.model.media.MediaPoseResult;

/*
 * AnalyzePoseServlet 클래스
 * ---------------------------------------
 * 홈페이지에서 이미지 파일을 업로드하면
 * 파일을 서버에 저장하고 Python(OpenCV + MediaPipe) 서버로 분석 요청을 보낸다.
 *
 * @WebServlet("/AnalyzePose")
 * form action="AnalyzePose" 와 연결된다.
 *
 * @MultipartConfig
 * 이미지 파일 업로드를 처리하기 위해 반드시 필요하다.
 */
@WebServlet("/AnalyzePose")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 20,
        maxRequestSize = 1024 * 1024 * 50
)
public class AnalyzePoseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // JSP form에서 넘어온 검술 종류와 자세 이름
        String styleType = request.getParameter("styleType");
        String poseName = request.getParameter("poseName");

        // 업로드된 파일 받기
        Part filePart = request.getPart("poseFile");

        // 업로드 파일명이 없으면 다시 입력 화면으로 보낸다.
        if (filePart == null || filePart.getSubmittedFileName() == null
                || filePart.getSubmittedFileName().equals("")) {
            request.setAttribute("error", "이미지 파일을 선택해주세요.");
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
            return;
        }

        // WebContent/upload 폴더의 실제 서버 경로를 구한다.
        String uploadPath = request.getServletContext().getRealPath("/upload");
        File uploadDir = new File(uploadPath);

        // upload 폴더가 없으면 자동 생성한다.
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // 파일명이 겹치지 않게 현재 시간을 붙인다.
        String originalFileName = filePart.getSubmittedFileName();
        String saveFileName = System.currentTimeMillis() + "_" + originalFileName;
        String savePath = uploadPath + File.separator + saveFileName;

        // 서버에 이미지 저장
        filePart.write(savePath);

        // Python MediaPipe 서버에 분석 요청
        MediaPipeClient client = new MediaPipeClient();
        MediaPoseResult result = client.analyze(savePath, styleType, poseName);

        // JSP에서 사용할 데이터 저장
        request.setAttribute("styleType", styleType);
        request.setAttribute("poseName", poseName);
        request.setAttribute("uploadedImage", "upload/" + saveFileName);
        request.setAttribute("result", result);

        // 결과 화면으로 이동
        RequestDispatcher rd = request.getRequestDispatcher("result.jsp");
        rd.forward(request, response);
    }
}
