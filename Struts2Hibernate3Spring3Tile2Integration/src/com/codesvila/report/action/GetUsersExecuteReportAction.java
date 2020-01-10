package com.codesvila.report.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.action.BaseAction;
import com.codesvila.bean.UserBean;
import com.codesvila.service.ReportService;
import com.codesvila.utils.GlobalConstants;

public class GetUsersExecuteReportAction extends BaseAction{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Autowired
	private ReportService reportService;
	
	private String startDate;
	private String endDate;
	private Integer userId;
	private String userName;
	private String phoneNumber;
	private String emailId;
	private String userType;
	private String loggedInUserId;
	private List<UserBean> userList = null;
	/**
	 * @return the userId
	 */
	public Integer getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	/**
	 * @return the userName
	 */
	public String getUserName() {
		return userName;
	}
	/**
	 * @param userName the userName to set
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}
	/**
	 * @return the phoneNumber
	 */
	public String getPhoneNumber() {
		return phoneNumber;
	}
	/**
	 * @param phoneNumber the phoneNumber to set
	 */
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	/**
	 * @return the emailId
	 */
	public String getEmailId() {
		return emailId;
	}
	/**
	 * @param emailId the emailId to set
	 */
	public void setEmailId(String emailId) {
		this.emailId = emailId;
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
	 * @return the userList
	 */
	public List<UserBean> getUserList() {
		return userList;
	}
	/**
	 * @param userList the userList to set
	 */
	public void setUserList(List<UserBean> userList) {
		this.userList = userList;
	}
	
	/**
	 * @return the loggedInUserId
	 */
	public String getLoggedInUserId() {
		loggedInUserId = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
		return loggedInUserId;
	}
	/**
	 * @param loggedInUserId the loggedInUserId to set
	 */
	public void setLoggedInUserId(String loggedInUserId) {
		this.loggedInUserId = loggedInUserId;
	}
	public String getUserReport() throws Exception{
		List<String> NotAllowedToSearchList = new ArrayList<String>();
		Map<String, Boolean> previlegeAccessMap = getAccessMap();
		boolean hasAccessToShowAdminUsers = previlegeAccessMap.get(GlobalConstants.M_SHOW_ADMIN_USERS);
		if(!hasAccessToShowAdminUsers)
			NotAllowedToSearchList.add(GlobalConstants.ADMIN_USER_TYPE);
		
		boolean hasAccessToShowExaminerUsers = previlegeAccessMap.get(GlobalConstants.M_SHOW_EXAMINER_USERS);
		if(!hasAccessToShowExaminerUsers)
			NotAllowedToSearchList.add(GlobalConstants.EXAMINER_USER_TYPE);
		
		boolean hasAccessToShowReviewerUsers = previlegeAccessMap.get(GlobalConstants.M_SHOW_REVIEWER_USERS);
		if(!hasAccessToShowReviewerUsers) 
			NotAllowedToSearchList.add(GlobalConstants.REVIEWER_USER_TYPE);
		
		userList= reportService.getUserReport(startDate,
				endDate,userName,phoneNumber,emailId,userType,userId,loggedInUserId,NotAllowedToSearchList);
		return "success";
	}

}
