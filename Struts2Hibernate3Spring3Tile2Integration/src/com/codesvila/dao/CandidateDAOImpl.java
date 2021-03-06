package com.codesvila.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.codesvila.bean.AttendedTestDetailsBean;
import com.codesvila.bean.GroupBO;
import com.codesvila.bean.QuestionBO;
import com.codesvila.bean.TestAuthBean;
import com.codesvila.bean.TestBO;
import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.model.AttendedTestDetails;
import com.codesvila.model.TestSubmissionDetails;
import com.codesvila.model.UserAnswersDetails;

@Repository("candidateDao")
public class CandidateDAOImpl implements CandidateDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	private static final Logger LOG = Logger.getLogger(CandidateDAOImpl.class);

	@SuppressWarnings("unchecked")
	@Override
	public List<TestAuthBean> getAllTestKeyAccess() throws Exception {
		// TODO Auto-generated method stub
		return ApacheCommonsDBCP.CandidateDBCPDataSource("GET_ALL_TEST_KEY_ACCESS_INFO", true, null);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GroupBO> getGroupsInfoAndNumberOfQuestionCount(Integer testID) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("testID", testID);
		return ApacheCommonsDBCP.CandidateDBCPDataSource("GET_TEST_GROUP_NO_OF_QUESTIONS_COUNT", true, map);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TestBO> getTestNameAndTime(Integer testID) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("testID", testID);
		return ApacheCommonsDBCP.CandidateDBCPDataSource("GET_TEST_NAME_AND_TIME", true, map);
	}


	@Override
	public int saveAttendedTestDetails(AttendedTestDetails atd, Date startTime, Date endTime) {
		// TODO Auto-generated method stub
		int generatedID = 0;
		List<AttendedTestDetailsBean>  tdlist = new ArrayList<AttendedTestDetailsBean>();
		try {
			tdlist = ApacheCommonsDBCP.CandidateDBCPDataSource("GET_ALL_ATTENDED_TEST_DETAILS", false, null);
			if(tdlist.size() > 0) {
				LOG.info("This saveAttendedTestDetails obj already present.. updating now");
				for(AttendedTestDetailsBean tbo : tdlist) {
					if(tbo.getUser_id().equals(atd.getUser_id()) && tbo.getTest_id() == atd.getTest_id()) {
						Session session = sessionFactory.openSession();
						Transaction tx2 = session.beginTransaction();
						//Test already given
						LOG.debug("Updating the test attended details");
						AttendedTestDetails attendedTest  = (AttendedTestDetails) session.get(AttendedTestDetails.class, tbo.getId());
						attendedTest.setAttempted(tbo.getAttempted()+1);
						try {
							session.update(attendedTest);
							generatedID = tbo.getId();
							tx2.commit();
						} catch (HibernateException e) {
							if (tx2 != null)
								tx2.rollback();
							e.printStackTrace();
						}finally {
							session.close();
						}
					}
					break;
				}
			}else {
				Session session = sessionFactory.openSession();
				Transaction tx2 = session.beginTransaction();
				LOG.info("Saving new saveAttendedDetails obj");
				try {
					generatedID = (Integer) session.save(atd);
					tx2.commit();
				} catch (HibernateException e) {
					if (tx2 != null)
						tx2.rollback();
					e.printStackTrace();
				}finally {
					session.close();
				}
			}
				Session session = sessionFactory.openSession();
				Transaction tx2 = session.beginTransaction();
				LOG.info("Saving the test submission details");
				try {
					
					if(generatedID > 0) {
						TestSubmissionDetails testSubmissionDetails = new TestSubmissionDetails();
						testSubmissionDetails.setTestId(atd.getTest_id());
						testSubmissionDetails.setTestStartTime(startTime);
						testSubmissionDetails.setTestEndTime(endTime);
						testSubmissionDetails.setUserId(atd.getUser_id());
						generatedID = (Integer) session.save(testSubmissionDetails);
					}
					tx2.commit();
				} catch (HibernateException e) {
					if (tx2 != null)
						tx2.rollback();
					e.printStackTrace();
				} finally {
					session.close();
				}
		}catch(Exception e) {
			e.printStackTrace();
		}

		return generatedID;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<AttendedTestDetailsBean> getAllAttendedTestDetails() throws Exception {
		// TODO Auto-generated method stub
		return ApacheCommonsDBCP.CandidateDBCPDataSource("GET_ALL_ATTENDED_TEST_DETAILS", false, null);
	}

	@Override
	public QuestionBO getQuestion(String quesID) {
		// TODO Auto-generated method stub
		QuestionBO qbo = new QuestionBO();
		try {
			Map<String,Object> paramMap = new HashMap<String,Object>();
			paramMap.put("QuestionID", Integer.parseInt(quesID));
			List<QuestionBO> questionList = ApacheCommonsDBCP.CandidateDBCPDataSource("GET_QUESTION_ONLY", true, paramMap);
			if(questionList !=null && questionList.size()>0) {
				String question = questionList.get(0).getQuestion();
				String question_type = questionList.get(0).getQuestion_type();
				qbo.setQuestion(question);
				qbo.setQuestion_type(question_type);
			}
		}catch(Exception e) {
			LOG.error("Error while getting the question",e);
		}
		return qbo;
	}

	@Override
	public List<QuestionInfoBO> getOptions(String quesID) {
		// TODO Auto-generated method stub
		List<QuestionInfoBO> questionList = new ArrayList<QuestionInfoBO>();
		try {
			Map<String,Object> paramMap = new HashMap<String,Object>();
			paramMap.put("QuestionID", Integer.parseInt(quesID));
			questionList = ApacheCommonsDBCP.CandidateDBCPDataSource("GET_OPTIONS_ONLY", true, paramMap);
		}catch(Exception e) {
			LOG.error("Error while getting the options",e);
		}
		return questionList;
	}

	@Override
	public int saveSubmitAnswerObject(UserAnswersDetails userAnswersDetails, String operationFlag) {
		// TODO Auto-generated method stub
		int result = 0;
		Session session = sessionFactory.openSession();
		Transaction tx2 = session.beginTransaction();
		try {
			if(operationFlag.equalsIgnoreCase("UPDATE")) {
				UserAnswersDetails bean = (UserAnswersDetails) session.get(UserAnswersDetails.class, userAnswersDetails.getId());
				bean.setAnswerId(userAnswersDetails.getAnswerId());
				bean.setGroup_id(userAnswersDetails.getGroup_id());
				bean.setQuestionId(userAnswersDetails.getQuestionId());
				bean.setTest_id(userAnswersDetails.getTest_id());
				bean.setTestAnswerContextId(userAnswersDetails.getTestAnswerContextId());
				bean.setIsCorrectAnswer(userAnswersDetails.getIsCorrectAnswer());
				session.update(bean);
				result = 1;
			}else {
				result = (int) session.save(userAnswersDetails);
			}
			tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			LOG.error("Error while saving the submit answer",e);
			e.printStackTrace();
		} finally {
			session.close();
		}
		return result;
	}
}
