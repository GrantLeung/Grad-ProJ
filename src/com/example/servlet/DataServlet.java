package com.example.servlet;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.bean.resource;
import com.example.bean.user_score;
import com.example.dao.CreateDao;
import com.example.dao.DeleteDao;
import com.example.dao.SelectDao;
import com.example.dao.UpdateDao;
import com.example.util.Util;

/**
 * Servlet implementation class UserServelet
 */
public class DataServlet extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 38261695919562018L;
	private boolean debug = true;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DataServlet() {
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
		
		if(actionName != null){
			if(actionName.equals("removeResource")){
				Integer id = Integer.valueOf(request.getParameter("resourceId"));
				DeleteDao.removeResource(id);
				ArrayList<user_score> l2 = SelectDao.getAllUserScore();
				for (user_score order : l2) {
					if(order.getResource_id().equals(id)){
						DeleteDao.removeObject(order);
					}
				}
			}else if(actionName.equals("addScore")){
				Integer userId = Integer.valueOf(request.getParameter("userId")); 
				Integer id = Integer.valueOf(request.getParameter("resourceId")); 
				Float score = Float.valueOf(request.getParameter("score"));
				user_score us = SelectDao.getUserScore(userId, id);
				if(us == null){
					CreateDao.createObject(new user_score(userId, id, score));
				}else{
					us.setScore(score);
					UpdateDao.updateObject(us);
				}
				resource r = SelectDao.findResource(id);
				DecimalFormat df = new DecimalFormat("0.0");
				double x = r.getScore()==0?score:(r.getScore()+score)/2;
				String xx = df.format(x);
				r.setScore(Float.valueOf(xx));
				UpdateDao.updateObject(r);
			}else{

			}
		}else{
		} 
	}
}

