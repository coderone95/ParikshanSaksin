package com.codesvila.action;

import org.apache.struts2.dispatcher.SessionMap;

public class LogoutAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5140916616272284399L;
	
	 @SuppressWarnings("rawtypes")
	public String logoutSession() {
		 contextSession.clear();
		((SessionMap) sessionMap).invalidate();
		//session.invalidate();
		return "success";
	 }
}
