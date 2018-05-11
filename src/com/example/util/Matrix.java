package com.example.util;

import java.util.ArrayList;
import java.util.List;


public class Matrix {
	
	ArrayList<ArrayList<Object>> data = new ArrayList<ArrayList<Object>>();
	
	public Matrix(String path) {
		List<String> list = Util.readFileLines(path);
		for(int i=1;i<list.size();i++){
			String[] ss = list.get(i).split("\\s+");
			ArrayList<Object> d = new ArrayList<Object>();
			for(int j=0;j<ss.length;j++){
				d.add(Double.valueOf(ss[j]));
			}
			data.add(d);
		}
	}

	//计算2部电影的欧基里德距离，the example maybe :d(x,y) = sqrt((x1-y2)^2+(x2-y2)^2+......)
	public Double getSimilarity(String number1, String number2) {
		ArrayList<Object> l1 = findLine(number1);
		ArrayList<Object> l2 = findLine(number2);
		if(l1 == null || l2 == null){
			return 1 /Math.sqrt(((data.get(0).size()-1)*10.0*10.0));
		}else {
			Double sim = 0.0;
			for(int i=1;i<l1.size();i++){
				sim += (Double.valueOf(l1.get(i).toString()) - Double.valueOf(l2.get(i).toString()) ) * 
						(Double.valueOf(l1.get(i).toString()) - Double.valueOf(l2.get(i).toString()) );
			}
			return 1 / Math.sqrt(sim);
		}
	}
	
	
	
	//计算2部电影的曼哈顿相关系数
	/*public Double getSimilarity(String number1, String number2) {
		ArrayList<Object> l1 = findLine(number1);
		ArrayList<Object> l2 = findLine(number2);
		if(l1 == null || l2 == null){
			return 1 /Math.sqrt(((data.get(0).size()-1)*10.0*10.0));
		}else {
			Double sim = 0.0;
			for(int i=1;i<l1.size();i++){
				sim += Math.abs((Double.valueOf(l1.get(i).toString()) - Double.valueOf(l2.get(i).toString()) ) );
			}
			return 1 / Math.sqrt(sim);
		}
	}*/
	
	
	//找到电影编号对应的行的数据
	private ArrayList<Object> findLine(String number){
		for(int i=0;i<data.size();i++){
			if(data.get(i).get(0).toString().equals(number)){
				return data.get(i);
			}
		}
		return null;
	}

}
