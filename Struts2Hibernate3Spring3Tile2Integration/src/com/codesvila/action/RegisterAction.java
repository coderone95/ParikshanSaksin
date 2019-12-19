//package com.codesvila.action;
//
//import java.util.ArrayList;
//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//
//import com.codesvila.bean.ErrorMessages;
//import com.codesvila.bean.UserBean;
//import com.codesvila.service.UserService;
//import com.codesvila.utils.CommonUtility;
//import com.codesvila.utils.DateUtils;
//import com.opensymphony.xwork2.ModelDriven;
//
//public class RegisterAction extends BaseAction implements  ModelDriven<UserBean>{
//	
//	/**
//	 * 
//	 */
//	private static final long serialVersionUID = 1L;
//	
//	@Autowired
//	private UserService userService;
//	
//	@Autowired
//	private UserBean userBean;
//	
//	private String name;
//	private String email_id;
//	private String password;
//	private String cpassword;
//	private String phone_number;
//	
//	public String getName() {
//		return name;
//	}
//
//	public void setName(String name) {
//		this.name = name;
//	}
//
//	public String getEmail_id() {
//		return email_id;
//	}
//
//	public void setEmail_id(String email_id) {
//		this.email_id = email_id;
//	}
//
//	public String getPassword() {
//		return password;
//	}
//
//	public void setPassword(String password) {
//		this.password = password;
//	}
//
//	public String getCpassword() {
//		return cpassword;
//	}
//
//	public void setCpassword(String cpassword) {
//		this.cpassword = cpassword;
//	}
//
//	public String getPhone_number() {
//		return phone_number;
//	}
//
//	public void setPhone_number(String phone_number) {
//		this.phone_number = phone_number;
//	}
//
//	public List<ErrorMessages> errorMessagesList = new ArrayList<ErrorMessages>();
//
//	
//	public List<ErrorMessages> getErrorMessagesList() {
//		return errorMessagesList;
//	}
//
//	public void setErrorMessagesList(List<ErrorMessages> errorMessagesList) {
//		this.errorMessagesList = errorMessagesList;
//	}
//
//	public UserService getUserService() {
//		return userService;
//	}
//
//	public void setUserService(UserService userService) {
//		this.userService = userService;
//	}
//
//	
//	public UserBean getUserBean() {
//		return userBean;
//	}
//
//	public void setUserBean(UserBean userBean) {
//		this.userBean = userBean;
//	}
//
//	public String register() {
//		userBean.setName(name);
//		userBean.setEmail_id(email_id);
//		userBean.setPhone_number(phone_number);
//		userBean.setPassword(password);
//		userBean.setCpassword(cpassword);
//		userBean.setCreated_on(DateUtils.getCurrentDate());
//		userBean.setUpdated_on(DateUtils.getCurrentDate());
//		userBean.setUser_type("student");
//		userBean.setIs_deleted(0);
//		userBean.setIs_disabled(0);
//		userService.saveUser(CommonUtility.createUserModel(userBean));
//		
//		return "success";
//	}
//
//	@Override
//	public UserBean getModel() {
//		// TODO Auto-generated method stub
//		return userBean;
//	}
//
//	
//
//}
