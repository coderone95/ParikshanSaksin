package com.codesvila.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.UserBean;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.service.UserService;
import com.codesvila.utils.GlobalConstants;
import com.opensymphony.xwork2.ActionSupport;

public class AdminUserListAction extends BaseAction {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2743988532882286L;
	
	private List<UserBean> userList = null;
	
	private String userId;
	private String loginId;
	
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


}
