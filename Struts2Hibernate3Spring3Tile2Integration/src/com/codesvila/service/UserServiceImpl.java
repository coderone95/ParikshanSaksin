package com.codesvila.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.codesvila.bean.UserBean;
import com.codesvila.dao.UserDao;
import com.codesvila.model.User;
import com.codesvila.utils.SendEmail;

//@Path("/user")
//@Consumes(MediaType.APPLICATION_XML)
//@Produces(MediaType.APPLICATION_XML)
@Service("userService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true) 
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	
	@Override
//	@POST
//    @Path("/add")
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)  
	public void saveUser( User user) {
		userDao.saveUser(user);
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


}
