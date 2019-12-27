package com.codesvila.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.codesvila.bean.GroupBO;
import com.codesvila.bean.TestBO;
import com.codesvila.bean.UserBean;
import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.dao.ReportDAO;

@Service("reportService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true) 
public class ReportServiceImpl implements ReportService{
	
	@Autowired
	private ReportDAO reportDao;

	@Override
	public List<QuestionInfoBO> getQuestionReport(String startDate, String endDate, String createdBy, String questionName,
			Integer questionId) throws Exception {
		// TODO Auto-generated method stub
		return reportDao.getQuestionReport(startDate,endDate,createdBy,questionName,questionId);
	}

	@Override
	public List<GroupBO> getGroupReport(String startDate, String endDate, String createdBy, String groupName,
			Integer groupId) throws Exception {
		// TODO Auto-generated method stub
		return reportDao.getGroupReport(startDate,endDate,createdBy,groupName,groupId);
	}

	@Override
	public List<TestBO> getTestReport(String startDate, String endDate, String createdBy, String testName,
			Integer testId, String testKey) throws Exception {
		// TODO Auto-generated method stub
		return reportDao.getTestReport(startDate,endDate,createdBy,testName,testId,testKey);
	}

	@Override
	public List<UserBean> getUserReport(String startDate, String endDate, String userName, String phoneNumber,
			String emailId, String userType, Integer userId) throws Exception {
		// TODO Auto-generated method stub
		return reportDao.getUserReport(startDate,endDate,userName,phoneNumber,emailId,userType,userId);
	}
	
}
