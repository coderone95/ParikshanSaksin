package com.codesvila.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.codesvila.model.UserAnswersDetails;
import com.codesvila.utils.GlobalConstants;

@Service("candidateService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class CandidateServiceImpl implements CandidateService {

	@Autowired
	private CandidateDAO candidateDao;

	private static final Logger LOG = Logger.getLogger(CandidateServiceImpl.class);

	@Override
	public List<TestAuthBean> getAllTestKeyAccess() throws Exception {
		// TODO Auto-generated method stub
		return candidateDao.getAllTestKeyAccess();
	}

	@Override
	public List<GroupBO> getGroupsInfoAndNumberOfQuestionCount(Integer testID) throws Exception {
		// TODO Auto-generated method stub
		return candidateDao.getGroupsInfoAndNumberOfQuestionCount(testID);
	}

	@Override
	public List<TestBO> getTestNameAndTime(Integer testID) throws Exception {
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
		return candidateDao.saveAttendedTestDetails(atd, startTime, endTime);
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
		} catch (Exception e) {
			LOG.error("Error while returning the Question ids", e);
		}

		LOG.debug("CandidateServiceImpl : getQuestionIds - end");
		return questionIds;
	}

	@Override
	public Map<String, Object> retrieveQustionWithOptions(String quesID) {
		// TODO Auto-generated method stub
		LOG.debug("CandidateServiceImpl : retrieveQustionWithOptions - start");
		Map<String, Object> data = new HashMap<String, Object>();
		try {
			QuestionBO questionBo = candidateDao.getQuestion(quesID);
			List<QuestionInfoBO> options = candidateDao.getOptions(quesID);

			data.put("QUESTION", questionBo.getQuestion());
			data.put("QUESTION_TYPE", questionBo.getQuestion_type());
			data.put("OPTIONS", options);

		} catch (Exception e) {
			LOG.error("Error while retrieving the question and options for question id", e);
		}
		LOG.debug("CandidateServiceImpl : retrieveQustionWithOptions - end");
		return data;
	}

	@Override
	public int submitAnswer(int testId, int groupId, int queId, String answerIDS, String testContextId) {
		// TODO Auto-generated method stub
		LOG.debug("CandidateServiceImpl : submitAnswer() - start");
		int result = 0;
		boolean isAlreadySubmittedAnswer = false;
		UserAnswersDetails userAnswerDetailsBean = new UserAnswersDetails();
		try {
			List<Object[]> resultList = new ArrayList<>();
			Integer contextId = null;
			Integer questionId = null;
			Integer testID = null;
			Integer groupID = null;
			Generic generic = new Generic();
			StringBuffer query = new StringBuffer();
			query.append(
					"SELECT ua.id, ua.test_answered_context_id, ua.question_id, ua.answer_id, ua.test_id, ua.group_id ");
			query.append("FROM tbl_user_answered ua WHERE ua.test_id =").append(testId);
			resultList = generic.nativeSQLQueryForList(query.toString());
			if (resultList.size() > 0 && resultList != null) {
				for (Object[] obj : resultList) {
					if (obj[0] != null) {
						Integer id = (Integer) obj[0];
						userAnswerDetailsBean.setId(id);
						if (obj[1] != null) {
							contextId = (Integer) obj[1];
							userAnswerDetailsBean.setTestAnswerContextId(contextId);
						}
						if (obj[2] != null) {
							questionId = (Integer) obj[2];
							userAnswerDetailsBean.setQuestionId(questionId);
						}
						if (obj[3] != null) {
							//answers = (String) obj[3];
						}
						if (obj[4] != null) {
							testID = (Integer) obj[4];
							userAnswerDetailsBean.setTest_id(testID);
						}
						if (obj[5] != null) {
							groupID = (Integer) obj[5];
							userAnswerDetailsBean.setGroup_id(groupID);
						}
						if (testID != null && questionId != null && contextId != null) {
							if (questionId == queId && contextId == Integer.parseInt(testContextId) && testID == testId
									&& groupID == groupId) {
								isAlreadySubmittedAnswer = true;
								break;
							}
						}
					}
				}
			}
			if (isAlreadySubmittedAnswer) {
				userAnswerDetailsBean.setAnswerId(answerIDS);
				Integer isCorrectAnswer = isCorrectAnswer(queId,answerIDS);
				userAnswerDetailsBean.setIsCorrectAnswer(isCorrectAnswer);
				result = candidateDao.saveSubmitAnswerObject(userAnswerDetailsBean, "UPDATE");
			} else {
				UserAnswersDetails userAnswersDetails = new UserAnswersDetails();
				userAnswersDetails.setAnswerId(answerIDS);
				userAnswersDetails.setGroup_id(groupId);
				userAnswersDetails.setTest_id(testId);
				userAnswersDetails.setQuestionId(queId);
				userAnswersDetails.setTestAnswerContextId(Integer.parseInt(testContextId));
				Integer isCorrectAnswer = isCorrectAnswer(queId,answerIDS);
				userAnswersDetails.setIsCorrectAnswer(isCorrectAnswer);
				result = candidateDao.saveSubmitAnswerObject(userAnswersDetails, "SAVE");
				
			}
		} catch (Exception e) {
			LOG.error("Error while submiting answer", e);
		} finally {

		}
		LOG.debug("CandidateServiceImpl : submitAnswer() - end");
		return result;
	}
	
	public Integer isCorrectAnswer(int queId, String answerIDS) {
		Integer isCorrectAnswer = 0;
		Generic generic = new Generic();
		StringBuilder query = new StringBuilder();
		query.append("SELECT opt.option_id FROM tbl_que_options opt WHERE opt.isCorrect = 1 AND opt.question_id =").append(queId);
		List<String> result = generic.nativeSQLQueryForList(query.toString());
		if(result.size() > 0 && result !=null) {
			String correctAnswerIds = result.toString().replace("[", "").replace("]", "").replace(" ", "");
			if(correctAnswerIds.equals(answerIDS)) {
				isCorrectAnswer = 1;
			}
		}
		return isCorrectAnswer;
	}

	@Override
	public Map<String, String> populateSubmittedAnswer(String testID, String groupID, String quesID, String contextID) {
		// TODO Auto-generated method stub
		LOG.debug("CandidateServiceImpl : populateSubmittedAnswer() - end");
		Map<String,String> answersData = new HashMap<String,String>();
		try {
			Generic generic = new Generic();
			String answerIds = null;
			StringBuffer query = new StringBuffer();
			query.append(" SELECT ua.answer_id FROM tbl_user_answered ua ");
			query.append(" WHERE ua.test_id = ").append(testID);
			query.append(" AND ua.group_id = ").append(groupID);
			query.append(" AND ua.question_id = ").append(quesID);
			query.append(" AND ua.test_answered_context_id = ").append(contextID);
			
			List<String> result = generic.nativeSQLQueryForList(query.toString());
			if(result != null && result.size() >0 ) {
				answerIds = result.get(0);
				answersData.put("ANSWER_IDS", answerIds);
			}
		}catch(Exception e) {
			LOG.error("Error in populateSubmittedAnswer()", e);
		}
		LOG.debug("CandidateServiceImpl : populateSubmittedAnswer() - end");
		return answersData;
	}
}
