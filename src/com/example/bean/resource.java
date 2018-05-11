package com.example.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.sun.org.apache.xerces.internal.impl.xs.SubstitutionGroupHandler;

@Entity
public class resource implements Serializable, Comparable<resource> {

	private static final long serialVersionUID = -1632554815794284219L;
	
	@Id
	@GeneratedValue
	Integer id;
	String number;
	String type;//动作，喜剧
	String area, year; //增加地区和年份
	String name;
	@Column(length=10240)
	String description;
	Float score;
	String url;

	@Transient
	Double tmp;
	
	public resource() {
		// TODO Auto-generated constructor stub
	}

	public resource(String number, String name, String description,
			String type, String area, String year) {
		super();
		this.number = number;
		this.name = name;
		this.description = description;
		this.score = 0.0f;
		this.type = type;
		this.url = "";
		this.area = area;
		this.year = year;
	}


	public String getArea() {
		return area;
	}
	public String getYear() {
		return year;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public Double getTmp() {
		return tmp;
	}
	
	public void setTmp(Double tmp) {
		this.tmp = tmp;
	}
	
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}

	public Float getScore() {
		return score;
	}


	public void setScore(Float score) {
		this.score = score;
	}


	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}

	@Override
	public int compareTo(resource o) {
		// TODO Auto-generated method stub
		return tmp.compareTo(o.tmp); 
	}
}
