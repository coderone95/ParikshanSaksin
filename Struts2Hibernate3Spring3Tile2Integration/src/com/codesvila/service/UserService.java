package com.codesvila.service;

import java.util.List;
import java.util.Map;

import com.codesvila.bean.FunctionalityBO;
import com.codesvila.bean.OTPBO;
import com.codesvila.bean.UserBean;
import com.codesvila.model.User;

public interface UserService {
	
	public int saveUser(User user);
	
	List<User> getUserList();

	public void deleteUser(String userId);

	public void disableEnableUser(String userId, UserBean ub);

	public void updateUser(UserBean userBean); 
	
	public void sendEmail(String string, String string2, String encryptedPwd);

	public List<FunctionalityBO> getUsersAccessGiven(Integer userID) throws Exception;
	
	public List<FunctionalityBO> getUsersAccessNOTGiven(Integer userID) throws Exception;

	public boolean givenSelectedAccessToUser(Integer userID, String userType, List<String> accessList);

	public boolean removeAccess(Integer userID, String concat, String accessCode) throws Exception;

	public List<UserBean> getAndVerifyUser(String email, String phone) throws Exception;

	public Integer saveOrUpdateOTPstatus(Integer userid, String otp);

	public List<OTPBO> getOTPForUser(String otp, Integer userID) throws Exception;

	public Map<String, Integer> getAllUsersCount() throws Exception;


}
