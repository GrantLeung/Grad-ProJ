package com.example.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.bean.user;
import com.example.dao.CreateDao;
import com.example.dao.SelectDao;
import com.example.dao.UpdateDao;
import com.example.util.Util;

/**
 * Servlet implementation class UserServelet
 */
public class UserServlet extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 3826169475919562018L;
	private boolean debug = true;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (this.debug ) {
			Util.printRequest(request);
		}

		String actionName = request.getParameter("actionName");
		request.setCharacterEncoding("utf-8");
		
		if(actionName != null){
			if(actionName.equals("register")){
				String userName = request.getParameter("userName");
				String password = request.getParameter("password1");
				String password2 = request.getParameter("password2");
				String mobile = request.getParameter("mobile");
				String address = request.getParameter("address");
				String hobby = request.getParameter("hobby");
				user u = SelectDao.findUser(userName);
				if(u!=null){
					request.setAttribute("info", "×¢²áÊ§°Ü");
					request.getRequestDispatcher("fail.jsp").forward(request,response);
				}else{
					CreateDao.createObject(new user(userName,password,mobile,address,hobby));
					response.sendRedirect("index.jsp"); 
				}
			}else if(actionName.equals("login")){
				String userName = request.getParameter("userName");
				String password = request.getParameter("password");
				String type = request.getParameter("type");
				if(type.equals("1")){//¹ÜÀíÔ±
					user u = SelectDao.findUser(userName);
					if(u!=null && u.getType().equals(type) && u.getPassword().equals(password)){
						response.sendRedirect("admin.jsp");
					}else{
						request.setAttribute("info", "µÇÂ¼Ê§°Ü");
						request.getRequestDispatcher("fail.jsp").forward(request,response);
					}
				}else{//
					user u = SelectDao.findUser(userName);
					if(u!=null && u.getType().equals(type) && u.getPassword().equals(password)){
						request.getSession().setAttribute("userId", u.getId());
						response.sendRedirect("main.jsp");
					}else{
						request.setAttribute("info", "µÇÂ¼Ê§°Ü");
						request.getRequestDispatcher("fail.jsp").forward(request,response);
					}
				}
			}else if(actionName.equals("updateUser")){
				String user_name = request.getParameter("user_name");
				String address = request.getParameter("address");
				String mobile = request.getParameter("mobile");
				user u = SelectDao.findUser(user_name);
				u.setAddress(address);
				u.setMobile(mobile);
				UpdateDao.updateObject(u);
				response.setCharacterEncoding("utf-8");
				response.getWriter().write("²Ù×÷³É¹¦");
			}
		}else{
			
		}
	}
}
