package com.kendo.controller.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.kendo.model.UserDAO;
import com.kendo.model.UserDTO;

@WebServlet("/ProfileSetService")
public class ProfileSetService extends HttpServlet {

    protected void service(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        UserDTO loginUser =
                (UserDTO) session.getAttribute("loginUser");

        if(loginUser != null) {

            UserDAO dao = new UserDAO();

            int result = dao.updateProfileSet(loginUser);

            System.out.println("PROFILE_SET UPDATE = " + result);

            if(result > 0) {
                loginUser.setProfileSet("Y");
                session.setAttribute("loginUser", loginUser);
            }
        }

        response.sendRedirect("main.jsp");
    }
}