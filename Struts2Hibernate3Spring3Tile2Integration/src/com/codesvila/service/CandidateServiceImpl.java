package com.codesvila.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.codesvila.bean.AttendedTestDetailsBean;
import com.codesvila.bean.GroupBO;
import com.codesvila.bean.TestAuthBean;
import com.codesvila.bean.TestBO;
import com.codesvila.dao.CandidateDAO;
import com.codesvila.model.AttendedTestDetails;
import com.codesvila.utils.GlobalConstants;

@Service("candidateService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true) 
public class CandidateServiceImpl implements CandidateService{
	
	@Autowired
	private CandidateDAO candidateDao;

	@Override
	public List<TestAuthBean> getAllTestKeyAccess() throws Exception{
		// TODO Auto-generated method stub
		return candidateDao.getAllTestKeyAccess();
	}

	@Override
	public List<GroupBO> getGroupsInfoAndNumberOfQuestionCount(Integer testID) throws Exception{
		// TODO Auto-generated method stub
		return candidateDao.getGroupsInfoAndNumberOfQuestionCount(testID);
	}

	@Override
	public List<TestBO> getTestNameAndTime(Integer testID) throws Exception{
		// TODO Auto-generated method stub
		return candidateDao.getTestNameAndTime(testID);
	}

	@Override
	public int saveAttendedTestDetails(String loginId, Integer testID, Date startTime, Date endTime) {
		// TODO Auto-generated method stub
		AttendedTestDetails atd = new AttendedTestDetails();
		atd.setTest_id(testID);
		atd.setUser_id(loginId);
		atd.setTest_started_time(startTime);
		atd.setTest_ended_time(endTime);
		atd.setAttempted(1);
		atd.setMax_attempt(GlobalConstants.default_max_attempt);
		return candidateDao.saveAttendedTestDetails(atd);
	}

	@Override
	public List<AttendedTestDetailsBean> getAllAttendedTestDetails() throws Exception {
		// TODO Auto-generated method stub
		return candidateDao.getAllAttendedTestDetails();
	}

	
}
