package com.codesvila.action;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.ErrorMessages;
import com.codesvila.bean.SuccessMessages;
import com.codesvila.bean.UserBean;
import com.codesvila.bean.UserMasterBO;
import com.codesvila.service.UserService;
import com.codesvila.utils.CommonUtility;
import com.codesvila.utils.CryptUtils;
import com.codesvila.utils.GlobalConstants;
import com.opensymphony.xwork2.ModelDriven;

import forward.SendmailSSl;

public class LoginAction extends BaseAction implements ModelDriven<UserBean>{
	
	private static final long serialVersionUID = 1L;
	
	
	@Autowired
	private UserBean userBean;
	
	@Autowired
	private UserService userService;
	
	
	private List<UserBean> users;
	
	
	public final static String ADM = "ADM";
	public final static String STD = "STD";
	
	private String login_id;
	private String password;
	private String name;
	private String loggedInUserName;
	
	public List<ErrorMessages> errorMessagesList = new ArrayList<ErrorMessages>();
	
	public List<SuccessMessages> successMessageList = new ArrayList<SuccessMessages>();
	
	
	public String getLogin_id() {
		return login_id;
	}

	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public UserBean getUserBean() {
		return userBean;
	}

	public void setUserBean(UserBean userBean) {
		this.userBean = userBean;
	}

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public List<UserBean> getUsers() {
		return users;
	}

	public void setUsers(List<UserBean> users) {
		this.users = users;
	}

	public List<ErrorMessages> getErrorMessagesList() {
		return errorMessagesList;
	}

	public void setErrorMessagesList(List<ErrorMessages> errorMessagesList) {
		this.errorMessagesList = errorMessagesList;
	}


	public List<SuccessMessages> getSuccessMessageList() {
		return successMessageList;
	}

	public void setSuccessMessageList(List<SuccessMessages> successMessageList) {
		this.successMessageList = successMessageList;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the loggedInUserName
	 */
	public String getLoggedInUserName() {
		return loggedInUserName;
	}

	/**
	 * @param loggedInUserName the loggedInUserName to set
	 */
	public void setLoggedInUserName(String loggedInUserName) {
		this.loggedInUserName = loggedInUserName;
	}

	@SuppressWarnings("unchecked")
	public String execute() throws Exception {
		LOG.info("LoginAction----execute():----- User creating --- start");
		boolean isUserPresent = false;
		users = CommonUtility.createUserBeanList(userService.getUserList());
		removeSessionValues();
		for(UserBean u : users)
		{
			String encrypted = CryptUtils.encrypt(userBean.getPassword(), GlobalConstants.cipher_Key);
			login_id = u.getEmail_id();
			loggedInUserName = u.getName();
			if(u.getIs_disabled() == 1 && u.getEmail_id().equalsIgnoreCase(userBean.getEmail_id())) {
				isUserPresent = true;
				LOG.warn("User is BLOCKED!!!");
				ErrorMessages er = new ErrorMessages();
				er.setErrorMsg("User is blocked");
				er.setErrorFor("user blocked");
				errorMessagesList.add(er);
			}else if(u.getEmail_id().equalsIgnoreCase(userBean.getEmail_id())  && u.getPassword().equals(encrypted) ) {
				isUserPresent = true;
				List list = new ArrayList();
				list.add(u.getUser_type());

				List<UserMasterBO> userMasterList = CommonUtility.getMasterUserData("GET_MASTER_USER_DETAILS", list, true); 
						
				int isManagementUser = 0;
				if(userMasterList != null) {
					for(UserMasterBO mu : userMasterList) {
						isManagementUser = mu.getIsManagment_User();
						break;// limits to 1 user
					}
				}
				if(isManagementUser == 1) {
//					System.out.println("Management User");
					LOG.info("LoginAction----execute():Management User");
					setSessionValues(u);
					LOG.info("LoginAction----execute():----- User creating --- end");
					return ADM;	
				}else {
//					System.out.println("Candidate User");
					LOG.info("LoginAction----execute():Candidate User");
					setSessionValues(u);
					LOG.info("LoginAction----execute():----- User creating --- end");
					return STD;
				}
			}
		}
		
		if(! isUserPresent) {
			ErrorMessages er = new ErrorMessages();
			er.setErrorMsg("Invalid username or password");
			er.setErrorFor("login failed");
			errorMessagesList.add(er);
			LOG.info("LoginAction----execute():----- User creating --- end");
			return "failure";
		}
		LOG.info("LoginAction----execute():----- User creating --- end");
		return "failure";
	}
	
	public void setSessionValues(UserBean u) {
		sessionMap.put(GlobalConstants.LOGIN_ID,userBean.getEmail_id());
		sessionMap.put(GlobalConstants.PASSWORD,userBean.getPassword());
		sessionMap.put(GlobalConstants.EMAIL_ID, u.getEmail_id());
		sessionMap.put(GlobalConstants.NAME, u.getName());
		contextSession.put("username", userBean.getEmail_id());
	}

	public void removeSessionValues() {
		sessionMap.remove(GlobalConstants.LOGIN_ID);
		sessionMap.remove(GlobalConstants.PASSWORD);
		sessionMap.remove(GlobalConstants.EMAIL_ID);
		sessionMap.remove(GlobalConstants.NAME);
		contextSession.remove("username");
	}
	@Override
	public UserBean getModel() {
		// TODO Auto-generated method stub
		return userBean;
	}
	
}
