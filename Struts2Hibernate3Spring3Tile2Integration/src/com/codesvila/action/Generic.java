package com.codesvila.action;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.codesvila.utils.HibernateUtil;

public class Generic {

	private static final long serialVersionUID = 2271494896526032387L;

	public List nativeSQLQueryList(String query) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = null;
		List data = null;
		try {
			tx = session.beginTransaction();
			SQLQuery w = session.createSQLQuery(query);
			w.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
			data = w.list();

			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return data;
	}

}
