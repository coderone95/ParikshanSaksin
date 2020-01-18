package com.codesvila.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.ErrorMessages;
import com.codesvila.bean.GroupBO;
import com.codesvila.bean.SuccessMessages;
import com.codesvila.bean.TestBO;
import com.codesvila.bo.ResponseBO;
import com.codesvila.service.TestService;
import com.codesvila.utils.CommonUtility;
import com.codesvila.utils.DateUtils;
import com.codesvila.utils.GlobalConstants;

public class TestsPageAction extends BaseAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8604763071405867386L;
	@Autowired
	private TestService testService;
	
	private String loginId;
	private String testName;
	private String testkey;
	private String accessKey;
	private String testInstructionsHtmlCode;
	private String expiresOn;
	private List<Integer> groupIDs;
	private List<ErrorMessages> errorMessagesList;
	private List<SuccessMessages> successMessagesList;
	private ResponseBO res = new ResponseBO();
	List<TestBO> testList ;
	private Integer testID; 
	private Integer testTime;
	private Map<Integer,String> testMap = new HashMap<Integer,String>();
	private String startOn;
	private String endOn;
	private Integer passingCriteria;
	private Integer hrs;
	private Integer mins;
	private Integer secs;
	private String errorMsg = null;
	public String getTestName() {
		return testName;
	}

	public void setTestName(String testName) {
		this.testName = testName;
	}

	public String getTestkey() {
		return testkey;
	}

	public void setTestkey(String testkey) {
		this.testkey = testkey;
	}

	public String getTestInstructionsHtmlCode() {
		return testInstructionsHtmlCode;
	}

	public void setTestInstructionsHtmlCode(String testInstructionsHtmlCode) {
		this.testInstructionsHtmlCode = testInstructionsHtmlCode;
	}

	public List<Integer> getGroupIDs() {
		return groupIDs;
	}

	public void setGroupIDs(List<Integer> groupIDs) {
		this.groupIDs = groupIDs;
	}

	public String getAccessKey() {
		return accessKey;
	}

	public void setAccessKey(String accessKey) {
		this.accessKey = accessKey;
	}

	public List<ErrorMessages> getErrorMessagesList() {
		return errorMessagesList;
	}

	public void setErrorMessagesList(List<ErrorMessages> errorMessagesList) {
		this.errorMessagesList = errorMessagesList;
	}

	public List<SuccessMessages> getSuccessMessagesList() {
		return successMessagesList;
	}

	public void setSuccessMessagesList(List<SuccessMessages> successMessagesList) {
		this.successMessagesList = successMessagesList;
	}
	
	public ResponseBO getRes() {
		return res;
	}

	public void setRes(ResponseBO res) {
		this.res = res;
	}

	public List<TestBO> getTestList() {
		return testList;
	}

	public void setTestList(List<TestBO> testList) {
		this.testList = testList;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getExpiresOn() {
		return expiresOn;
	}

	public void setExpiresOn(String expiresOn) {
		this.expiresOn = expiresOn;
	}
	

	public Integer getTestID() {
		return testID;
	}

	public void setTestID(Integer testID) {
		this.testID = testID;
	}

	public Integer getTestTime() {
		return testTime;
	}

	public void setTestTime(Integer testTime) {
		this.testTime = testTime;
	}

	public Map<Integer,String> getTestMap() {
		return testMap;
	}

	public void setTestMap(Map<Integer,String> testMap) {
		this.testMap = testMap;
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

	public String show() throws Exception{
		loginId = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
		LOG.info("contextSession"+contextSession.get("username"));
		List<GroupBO> groupList = testService.getAllGroupsInfo();
		if(! groupList.isEmpty() && groupList.size() > 0) {
			for(GroupBO g: groupList) {
				GroupBO gp = g;
				testMap.put(gp.getGroup_id(), gp.getGroup_name());
			}
		}
		return "success";
	}
	
	public String createTest() throws Exception{
		if(validateInputs()) {
			boolean isAlreadyExists = false;
			String failedFor = null;
			int result = 0;
			if(groupIDs.isEmpty() || groupIDs.size() < 1 || groupIDs == null) {
				res.setStatus(403);
				res.setMessage("Test cannot be empty. Please at least one group!!");
				return "success";
			}
			List<TestBO> testList = testService.getAllTests();
			if(testList.size() > 0 && !testList.isEmpty()) {
				for(TestBO tb : testList) {
					if(tb.getTest_name().equalsIgnoreCase(testName)) {
						failedFor = "Test";
						isAlreadyExists = true;
						break;
					}else if(tb.getTest_key().equalsIgnoreCase(testkey)) {
						failedFor = "Test Key";
						isAlreadyExists = true;
						break;
					}
				}
			}
			if(! isAlreadyExists) {
				String loginID = null;
				if((String) sessionMap.get(GlobalConstants.LOGIN_ID) == null) {
					loginID = loginId;
				}else {
					loginID = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
				}
				if(passingCriteria == 0) {
					passingCriteria = 40;
				}
				Integer examTime = CommonUtility.returnsTestTimeInSecs(hrs, mins, secs);
				//result = testService.createTest(loginID,testName,testkey,accessKey,groupIDs,testInstructionsHtmlCode,DateUtils.getFormattedDate(expiresOn),testTime);
				result = testService.createTest(loginID,testName,testkey,accessKey,groupIDs,testInstructionsHtmlCode,
						DateUtils.getFormattedDate(startOn),DateUtils.getFormattedDate(endOn), examTime, passingCriteria);
				if(result < 1 ) {
					res.setStatus(403);
					res.setMessage("Unable to create Test!!");
				}else {
					res.setStatus(200);
					res.setMessage("Test created successfully!!");
				}
			}else {
				res.setStatus(403);
				res.setMessage(""+failedFor+" is already existed!!");
			}
		}
		return "success";
	}
	
	public String getAllTests() throws Exception {
		testList = testService.getAllTests();
		return "success";
	}
	
	public String deleteTest(){
		try {
			testService.deleteTest(testID);
			res.setStatus(200);
			res.setMessage("Test deleted successfully!!");
		}catch(Exception e) {
			res.setStatus(403);
			res.setMessage("Error while deleting the test!!");
			e.printStackTrace();
		}
		
		return "success";
	}
	
	public boolean validateInputs() {
		if(! StringUtils.isNotBlank(testName) || testName == null) {
			setErrorMsg("Please enter test name");
			return false;
		}else if(! StringUtils.isNotBlank(testkey) || testkey == null) {
			setErrorMsg("Please enter test key");
			return false;
		}else if((StringUtils.isNotBlank(testkey) && testkey != null) &&  (!StringUtils.isNotBlank(accessKey) || accessKey == null)) {
			setErrorMsg("Please enter access key");
			return false;
		}else if(!StringUtils.isNotBlank(startOn) || startOn == null) {
			setErrorMsg("Please select test start date and time");
			return false;
		}else if(!StringUtils.isNotBlank(endOn) || endOn == null) {
			setErrorMsg("Please select test end date and time");
			return false;
		}else if(passingCriteria > 100) {
			setErrorMsg("Passing criteria must be 0 to 100");
			return false;
		}else if(hrs == 0 && mins == 0) {
			setErrorMsg("Mention either hour or minutes.");
			return false;
		}else if(mins > 60) {
			setErrorMsg("Mintues must be 0 to 60");
			return false;
		}else if(secs > 60) {
			setErrorMsg("Seconds must be 0 to 60");
			return false;
		}
		return true;
	}
	
	public String testDetails() {
		LOG.info("Test ID \t" + testID);
		sessionMap.put("selectedTestID", testID);
		return "success";
	}
	
//	public String addedQuestions() throws Exception {
//		testID = (Integer) sessionMap.get("selectedTestID");
//		return "success";
//	}
}
