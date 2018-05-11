package com.example.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import com.example.dao.CreateDao;
import com.example.dao.SelectDao;
import com.example.bean.resource;
import com.example.bean.user;
import com.example.util.Util;

/**
 * Servlet implementation class UserServelet
 */
public class FileServlet extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1l;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileServlet() {
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
		//这个SERVLET用来处理有文件的请求，电影添加

		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		boolean status  = true;
		String message = "操作成功";
		
		try {
			Map<String, Object> mapParams = new HashMap<>();
			Map<String, FileItem> mapFiles = new HashMap<>();
			
			// 上传文件解析,将字符串参数解析到mapParams，将文件参数解析到mapFiles
			List<?> items = upload.parseRequest(request);
			Iterator<?> itr = items.iterator();// 枚举方法
			while (itr.hasNext()) {
				FileItem item = (FileItem) itr.next();
				if (item.isFormField()) {
					if(mapParams.containsKey(item.getFieldName())){
						mapParams.put(item.getFieldName(), 
								mapParams.get(item.getFieldName()) + ";" + new String(item.get(),"utf-8"));
					}else {
						mapParams.put(item.getFieldName(), new String(item.get(),"utf-8"));
					}
				} else {
					mapFiles.put(item.getFieldName(), item);
				}
			}
			//输出调试信息
			Util.printRequest(request,mapParams,mapFiles);
			
			String actionName = mapParams.get("actionName").toString();
			if(actionName.equals("addResource")){//添加,修改电影
				Object id = mapParams.get("id");
				String number = mapParams.get("number").toString();
				String name = mapParams.get("name").toString();
				String description = mapParams.get("description").toString();
				Object type = mapParams.get("type");
				Object area = mapParams.get("area");
				Object year = mapParams.get("year");
				
				resource  r = new resource(number,name, 
						description,
						type == null ? "" : type.toString(),
						area == null ? "" : area.toString(),
						year == null ? "" : year.toString()
						);
				
				//如果参数包含id则是修改，否则是添加
				if(id != null)r.setId(Integer.valueOf(id.toString()));
				
				FileItem fileItem = mapFiles.get("image");
				if(fileItem.getSize() > 0){
					String format = fileItem.getName().substring(fileItem.getName().lastIndexOf(".")+1);
					String fileName = r.getId() + "_" + System.currentTimeMillis() + "." + format;
					Util.saveImage(fileItem.get(), request.getServletContext().getRealPath("") + "/image", fileName);
					r.setUrl(fileName);
				}else {
					//没有上传图片
					if(id == null){
						r.setUrl("default.jpg");
					}else {
						r.setUrl(SelectDao.findResource(r.getId()).getUrl());
					}
				}
				CreateDao.createObject(r);
			}else if(actionName.equals("addUser")){//添加,修改,用户，如果带图片
				Object id = mapParams.get("id");
				String title = mapParams.get("user_name").toString();
				String password1 = mapParams.get("password1").toString();
				String password2 = mapParams.get("password2").toString();
				
				user  r = new user(title, password1, 2+"");
				if(id!=null)r.setId(Integer.valueOf(id.toString()));
				
				FileItem fileItem = mapFiles.get("image");
				if(fileItem.getSize() > 0){
					String format = fileItem.getName().substring(fileItem.getName().lastIndexOf(".")+1);
					String fileName = r.getId() + "_" + System.currentTimeMillis() + "." + format;
					Util.saveImage(fileItem.get(), request.getServletContext().getRealPath("") + "/image", fileName);
					r.setUrl(fileName);
				}else {
					r.setUrl(r.getUrl());
				}
				CreateDao.createObject(r);
			}else {
				//request.setAttribute("info", "操作失败");
				//request.getRequestDispatcher("fail.jsp").forward(request,response);
				message = "操作失败";
			}

		} catch (Exception e) {
			//request.setAttribute("info", "操作失败：" + e.getMessage());
			//request.getRequestDispatcher("fail.jsp").forward(request,response);
			message = "操作失败：" + e.getMessage();
		}
		System.out.println(message);
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(message);
	}
}
