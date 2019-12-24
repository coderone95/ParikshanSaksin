package com.codesvila.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
}
