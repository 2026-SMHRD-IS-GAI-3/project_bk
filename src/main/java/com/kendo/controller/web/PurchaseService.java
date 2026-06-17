package com.kendo.controller.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.kendo.model.UserDAO;
import com.kendo.model.UserDTO;

@WebServlet("/PurchaseService")
public class PurchaseService extends HttpServlet {
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

        int goodsNum = Integer.parseInt(request.getParameter("goodsNum"));

        Map<String, Object> param = new HashMap<String, Object>();
        param.put("mNum", loginUser.getmNum());
        param.put("goodsNum", goodsNum);

        UserDAO dao = new UserDAO();
        int result = dao.purchaseGoods(param);

        if (result > 0) {
            response.getWriter().print("OK");
        } else {
            response.getWriter().print("FAIL");
        }
    }
}