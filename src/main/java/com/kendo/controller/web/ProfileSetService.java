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

        String kGradeParam = request.getParameter("kGrade");
        String lGradeParam = request.getParameter("lGrade");

        int kGrade = loginUser.getkGrade();
        int lGrade = loginUser.getlGrade();

        if (kGradeParam != null && !"".equals(kGradeParam)) {
            kGrade = Integer.parseInt(kGradeParam);
        }

        if (lGradeParam != null && !"".equals(lGradeParam)) {
            lGrade = Integer.parseInt(lGradeParam);
        }

        System.out.println("kGradeParam = " + kGradeParam);
        System.out.println("lGradeParam = " + lGradeParam);
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