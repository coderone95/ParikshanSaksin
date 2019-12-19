package com.codesvila.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.codesvila.bean.LibraryBean;
import com.codesvila.bean.OptionsBO;
import com.codesvila.bean.QuestionBO;
import com.codesvila.bean.UserBean;
import com.codesvila.bean.UserMasterBO;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.model.Library;
import com.codesvila.model.Options;
import com.codesvila.model.Question;
import com.codesvila.model.User;


public class CommonUtility {
	public static User createModel(UserBean userBean){
		User user = new User();
		user.setEmail_id(userBean.getEmail_id());
//		user.setName(name);
//		user.(userBean.getId());
//		user.setUsername(userBean.getUsername());
//		user.setPassword(userBean.getPassword());
//		user.setCpassword(userBean.getCpassword());
		
		return user;
	}
	
	public static User createUserModel(UserBean userBean) {
		
		User user = new User();
		user.setName(userBean.getName());
		user.setEmail_id(userBean.getEmail_id());
		user.setPassword(userBean.getPassword());
		user.setPhone_number(userBean.getPhone_number());
		user.setCreated_on(DateUtils.getCurrentDate());
		user.setUpdated_on(DateUtils.getCurrentDate());
		user.setIs_deleted(0);
		user.setIs_disabled(0);
		user.setUser_type(userBean.getUser_type());
		return user;
	}
	public static Library createLibraryModel(LibraryBean libraryBean){
		Library library = new Library();
		
		library.setId(libraryBean.getId());
		library.setName(libraryBean.getName());
		library.setAuthor(libraryBean.getAuthor());
		library.setPrice(libraryBean.getPrice());   
		library.setQuantity(libraryBean.getQuantity());
		
		return library;
	
	}

	public static List<UserBean> createUserBeanList(List<User> users){
		List<UserBean> beans = new ArrayList<UserBean>();
		UserBean userBean = null;
		for(User user : users){
			userBean = new UserBean();
			userBean.setName(user.getName());
			userBean.setPassword(user.getPassword());
			userBean.setUser_type(user.getUser_type());
			userBean.setEmail_id(user.getEmail_id());
			userBean.setPhone_number(user.getPhone_number());
			userBean.setIs_disabled(user.getIs_disabled());
			beans.add(userBean);
		}
		return beans;	
	}
	
	public static List<LibraryBean> createLibraryBeanList(List<Library> library){
		List<LibraryBean> beans = new ArrayList<LibraryBean>();
		LibraryBean libraryBean = null;
		
		for(Library lib : library )
		{ 
			libraryBean = new LibraryBean();
			
			libraryBean.setId(lib.getId());
			libraryBean.setName(lib.getName());
			libraryBean.setAuthor(lib.getAuthor());
			libraryBean.setPrice(lib.getPrice());
			libraryBean.setQuantity(lib.getQuantity());
			beans.add(libraryBean);
		}
		return beans;
		
	}
	
	@SuppressWarnings("unchecked")
	public static List<UserBean> getUserProfileData(String queryId, List list, boolean isParamsAvailable) throws Exception{
		return ApacheCommonsDBCP.DBCPDataSource(queryId,list,isParamsAvailable,null,null);
	}

	@SuppressWarnings("unchecked")
	public static List<UserMasterBO> getMasterUserData(String queryId, List list, boolean isParamsAvailable) throws Exception{
		// TODO Auto-generated method stub
		return ApacheCommonsDBCP.DBCPDataSource(queryId,list,isParamsAvailable,null,null);
	}

	@SuppressWarnings("unchecked")
	public static Map<String,String> getDashboardCandidateCounts(String string, List object, boolean b) throws Exception {
		// TODO Auto-generated method stub
		return ApacheCommonsDBCP.getDataInMap(string,object,b);
	}

	public static Question createQuestionModel(QuestionBO queBO) {
		// TODO Auto-generated method stub
		Question q = new Question();
		q.setCreated_by(queBO.getCreated_by());
		q.setUpdated_by(queBO.getUpdated_by());
		q.setQuestion(queBO.getQuestion());
		q.setCreated_on(DateUtils.getCurrentDate());
		q.setUpdated_on(DateUtils.getCurrentDate());
		return q;
	}

	public static Options createOptionModel(OptionsBO opBO) {
		// TODO Auto-generated method stub
		Options opt = new Options();
		opt.setCreated_by(opBO.getCreated_by());
		opt.setUpdated_by(opBO.getUpdated_by());
		opt.setIsCorrect(opBO.getIsCorrect());
		opt.setQuestion_id(opBO.getQuestion_id());
		opt.setOption_value(opBO.getOption_value());
		return opt;
	}

	@SuppressWarnings("unchecked")
	public static Map<String, String> getDashboardAdminCounts(String string, List object, boolean b) throws Exception {
		// TODO Auto-generated method stub
		return ApacheCommonsDBCP.getDataInMap(string,object,b);
	}

	@SuppressWarnings("unchecked")
	public static Map<String, String> getDashboardQuestionsCount(String string, List object, boolean b) throws Exception {
		// TODO Auto-generated method stub
		return ApacheCommonsDBCP.getDataInMap(string,object,b);
	}
	
	public static int booleanToInteger(boolean b) {
		return b ? 1:0;
	}
	
	public static int returnsTestTimeInSecs(int hrs, int mins, int secs) {
		return ((hrs*60*60)+(mins*60)+secs);
	}

}
