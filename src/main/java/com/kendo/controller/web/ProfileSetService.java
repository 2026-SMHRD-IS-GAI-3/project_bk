package com.kendo.controller.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.kendo.model.UserDAO;
import com.kendo.model.UserDTO;

@WebServlet("/ProfileSetService")
public class ProfileSetService extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        UserDTO loginUser =
                (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String division = request.getParameter("initialTrainingDivision");
        String gradeParam = request.getParameter("kGrade");

        int kGrade = 1;
        int lGrade = 1;

        if ("1".equals(division)) {
            kGrade = Integer.parseInt(gradeParam);
        } else if ("2".equals(division)) {
            lGrade = Integer.parseInt(gradeParam);
        }

        System.out.println("division = " + division);
        System.out.println("gradeParam = " + gradeParam);
        System.out.println("kGrade = " + kGrade);
        System.out.println("lGrade = " + lGrade);
        System.out.println("mNum = " + loginUser.getmNum());

        loginUser.setkGrade(kGrade);
        loginUser.setlGrade(lGrade);
        loginUser.setProfileSet("Y");

        UserDAO dao = new UserDAO();

        int result = dao.updateProfileSet(loginUser);

        System.out.println("PROFILE_SET UPDATE = " + result);

        if (result > 0) {
            session.setAttribute("loginUser", loginUser);
            response.sendRedirect("main.jsp");
        } else {
            response.sendRedirect("settings.jsp");
        }
    }
}