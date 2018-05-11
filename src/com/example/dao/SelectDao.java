package com.example.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.example.bean.resource;
import com.example.bean.user;
import com.example.bean.user_score;
import com.example.util.HibernateUtil;
import com.example.util.Matrix;
import com.example.util.Util;

public class SelectDao {
	
	public static ArrayList<user> getAllUser() {
		Session session = HibernateUtil.currentSession();
		session.beginTransaction();

		Criteria critera = session.createCriteria(user.class);
		critera.addOrder(Order.asc("user_name"));
		List<user> list = critera.list();

		session.getTransaction().commit();
		session.close();

		ArrayList<user> resourceList = new ArrayList<user>();
		resourceList.addAll(list);

		return resourceList;
	}

	
	public static user findUser(Integer id) {
		Session session = HibernateUtil.currentSession();
		session.beginTransaction();
		
		List<user> list;
		Criteria critera = session.createCriteria(user.class);
		critera.add( Restrictions.eq("id", id) );
		list = critera.list();
		
		session.getTransaction().commit();
		session.close();
		return (user) (list.size()==0 ? null : list.get(0) );
	}
	
	public static user findUser(String userName) {
		Session session = HibernateUtil.currentSession();
		session.beginTransaction();
		
		List<user> list;
		Criteria critera = session.createCriteria(user.class);
		critera.add( Restrictions.eq("user_name", userName) );
		list = critera.list();
		
		session.getTransaction().commit();
		session.close();
		return (user) (list.size()==0 ? null : list.get(0) );
	}

	public static resource findResource(Integer id) {
		Session session = HibernateUtil.currentSession();
		session.beginTransaction();
		
		List<resource> list;
		Criteria critera = session.createCriteria(resource.class);
		critera.add( Restrictions.eq("id", id) );
		list = critera.list();
		
		session.getTransaction().commit();
		session.close();
		return (resource) (list.size()==0 ? null : list.get(0) );
	}
	
	public static ArrayList<resource> getAllResources() {
		Session session = HibernateUtil.currentSession();
		session.beginTransaction();

		Criteria critera = session.createCriteria(resource.class);
		//critera.add( Restrictions.eq("email", email) );
		List<resource> list = critera.list();

		session.getTransaction().commit();
		session.close();

		ArrayList<resource> resourceList = new ArrayList<resource>();
		resourceList.addAll(list);
		for (resource r : resourceList) {
			List<user_score> scores = getAllUserScore(r.getId());
			double sum = 0;
			for (user_score score : scores) {
				sum += score.getScore();
			}
			if(scores.size()>0){
				sum /= scores.size();
			}
			else {
				sum = 0;
			}
			if(scores.size() > 0){ 
				r.setScore((float)sum);
			}
		}
		return resourceList;
	}
	
	public static ArrayList<user_score> getUserScore(Integer userId) {
		Session session = HibernateUtil.currentSession();
		session.beginTransaction();

		Criteria critera = session.createCriteria(user_score.class);
		critera.add( Restrictions.eq("user_id", userId) );
		List<user_score> list = critera.list();

		session.getTransaction().commit();
		session.close();

		ArrayList<user_score> resourceList = new ArrayList<user_score>();
		resourceList.addAll(list);

		return resourceList;
	}
	
	public static user_score getUserScore(Integer userId, Integer resourceId) {
		Session session = HibernateUtil.currentSession();
		session.beginTransaction();

		Criteria critera = session.createCriteria(user_score.class);
		critera.add( Restrictions.eq("user_id", userId) );
		critera.add( Restrictions.eq("resource_id", resourceId) );
		List<user_score> list = critera.list();

		session.getTransaction().commit();
		session.close();

		return (user_score) (list.size()==0 ? null : list.get(0) );
	}
	
	//得到用户打过分的电影
	public static ArrayList<resource> getSelectedResources(Integer userId) {
		ArrayList<resource> all = getAllResources();
		ArrayList<resource> ret = new ArrayList<resource>();
		for (resource r : all) {
			user_score  score = getUserScore(userId, r.getId());
			if(score != null){
				r.setScore(score.getScore());
				ret.add(r);
			}	
		}
		return ret;
	}
	
	//得到用户没有打过分的电影
	public static ArrayList<resource> getUnselectedResources(Integer userId) {
		ArrayList<resource> all = getAllResources();
		ArrayList<resource> ret = new ArrayList<resource>();
		for (resource r : all) {
			user_score  score = getUserScore(userId, r.getId());
			if(score == null){
				ret.add(r);
			}
		}
		return ret;
	}

	public static ArrayList<user_score> getAllUserScore() {
		Session session = HibernateUtil.currentSession();
		session.beginTransaction();

		Criteria critera = session.createCriteria(user_score.class);
		List<user_score> list = critera.list();

		session.getTransaction().commit();
		session.close();

		ArrayList<user_score> resourceList = new ArrayList<user_score>();
		resourceList.addAll(list);

		return resourceList;
	}
	
	public static ArrayList<user_score> getAllUserScore(Integer resourceId) {
		Session session = HibernateUtil.currentSession();
		session.beginTransaction();

		Criteria critera = session.createCriteria(user_score.class);
		critera.add( Restrictions.eq("resource_id", resourceId) );
		List<user_score> list = critera.list();

		session.getTransaction().commit();
		session.close();

		ArrayList<user_score> resourceList = new ArrayList<user_score>();
		resourceList.addAll(list);

		return resourceList;
	}
	
	//找推荐
	public static ArrayList<resource> getPreferResources(Integer userId,
			String path) {
		Matrix m = new Matrix(path);
		ArrayList<resource> sList = getSelectedResources(userId);//用户已经打过分的电影
		ArrayList<resource> uList = getUnselectedResources(userId);//用户未打过分的电影
		System.out.println(uList.size() + " " + sList.size());
		for (resource r1 : uList) {
			Double similaritySum1 = 0.0;
			Double similaritySum2 = 0.0;
			
			for (resource r2 : sList) {
				user_score us = getUserScore(userId, r2.getId());
				
				Double sim = m.getSimilarity(r1.getNumber(),r2.getNumber()) ;
				System.out.println("电影编号 "+r1.getNumber() + "与 " +"电影编号 "+ r2.getNumber() + "相似度为" + sim);
				
				similaritySum1 += sim * (us.getScore()/10);//权重为各个物品与当前物品的相似度，对已经打过分的电影进行加权求和
				similaritySum2 += sim;//求得物品相似度的和
			}
			
			if(similaritySum2 != 0.0){
				Double s = similaritySum1/similaritySum2;//求得预测评分值
				r1.setTmp(s);
				System.out.println("tmp:该电影评分预测值为 " + s);
			}else {
				r1.setTmp(Double.MIN_VALUE);
			}
		}
		
		Collections.sort(uList);
		Collections.reverse(uList);
		return uList;
	}
	
	//找邻居
	public static List<user> getNeighbors(Integer userId){
		user current = findUser(userId);//得到当前用户
		List<user> users = getAllUser();//得到所有用户列表
		List<resource> resources = getAllResources();//获取所有电影信息
		
		//当前用户的偏好向量
		List<Double> vectorCurrent = new ArrayList<>();
		for (resource r : resources) {
			double numScore = Double.MIN_VALUE;
			user_score score = getUserScore(current.getId(), r.getId()); 
			if(score != null){
				numScore = score.getScore();
			}
			vectorCurrent.add(numScore);
		}
		System.out.println("current: " + vectorCurrent.toString());

		for (user u : users) {
			//得到每一个用户的向量
			List<Double> vector = new ArrayList<>();
			for (resource r : resources) {
				double numScore = Double.MIN_VALUE;
				user_score score = getUserScore(u.getId(), r.getId()); 
				if(score != null){
					numScore = score.getScore();
				}
				vector.add(numScore);
			}
           //所有用户的偏好初始化完毕
			double distance = Util.distance(vectorCurrent,vector);//计算用户之间的距离
			u.setDistance(distance);
			System.out.println("distance: " + distance + " " + u.getUser_name() + ": " + vectorCurrent.toString());
			//System.out.println("Current user's vector :" + vector.toString());
		}
		
		Collections.sort(users);
		return users;
	}
}
