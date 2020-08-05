package com.codesvila.dao;

import java.util.List;

import com.codesvila.bean.GroupBO;
import com.codesvila.bean.TestBO;
import com.codesvila.bean.UserBean;
import com.codesvila.bo.QuestionInfoBO;

public interface ReportDAO {

	List<QuestionInfoBO> getQuestionReport(String startDate, String endDate, String createdBy, String questionName,
			Integer questionId, Integer groupId) throws Exception;

	List<GroupBO> getGroupReport(String startDate, String endDate, String createdBy, String groupName, Integer groupId)throws Exception;

	List<TestBO> getTestReport(String startDate, String endDate, String createdBy, String testName, Integer testId, String testKey) throws Exception;

	List<UserBean> getUserReport(String startDate, String endDate, String userName, String phoneNumber, String emailId,
			String userType, Integer userId, String loggedInUserId, List<String> notAllowedToSearchList) throws Exception;
	
}
