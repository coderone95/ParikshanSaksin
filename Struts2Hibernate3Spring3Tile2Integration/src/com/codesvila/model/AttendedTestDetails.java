package com.codesvila.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="tbl_attended_test_details")
public class AttendedTestDetails implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id  
	@GeneratedValue(strategy=GenerationType.AUTO)  
	@Column(name = "id", nullable = false)
	private int id;
	
	@Column(name = "test_id")
	private int test_id;
	
	@Column(name = "org_id")
	private int org_id;
	
	@Column(name = "user_id")
	private String user_id;
	
	@Column(name = "test_started_time")
	private Date test_started_time;
	
	@Column(name = "test_ended_time")
	private Date test_ended_time;
	
	@Column(name = "attempted")
	private int attempted;
	
	@Column(name = "max_attempt")
	private int max_attempt;

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

	public Date getTest_started_time() {
		return test_started_time;
	}

	public void setTest_started_time(Date test_started_time) {
		this.test_started_time = test_started_time;
	}

	public Date getTest_ended_time() {
		return test_ended_time;
	}

	public void setTest_ended_time(Date test_ended_time) {
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

}
