package com.codesvila.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.AttendedTestDetailsBean;
import com.codesvila.bean.TestAuthBean;
import com.codesvila.bean.UserBean;
import com.codesvila.service.CandidateService;
import com.codesvila.service.UserService;
import com.codesvila.utils.CommonUtility;
import com.codesvila.utils.CryptUtils;
import com.codesvila.utils.GlobalConstants;

public class TestAutheniticationAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = 916494429698816893L;
	
	private TestAuthBean testAuthBean;
	@Autowired
	private CandidateService candidateService;
	private Map<String,Object> map;
	private List<UserBean> userList;
	@Autowired
	private UserService userService;
	private UserBean userBean;
	private Integer testID;
	private String loginId;
	private String message;
	private String error;
	private String name;
	private String hasExamStarted;
	
	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

	public TestAuthBean getTestAuthBean() {
		return testAuthBean;
	}

	public void setTestAuthBean(TestAuthBean testAuthBean) {
		this.testAuthBean = testAuthBean;
	}

	public List<UserBean> getUserList() {
		return userList;
	}

	public UserBean getUserBean() {
		return userBean;
	}

	public void setUserBean(UserBean userBean) {
		this.userBean = userBean;
	}

	public void setUserList(List<UserBean> userList) {
		this.userList = userList;
	}

	
	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public Integer getTestID() {
		return testID;
	}

	public void setTestID(Integer testID) {
		this.testID = testID;
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

	public String display() {
		return "success";
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
	public String execute() throws Exception{
		hasExamStarted = "NO";
		error = null;
		loginId = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
		name = (String) sessionMap.get("name");
		System.out.println("TestKey:"+testAuthBean.getTestKey());
		List<TestAuthBean> authBean = candidateService.getAllTestKeyAccess();
		List<AttendedTestDetailsBean> dataList = candidateService.getAllAttendedTestDetails();
		if(dataList.size() > 0 && ! dataList.isEmpty()) {
			for(AttendedTestDetailsBean atb: dataList) {
				if(atb.getTest_key().equals(testAuthBean.getTestKey())  && loginId.equals(atb.getUser_id())) {
					if(atb.getAttempted() >= atb.getMax_attempt()) {
						error = "Test already given.";
						return "failure";
					}
				}
			}
		}
		for(TestAuthBean b : authBean) {
			if(b.getTestKey().equals(testAuthBean.getTestKey()) && b.getAccessKey().equals(testAuthBean.getAccessKey())) {
				testID = b.getTestID();
				sessionMap.put("currentTestID", testID);
				return "success";
			}
		}
		return "failure";
	}
	
	@SuppressWarnings("unchecked")
	public String getCandidateProfile() throws Exception{
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("email", (String) sessionMap.get(GlobalConstants.LOGIN_ID));
		paramMap.put("userId", null);
		userList = CommonUtility.getUserProfileData("GET_USER_PROFILE_DATA", null,true,paramMap);

		return "success";
	}
	
	public String updateProfile() throws Exception{
		System.out.println("Password"+userBean.getPassword());
		if(userBean.getPassword() != null && StringUtils.isNotBlank(userBean.getPassword())) {
			String encryptedPwd = CryptUtils.encrypt(userBean.getPassword(), GlobalConstants.cipher_Key);
			userBean.setPassword(encryptedPwd);
		}
		userService.updateUser(userBean);
		return "success";
	}
	
	public String getTestInstructions() throws Exception{
		List<TestAuthBean> authBean = candidateService.getAllTestKeyAccess();
		for(TestAuthBean b : authBean) {
			if(testID == b.getTestID()) {
				testAuthBean.setTest_instructions(b.getTest_instructions());
				return "success";
			}
		}
		return "success";
	}
	
	
	
}
