package com.codesvila.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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
	
}
