package com.codesvila.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.codesvila.action.Generic;
import com.codesvila.bean.AttendedTestDetailsBean;
import com.codesvila.bean.GroupBO;
import com.codesvila.bean.QuestionBO;
import com.codesvila.bean.TestAuthBean;
import com.codesvila.bean.TestBO;
import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.dao.CandidateDAO;
import com.codesvila.model.AttendedTestDetails;
import com.codesvila.utils.GlobalConstants;

@Service("candidateService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true) 
public class CandidateServiceImpl implements CandidateService{
	
	@Autowired
	private CandidateDAO candidateDao;
	
	private static final Logger LOG = Logger.getLogger(CandidateServiceImpl.class);

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
		atd.setAttempted(1);
		atd.setMax_attempt(GlobalConstants.default_max_attempt);
		return candidateDao.saveAttendedTestDetails(atd,startTime,endTime);
	}

	@Override
	public List<AttendedTestDetailsBean> getAllAttendedTestDetails() throws Exception {
		// TODO Auto-generated method stub
		return candidateDao.getAllAttendedTestDetails();
	}

	@Override
	public List<Integer> getQuestionIds(Integer groupId, Integer testId) {
		// TODO Auto-generated method stub
		LOG.debug("CandidateServiceImpl : getQuestionIds - start");
		List<Integer> questionIds = new ArrayList<Integer>();
		try {
			Generic generic = new Generic();
			StringBuffer query = new StringBuffer();
			query.append("SELECT q.question_id FROM tbl_questions q ");
			query.append("INNER JOIN tbl_questions_group qg ");
			query.append("ON qg.question_id = q.question_id where qg.group_id = ").append(groupId);
			questionIds = generic.nativeSQLQueryForList(query.toString());
		}catch(Exception e) {
			LOG.error("Error while returning the Question ids",e);
		}
		
		LOG.debug("CandidateServiceImpl : getQuestionIds - end");
		return questionIds;
	}

	@Override
	public Map<String,Object> retrieveQustionWithOptions(String quesID) {
		// TODO Auto-generated method stub
		LOG.debug("CandidateServiceImpl : retrieveQustionWithOptions - start");
		Map<String,Object> data = new HashMap<String,Object>();
		try{
			QuestionBO questionBo = candidateDao.getQuestion(quesID);
			List<QuestionInfoBO> options = candidateDao.getOptions(quesID);
			
			data.put("QUESTION", questionBo.getQuestion());
			data.put("OPTIONS", options);
			
		}catch(Exception e) {
			LOG.error("Error while retrieving the question and options for question id", e);
		}
		LOG.debug("CandidateServiceImpl : retrieveQustionWithOptions - end");
		return data;
	}

	
}
