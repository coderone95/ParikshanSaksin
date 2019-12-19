package com.codesvila.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.codesvila.bean.UserBean;

@Repository("genericDao")
public class GenericDAOImpl implements GenericDAO{
	
	@Autowired
	private SessionFactory sessionFactory;


	@SuppressWarnings("rawtypes")
	@Override
	public List nativeSQLQuery(String query) {
		// TODO Auto-generated method stub
		 Session session = sessionFactory.openSession();
	      Transaction tx = null;
	      List data = null;
	      try {
	          tx = session.beginTransaction();
	          SQLQuery w = session.createSQLQuery(query);
	          w.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	          data = w.list();
	          
	          for(Object object : data) {
	             Map row = (Map)object;
	             UserBean ub = new UserBean();
	             ub.setName((String) row.get("name"));
	             ub.setEmail_id((String) row.get("email_id"));
	             System.out.println("UserBean name "+ ub.getName());
	             System.out.println("UserBean email "+ ub.getEmail_id());
	          }
	          
	          tx.commit();
	       } catch (HibernateException e) {
	          if (tx!=null) tx.rollback();
	          e.printStackTrace(); 
	       } finally {
	          session.close(); 
	       }
		return data;
	}
	
}
