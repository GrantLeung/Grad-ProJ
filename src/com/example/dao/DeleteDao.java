package com.example.dao;

import org.hibernate.Session;

import com.example.bean.resource;
import com.example.bean.user;
import com.example.util.HibernateUtil;

public class DeleteDao {
	
	public static void deleteUser(Integer userId) {
		Session session = HibernateUtil.currentSession();
		session.beginTransaction();
		
		user u = (user) session.get(user.class, userId);
		session.delete(u);
		
		session.getTransaction().commit();
		session.close();
	}

	public static void removeResource(Integer id) {
		Session session = HibernateUtil.currentSession();
		session.beginTransaction();
		
		resource u = (resource) session.get(resource.class, id);
		session.delete(u);

		session.getTransaction().commit();
		session.close();
	}

	public static void removeObject(Object o) {
		Session session = HibernateUtil.currentSession();
		session.beginTransaction();
		
		session.delete(o);

		session.getTransaction().commit();
		session.close();
	}
	
}
