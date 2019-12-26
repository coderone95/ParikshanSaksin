package com.codesvila.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.codesvila.bean.GroupBO;
import com.codesvila.bean.TestBO;
import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.datasource.ApacheCommonsDBCP;

@Repository("reportDao")
public class ReportDAOImpl implements ReportDAO{
	
	@Autowired  
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	@Override
	public List<QuestionInfoBO> getQuestionReport(String startDate, String endDate, String createdBy,
			String questionName, Integer questionId) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("startDate", startDate);
		paramMap.put("endDate", endDate);
		paramMap.put("createdBy", createdBy);
		paramMap.put("questionName", questionName);
		if(questionId == 0) {
			paramMap.put("questionId", null);
		}else {
			paramMap.put("questionId", questionId);
		}
		return ApacheCommonsDBCP.DBCPDataSource("GET_QUESTIONS_REPORT", null, true, paramMap,null);
	}

	@Override
	public List<GroupBO> getGroupReport(String startDate, String endDate, String createdBy, String groupName,
			Integer groupId) throws Exception {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("startDate", startDate);
		paramMap.put("endDate", endDate);
		paramMap.put("createdBy", createdBy);
		paramMap.put("groupName", groupName);
		if(groupId == 0) {
			paramMap.put("groupId", null);
		}else {
			paramMap.put("groupId", groupId);
		}
		return ApacheCommonsDBCP.DBCPDataSource("GET_GROUPS_REPORT", null, true, paramMap,null);
	}  
	
	@Override
	public List<TestBO> getTestReport(String startDate, String endDate, String createdBy, String testName, Integer testId,String testKey) throws Exception {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("startDate", startDate);
		paramMap.put("endDate", endDate);
		paramMap.put("createdBy", createdBy);
		paramMap.put("testName", testName);
		if(testId == 0) {
			paramMap.put("testId", null);
		}else {
			paramMap.put("testId", testId);
		}
		paramMap.put("testKey", testKey);
		return ApacheCommonsDBCP.DBCPDataSource("GET_TESTS_REPORT", null, true, paramMap,null);
	}  
	
}
