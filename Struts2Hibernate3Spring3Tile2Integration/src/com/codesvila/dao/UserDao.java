package com.codesvila.dao;

import java.util.List;

import com.codesvila.bean.FunctionalityBO;
import com.codesvila.bean.OTPBO;
import com.codesvila.bean.UserBean;
import com.codesvila.model.Functionality;
import com.codesvila.model.OTP;
import com.codesvila.model.User;

public interface UserDao {
	public int saveUser(User user);
	
	List<User> getUserList();

	public void updateUser(UserBean userBean); 
	
	 <T> List<T> nativeSQLQueryList(final String strQuery);

	public void deleteUser(String userId);
	
	public void disableEnableUser(String userId, UserBean ub);

	public void addFunctionality(Functionality fbo);

	public List<FunctionalityBO> getUsersAccessGiven(Integer userID) throws Exception;

	public List<FunctionalityBO> getUsersAccessNOTGiven(Integer userID) throws Exception;

	public boolean givenSelectedAccessToUser(Functionality fb);

	public boolean removeAccess(Integer userID, String userType, String accessCode) throws Exception;

	public List<UserBean> getAndVerifyUser(String email, String phone) throws Exception;

	public Integer saveOrUpdateOTPstatus(OTP otpb);

	public List<OTPBO> getOTPForUser(String otp, Integer userID) throws Exception;


	
}
