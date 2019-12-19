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

}
