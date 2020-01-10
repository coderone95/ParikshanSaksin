package com.codesvila.service;

import java.util.List;

import com.codesvila.bean.UserBean;
import com.codesvila.model.User;

public interface UserService {
	
	public int saveUser(User user);
	
	List<User> getUserList();

	public void deleteUser(String userId);

	public void disableEnableUser(String userId, UserBean ub);

	public void updateUser(UserBean userBean); 
	
	public void sendEmail(String string, String string2, String encryptedPwd);

}
