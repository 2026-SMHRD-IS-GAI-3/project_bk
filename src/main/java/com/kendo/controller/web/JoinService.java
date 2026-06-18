package com.kendo.controller.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kendo.model.UserDAO;
import com.kendo.model.UserDTO;

/*
 * 회원가입 Servlet
 * join.jsp에서 입력받은 회원 정보를 DB에 저장한다.
 */
@WebServlet("/JoinService")
public class JoinService extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // POST 방식 한글 깨짐 방지
        request.setCharacterEncoding("UTF-8");

        // form 태그에서 넘어온 데이터 받기
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String name = request.getParameter("name");
        String goods = " ";
        String gender = request.getParameter("gender");

        // 숫자는 문자열로 넘어오므로 int로 변환한다.
        String ageStr = request.getParameter("age");

        if (ageStr == null || ageStr.trim().isEmpty()) {
            response.sendRedirect("join.jsp");
            return;
        }
        int age = Integer.parseInt(ageStr);

        // 회원가입 기본값
        int kGrade = 0;
        int lGrade = 0;
        int adminM = 0;
        int point = 0;

        // DTO에 회원 정보 담기
        UserDTO dto = new UserDTO(id, pw, name, goods, age, gender, kGrade, lGrade, adminM, point);

        // DAO를 통해 DB에 저장
        UserDAO dao = new UserDAO();
        int result = dao.join(dto);

        // 회원가입 성공/실패에 따라 이동할 페이지 결정
        if (result > 0) {
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("join.jsp");
        }
    }
}
