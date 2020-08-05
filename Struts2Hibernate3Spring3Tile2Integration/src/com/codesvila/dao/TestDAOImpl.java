package com.codesvila.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.codesvila.bean.GroupBO;
import com.codesvila.bean.GroupsTestInfoBO;
import com.codesvila.bean.QuestionBO;
import com.codesvila.bean.QuestionsGroupBO;
import com.codesvila.bean.TestBO;
import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.model.Group;
import com.codesvila.model.GroupsTest;
import com.codesvila.model.Options;
import com.codesvila.model.Question;
import com.codesvila.model.QuestionsGroup;
import com.codesvila.model.Test;
import com.codesvila.utils.DateUtils;

@Repository("testDao")
public class TestDAOImpl implements TestDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public int saveQuestion(Question question) {
		// sessionFactory.getCurrentSession().saveOrUpdate(user);
		Session session = sessionFactory.openSession();
		// Session session =
		// getHibernateTemplate().getSessionFactory().getCurrentSession();

		// TODO Auto-generated method stub
		Transaction tx2 = session.beginTransaction();
		int generatedID = 0;
		try {
			generatedID = (Integer) session.save(question);
			tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return generatedID;
	}

	@Override
	public int saveOptions(Options options) {
		// sessionFactory.getCurrentSession().saveOrUpdate(user);
		Session session = sessionFactory.openSession();

		// TODO Auto-generated method stub
		Transaction tx2 = session.beginTransaction();
		int generatedID = 0;
		try {
			generatedID = (Integer) session.save(options);
			tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return generatedID;
	}

	@Override
	public void deleteQuestion(Integer questionId) throws Exception {
		// TODO Auto-generated method stub
		List<Integer> params = new ArrayList<Integer>();
		params.add(questionId);
		ApacheCommonsDBCP.DBCPDataSource("CALL_DELETE_QUESTION_PROC", params, true, null, null);
	}

	@Override
	public List<QuestionInfoBO> getQuestionAndAnswer(Integer questionId) throws Exception {
		List<QuestionInfoBO> inforB = new ArrayList<QuestionInfoBO>();
		// TODO Auto-generated method stub
		List<Integer> params = new ArrayList<Integer>();
		params.add(questionId);
		inforB = ApacheCommonsDBCP.DBCPDataSource("GET_QUESTION_WITH_ANSWER", params, true, null, null);

		return inforB;
	}

	@Override
	public List<QuestionInfoBO> getOptionsForQuestion(Integer questionId) throws Exception {
		// TODO Auto-generated method stub
		List<QuestionInfoBO> optionList = new ArrayList<QuestionInfoBO>();
		List<Integer> params = new ArrayList<Integer>();
		params.add(questionId);
		optionList = ApacheCommonsDBCP.DBCPDataSource("GET_OPTIONS_FOR_QUESTION", params, true, null, null);
		return optionList;
	}

	@Override
	public Integer updateQuestionDetails(int questionid, String loginId, String questionValue, String [] correctOptionIds,
			Map<String, String> optionMap, String questionType) throws Exception {
		int res = 1;
		Session session = sessionFactory.openSession();

		try {
			updateQuestion(session, questionid, questionValue, loginId,questionType);
			updateOptions(session, optionMap);
			for(String id : correctOptionIds) {
				updateCorrectOption(session, Integer.parseInt(id));
			}
		} catch (Exception e) {
			res = 0;
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	public void updateQuestion(Session session, Integer questionID, String question, String loginID, String questionType) {
		Transaction tx2 = session.beginTransaction();
		Question que = (Question) session.get(Question.class, questionID);
		que.setQuestion(question);
		que.setQuestion_type(questionType);
		que.setCreated_by(loginID);
		que.setUpdated_on(DateUtils.getCurrentDate());
		try {
			session.saveOrUpdate(que);
			if (!tx2.wasCommitted())
				tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")
	public void updateOptions(Session session, Map<String, String> optionMap) {
		Transaction tx2 = session.beginTransaction();

		for (String key : optionMap.keySet()) {
			String option = optionMap.get(key);
			Integer optionId = Integer.parseInt(key);
			Options op = (Options) session.get(Options.class, optionId);
			op.setOption_value(option);
			op.setIsCorrect(0);

			try {
				session.saveOrUpdate(op);
				if (!tx2.wasCommitted())
					tx2.commit();
			} catch (HibernateException e) {
				if (tx2 != null)
					tx2.rollback();
				e.printStackTrace();
			}
		}
	}

	public void updateCorrectOption(Session session, Integer correctOptionId) {
		Transaction tx2 = session.beginTransaction();
		Options correctOp = (Options) session.get(Options.class, correctOptionId);
		correctOp.setIsCorrect(1);

		try {
			session.saveOrUpdate(correctOp);
			if (!tx2.wasCommitted())
				tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		}
	}

	@Override
	public int createGroup(Group group) {
		Session session = sessionFactory.openSession();
		Transaction tx2 = session.beginTransaction();
		int generatedID = 0;
		try {
			generatedID = (Integer) session.save(group);
			tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return generatedID;
	}

	@Override
	public List<GroupBO> getAllGroupsInfo() throws Exception {
		// TODO Auto-generated method stub
		return ApacheCommonsDBCP.DBCPDataSource("GET_GROUPS", null, false, null, null);
	}

	@Override
	public void addSelectedQuestionsToGroup(QuestionsGroupBO questionsGroupBean) {
		Session session = sessionFactory.openSession();
		Transaction tx2 = session.beginTransaction();
		QuestionsGroup questionG = new QuestionsGroup();
		questionG.setGroup_id(questionsGroupBean.getGroup_id());
		questionG.setQuestion_id(questionsGroupBean.getQuestion_id());

		try {
			session.save(questionG);
			tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<QuestionsGroupBO> getAllAddedQuestionsOfGroup() throws Exception {
		// TODO Auto-generated method stub
		return ApacheCommonsDBCP.DBCPDataSource("GET_ALL_ADDED_QUESTIONS_OF_GROUP", null, false, null, null);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<QuestionsGroupBO> getDetailsForSelectedGroup(String selectedGId) throws Exception {
		List<Integer> params = new ArrayList<Integer>();
		params.add(Integer.parseInt(selectedGId));
		return ApacheCommonsDBCP.DBCPDataSource("GET_DETAILS_FOR_SELECTED_GROUP", params, true, null, null);
	}

	@Override
	public void deleteSelectedGroup(Integer selectedGroupID) throws Exception {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		List<Integer> params = new ArrayList<Integer>();
		params.add(selectedGroupID);
		try {
			deleteGroup(session, selectedGroupID);
			ApacheCommonsDBCP.DBCPDataSource("CALL_QUESTIONS_GROUP_DELETE_PROC", params, true, null, null);
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}
	
	public void deleteGroup(Session session, Integer selectedGroupID) {
		Transaction tx2 = session.beginTransaction();
		Group group = (Group) session.load(Group.class, selectedGroupID);
		
		try {
			session.delete(group);
			if (!tx2.wasCommitted())
				tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		}
	}

	@Override
	public void removeSelectedQuestionFromGroup(Integer selectedGroupID, Integer questionId) throws Exception {
		// TODO Auto-generated method stub
		List<Integer> params = new ArrayList<Integer>();
		params.add(selectedGroupID);
		params.add(questionId);
		ApacheCommonsDBCP.DBCPDataSource("CALL_DELETE_SELECTED_QUESTION_FROM_GROUP_PROC", params, true, null, null);
	}
	
	@Override
	public void updateGroup(Group group, Integer selectedGroupID) {
		Session session = sessionFactory.openSession();
		Transaction tx2 = session.beginTransaction();
		Group gp = (Group) session.get(Group.class, selectedGroupID);
		gp.setGroup_name(group.getGroup_name());
		gp.setUpdated_by(group.getUpdated_by());
		gp.setUpdated_on(group.getUpdated_on());
		try {
			session.saveOrUpdate(gp);
			if (!tx2.wasCommitted())
				tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		}
	}

	@Override
	public int createTest(Test tbo) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tx2 = session.beginTransaction();
		int generatedID = 0;
		try {
			generatedID = (Integer) session.save(tbo);
			tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return generatedID;
	}

	@Override
	public int addGroupsToTest(GroupsTest gt) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tx2 = session.beginTransaction();
		int generatedID = 0;
		try {
			generatedID = (Integer) session.save(gt);
			tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return generatedID;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TestBO> getAllTests() throws Exception {
		// TODO Auto-generated method stub
		return ApacheCommonsDBCP.DBCPDataSource("GET_ALL_TESTS", null, false, null,null);
	}

	@Override
	public void deleteTest(Integer testID) throws Exception {
		Session session = sessionFactory.openSession();
		// TODO Auto-generated method stub
		Transaction tx2 = session.beginTransaction();
		Test test = (Test) session.load(Test.class, testID);
		try {
			session.delete(test);
			removeRecordsFromGroupsTest(testID);
			tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	private void removeRecordsFromGroupsTest(Integer testID) throws Exception{
		// TODO Auto-generated method stub
		List<Integer> param = new ArrayList<Integer>();
		param.add(testID);
		ApacheCommonsDBCP.DBCPDataSource("CALL_REMOVE_TEST_REC_FROM_GROUPS_TEST_TABLE", param, true, null,null);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TestBO> getTestInfoForSelectedID(Integer testID) throws Exception {
		// TODO Auto-generated method stub
		List<Integer> param = new ArrayList<Integer>();
		param.add(testID);
		return ApacheCommonsDBCP.DBCPDataSource("GET_TEST_INFO_FOR_SELECTED_ID", param, true, null,null);
	}

	@Override
	public Integer updateTest(Test tbo, Integer testID) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tx2 = session.beginTransaction();
		Test testBo = (Test) session.get(Test.class, testID);
		testBo.setTest_name(tbo.getTest_name());
		testBo.setAccess_key(tbo.getAccess_key());
		testBo.setIs_live(tbo.getIs_live());
		testBo.setTest_key(tbo.getTest_key());
		testBo.setTest_instructions(tbo.getTest_instructions());
		testBo.setUpdated_by(tbo.getUpdated_by());
		testBo.setUpdated_on(tbo.getUpdated_on());
		testBo.setTest_time(tbo.getTest_time());
		testBo.setPassingCriteria(tbo.getPassingCriteria());
		testBo.setStartOn(tbo.getStartOn());
		testBo.setEndOn(tbo.getEndOn());
		int res = 0;
		try {
			session.saveOrUpdate(testBo);
			if (!tx2.wasCommitted())
				tx2.commit();
			res = 1;
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		}finally {
			session.close();
		}
		return res;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GroupsTestInfoBO> getAddedGroupsForSelectedTest(Integer testID) throws Exception {
		// TODO Auto-generated method stub
		List<Integer> param = new ArrayList<Integer>();
		param.add(testID);
		return ApacheCommonsDBCP.DBCPDataSource("GET_ADDED_GROUPS_FOR_SELECTED_TEST", param, true, null,null);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GroupsTestInfoBO> getAvailableGroupsForSelectedTest(Integer testID) throws Exception {
		// TODO Auto-generated method stub
		List<Integer> param = new ArrayList<Integer>();
		param.add(testID);
		return ApacheCommonsDBCP.DBCPDataSource("GET_AVAILABLE_GROUPS_FOR_SELECTED_TEST", param, true, null,null);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GroupsTestInfoBO> getAddedQuestionsForSelectedGroup(Integer selectedGroupID) throws Exception {
		// TODO Auto-generated method stub
		List<Integer> param = new ArrayList<Integer>();
		param.add(selectedGroupID);
		return ApacheCommonsDBCP.DBCPDataSource("GET_ADDED_QUESTIONS_FOR_SELECTED_GROUP", param, true, null,null);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GroupsTestInfoBO> getAvailableQuestionsForSelectedGroup(Integer selectedGroupID) throws Exception {
		// TODO Auto-generated method stub
		List<Integer> param = new ArrayList<Integer>();
		param.add(selectedGroupID);
		return ApacheCommonsDBCP.DBCPDataSource("GET_AVAILABLE_QUESTIONS_FOR_SELECTED_GROUP", param, true, null,null);
	}

	@SuppressWarnings("unchecked")
	@Override
	public int removeSelectedGroupFromSelectedTest(Integer testID, Integer groupId) throws Exception {
		// TODO Auto-generated method stub
		List<Integer> param = new ArrayList<Integer>();
		param.add(groupId);
		param.add(testID);
		List<Integer> res = ApacheCommonsDBCP.DBCPDataSource("CALL_DELETE_SELECTED_GROUP_FROM_SELECTED_TEST_PROC", param, true, null,null);
		return res.get(0);
	}

	@Override
	public Integer addSelectedGroupsToTest(Integer groupID, Integer testID) throws Exception {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tx2 = session.beginTransaction();
		int generatedID = 0;
		GroupsTest gt = new GroupsTest();
		gt.setGroup_id(groupID);
		gt.setTest_id(testID);
		
		try {
			generatedID = (Integer) session.save(gt);
			tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return generatedID;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<QuestionBO> getAddedQuestionsForSelectTest(Integer testID) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("testID", testID);
		return ApacheCommonsDBCP.DBCPDataSource("GET_ADDED_QUESTIONS_FOR_SELECT_TEST", null, true, paramMap,null);
	}

}
