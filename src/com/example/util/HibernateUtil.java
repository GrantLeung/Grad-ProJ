package com.example.util;

import org.hibernate.HibernateException;  
import org.hibernate.Session;  
import org.hibernate.SessionFactory;  
import org.hibernate.cfg.Configuration;  
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

public class HibernateUtil {
	
	private static final SessionFactory sessionFactory = configureSessionFactory();

	private static SessionFactory configureSessionFactory() throws HibernateException {
		try {
			Configuration configuration = new Configuration();
			configuration.configure();
			
			ServiceRegistry serviceRegistry = new ServiceRegistryBuilder().applySettings(configuration.getProperties()).buildServiceRegistry();        
			return configuration.buildSessionFactory(serviceRegistry);
		} catch (HibernateException ex) {
			// Make sure you log the exception, as it might be swallowed
			System.err.println("Initial SessionFactory creation failed." + ex);
			throw new RuntimeException("Initial SessionFactory creation failed.: " + ex.getMessage(), ex); 
		}
	}
    
	public static SessionFactory getSessionFactory() {
	    return sessionFactory;
	}
	
	public static Session currentSession() throws HibernateException {
		Session s = getSessionFactory().openSession();
		return s;
	}
}
