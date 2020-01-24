package com.codesvila.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.FunctionalityBO;
import com.codesvila.bean.UserBean;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.service.UserService;
import com.codesvila.utils.GlobalConstants;

public class AdminUserListAction extends BaseAction {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2743988532882286L;
	
	private List<UserBean> userList = null;
	
	private String userId;
	private String loginId;
	private Integer userID;
	private List<FunctionalityBO> accessRightsGivenList;
	private List<FunctionalityBO> accessRightsNOTGivenList;
	private List<FunctionalityBO> accessRightsList;
	private List<String> accessList;
	private String userType;
	private String successMsg;
	private String errorMsg;
	private String accessCode;
	@Autowired
	private UserService userService;
	
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public List<UserBean> getUserList() {
		return userList;
	}

	public void setUserList(List<UserBean> userList) {
		this.userList = userList;
	}


	public String execute() {
		loginId = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
		return "success";
	}
	
	@SuppressWarnings("unchecked")
	public String getUsers() throws Exception{
		userList = ApacheCommonsDBCP.DBCPDataSource("GET_USERS",null,false,null,null);
		return "success";
	}
	
	public String deleteUser() throws Exception{
		userService.deleteUser(userId);
		return "success";
	}
	
	public String disableUser() throws Exception{
		UserBean ub = new UserBean();
		ub.setIs_disabled(1);
		userService.disableEnableUser(userId,ub);
		return "success";
	}
	
	public String enableUser() throws Exception {
		UserBean ub = new UserBean();
		ub.setIs_disabled(0);
		userService.disableEnableUser(userId,ub);
		return "success";
	}

	/**
	 * @return the loginId
	 */
	public String getLoginId() {
		return loginId;
	}

	/**
	 * @param loginId the loginId to set
	 */
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	
	/**
	 * @return the userID
	 */
	public Integer getUserID() {
		return userID;
	}

	/**
	 * @param userID the userID to set
	 */
	public void setUserID(Integer userID) {
		this.userID = userID;
	}

	/**
	 * @return the accessRightsGivenList
	 */
	public List<FunctionalityBO> getAccessRightsGivenList() {
		return accessRightsGivenList;
	}

	/**
	 * @return the accessRightsNOTGivenList
	 */
	public List<FunctionalityBO> getAccessRightsNOTGivenList() {
		return accessRightsNOTGivenList;
	}

	/**
	 * @param accessRightsNOTGivenList the accessRightsNOTGivenList to set
	 */
	public void setAccessRightsNOTGivenList(List<FunctionalityBO> accessRightsNOTGivenList) {
		this.accessRightsNOTGivenList = accessRightsNOTGivenList;
	}

	/**
	 * @param accessRightsGivenList the accessRightsGivenList to set
	 */
	public void setAccessRightsGivenList(List<FunctionalityBO> accessRightsGivenList) {
		this.accessRightsGivenList = accessRightsGivenList;
	}

	/**
	 * @return the accessRightsList
	 */
	public List<FunctionalityBO> getAccessRightsList() {
		return accessRightsList;
	}

	/**
	 * @param accessRightsList the accessRightsList to set
	 */
	public void setAccessRightsList(List<FunctionalityBO> accessRightsList) {
		this.accessRightsList = accessRightsList;
	}

	/**
	 * @return the accessList
	 */
	public List<String> getAccessList() {
		return accessList;
	}

	/**
	 * @param accessList the accessList to set
	 */
	public void setAccessList(List<String> accessList) {
		this.accessList = accessList;
	}

	/**
	 * @return the userType
	 */
	public String getUserType() {
		return userType;
	}

	/**
	 * @param userType the userType to set
	 */
	public void setUserType(String userType) {
		this.userType = userType;
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
	 * @return the accessCode
	 */
	public String getAccessCode() {
		return accessCode;
	}

	/**
	 * @param accessCode the accessCode to set
	 */
	public void setAccessCode(String accessCode) {
		this.accessCode = accessCode;
	}

	public String manageUsersAccess() {
		return "success";
	}
	
	public String getUsersAccessGiven() throws Exception{
		accessRightsList = userService.getUsersAccessGiven(userID);
		return "success";
	}
	
	public String getUsersAccessNOTGiven() throws Exception{
		accessRightsList = userService.getUsersAccessNOTGiven(userID);
		return "success";
	}
	
	public String givenSelectedAccessToUser() throws Exception {
		boolean isAccessGrantedSuccessFully = userService.givenSelectedAccessToUser(userID,userType.concat("_USER"),accessList);
		if(isAccessGrantedSuccessFully) {
			successMsg = "Access Granted";
		}else {
			errorMsg = "Error while giving required access";
		}
		return "success";
	}

	public String removeAccess()  throws Exception{
		boolean isRemovedAccessSuccessfully = userService.removeAccess(userID,userType.concat("_USER"),accessCode);
		if(isRemovedAccessSuccessfully) {
			successMsg = "Access Removed";
		}else {
			errorMsg = "Error while removing the access";
		}
		return "success";
	}
}
