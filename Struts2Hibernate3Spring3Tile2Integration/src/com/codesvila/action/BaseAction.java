package com.codesvila.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.json.JSONUtil;
import org.apache.struts2.util.ServletContextAware;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.FunctionalityBO;
import com.codesvila.bean.UserBean;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.utils.CommonUtility;
import com.codesvila.utils.GlobalConstants;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport implements SessionAware, ServletRequestAware, ServletResponseAware, ServletContextAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected Map<String,Object> sessionMap ;
	
	 protected HttpServletRequest request;
	  protected HttpServletResponse response;
	  protected HttpSession session;
	  protected Map<String,Object> contextSession = ActionContext.getContext().getSession();
	  
	 protected String loggedInEmailID = null;
	 protected Map<String,Boolean> accessMap = new HashMap<String,Boolean>();


	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

//	public void setResponse(HttpServletResponse response) {
//		this.response = response;
//	}

	public HttpSession getSession() {
		return session;
	}

	public void setSession(HttpSession session) {
		this.session = session;
	}

	@Override
	public void setSession(Map<String, Object> sessionMap) {
		// TODO Auto-generated method stub
		this.sessionMap = sessionMap;
	}
	
	@Override
	public void setServletContext(ServletContext arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setServletResponse(HttpServletResponse response) {
		// TODO Auto-generated method stub
		this.response = response;
	}

	@Override
	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		
	}

	 public Map<String, Object> getContextSession() {
		return contextSession;
	}

	public void setContextSession(Map<String, Object> contextSession) {
		this.contextSession = contextSession;
	}
	/**
	 * @return the accessMap
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Boolean> getAccessMap() throws Exception{
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("email", (String) sessionMap.get(GlobalConstants.LOGIN_ID));
		paramMap.put("userId", null);
		List<UserBean> userList = CommonUtility.getUserProfileData("GET_USER_PROFILE_DATA", null,true,paramMap);
		String userType = userList.get(0).getUser_type();
		Integer userId  = (Integer) userList.get(0).getUser_id();
		Map<String,Object> paramMap1 = new HashMap<String,Object>();
		paramMap1.put("userId", userId);
		paramMap1.put("userType", userType.concat("_USER"));
		List<FunctionalityBO> accessRightsList = ApacheCommonsDBCP.DBCPDataSource("GET_ALL_ACCESS_RIGHTS_INFO", null, true, paramMap1, null);
		Boolean hasAccessForM_DASHBOARD_PAGE = isAccessRightGiven(accessRightsList,GlobalConstants.M_DASHBOARD_PAGE);
		accessMap.put(GlobalConstants.M_DASHBOARD_PAGE, hasAccessForM_DASHBOARD_PAGE);
		boolean hasAccessForADD_ADMIN_USER = isAccessRightGiven(accessRightsList,GlobalConstants.ADD_ADMIN_USER);
		accessMap.put(GlobalConstants.ADD_ADMIN_USER, hasAccessForADD_ADMIN_USER);
		boolean hasAccessForADD_EXAMINER_USER = isAccessRightGiven(accessRightsList,GlobalConstants.ADD_EXAMINER_USER);
		accessMap.put(GlobalConstants.ADD_EXAMINER_USER, hasAccessForADD_EXAMINER_USER);
		boolean hasAccessForADD_REVIEWER_USER = isAccessRightGiven(accessRightsList,GlobalConstants.ADD_REVIEWER_USER);
		accessMap.put(GlobalConstants.ADD_REVIEWER_USER, hasAccessForADD_REVIEWER_USER);
		boolean hasAccessForADD_CANDIDATE_USER = isAccessRightGiven(accessRightsList,GlobalConstants.ADD_CANDIDATE_USER);
		accessMap.put(GlobalConstants.ADD_CANDIDATE_USER, hasAccessForADD_CANDIDATE_USER);
		boolean hasAccessForM_USERS_PAGE = isAccessRightGiven(accessRightsList,GlobalConstants.M_USERS_PAGE);
		accessMap.put(GlobalConstants.M_USERS_PAGE, hasAccessForM_USERS_PAGE);
		boolean hasAccessForM_SHOW_ADMIN_USERS = isAccessRightGiven(accessRightsList,GlobalConstants.M_SHOW_ADMIN_USERS);
		accessMap.put(GlobalConstants.M_SHOW_ADMIN_USERS, hasAccessForM_SHOW_ADMIN_USERS);
		boolean hasAccessForM_SHOW_EXAMINER_USERS = isAccessRightGiven(accessRightsList,GlobalConstants.M_SHOW_EXAMINER_USERS);
		accessMap.put(GlobalConstants.M_SHOW_EXAMINER_USERS, hasAccessForM_SHOW_EXAMINER_USERS);
		boolean hasAccessForM_SHOW_REVIEWER_USERS = isAccessRightGiven(accessRightsList,GlobalConstants.M_SHOW_REVIEWER_USERS);
		accessMap.put(GlobalConstants.M_SHOW_REVIEWER_USERS, hasAccessForM_SHOW_REVIEWER_USERS);
		boolean hasAccessForM_ADD_USER = isAccessRightGiven(accessRightsList,GlobalConstants.M_ADD_USER);
		accessMap.put(GlobalConstants.M_ADD_USER, hasAccessForM_ADD_USER);
		boolean hasAccessForM_DISABLE_USER = isAccessRightGiven(accessRightsList,GlobalConstants.M_DISABLE_USER);
		accessMap.put(GlobalConstants.M_DISABLE_USER, hasAccessForM_DISABLE_USER);
		boolean hasAccessForM_ENABLE_USER = isAccessRightGiven(accessRightsList,GlobalConstants.M_ENABLE_USER);
		accessMap.put(GlobalConstants.M_ENABLE_USER, hasAccessForM_ENABLE_USER);
		boolean hasAccessForM_EDIT_USER = isAccessRightGiven(accessRightsList,GlobalConstants.M_EDIT_USER);
		accessMap.put(GlobalConstants.M_EDIT_USER, hasAccessForM_EDIT_USER);
		boolean hasAccessM_DELETE_USER = isAccessRightGiven(accessRightsList,GlobalConstants.M_DELETE_USER);
		accessMap.put(GlobalConstants.M_DELETE_USER, hasAccessM_DELETE_USER);
		boolean hasAccessForM_GROUP_PAGE = isAccessRightGiven(accessRightsList,GlobalConstants.M_GROUP_PAGE);
		accessMap.put(GlobalConstants.M_GROUP_PAGE, hasAccessForM_GROUP_PAGE);
		boolean hasAccessForM_SHOW_GROUPS = isAccessRightGiven(accessRightsList,GlobalConstants.M_SHOW_GROUPS);
		accessMap.put(GlobalConstants.M_SHOW_GROUPS, hasAccessForM_SHOW_GROUPS);
		boolean hasAccessForM_ADD_GROUP = isAccessRightGiven(accessRightsList,GlobalConstants.M_ADD_GROUP);
		accessMap.put(GlobalConstants.M_ADD_GROUP, hasAccessForM_ADD_GROUP);
		boolean hasAccessForM_EDIT_GROUP = isAccessRightGiven(accessRightsList,GlobalConstants.M_EDIT_GROUP);
		accessMap.put(GlobalConstants.M_EDIT_GROUP, hasAccessForM_EDIT_GROUP);
		boolean hasAccessForM_DELETE_GROUP = isAccessRightGiven(accessRightsList,GlobalConstants.M_DELETE_GROUP);
		accessMap.put(GlobalConstants.M_DELETE_GROUP, hasAccessForM_DELETE_GROUP);
		boolean hasAccessForM_TEST_PAGE = isAccessRightGiven(accessRightsList,GlobalConstants.M_TEST_PAGE);
		accessMap.put(GlobalConstants.M_TEST_PAGE, hasAccessForM_TEST_PAGE);
		boolean hasAccessForM_ADD_TEST = isAccessRightGiven(accessRightsList,GlobalConstants.M_ADD_TEST);
		accessMap.put(GlobalConstants.M_ADD_TEST, hasAccessForM_ADD_TEST);
		boolean hasAccessForM_EDIT_TEST = isAccessRightGiven(accessRightsList,GlobalConstants.M_EDIT_TEST);
		accessMap.put(GlobalConstants.M_EDIT_TEST, hasAccessForM_EDIT_TEST);
		boolean hasAccessForM_DELETE_TEST = isAccessRightGiven(accessRightsList,GlobalConstants.M_DELETE_TEST);
		accessMap.put(GlobalConstants.M_DELETE_TEST, hasAccessForM_DELETE_TEST);
		boolean hasAccessForM_QUESTIONS_PAGE = isAccessRightGiven(accessRightsList,GlobalConstants.M_QUESTIONS_PAGE);
		accessMap.put(GlobalConstants.M_QUESTIONS_PAGE, hasAccessForM_QUESTIONS_PAGE);
		boolean hasAccessForM_SHOW_QUESTIONS = isAccessRightGiven(accessRightsList,GlobalConstants.M_SHOW_QUESTIONS);
		accessMap.put(GlobalConstants.M_SHOW_QUESTIONS, hasAccessForM_SHOW_QUESTIONS);
		boolean hasAccessForM_ADD_QUESTION = isAccessRightGiven(accessRightsList,GlobalConstants.M_ADD_QUESTION);
		accessMap.put(GlobalConstants.M_ADD_QUESTION, hasAccessForM_ADD_QUESTION);
		boolean hasAccessForM_EDIT_QUESTION = isAccessRightGiven(accessRightsList,GlobalConstants.M_EDIT_QUESTION);
		accessMap.put(GlobalConstants.M_EDIT_QUESTION, hasAccessForM_EDIT_QUESTION);
		boolean hasAccessForM_DELETE_QUESTION = isAccessRightGiven(accessRightsList,GlobalConstants.M_DELETE_QUESTION);
		accessMap.put(GlobalConstants.M_DELETE_QUESTION, hasAccessForM_DELETE_QUESTION);
		boolean hasAccessForM_ADD_QUESTIONS_TO_GROUP = isAccessRightGiven(accessRightsList,GlobalConstants.M_ADD_QUESTIONS_TO_GROUP);
		accessMap.put(GlobalConstants.M_ADD_QUESTIONS_TO_GROUP, hasAccessForM_ADD_QUESTIONS_TO_GROUP);
		boolean hasAccessForM_SHOW_ADDED_QUESTIONS_TO_GROUP = isAccessRightGiven(accessRightsList,GlobalConstants.M_SHOW_ADDED_QUESTIONS_TO_GROUP);
		accessMap.put(GlobalConstants.M_SHOW_ADDED_QUESTIONS_TO_GROUP, hasAccessForM_SHOW_ADDED_QUESTIONS_TO_GROUP);
		boolean hasAccessForM_DELETE_QUESTIONS_FROM_GROUP = isAccessRightGiven(accessRightsList,GlobalConstants.M_DELETE_QUESTIONS_FROM_GROUP);
		accessMap.put(GlobalConstants.M_DELETE_QUESTIONS_FROM_GROUP, hasAccessForM_DELETE_QUESTIONS_FROM_GROUP);

		return accessMap;
	}

	/**
	 * @param accessMap the accessMap to set
	 */
	public void setAccessMap(Map<String, Boolean> accessMap) {
		this.accessMap = accessMap;
	}
	/**
	 * @return the loggedInEmailID
	 */
	public String getLoggedInEmailID() {
		loggedInEmailID = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
		return loggedInEmailID;
	}

	/**
	 * @param loggedInEmailID the loggedInEmailID to set
	 */
	public void setLoggedInEmailID(String loggedInEmailID) {
		this.loggedInEmailID = loggedInEmailID;
	}

	protected String writeJsonResponse(Object result) {
	      // HttpServletResponse response = (HttpServletResponse)
	      // ActionContext.getContext().get(StrutsStatics.HTTP_RESPONSE);
	      response.setHeader("Cache-Control", "no-cache");
	      response.setHeader("Pragma", "no-cache");
	      response.setDateHeader("Expires", 0);
	      this.response.setContentType("application/json");
	      this.response.setCharacterEncoding("UTF-8");
	      try {
	        String responseStr = "";
	        if (result instanceof JSONObject) {
	          responseStr = String.valueOf(result);
	        } else {
	          responseStr = JSONUtil.serialize(result);
	        }
	        this.response.getOutputStream().write(responseStr.getBytes("UTF-8"));
	        
	      } catch (Exception e) {
	        if (LOG.isDebugEnabled()) {
	          LOG.error("BaseAction.writeResponse - Error - ", e);
	        } else {
	          LOG.error("BaseAction.writeResponse - Error - " + e);
	        }
	        return ERROR;
	      }
	      return null;
	    }
	
	public Boolean isAccessRightGiven(List<FunctionalityBO> accessRightsList, String access) {
		if(accessRightsList.size() > 0 && !accessRightsList.isEmpty()) {
			for(FunctionalityBO bo : accessRightsList) {
				if(bo.getFunctionality_code().equals(access)) {
					return true;
				}
			}
		}
		return false;
	}
}

