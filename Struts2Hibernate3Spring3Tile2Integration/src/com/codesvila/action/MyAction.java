package com.codesvila.action;

import java.util.ArrayList;
import java.util.List;

import com.opensymphony.xwork2.ActionSupport;

public class MyAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private List<String> dataList = null;

	@Override
	public String execute() throws Exception {
		dataList = new ArrayList<String>();
		dataList.add("India");
		dataList.add("USA");
		dataList.add("Russia");
		dataList.add("China");
		dataList.add("Japan");
		return "SUCCESS";
	}

	public List<String> getDataList() {
		return dataList;
	}

	public void setDataList(List<String> dataList) {
		this.dataList = dataList;
	}

}