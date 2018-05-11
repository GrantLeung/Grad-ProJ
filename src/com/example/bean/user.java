package com.example.bean;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Transient;


@Entity
public class user implements Serializable,Comparable<user> {
	private static final long serialVersionUID = -1632554815794284219L;
	
	@Id
	@GeneratedValue
	Integer id;
	String user_name;
	String password;
	String type;
	String mobile;
	String address;//ÊÖ»ú£¬ µØÖ·
	String hobby;
	String url;
	
	@Transient
	Double distance;
	public Double getDistance() {
		return distance;
	}
	public void setDistance(Double distance) {
		this.distance = distance;
	}
	
	public user() {
		// TODO Auto-generated constructor stub
	}
	
	public user(String userName, String password2, String mobile, String address,String hobby) {
		user_name = userName;
		password = password2;
		//user_hobby = hobby;
		this.mobile = mobile;
		this.address = address;
		this.hobby = hobby;
		type = "2";
	}

	public user(String userName, String password2, String type2) {
		user_name = userName;
		password = password2;
		type = type2;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	@Override
	public int compareTo(user o) {
		// TODO Auto-generated method stub
		return distance.compareTo(o.distance);
	}

}

