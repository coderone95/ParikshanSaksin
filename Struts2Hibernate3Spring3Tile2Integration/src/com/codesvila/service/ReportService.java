package com.codesvila.service;

import java.util.List;

import com.codesvila.bean.GroupBO;
import com.codesvila.bean.TestBO;
import com.codesvila.bo.QuestionInfoBO;

public interface ReportService {

	List<QuestionInfoBO> getQuestionReport(String startDate, String endDate, String createdBy, String questionName,
			Integer questionId) throws Exception;

	List<GroupBO> getGroupReport(String startDate, String endDate, String createdBy, String groupName, Integer groupId) throws Exception;

	List<TestBO> getTestReport(String startDate, String endDate, String createdBy, String testName, Integer testId, String testKey)throws Exception;

}
