package com.kendo.controller.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.kendo.model.UserDAO;
import com.kendo.model.UserDTO;

@WebServlet("/TrainHisService")
public class TrainHisService extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.getWriter().print("LOGIN_FAIL");
            return;
        }

        int division = Integer.parseInt(request.getParameter("division"));
        int trainNum = Integer.parseInt(request.getParameter("trainNum"));
        int postureNum = Integer.parseInt(request.getParameter("postureNum"));

        int accuracy = 0;

        if (request.getParameter("accuracy") != null) {
            accuracy = Integer.parseInt(request.getParameter("accuracy"));
        }

        System.out.println("훈련 기록 저장 요청");
        System.out.println("mNum = " + loginUser.getmNum());
        System.out.println("division = " + division);
        System.out.println("trainNum = " + trainNum);
        System.out.println("postureNum = " + postureNum);
        System.out.println("accuracy = " + accuracy);

        Map<String, Object> param = new HashMap<String, Object>();
        param.put("mNum", loginUser.getmNum());
        param.put("division", division);
        param.put("trainNum", trainNum);
        param.put("postureNum", postureNum);
        param.put("accuracy", accuracy);

        UserDAO dao = new UserDAO();
        int result = dao.insertTrainHis(param);

        if (result > 0) {
            response.getWriter().print("OK");
        } else {
            response.getWriter().print("FAIL");
        }
    }
}