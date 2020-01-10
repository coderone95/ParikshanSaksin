package com.codesvila.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.codesvila.bean.UserBean;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.utils.CommonUtility;
import com.codesvila.utils.GlobalConstants;

public class AdminUserProfilePageAction extends BaseAction {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private String email_id;
	
	private String login_id;
	
	private Map<String,Object> map = new HashMap<String,Object>();
	
	public String getEmail_id() {
		return email_id;
	}

	public void setEmail_id(String email_id) {
		this.email_id = email_id;
	}


	public String getLogin_id() {
		return login_id;
	}

	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}


	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

	public String execute() {
		if(sessionMap != null) {
			email_id = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
			login_id = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
		}
		return "success";
	}
	
	@SuppressWarnings("unchecked")
	public String getUserProfile() throws Exception{
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("email", (String) sessionMap.get(GlobalConstants.LOGIN_ID));
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
		
		return "success";
	}
	
	
}
