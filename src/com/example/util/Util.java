package com.example.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;


public class Util {

	public static String printRequest(HttpServletRequest request){
		;
		String printString = getLogString(request);
		printString = "\n\n--------------Request------------" 
				+ request.getContentType() + "  "
				+ request.getCharacterEncoding() + "\n" + printString;
		System.out.println(printString);
		return printString;
	}

	public static String getLogString(HttpServletRequest request){
		return toString(request);
	}

	public static String toString(HttpServletRequest request){
		String message = "";
		Enumeration<String> params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String key = params.nextElement();
			String[] values = request.getParameterValues(key);
			String valueString = "";
			for(int i=0;i<values.length;i++){
				valueString += values[i];
			}
			message += key + "(" + values.length +"): " + valueString + "\n";
		}
		return message;
	}
	
	public static void printRequest(HttpServletRequest request, Map<String, Object> mapParams, Map<String, FileItem> mapFiles) {
			String logString = "";
			logString += ("------------Http Request------------"
					+ "\n"
					);
			logString += ("Api: " + mapParams.get("actionName") + "\n");
			logString += ("Url: " + request.getLocalAddr() + ":" + request.getLocalPort() + request.getRequestURI() + "\n");
			logString += ("Params: \n");
			logString += mapParams.toString() + "\n";
			logString += mapFiles.toString() + "\n";
			System.out.println(logString);
	}
	
	public static void  removeFile(String filePath) {
		File file = new File(filePath);
		if(file.exists()){
			file.delete();
		}
	}
	
	public static void copyfile(String srFile, String dtFile){
		try{
			  File f1 = new File(srFile);
			  File f2 = new File(dtFile);
			  InputStream in = new FileInputStream(f1);
			  
			  //For Append the file.
			  //  OutputStream out = new FileOutputStream(f2,true);
	
			  //For Overwrite the file.
			  OutputStream out = new FileOutputStream(f2);
	
			  byte[] buf = new byte[1024];
			  int len;
			  while ((len = in.read(buf)) > 0){
				  out.write(buf, 0, len);
			  }
			  in.close();
			  out.close();
		}catch(IOException e){
			System.out.println("copy " + srFile + " to " + dtFile + "\t" + e.getMessage());  
		}
	}
	
	public static List<String> readFileLines(String path){
		List<String> lines = new ArrayList<String>();
		try{
			  File f1 = new File(path);
			  BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(f1),"utf-8"));
			  String line = reader.readLine();
			  while(line != null){
				  lines.add(line);
				  line = reader.readLine();
			  }
			  reader.close();
		}catch(IOException e){
			e.printStackTrace();
			return null;
		}
		return lines;
	}

	public static int random(int i) {
		Random r = new Random();
		return r.nextInt(i);
	}


	public static void saveImage(byte[] bs, String folder, String name) throws IOException {
		File file = new File(folder);
		file.mkdirs();
		file = new File(folder + File.separator + name);
		file.createNewFile();
		FileOutputStream outputStream = new FileOutputStream(file);
		outputStream.write(bs);
		outputStream.close();
	}

	public static double distance(List<Double> vectorCurrent, List<Double> vector) {
		double sum = 0;
		for (int i=0;i<vector.size();i++) {
			sum += (vectorCurrent.get(i)-vector.get(i)) * (vectorCurrent.get(i)-vector.get(i));
		}
		sum = Math.sqrt(sum);
		return sum;
	}
}
