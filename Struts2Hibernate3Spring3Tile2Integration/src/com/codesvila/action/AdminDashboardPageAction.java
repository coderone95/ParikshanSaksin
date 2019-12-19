package com.codesvila.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.UserBean;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.service.UserService;
import com.codesvila.utils.CommonUtility;

public class AdminDashboardPageAction extends BaseAction{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4902412005546344635L;
	

	@Autowired
	private UserService userService;
	
	private List<UserBean> userList = null;
	
	Map<String,String> countMap = new HashMap<String,String>();
	
	Map<String,String> adminCountMap = new HashMap<String,String>();
	
	Map<String,String> questionsCountMap = new HashMap<String,String>();
	
	
	public Map<String, String> getQuestionsCountMap() {
		return questionsCountMap;
	}

	public void setQuestionsCountMap(Map<String, String> questionsCountMap) {
		this.questionsCountMap = questionsCountMap;
	}

	public Map<String, String> getCountMap() {
		return countMap;
	}

	public void setCountMap(Map<String, String> countMap) {
		this.countMap = countMap;
	}

	
	public List<UserBean> getUserList() {
		return userList;
	}

	public void setUserList(List<UserBean> userList) {
		this.userList = userList;
	}

	public Map<String, String> getAdminCountMap() {
		return adminCountMap;
	}

	public void setAdminCountMap(Map<String, String> adminCountMap) {
		this.adminCountMap = adminCountMap;
	}

	public String execute() {
		return "success";
	}
	
	public String populateCandidateCount() throws Exception {
		countMap  = CommonUtility.getDashboardCandidateCounts("GET_DASHBOARDS_CANDIDATE_COUNT", null, false);
		
		return "success";
	}
	@SuppressWarnings("unchecked")
	public String getCandidateUsers() throws Exception{
		userList = ApacheCommonsDBCP.DBCPDataSource("GET_CANDIDATE_USERS",null,false,null,null);
		return "success";
	}
	
	public String candidateUserListPage() {
		return "success";
	}
	
	public String populateAdminUsersCount() throws Exception{
		adminCountMap = CommonUtility.getDashboardAdminCounts("GET_DASHBOARDS_ADMIN_COUNT", null, false);
		return "success";
	}
	
	public String populateQuestionsCount() throws Exception{
		questionsCountMap = CommonUtility.getDashboardQuestionsCount("GET_DASHBOARDS_QUESTIONS_COUNT", null, false);
		return "success";
	}

}
