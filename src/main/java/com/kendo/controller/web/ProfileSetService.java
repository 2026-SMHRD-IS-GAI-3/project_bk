package com.kendo.controller.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.kendo.model.UserDAO;
import com.kendo.model.UserDTO;

@WebServlet("/ProfileSetService")
public class ProfileSetService extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.sendRedirect("login.jsp?login=required");
            return;
        }

        String kGradeStr = request.getParameter("kGrade");
        String lGradeStr = request.getParameter("lGrade");

        if (kGradeStr == null || lGradeStr == null) {
            response.sendRedirect("trainingSetting.jsp?mode=reset");
            return;
        }

        int kGrade = Integer.parseInt(kGradeStr);
        int lGrade = Integer.parseInt(lGradeStr);

        Map<String, Object> param = new HashMap<String, Object>();
        param.put("mNum", loginUser.getmNum());
        param.put("kGrade", kGrade);
        param.put("lGrade", lGrade);

        UserDAO dao = new UserDAO();
        int result = dao.updateTrainingGrade(param);

        if (result > 0) {
            // 핵심: DB만 바꾸면 화면에 바로 반영 안 됨
            // 세션에 들어있는 loginUser 값도 같이 바꿔야 함
        	loginUser.setkGrade(kGrade);
        	loginUser.setlGrade(lGrade);
        	loginUser.setProfileSet("Y");

        	session.setAttribute("loginUser", loginUser);
        	response.sendRedirect(
        		    "main.jsp?gradeUpdated=1&kGrade=" + kGrade + "&lGrade=" + lGrade
        		);
        		return;
        }

        response.sendRedirect("trainingSetting.jsp?mode=reset");
    }
}