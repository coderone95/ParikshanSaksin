package com.codesvila.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.codesvila.bean.AttendedTestDetailsBean;
import com.codesvila.bean.GroupBO;
import com.codesvila.bean.TestAuthBean;
import com.codesvila.bean.TestBO;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.model.AttendedTestDetails;

@Repository("candidateDao")
public class CandidateDAOImpl implements CandidateDAO {

	@Autowired
	private SessionFactory sessionFactory;

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
	public int saveAttendedTestDetails(AttendedTestDetails atd) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();

		// TODO Auto-generated method stub
		Transaction tx2 = session.beginTransaction();
		int generatedID = 0;
		try {
			generatedID = (Integer) session.save(atd);
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
	public List<AttendedTestDetailsBean> getAllAttendedTestDetails() throws Exception {
		// TODO Auto-generated method stub
		return ApacheCommonsDBCP.CandidateDBCPDataSource("GET_ALL_ATTENDED_TEST_DETAILS", false, null);
	}
}
