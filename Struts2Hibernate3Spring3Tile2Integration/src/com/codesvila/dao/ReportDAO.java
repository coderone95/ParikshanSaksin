package com.codesvila.dao;

import java.util.List;

import com.codesvila.bo.QuestionInfoBO;

public interface ReportDAO {

	List<QuestionInfoBO> getQuestionReport(String startDate, String endDate, String createdBy, String questionName,
			Integer questionId) throws Exception;
	
}
