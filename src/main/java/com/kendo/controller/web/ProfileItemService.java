package com.kendo.controller.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.kendo.model.UserDAO;
import com.kendo.model.UserDTO;

@WebServlet("/ProfileItemService")
public class ProfileItemService extends HttpServlet {
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

        String goods = request.getParameter("goods");

        if (goods == null) {
            goods = "";
        }

        UserDTO dto = new UserDTO();
        dto.setmNum(loginUser.getmNum());
        dto.setGoods(goods);

        UserDAO dao = new UserDAO();
        int result = dao.updateMemberGoods(dto);

        if (result > 0) {
            loginUser.setGoods(goods);
            session.setAttribute("loginUser", loginUser);

            response.getWriter().print("OK");
        } else {
            response.getWriter().print("FAIL");
        }
    }
}