package com.codesvila.service;

import java.util.List;

import com.codesvila.bo.QuestionInfoBO;

public interface ReportService {

	List<QuestionInfoBO> getQuestionReport(String startDate, String endDate, String createdBy, String questionName,
			Integer questionId) throws Exception;

}
