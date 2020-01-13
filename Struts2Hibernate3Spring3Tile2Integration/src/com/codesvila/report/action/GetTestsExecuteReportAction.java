package com.codesvila.report.action;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.action.BaseAction;
import com.codesvila.bean.TestBO;
import com.codesvila.service.ReportService;
import com.codesvila.utils.GlobalConstants;

public class GetTestsExecuteReportAction extends BaseAction{
	
	@Autowired
	private ReportService reportService;
	
	
	private String startDate;
	private String endDate;
	private Integer testId;
	private String createdBy;
	private String testName;
	private String testKey;
	private List<TestBO> testList ;
	private boolean hasTestEditAccess;
	private boolean hasTestDeleteAccess;
	
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
	/**
	 * @return the hasTestEditAccess
	 */
	public boolean isHasTestEditAccess() {
		return hasTestEditAccess;
	}
	/**
	 * @param hasTestEditAccess the hasTestEditAccess to set
	 */
	public void setHasTestEditAccess(boolean hasTestEditAccess) {
		this.hasTestEditAccess = hasTestEditAccess;
	}
	/**
	 * @return the hasTestDeleteAccess
	 */
	public boolean isHasTestDeleteAccess() {
		return hasTestDeleteAccess;
	}
	/**
	 * @param hasTestDeleteAccess the hasTestDeleteAccess to set
	 */
	public void setHasTestDeleteAccess(boolean hasTestDeleteAccess) {
		this.hasTestDeleteAccess = hasTestDeleteAccess;
	}
	public String getTestReport() throws Exception{
		Map<String,Boolean> accessListMap = getAccessMap();
		hasTestEditAccess = accessListMap.get(GlobalConstants.M_EDIT_TEST);
		hasTestDeleteAccess = accessListMap.get(GlobalConstants.M_DELETE_TEST);
		testList = reportService.getTestReport(startDate,
				endDate,createdBy,testName,testId,testKey);
		return "success";
	}

}
