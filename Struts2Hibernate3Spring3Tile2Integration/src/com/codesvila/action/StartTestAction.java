package com.codesvila.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	@Autowired
	private AttendedTestDetailsBean attendedTestDetailsBean;
	private Integer testID;
	private List<GroupBO> groupInfoAndCountList;
	private TestBO testBo;
	private String starttime;
	private String endtime;
	private String loginId;
	private String message;
	private String error;
	private String hasExamStarted;
	private String name;
	
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
	/**
	 * @return the attendedTestDetailsBean
	 */
	public AttendedTestDetailsBean getAttendedTestDetailsBean() {
		return attendedTestDetailsBean;
	}
	/**
	 * @param attendedTestDetailsBean the attendedTestDetailsBean to set
	 */
	public void setAttendedTestDetailsBean(AttendedTestDetailsBean attendedTestDetailsBean) {
		this.attendedTestDetailsBean = attendedTestDetailsBean;
	}
	/**
	 * @return the hasExamStarted
	 */
	public String getHasExamStarted() {
		return hasExamStarted;
	}
	/**
	 * @param hasExamStarted the hasExamStarted to set
	 */
	public void setHasExamStarted(String hasExamStarted) {
		this.hasExamStarted = hasExamStarted;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	public String display() throws Exception{
		loginId = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
		testID = (Integer) sessionMap.get("currentTestID");
		return "success";
	}
	
	public String getGroupsInfoAndNumberOfQuestionCount() throws Exception{
		LOG.debug("StartTestAction ---- getGroupsInfoAndNumberOfQuestionCount() --- start");
		Map<String,Object> data = new HashMap<String,Object>();
		try {
			List<GroupBO> groupInfoCountList = candidateService.getGroupsInfoAndNumberOfQuestionCount(testID);
			data.put("GROUPS_INFO_AND_NUMBER_OF_QUE_COUNT", groupInfoCountList);
		}catch(Exception e) {
			LOG.error("Error while getting the groups info and count of questions", e);
		}
		
		LOG.debug("StartTestAction ---- getGroupsInfoAndNumberOfQuestionCount() --- end");
		return writeJsonResponse(data);
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
		TestBO tbo = getTestNameAndTimeBo(testID);
		long time = 0;
		if(tbo != null) {
			time = tbo.getTest_time();
		}
		Date startTime = DateUtils.getFormattedDate(starttime);
		Date endTime = new Date(startTime.getTime() + (time*1000));
		name = (String) sessionMap.get("name");
		loginId = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
		int generatedID = candidateService.saveAttendedTestDetails(loginId,testID,startTime,endTime);
		if(generatedID > 0) {
			session.setAttribute("TEST_CONTEXT_ID", String.valueOf(generatedID));
			hasExamStarted = "YES";
			sessionMap.put("hasExamStarted",hasExamStarted);
		}
		return "success";
	}
	
	public TestBO getTestNameAndTimeBo(Integer testID) throws Exception{
		List<TestBO> testInfo = candidateService.getTestNameAndTime(testID);
		TestBO tb = new TestBO();
		if(testInfo.size() > 0 && !testInfo.isEmpty()) {
			return tb = testInfo.get(0);
		}
		return tb;
	}
	
	public String showTestIns() {
		testID = (Integer) sessionMap.get("currentTestID");
		hasExamStarted = "YES";
		loginId = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
		name = (String) sessionMap.get("name");
		return "success"; 
	}
	
	public String showExamSet() {
		testID = (Integer) sessionMap.get("currentTestID");
		hasExamStarted = "YES";
		loginId = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
		name = (String) sessionMap.get("name");
		return "success"; 
	}

}
