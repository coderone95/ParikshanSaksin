package com.codesvila.report.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.TestBO;
import com.codesvila.service.ReportService;

public class GetTestsExecuteReportAction {
	
	@Autowired
	private ReportService reportService;
	
	
	private String startDate;
	private String endDate;
	private Integer testId;
	private String createdBy;
	private String testName;
	private String testKey;
	private List<TestBO> testList ;
	
	/**
	 * @return the startDate
	 */
	public String getStartDate() {
		return startDate;
	}
	/**
	 * @param startDate the startDate to set
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}
	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
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
	 * @return the createdBy
	 */
	public String getCreatedBy() {
		return createdBy;
	}
	/**
	 * @param createdBy the createdBy to set
	 */
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	/**
	 * @return the testName
	 */
	public String getTestName() {
		return testName;
	}
	/**
	 * @param testName the testName to set
	 */
	public void setTestName(String testName) {
		this.testName = testName;
	}
	
	public List<TestBO> getTestList() {
		return testList;
	}
	public void setTestList(List<TestBO> testList) {
		this.testList = testList;
	}
	/**
	 * @return the testKey
	 */
	public String getTestKey() {
		return testKey;
	}
	/**
	 * @param testKey the testKey to set
	 */
	public void setTestKey(String testKey) {
		this.testKey = testKey;
	}
	public String getTestReport() throws Exception{
		testList = reportService.getTestReport(startDate,
				endDate,createdBy,testName,testId,testKey);
		return "success";
	}

}
