package com.codesvila.dao;

import java.util.List;

import com.codesvila.bean.UserBean;
import com.codesvila.model.User;

public interface UserDao {
	public void saveUser(User user);
	
	List<User> getUserList();

	public void updateUser(UserBean userBean); 
	
	 <T> List<T> nativeSQLQueryList(final String strQuery);

	public void deleteUser(String userId);
	
	public void disableEnableUser(String userId, UserBean ub);

	
}
