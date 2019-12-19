package com.codesvila.dao;

import java.util.List;

import com.codesvila.bean.AttendedTestDetailsBean;
import com.codesvila.bean.GroupBO;
import com.codesvila.bean.TestAuthBean;
import com.codesvila.bean.TestBO;
import com.codesvila.model.AttendedTestDetails;

public interface CandidateDAO {

	List<TestAuthBean> getAllTestKeyAccess() throws Exception;

	List<GroupBO> getGroupsInfoAndNumberOfQuestionCount(Integer testID) throws Exception;

	List<TestBO> getTestNameAndTime(Integer testID) throws Exception;

	int saveAttendedTestDetails(AttendedTestDetails atd);

	List<AttendedTestDetailsBean> getAllAttendedTestDetails() throws Exception;

}
