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

import com.codesvila.bean.LibraryBean;
import com.codesvila.model.Library;

@Repository("libraryDao")  
public class LibraryDAOImpl implements LibraryDAO {

	@Autowired  
	private SessionFactory sessionFactory;  
	
	@Override
	public void saveBook(Library library) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().saveOrUpdate(library);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Library> getBookList() {
		return (List<Library>) sessionFactory.getCurrentSession().createCriteria(Library.class).list();
	}

	@Override
	public void deleteBook(int id) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tx2 = session.beginTransaction();
		Library lib = (Library) session.get(Library.class, id);
		
		try {
			session.delete(lib);
			tx2.commit();
		}catch (HibernateException e) {
	         if (tx2!=null) tx2.rollback();
	         e.printStackTrace(); 
	      }finally {
	         session.close(); 
	      }
		
	}

	@Override
	public void updateBook(int id, LibraryBean libraryBean) {
		Session session = sessionFactory.openSession();
		// TODO Auto-generated method stub
		Transaction tx2 = session.beginTransaction();
		
		Library lib = 
                    (Library)session.get(Library.class, id); 
		
		
		lib.setPrice(libraryBean.getPrice());
		lib.setQuantity(libraryBean.getQuantity());
		
		try {
			  session.update(lib); 
		tx2.commit();
		}
		catch (HibernateException e) {
	         if (tx2!=null) tx2.rollback();
	         e.printStackTrace(); 
	      }finally {
	         session.close(); 
	      }
		
	}
	
	public void nativeQuery() {
		 Session session = sessionFactory.openSession();
	      Transaction tx = null;
	      
	      try {
	          tx = session.beginTransaction();
	          String sql = "select * from Person";
	          SQLQuery query = session.createSQLQuery(sql);
	          query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	          List data = query.list();

	          for(Object object : data) {
	             Map row = (Map)object;
	             System.out.print(" Id: " + row.get("id")); 
	             System.out.println(", Name: " + row.get("name")); 
	          }
	          tx.commit();
	       } catch (HibernateException e) {
	          if (tx!=null) tx.rollback();
	          e.printStackTrace(); 
	       } finally {
	          session.close(); 
	       }
	}
	
}
