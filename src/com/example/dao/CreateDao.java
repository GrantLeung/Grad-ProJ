package com.example.dao;

import java.util.ArrayList;

import org.hibernate.Session;

import com.example.bean.resource;
import com.example.util.HibernateUtil;


public class CreateDao {
	
	public static void createObject(Object o){
		Session session = HibernateUtil.currentSession();
		session.beginTransaction();

		session.saveOrUpdate(o);
		
		session.getTransaction().commit();
		session.close();
	}
	
	public static void createObjectByString(String o) throws Exception {
		Session session = HibernateUtil.currentSession();
		session.beginTransaction();

		session.save(Class.forName(o).newInstance());
		
		session.getTransaction().commit();
		session.close();
	}
	
	public static void createObject(ArrayList<Object> os) {
		// TODO Auto-generated method stub
		for (Object o : os) {
			createObject(o);
		}
	}
	
}
