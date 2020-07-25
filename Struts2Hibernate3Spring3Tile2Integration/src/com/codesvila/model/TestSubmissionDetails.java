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
@Table(name="tbl_test_submission_details")
public class TestSubmissionDetails implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id  
	@GeneratedValue(strategy=GenerationType.AUTO)  
	@Column(name = "id", nullable = false)
	private Integer id;
	
	@Column(name = "user_id")
	private String userId;
	
	@Column(name = "test_id")
	private Integer testId;
	
	@Column(name = "test_start_time")
	private Date testStartTime;
	
	@Column(name = "test_end_time")
	private Date testEndTime;
	
	@Column(name = "submitted_successfully")
	private boolean isSubmittedSuccessfully;
	
	/**
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}
	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * @return the testId
	 */
	public Integer getTestId() {
		return testId;
	}
	/**
	 * @param testId the testId to set
	 */
	public void setTestId(Integer testId) {
		this.testId = testId;
	}
	/**
	 * @return the testStartTime
	 */
	public Date getTestStartTime() {
		return testStartTime;
	}
	/**
	 * @param testStartTime the testStartTime to set
	 */
	public void setTestStartTime(Date testStartTime) {
		this.testStartTime = testStartTime;
	}
	/**
	 * @return the isSubmittedSuccessfully
	 */
	public boolean isSubmittedSuccessfully() {
		return isSubmittedSuccessfully;
	}
	/**
	 * @param isSubmittedSuccessfully the isSubmittedSuccessfully to set
	 */
	public void setSubmittedSuccessfully(boolean isSubmittedSuccessfully) {
		this.isSubmittedSuccessfully = isSubmittedSuccessfully;
	}
	/**
	 * @return the testEndTime
	 */
	public Date getTestEndTime() {
		return testEndTime;
	}
	/**
	 * @param testEndTime the testEndTime to set
	 */
	public void setTestEndTime(Date testEndTime) {
		this.testEndTime = testEndTime;
	}
	
	
}
