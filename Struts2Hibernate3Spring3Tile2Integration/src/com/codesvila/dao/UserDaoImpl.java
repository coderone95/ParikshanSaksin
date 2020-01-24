package com.codesvila.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.codesvila.bean.FunctionalityBO;
import com.codesvila.bean.UserBean;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.model.Functionality;
import com.codesvila.model.User;
import com.codesvila.utils.DateUtils;

@Repository("userDao")
public class UserDaoImpl implements UserDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public int saveUser(User user) {
		// sessionFactory.getCurrentSession().saveOrUpdate(user);
		Session session = sessionFactory.openSession();
		// Session session =
		// getHibernateTemplate().getSessionFactory().getCurrentSession();

		// TODO Auto-generated method stub
		Transaction tx2 = session.beginTransaction();
		int generatedID = 0;
		try {
			generatedID = (Integer) session.save(user);
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
	public void deleteUser(String userId) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tx2 = session.beginTransaction();
		User user = (User) session.get(User.class, Integer.parseInt(userId));

		try {
			session.delete(user);

			tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	@Override
	public void disableEnableUser(String userId, UserBean ub) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		// TODO Auto-generated method stub
		Transaction tx2 = session.beginTransaction();

		User user = (User) session.get(User.class, Integer.parseInt(userId));

		user.setIs_disabled(ub.getIs_disabled());

		try {
			session.update(user);
			// session.getTransaction().commit();

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
	public List<User> getUserList() {
		return (List<User>) sessionFactory.getCurrentSession().createCriteria(User.class).list();
	}

	public void updateUser(UserBean u) {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tx2 = session.beginTransaction();
		User user = (User) session.get(User.class, u.getUser_id());
		if (StringUtils.isNotBlank(u.getPassword()) && u.getPassword() != null) {
			user.setPassword(u.getPassword());
		}
		if (StringUtils.isNotBlank(u.getName()) && u.getName() != null) {
			user.setName(u.getName());
		}
		if (StringUtils.isNotBlank(u.getPhone_number()) && u.getPhone_number() != null) {
			user.setPhone_number(u.getPhone_number());
		}
		user.setUpdated_on(DateUtils.getCurrentDate());
		try {
			session.update(user);

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
	public <T> List<T> nativeSQLQueryList(final String strQuery) {

		// Prep work
		Session session = sessionFactory.getCurrentSession();

		// Get All Employees
		Transaction tx = session.beginTransaction();
		Query query = session.createSQLQuery(strQuery);
		List<T> retList = query.list();
		return retList;
	}

	public void update(Object obj, Session session) {
		session.update(obj);
	}

	public void delete(Object obj, Session session) {
		session.delete(obj);
	}

	@Override
	public void addFunctionality(Functionality fbo) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		
		Transaction tx2 = session.beginTransaction();
		try {
			session.saveOrUpdate(fbo);
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
	public List<FunctionalityBO> getUsersAccessGiven(Integer userID) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("userID", userID);
		return ApacheCommonsDBCP.DBCPDataSource("GET_USERS_ACCESS_GIVEN", null, true, paramMap,null);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<FunctionalityBO> getUsersAccessNOTGiven(Integer userID) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("userID", userID);
		return ApacheCommonsDBCP.DBCPDataSource("GET_USERS_ACCESS_NOT_GIVEN", null, true, paramMap,null);
	}

	@Override
	public boolean givenSelectedAccessToUser(Functionality fb) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		int genereatedID = 0;
		Transaction tx2 = session.beginTransaction();
		try {
			genereatedID = (Integer) session.save(fb);
			tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		if(genereatedID>0)
			return true;
		return false;
	}

	@Override
	public boolean removeAccess(Integer userID, String userType, String accessCode) throws Exception {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
        int res = 0;
		Transaction tx2 = session.beginTransaction();
		try {
			Query q=session.createQuery("delete from Functionality where user_id=:userID and user_type=:user_type and functionality_code=:accessCode");  
	        q.setParameter("userID",userID);  
	        q.setParameter("user_type",userType);
	        q.setParameter("accessCode",accessCode);
	        res = q.executeUpdate();
			tx2.commit();
		} catch (HibernateException e) {
			if (tx2 != null)
				tx2.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		if(res > 0)
        	return true;
		return false;
	}

}
