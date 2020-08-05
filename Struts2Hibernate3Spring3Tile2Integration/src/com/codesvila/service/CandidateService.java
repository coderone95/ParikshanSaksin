package com.codesvila.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.codesvila.bean.AttendedTestDetailsBean;
import com.codesvila.bean.GroupBO;
import com.codesvila.bean.TestAuthBean;
import com.codesvila.bean.TestBO;

public interface CandidateService {

	List<TestAuthBean> getAllTestKeyAccess() throws Exception;

	List<GroupBO> getGroupsInfoAndNumberOfQuestionCount(Integer testID) throws Exception;

	List<TestBO> getTestNameAndTime(Integer testID) throws Exception;

	int saveAttendedTestDetails(String loginId, Integer testID, Date formattedDate, Date formattedDate2);

	List<AttendedTestDetailsBean> getAllAttendedTestDetails() throws Exception;

	List<Integer> getQuestionIds(Integer groupId, Integer testId);

	Map<String, Object> retrieveQustionWithOptions(String quesID);

	int submitAnswer(int testId, int groupId, int queId, String answerIDS, String testContextId);

	Map<String, String> populateSubmittedAnswer(String testID, String groupID, String quesID, String contextID);

}
