package com.codesvila.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.dispatcher.SessionMap;
import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.OTPBO;
import com.codesvila.bean.UserBean;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.service.UserService;
import com.codesvila.utils.CryptUtils;
import com.codesvila.utils.EmailValidator;
import com.codesvila.utils.GlobalConstants;
import com.codesvila.utils.SendSMS;

import forward.SendmailSSl;

public class LogoutAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5140916616272284399L;
	@Autowired
	private UserService userService;
	
	private String phoneOrEmail;
	private String successMsg;
	private String errorMsg;
	private String isValidCredentials;
	private String otp;
	private String isOTPVerified;
	

	/**
	 * @return the phoneOrEmail
	 */
	public String getPhoneOrEmail() {
		return phoneOrEmail;
	}

	/**
	 * @param phoneOrEmail the phoneOrEmail to set
	 */
	public void setPhoneOrEmail(String phoneOrEmail) {
		this.phoneOrEmail = phoneOrEmail;
	}

	/**
	 * @return the errorMsg
	 */
	public String getErrorMsg() {
		return errorMsg;
	}

	/**
	 * @param errorMsg the errorMsg to set
	 */
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	/**
	 * @return the successMsg
	 */
	public String getSuccessMsg() {
		return successMsg;
	}

	/**
	 * @param successMsg the successMsg to set
	 */
	public void setSuccessMsg(String successMsg) {
		this.successMsg = successMsg;
	}


	/**
	 * @return the isValidCredentials
	 */
	public String getIsValidCredentials() {
		return isValidCredentials;
	}

	/**
	 * @param isValidCredentials the isValidCredentials to set
	 */
	public void setIsValidCredentials(String isValidCredentials) {
		this.isValidCredentials = isValidCredentials;
	}

	/**
	 * @return the otp
	 */
	public String getOtp() {
		return otp;
	}

	/**
	 * @param otp the otp to set
	 */
	public void setOtp(String otp) {
		this.otp = otp;
	}

	/**
	 * @return the isOTPVerified
	 */
	public String getIsOTPVerified() {
		return isOTPVerified;
	}

	/**
	 * @param isOTPVerified the isOTPVerified to set
	 */
	public void setIsOTPVerified(String isOTPVerified) {
		this.isOTPVerified = isOTPVerified;
	}

	@SuppressWarnings("rawtypes")
	public String logoutSession() {
		contextSession.clear();
		((SessionMap) sessionMap).invalidate();
		// session.invalidate();
		return "success";
	}

	public String forgotPage() {
		return "success";
	}
	
	public String forgotCredentials() throws Exception{
		if(!(StringUtils.isNotBlank(phoneOrEmail))) {
			errorMsg = "Please enter email or phone!!";
			return "success";
		}
		boolean isValidUser = false;
		if(StringUtils.isNumeric(phoneOrEmail)) {
			LOG.info("Forgot Action ---- Is Number---::: "+phoneOrEmail);
			isValidUser = isValidUser(phoneOrEmail, false);
		}else {
			boolean isValidEmail = emailValidator(phoneOrEmail);
			if(isValidEmail) {
				isValidUser = isValidUser(phoneOrEmail, true);
			}else {
				errorMsg = "Invalid email address";
			}
		}
		if(isValidUser) {
			LOG.info("Forgot Action ---- forgotCredentials()---: Valid User Details");
			//successMsg = "Valid user details";
			isValidCredentials = "YES";
			String otp = generateOtp();
			Integer userid = (Integer) sessionMap.get("verifyOtpForUserId");
			Integer res = userService.saveOrUpdateOTPstatus(userid,otp);
			if(res > 0){
				LOG.info("Forgot Action ---- forgotCredentials()---: OTP Saved or Updated:::: "+otp);
				sendOTPOnRegisteredPhoneOrEmailAddress(otp);
			}
			LOG.info("Forgot Action ---- forgotCredentials()---: OTP:::: "+otp);
		}else {
			LOG.info("Forgot Action ---- forgotCredentials() ---: In-Valid User Details");
			errorMsg = "Invalid user details";
		}
		 
		LOG.info("Forgot Action --- phoneOrEmailField----::: "+phoneOrEmail);
		
		return "success";
	}

	private String generateOtp() {
		// TODO Auto-generated method stub
		int randomPin   =(int) (Math.random()*90000)+100000; 
		String otp  = String.valueOf(randomPin); 
		return otp; 
	}

	public static boolean emailValidator(String email) {
		EmailValidator validator = new EmailValidator();
		return validator.validateEmail(email);
	}
	public boolean isValidUser(String emailOrPhone, boolean isEmailAddress) throws Exception{
		if(isEmailAddress) {
			String email = emailOrPhone;
			List<UserBean> user = userService.getAndVerifyUser(email,null);
			if(!(user.size() > 0)) {
				return false;
			}else {
				sessionMap.put("verifyOtpForUserId", user.get(0).getUser_id());
				sessionMap.put("verifyOtpForUserPhoneNumber", user.get(0).getPhone_number());
				sessionMap.put("verifyOtpForUserEmailAdddress", user.get(0).getEmail_id());
			}
		}else {
			String phone = emailOrPhone;
			List<UserBean> user = userService.getAndVerifyUser(null,phone);
			if(!(user.size() > 0)) {
				return false;
			}else {
				sessionMap.put("verifyOtpForUserId", user.get(0).getUser_id());
				sessionMap.put("verifyOtpForUserEmailAdddress", user.get(0).getEmail_id());
				sessionMap.put("verifyOtpForUserPhoneNumber", user.get(0).getPhone_number());
			}
		}
		return true;
	}
	
	public void sendOTPOnRegisteredPhoneOrEmailAddress(String otp) {
		String email = (String) sessionMap.get("verifyOtpForUserEmailAdddress");
		String phone = (String) sessionMap.get("verifyOtpForUserPhoneNumber");
		//boolean isSentP = sendOTPtoRegisteredPhone(phone,otp);
		boolean isSentE = sendOTPtoRegisteredEmailAddress(email,otp);
		successMsg = "OTP sent to registered email address and phone number";
	}

	public boolean sendOTPtoRegisteredPhone(String phone, String otp) {
		// TODO Auto-generated method stub
		String status =  SendSMS.sendOTPViaSms(phone, otp);
		if(status.equalsIgnoreCase("Error"))
			return false;
		return true;
	}
	public boolean sendOTPtoRegisteredEmailAddress(String email, String otp) {
		// TODO Auto-generated method stub
		SendmailSSl sendEmail = new SendmailSSl();
		sendEmail.sendOTPViaEmail(otp, email);
		return true;
	}
	
	public String verifyOtp() throws Exception{
		isValidCredentials = "YES";
		Integer userID = (Integer) sessionMap.get("verifyOtpForUserId");
		List<OTPBO> otps = userService.getOTPForUser(otp,userID);
		if(otps.size() > 0 && !otps.isEmpty()) {
			if(otps.get(0).getOtp() != null && otps.get(0).getOtp().equals(otp)) {
				LOG.info("User's otp verified");
				isOTPVerified = "YES";
				Map<String,Object> paramMap = new HashMap<String,Object>();
				paramMap.put("email", null);
				paramMap.put("userId", userID);
				List<UserBean> userList = ApacheCommonsDBCP.DBCPDataSource("GET_USER_PROFILE_DATA",null,true,paramMap,null);
				String decryptedPwd= null;
				String userName = null;
				String user= null;
				if(userList.size() > 0){
					decryptedPwd = CryptUtils.decrypt(userList.get(0).getPassword(), GlobalConstants.cipher_Key);
					userName = userList.get(0).getEmail_id();
					user = userList.get(0).getName();
				}
				//String stauts = SendSMS.sendLoginCredentialsViaSMS(userName, decryptedPwd,(String) sessionMap.get("verifyOtpForUserPhoneNumber"));
				SendmailSSl sendEmail = new SendmailSSl();
				sendEmail.sendLoginCredentialsViaEmail(user,userName, decryptedPwd, (String) sessionMap.get("verifyOtpForUserEmailAdddress"));
				successMsg = "Login Credentials are sent to registered email and phone";
			}else if(otps.get(0).getOtp() == null && otps.get(0).getUser_id() > 0 ) {
				errorMsg = "OTP expired. Please try with new one.";
			}else if(! otps.get(0).getOtp().equals(otp) ) {
				errorMsg = "Incorrect OTP. Please enter correct OTP.";
			}
		}else {
			errorMsg = "OTP expired. Please try with new one.";
		}
		return "success";
	}
}
