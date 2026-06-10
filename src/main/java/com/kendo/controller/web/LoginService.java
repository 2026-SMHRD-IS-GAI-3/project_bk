package com.kendo.controller.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kendo.model.UserDAO;
import com.kendo.model.UserDTO;

/*
 * 로그인 Servlet
 * login.jsp에서 받은 ID/PW를 MEMBER 테이블과 비교한다.
 */
@WebServlet("/LoginService")
public class LoginService extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String profileSet = request.getParameter("profileSet");

        UserDTO dto = new UserDTO(id, pw);
        UserDAO dao = new UserDAO();

        UserDTO loginUser = dao.login(dto);

        if (loginUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", loginUser);

            if ("Y".equals(loginUser.getProfileSet())) {
                response.sendRedirect("main.jsp");
            } else {
                response.sendRedirect("settings.jsp");
            }

        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
