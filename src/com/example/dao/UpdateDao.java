package com.example.dao;

import org.hibernate.Session;

import com.example.util.HibernateUtil;

public class UpdateDao {

	public static void updateObject(Object o){

		Session session = HibernateUtil.currentSession();
		session.beginTransaction();
		
		session.update(o);
		
		session.getTransaction().commit();
		session.close();
	}
}
