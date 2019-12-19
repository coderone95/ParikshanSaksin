package com.codesvila.action;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.GroupsTestInfoBO;
import com.codesvila.bean.SuccessMessages;
import com.codesvila.bean.TestBO;
import com.codesvila.bo.ResponseBO;
import com.codesvila.service.TestService;
import com.codesvila.utils.CommonUtility;
import com.codesvila.utils.DateUtils;
import com.codesvila.utils.GlobalConstants;

public class UpdateTestAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1041120010443914559L;
	@Autowired
	private TestService testService;
	private Integer testID;
	private String loginId;
	private TestBO testBo;
	private List<TestBO> testBoList;
	private ResponseBO res;
	private String testName;
	private String testKey;
	private String testAccessKey;
	private String expiresOn;
	private String testInstructions;
	private List<SuccessMessages> successMsgList;
	private List<GroupsTestInfoBO> addedGroupsList;
	private List<GroupsTestInfoBO> availableGroupsList;
	private Integer groupId;
	private List<Integer> groupIDs;
	//private UserBean userBean;
	private Integer testTime;
	private String startOn;
	private String endOn;
	private Integer passingCriteria;
	private Integer hrs;
	private Integer mins;
	private Integer secs;
	private String errorMsg = null;
	
	public Integer getTestID() {
		return testID;
	}

	public void setTestID(Integer testID) {
		this.testID = testID;
	}

	public TestBO getTestBo() {
		return testBo;
	}

	public void setTestBo(TestBO testBo) {
		this.testBo = testBo;
	}

	public ResponseBO getRes() {
		return res;
	}

	public void setRes(ResponseBO res) {
		this.res = res;
	}
	
	public List<TestBO> getTestBoList() {
		return testBoList;
	}

	public void setTestBoList(List<TestBO> testBoList) {
		this.testBoList = testBoList;
	}

	public String getTestName() {
		return testName;
	}

	public void setTestName(String testName) {
		this.testName = testName;
	}

	public String getTestKey() {
		return testKey;
	}

	public void setTestKey(String testKey) {
		this.testKey = testKey;
	}

	public String getTestAccessKey() {
		return testAccessKey;
	}

	public void setTestAccessKey(String testAccessKey) {
		this.testAccessKey = testAccessKey;
	}

	public String getExpiresOn() {
		return expiresOn;
	}

	public void setExpiresOn(String expiresOn) {
		this.expiresOn = expiresOn;
	}

	public String getTestInstructions() {
		return testInstructions;
	}

	public void setTestInstructions(String testInstructions) {
		this.testInstructions = testInstructions;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public List<SuccessMessages> getSuccessMsgList() {
		return successMsgList;
	}

	public void setSuccessMsgList(List<SuccessMessages> successMsgList) {
		this.successMsgList = successMsgList;
	}

	public List<GroupsTestInfoBO> getAddedGroupsList() {
		return addedGroupsList;
	}

	public void setAddedGroupsList(List<GroupsTestInfoBO> addedGroupsList) {
		this.addedGroupsList = addedGroupsList;
	}

	public List<GroupsTestInfoBO> getAvailableGroupsList() {
		return availableGroupsList;
	}

	public void setAvailableGroupsList(List<GroupsTestInfoBO> availableGroupsList) {
		this.availableGroupsList = availableGroupsList;
	}

	public Integer getGroupId() {
		return groupId;
	}

	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	public List<Integer> getGroupIDs() {
		return groupIDs;
	}

	public void setGroupIDs(List<Integer> groupIDs) {
		this.groupIDs = groupIDs;
	}
//
//	public UserBean getUserBean() {
//		return userBean;
//	}
//
//	public void setUserBean(UserBean userBean) {
//		this.userBean = userBean;
//	}

	public Integer getTestTime() {
		return testTime;
	}

	public void setTestTime(Integer testTime) {
		this.testTime = testTime;
	}

	public String showUpdateTestPage() {
		loginId = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
		return "success";
	}
	
	public String getTestInfoForSelectedID() throws Exception{
		testBoList = testService.getTestInfoForSelectedID(testID);
		return "success";
	}
	
	public String getStartOn() {
		return startOn;
	}

	public void setStartOn(String startOn) {
		this.startOn = startOn;
	}

	public String getEndOn() {
		return endOn;
	}

	public void setEndOn(String endOn) {
		this.endOn = endOn;
	}

	public Integer getPassingCriteria() {
		return passingCriteria;
	}

	public void setPassingCriteria(Integer passingCriteria) {
		this.passingCriteria = passingCriteria;
	}

	/**
	 * @return the errorMsg
	 */
	public String getErrorMsg() {
		return errorMsg;
	}

	/**
	 * @param errorMsg the errorMsg to set
	 */
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	public Integer getHrs() {
		return hrs;
	}

	public void setHrs(Integer hrs) {
		this.hrs = hrs;
	}

	public Integer getMins() {
		return mins;
	}

	public void setMins(Integer mins) {
		this.mins = mins;
	}

	public Integer getSecs() {
		return secs;
	}

	public void setSecs(Integer secs) {
		this.secs = secs;
	}

	public String updateTest() throws Exception{
		if(validateInputs()) {
			String loginID = null;
			if((String) sessionMap.get(GlobalConstants.LOGIN_ID) == null) {
				loginID = loginId;
			}else {
				loginID = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
			}
			Integer examTime = CommonUtility.returnsTestTimeInSecs(hrs, mins, secs);
			//		Integer result = testService.updateTest(loginID,testID,testName,testKey,testAccessKey,testInstructions,DateUtils.getFormattedDate(expiresOn),testTime);
			if(passingCriteria == 0) {
				passingCriteria = 40;
			}
			
			Integer result = testService.updateTest(loginID,testID,testName,testKey,testAccessKey,testInstructions,
					DateUtils.getFormattedDate(startOn),DateUtils.getFormattedDate(endOn),examTime,passingCriteria);
			
		}
		
		return "success";
	}
	
	public String getAddedGroupsForSelectedTest() throws Exception{
		addedGroupsList = testService.getAddedGroupsForSelectedTest(testID);
		return "success";
	}
	
	public String getAvailableGroupsForSelectedTest() throws Exception{
		availableGroupsList = testService.getAvailableGroupsForSelectedTest(testID);
		return "success";
	}
	
	public String removeSelectedGroupFromSelectedTest() throws Exception{
		int result = testService.removeSelectedGroupFromSelectedTest(testID,groupId);
		return "success";
	}
	
	public String addSelectedGroupsToTest() throws Exception{
		Integer result = testService.addSelectedGroupsToTest(groupIDs,testID);
		return "success";
	}
	
	public boolean validateInputs() {
		if(! StringUtils.isNotBlank(testName) || testName == null) {
			errorMsg = "Please enter test name";
			return false;
		}else if(! StringUtils.isNotBlank(testKey) || testKey == null) {
			errorMsg = "Please enter test key";
			return false;
		}else if((StringUtils.isNotBlank(testKey) && testKey != null) &&  (!StringUtils.isNotBlank(testAccessKey) || testAccessKey == null)) {
			errorMsg = "Please enter access key";
			return false;
		}else if(!StringUtils.isNotBlank(startOn) || startOn == null) {
			errorMsg = "Please select test start date and time";
			return false;
		}else if(passingCriteria > 100) {
			errorMsg = "Passing criteria must be 0 to 100";
			return false;
		}else if(hrs == 0 && mins == 0) {
			errorMsg = "Mention either hour or minutes.";
			return false;
		}else if(mins > 60) {
			errorMsg = "Mintues must be 0 to 60";
			return false;
		}else if(secs > 60) {
			errorMsg = "Seconds must be 0 to 60";
			return false;
		}
		return true;
	}
	
}
