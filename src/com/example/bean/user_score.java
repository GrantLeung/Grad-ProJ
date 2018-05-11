package com.example.bean;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
public class user_score implements Serializable {

	private static final long serialVersionUID = -1632554815794284219L;
	
	@Id
	@GeneratedValue
	Integer id;
	Integer user_id;
	Integer resource_id;
	Float  score;
	Date time;
	
	public user_score() {
		// TODO Auto-generated constructor stub
	}
	
	public user_score(Integer userId, Integer resource_id, Float score) {
		this.user_id = userId;
		this.resource_id = resource_id;
		this.score = score;
		this.time = new Date();
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public Integer getResource_id() {
		return resource_id;
	}

	public void setResource_id(Integer resource_id) {
		this.resource_id = resource_id;
	}

	public Float getScore() {
		return score;
	}

	public void setScore(Float score) {
		this.score = score;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}
	
	
}
