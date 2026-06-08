package com.genai.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.genai.model.WebMember;
import com.genai.model.WebMemberDAO;

@WebServlet("/JoinService")
public class JoinService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 입력받은 회원가입 정보(email, pw, tel, address) 가져오기
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		
		
		// 2. DB에 저장하기 위해 데이터 묶어주기 (WebMember객체생성) 
		WebMember member = new WebMember(id,pw,name,gender);
		
		// 3. DB에 회원가입 정보 저장하기
		// - DAO 클래스 내 join() 메소드 생성 필요
		WebMemberDAO dao = new WebMemberDAO();
		int cnt = dao.join(member);
		
		
		// 4. 가입성공 여부에 따른 페이지 이동처리
		// - 성공 : JoinSuccess.jsp
		// - 실패 : Main.jsp
		if(cnt>0) {
			request.setAttribute("id", id);
			
			RequestDispatcher rd = request.getRequestDispatcher("JoinSuccess.jsp");
			rd.forward(request, response);
		}
		else {

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
				
			out.print("<script>");
			out.print("alert('회원가입이 실패했습니다. 다시 진행해주세요');");
			out.print("location.href='Main.jsp';");
			out.print("</script>");
		}
		
	}

}
