package com.codesvila.bean;

import java.util.Date;

public class TestSubmissionDetailsBO {
	private Integer id;
	private String userId;
	private Integer testId;
	private Date testStartTime;
	private Date testEndTime;
	private boolean isSubmittedSuccessfully;
	private Integer afterFailureRemainingTime;
	private Integer failureSessionCount;
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
	 * @return the afterFailureRemainingTime
	 */
	public Integer getAfterFailureRemainingTime() {
		return afterFailureRemainingTime;
	}
	/**
	 * @param afterFailureRemainingTime the afterFailureRemainingTime to set
	 */
	public void setAfterFailureRemainingTime(Integer afterFailureRemainingTime) {
		this.afterFailureRemainingTime = afterFailureRemainingTime;
	}
	/**
	 * @return the failureSessionCount
	 */
	public Integer getFailureSessionCount() {
		return failureSessionCount;
	}
	/**
	 * @param failureSessionCount the failureSessionCount to set
	 */
	public void setFailureSessionCount(Integer failureSessionCount) {
		this.failureSessionCount = failureSessionCount;
	}
	
	
}
