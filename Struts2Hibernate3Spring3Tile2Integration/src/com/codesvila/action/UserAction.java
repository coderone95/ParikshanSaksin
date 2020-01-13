package com.codesvila.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.ErrorMessages;
import com.codesvila.bean.Response;
import com.codesvila.bean.SuccessMessages;
import com.codesvila.bean.UserBean;
import com.codesvila.service.UserService;
import com.codesvila.utils.CommonUtility;
import com.codesvila.utils.CryptUtils;
import com.codesvila.utils.GlobalConstants;

public class UserAction extends BaseAction  {

	private static final long serialVersionUID = 1L;

	
	private UserBean userBean;
	@Autowired
	private UserService userService;
	private List<UserBean> users;
	
	private String myData;
	
	private String userID;
	private String emailId;
	
	private Map<String,Object> map = new HashMap<String,Object>();

	public List<ErrorMessages> errorMessagesList = new ArrayList<ErrorMessages>();
	
	public List<SuccessMessages> successMessageList = new ArrayList<SuccessMessages>();
	
	private String errorMsg = null;
	private String successMsg = null;
	
	
	public List<ErrorMessages> getErrorMessagesList() {
		return errorMessagesList;
	}

	public void setErrorMessagesList(List<ErrorMessages> errorMessagesList) {
		this.errorMessagesList = errorMessagesList;
	}

	public List<SuccessMessages> getSuccessMessageList() {
		return successMessageList;
	}

	public void setSuccessMessageList(List<SuccessMessages> successMessageList) {
		this.successMessageList = successMessageList;
	}
	

	public UserBean getUserBean() {
		return userBean;
	}

	public void setUserBean(UserBean userBean) {
		this.userBean = userBean;
	}

	
	public String getMyData() {
		return myData;
	}

	public void setMyData(String myData) {
		this.myData = myData;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
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

	/**
	 * @return the successMsg
	 */
	public String getSuccessMsg() {
		return successMsg;
	}

	/**
	 * @param successMsg the successMsg to set
	 */
	public void setSuccessMsg(String successMsg) {
		this.successMsg = successMsg;
	}

	public String execute() throws Exception{
		LOG.info("UserAction ----------- execute()-------------- - start");
		myData = "Test Data";
		if(validateInputs()) {
			users = CommonUtility.createUserBeanList(userService.getUserList());
			Response rs = new Response();
			for (UserBean u : users) {
				if (u.getEmail_id().equalsIgnoreCase(userBean.getEmail_id()) || u.getEmail_id() == userBean.getEmail_id()) {
					rs.setStatus(400);
					break;
				}
			}
			if(rs.getStatus() == 400) {
				ErrorMessages er = new ErrorMessages();
				er.setErrorMsg("User already exists!!");
				er.setErrorFor("User Registration Failed");
				errorMessagesList.add(er);
				setErrorMsg("User already exists!!");
			}else {
				LOG.info("UserAction --- execute()-------------- - encrypting the pwd --- ");
				String encryptedPwd = CryptUtils.encrypt(userBean.getPassword(), GlobalConstants.cipher_Key);
				LOG.info("UserAction --- execute()-------------- - encrypting the pwd is DONE--- ");
				userBean.setPassword(encryptedPwd);
				int generatedID = userService.saveUser(CommonUtility.createUserModel(userBean));
				if(generatedID > 0) {
					userService.sendEmail("USER_REGISTRATION", userBean.getEmail_id(),CryptUtils.decrypt(userBean.getPassword(), GlobalConstants.cipher_Key));
					SuccessMessages sm = new SuccessMessages();
					sm.setSuccessMsg("User registered successfully!!!");
					LOG.info("UserAction --- execute()-------------- - user registration successfully!, user id is "+ generatedID);
					sm.setSuccessFor("User Registration");
					successMessageList.add(sm);
					setSuccessMsg("User added successfully!!");
				}else {
					ErrorMessages er = new ErrorMessages();
					er.setErrorMsg("Error occured while user registering!!!");
					er.setErrorFor("User Registration Failed");
					errorMessagesList.add(er);
					setErrorMsg("User Registration Failed!!");
				}
				
			}
		}
		LOG.info("UserAction ----------- execute()-------------- - end");
		return "success";
	}

	public String updateProfile() throws Exception{
		LOG.info("UserAction ----------- updateProfile()-------------- - start");
		LOG.info("Password"+userBean.getPassword());
		if(userBean.getPassword() != null && StringUtils.isNotBlank(userBean.getPassword())) {
			String encryptedPwd = CryptUtils.encrypt(userBean.getPassword(), GlobalConstants.cipher_Key);
			userBean.setPassword(encryptedPwd);
		}
		
		userService.updateUser(userBean);
		SuccessMessages sm = new SuccessMessages();
		sm.setSuccessMsg("User updated successfully!!!");
		sm.setSuccessFor("User Updattion");
		successMessageList.add(sm);
		LOG.info("UserAction ----------- updateProfile()-------------- - end");
		return "success";
	}
	

	public List<UserBean> getUsers() {
		return users;
	}

	public void setUsers(List<UserBean> users) {
		this.users = users;
	}
	
	@SuppressWarnings("unchecked")
	public String getUserInfo() throws Exception{
		LOG.info("UserAction ----------- getUserInfo()-------------- - start");
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("email", emailId);
		paramMap.put("userId", null);
		List<UserBean> userList = CommonUtility.getUserProfileData("GET_USER_PROFILE_DATA", null,true,paramMap);
				
		if(userList != null) {
			for(UserBean u : userList) {
				map.put("userId", u.getUser_id());
				map.put("email", u.getEmail_id());
				map.put("name", u.getName());
				map.put("phone", u.getPhone_number());
				break;// limits to 1 user
			}
		}
		LOG.info("UserAction ----------- getUserInfo()-------------- - end");
		return "success";
	}
	
	public boolean validateInputs() {
		LOG.info("UserAction ----------- validateInputs()-------------- - start");
		if(! StringUtils.isNotBlank(userBean.getEmail_id()) || userBean.getEmail_id() == null) {
			setErrorMsg("Please enter email address");
			return false;
		}else if(! StringUtils.isNotBlank(userBean.getName()) || userBean.getName() == null) {
			setErrorMsg("Please enter name");
			return false;
		}else if(! StringUtils.isNotBlank(userBean.getPhone_number()) || userBean.getPhone_number() == null) {
			setErrorMsg("Please enter phone number");
			return false;
		}else if(! StringUtils.isNotBlank(userBean.getPassword()) || userBean.getPassword() == null) {
			setErrorMsg("Please enter password");
			return false;
		}else if(! StringUtils.isNotBlank(userBean.getCpassword()) || userBean.getCpassword() == null) {
			setErrorMsg("Please confirm password");
			return false;
		}else if(StringUtils.isNotBlank(userBean.getPassword()) && StringUtils.isNotBlank(userBean.getCpassword())) {
			if(! userBean.getPassword().equals(userBean.getCpassword())) {
				setErrorMsg("Password not matched!");
				return false;
			}
		}
		LOG.info("UserAction ----------- validateInputs()-------------- - end");
		return true;
	}


}