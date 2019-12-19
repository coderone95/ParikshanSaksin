package com.codesvila.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.UserBean;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.service.UserService;
import com.opensymphony.xwork2.ActionSupport;

public class AdminUserListAction extends ActionSupport {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2743988532882286L;
	
	private List<UserBean> userList = null;
	
	private String userId;
	
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


}
