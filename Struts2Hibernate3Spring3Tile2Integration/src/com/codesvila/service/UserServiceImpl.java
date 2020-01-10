package com.codesvila.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.codesvila.bean.UserBean;
import com.codesvila.dao.UserDao;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.model.Functionality;
import com.codesvila.model.User;
import com.codesvila.utils.GlobalConstants;
import com.codesvila.utils.SendEmail;

@Service("userService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true) 
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)  
	public int saveUser( User user) {
		int userGeneratedID = userDao.saveUser(user);
		try {
			if(userGeneratedID > 0) {
				List<Functionality> accessRightsList = populateAccessRights(userGeneratedID);
				if(accessRightsList.size() > 0 && ! accessRightsList.isEmpty()) {
					for(Functionality fbo : accessRightsList) {
						userDao.addFunctionality(fbo);
					}
				}
			}
		}catch(Exception e) {
			e.printStackTrace(); 
		}
		return userGeneratedID;
	}

	
	@Override
	public List<User> getUserList() {
		return userDao.getUserList();
	}

	@Override
	public void deleteUser(String userId) {
		// TODO Auto-generated method stub
		userDao.deleteUser(userId);
	}
	
	@Override
	public void disableEnableUser(String userId, UserBean ub) {
		// TODO Auto-generated method stub
		userDao.disableEnableUser(userId, ub);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false) 
	public void updateUser(UserBean userBean) {
		// TODO Auto-generated method stub
		userDao.updateUser(userBean);
	}

	@Override
	public void sendEmail(String sendEmailFor, String email, String pwd) {
		// TODO Auto-generated method stub
		if(sendEmailFor.equalsIgnoreCase("USER_REGISTRATION")) {
			StringBuilder sb = new StringBuilder();
			String sub = "User Registration is successful";
			sb.append("You have successfully registered");
			sb.append("\n");
			sb.append("You can access your account using following credentials");
			sb.append("\n");
			sb.append("Username: "+email);
			sb.append("\n");
			sb.append("Password: "+pwd);
			sb.append("\n");
			SendEmail.sendEmail(sb.toString(), sub,null, email,null, null);
		}
	}
	
	private List<Functionality> populateAccessRights(Integer userGeneratedID) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> paramMap = new HashMap<String,Object>();
		List<Functionality> accessRightsList = new ArrayList<Functionality>();
		paramMap.put("userId",userGeneratedID);
		paramMap.put("email",null);
		@SuppressWarnings("unchecked")
		List<UserBean> userList = ApacheCommonsDBCP.DBCPDataSource("GET_USER_PROFILE_DATA", null,true,paramMap,null);
		String userType = userList.get(0).getUser_type().concat("_USER");
		Integer userId = userList.get(0).getUser_id();
		System.out.println("--------------------------- User type ----------------- " +userList.get(0).getUser_type());
		if(userType.equals(GlobalConstants.ADMIN_USER)) {
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_DASHBOARD_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.ADD_ADMIN_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.ADD_EXAMINER_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.ADD_REVIEWER_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.ADD_CANDIDATE_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_USERS_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_SHOW_ADMIN_USERS,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_SHOW_EXAMINER_USERS,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_SHOW_REVIEWER_USERS,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_ADD_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_DISABLE_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_ENABLE_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_EDIT_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_DELETE_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_GROUP_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_SHOW_GROUPS,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_ADD_GROUP,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_EDIT_GROUP,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_DELETE_GROUP,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_TEST_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_ADD_TEST,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_EDIT_TEST,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_DELETE_TEST,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_QUESTIONS_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_SHOW_QUESTIONS,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_ADD_QUESTION,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_EDIT_QUESTION,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_DELETE_QUESTION,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_EDIT_TEST,userType));
		}else if(userType.equals(GlobalConstants.EXAMINER_USER)) {
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_DASHBOARD_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.ADD_REVIEWER_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.ADD_CANDIDATE_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_USERS_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_SHOW_REVIEWER_USERS,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_ADD_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_DISABLE_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_ENABLE_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_EDIT_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_DELETE_USER,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_GROUP_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_SHOW_GROUPS,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_ADD_GROUP,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_EDIT_GROUP,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_DELETE_GROUP,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_TEST_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_ADD_TEST,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_EDIT_TEST,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_DELETE_TEST,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_QUESTIONS_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_SHOW_QUESTIONS,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_ADD_QUESTION,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_EDIT_QUESTION,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_DELETE_QUESTION,userType));

			
		}else if(userType.equals(GlobalConstants.REVIEWER_USER)) {
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_DASHBOARD_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_USERS_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_GROUP_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_SHOW_GROUPS,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_DASHBOARD_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_TEST_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_QUESTIONS_PAGE,userType));
			accessRightsList.add(setFunctionalityValues(userId,GlobalConstants.M_SHOW_QUESTIONS,userType));
		}
		return accessRightsList;
	}

	public Functionality setFunctionalityValues(int userId, String fun_code, String userType) {
		Functionality bo = new Functionality();
		bo.setUser_id(userId);
		bo.setUser_type(userType);
		bo.setFunctionality_name(fun_code);
		bo.setFunctionality_code(fun_code);
		return bo;
	}
	

}
