package com.codesvila.bean;

public class AttendedTestDetailsBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int id;
	
	private int test_id;
	
	private int org_id;
	
	private String user_id;
	
	private String test_started_time;
	
	private String test_ended_time;
	
	private int attempted;
	
	private int max_attempt;
	
	private String test_key;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getTest_id() {
		return test_id;
	}

	public void setTest_id(int test_id) {
		this.test_id = test_id;
	}

	public int getOrg_id() {
		return org_id;
	}

	public void setOrg_id(int org_id) {
		this.org_id = org_id;
	}

	public String getTest_started_time() {
		return test_started_time;
	}

	public void setTest_started_time(String test_started_time) {
		this.test_started_time = test_started_time;
	}

	public String getTest_ended_time() {
		return test_ended_time;
	}

	public void setTest_ended_time(String test_ended_time) {
		this.test_ended_time = test_ended_time;
	}

	public int getAttempted() {
		return attempted;
	}

	public void setAttempted(int attempted) {
		this.attempted = attempted;
	}

	public int getMax_attempt() {
		return max_attempt;
	}

	public void setMax_attempt(int max_attempt) {
		this.max_attempt = max_attempt;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getTest_key() {
		return test_key;
	}

	public void setTest_key(String test_key) {
		this.test_key = test_key;
	}
	
	
	
}
