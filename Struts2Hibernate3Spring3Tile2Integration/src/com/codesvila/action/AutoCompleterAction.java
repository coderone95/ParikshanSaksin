package com.codesvila.action;

import com.opensymphony.xwork2.ActionSupport;

public class AutoCompleterAction extends ActionSupport{
 
	private String yourDatabase;
	
	public String display() {
		return NONE;
	}

	public String getYourDatabase() {
		return yourDatabase;
	}

	public void setYourDatabase(String yourDatabase) {
		this.yourDatabase = yourDatabase;
	}

}