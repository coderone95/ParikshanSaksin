package com.codesvila.dao;

import java.util.Date;
import java.util.List;

import com.codesvila.bean.AttendedTestDetailsBean;
import com.codesvila.bean.GroupBO;
import com.codesvila.bean.QuestionBO;
import com.codesvila.bean.TestAuthBean;
import com.codesvila.bean.TestBO;
import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.model.AttendedTestDetails;

public interface CandidateDAO {

	List<TestAuthBean> getAllTestKeyAccess() throws Exception;

	List<GroupBO> getGroupsInfoAndNumberOfQuestionCount(Integer testID) throws Exception;

	List<TestBO> getTestNameAndTime(Integer testID) throws Exception;

	int saveAttendedTestDetails(AttendedTestDetails atd, Date startTime, Date endTime);

	List<AttendedTestDetailsBean> getAllAttendedTestDetails() throws Exception;

	QuestionBO getQuestion(String quesID);

	List<QuestionInfoBO> getOptions(String quesID);

}
