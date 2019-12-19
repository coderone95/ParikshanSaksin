package com.codesvila.action;

import java.text.ParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.AttendedTestDetailsBean;
import com.codesvila.bean.GroupBO;
import com.codesvila.bean.TestBO;
import com.codesvila.service.CandidateService;
import com.codesvila.utils.DateUtils;
import com.codesvila.utils.GlobalConstants;

public class StartTestAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Autowired
	private CandidateService candidateService;
	private Integer testID;
	private List<GroupBO> groupInfoAndCountList;
	private TestBO testBo;
	private String starttime;
	private String endtime;
	private String loginId;
	private String message;
	private String error;
	
	public Integer getTestID() {
		return testID;
	}
	public void setTestID(Integer testID) {
		this.testID = testID;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public List<GroupBO> getGroupInfoAndCountList() {
		return groupInfoAndCountList;
	}
	public void setGroupInfoAndCountList(List<GroupBO> groupInfoAndCountList) {
		this.groupInfoAndCountList = groupInfoAndCountList;
	}
	public TestBO getTestBo() {
		return testBo;
	}
	public void setTestBo(TestBO testBo) {
		this.testBo = testBo;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getError() {
		return error;
	}
	public void setError(String error) {
		this.error = error;
	}
	public String display() throws Exception{
		loginId = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
		testID = (Integer) sessionMap.get("currentTestID");
		return "success";
	}
	
	public String getGroupsInfoAndNumberOfQuestionCount() throws Exception{
		groupInfoAndCountList = candidateService.getGroupsInfoAndNumberOfQuestionCount(testID);
		return "success";
	}
	
	public String getTestNameAndTime() throws Exception{
		List<TestBO> testInfo = candidateService.getTestNameAndTime(testID);
		if(testInfo.size() > 0 && !testInfo.isEmpty()) {
			for(TestBO tb : testInfo) {
				testBo = tb;
				return "success";
			}
		}
		return "success";
	}
	
	public String saveAttendedTestDetails() throws Exception {
		loginId = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
		int generatedID = candidateService.saveAttendedTestDetails(loginId,testID,DateUtils.getFormattedDate(starttime),DateUtils.getFormattedDate(endtime));
		return "success";
	}

}
