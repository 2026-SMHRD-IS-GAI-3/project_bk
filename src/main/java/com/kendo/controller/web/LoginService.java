package com.kendo.controller.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.kendo.model.UserDAO;
import com.kendo.model.UserDTO;

@WebServlet("/LoginService")
public class LoginService extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String pw = request.getParameter("pw");

        UserDTO user = new UserDTO();
        user.setId(id);
        user.setPw(pw);

        UserDAO dao = new UserDAO();
        UserDTO loginUser = dao.login(user);

        if (loginUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", loginUser);

            response.sendRedirect("main.jsp");
            return;
        }

        response.sendRedirect("login.jsp?login=fail");
        return;
    }
}