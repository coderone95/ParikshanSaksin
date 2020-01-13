package com.codesvila.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.ErrorMessages;
import com.codesvila.bean.GroupBO;
import com.codesvila.bean.QuestionsGroupBO;
import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.service.TestService;
import com.codesvila.utils.GlobalConstants;

public class GroupAction extends BaseAction {
	/**
	 */
	private static final long serialVersionUID = 8604763071405867386L;

	@Autowired
	private TestService testService;
	private GroupBO groupbean;
	private List<GroupBO> groupList;
	private List<ErrorMessages> errorMessagesList = new ArrayList<ErrorMessages>();
	private Integer groupID;
	private Integer selectedGroupID;
	private String selectedGId;
	private List<String> selectedQuestionIDs;
	private List<QuestionsGroupBO> groupQuestionInfo = new ArrayList<QuestionsGroupBO>();
	private Integer totalQuestionsAddedForSelectGroup;
	private Integer questionId;
	private List<QuestionInfoBO> questionInfo = new ArrayList<QuestionInfoBO>();
	private List<Integer> addedQuestionIDs = new ArrayList<Integer>();
	private String groupName;

	public GroupBO getGroupbean() {
		return groupbean;
	}

	public void setGroupbean(GroupBO groupbean) {
		this.groupbean = groupbean;
	}

	public List<GroupBO> getGroupList() {
		return groupList;
	}

	public void setGroupList(List<GroupBO> groupList) {
		this.groupList = groupList;
	}

	public List<ErrorMessages> getErrorMessagesList() {
		return errorMessagesList;
	}

	public void setErrorMessagesList(List<ErrorMessages> errorMessagesList) {
		this.errorMessagesList = errorMessagesList;
	}

	public Integer getGroupID() {
		return groupID;
	}

	public void setGroupID(Integer groupID) {
		this.groupID = groupID;
	}

	public Integer getSelectedGroupID() {
		return selectedGroupID;
	}

	public void setSelectedGroupID(Integer selectedGroupID) {
		this.selectedGroupID = selectedGroupID;
	}

	public List<String> getSelectedQuestionIDs() {
		return selectedQuestionIDs;
	}

	public void setSelectedQuestionIDs(List<String> selectedQuestionIDs) {
		this.selectedQuestionIDs = selectedQuestionIDs;
	}

	public String getSelectedGId() {
		return selectedGId;
	}

	public void setSelectedGId(String selectedGId) {
		this.selectedGId = selectedGId;
	}

	public List<QuestionsGroupBO> getGroupQuestionInfo() {
		return groupQuestionInfo;
	}

	public void setGroupQuestionInfo(List<QuestionsGroupBO> groupQuestionInfo) {
		this.groupQuestionInfo = groupQuestionInfo;
	}
	

	public Integer getTotalQuestionsAddedForSelectGroup() {
		return totalQuestionsAddedForSelectGroup;
	}

	public void setTotalQuestionsAddedForSelectGroup(Integer totalQuestionsAddedForSelectGroup) {
		this.totalQuestionsAddedForSelectGroup = totalQuestionsAddedForSelectGroup;
	}

	public Integer getQuestionId() {
		return questionId;
	}

	public void setQuestionId(Integer questionId) {
		this.questionId = questionId;
	}

	public List<QuestionInfoBO> getQuestionInfo() {
		return questionInfo;
	}

	public void setQuestionInfo(List<QuestionInfoBO> questionInfo) {
		this.questionInfo = questionInfo;
	}

	public List<Integer> getAddedQuestionIDs() {
		return addedQuestionIDs;
	}

	public void setAddedQuestionIDs(List<Integer> addedQuestionIDs) {
		this.addedQuestionIDs = addedQuestionIDs;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String show() {
		return "success";
	}

	@SuppressWarnings({ "unchecked" })
	public String execute() throws Exception {
		LOG.info("GroupAction---- execute()-- add group section--- start");
		boolean isAlreadyExists = false;
		if(groupbean.getGroup_name() == null || !StringUtils.isNotBlank(groupbean.getGroup_name())) {
			ErrorMessages er = new ErrorMessages();
			er.setErrorMsg("Please enter group name");
			errorMessagesList.add(er);
			return "success";
		}
		List<GroupBO> groups = (List<GroupBO>) sessionMap.get("groupList");
		if (groups != null) {
			for (GroupBO gp : groups) {
				if (gp.getGroup_name().equalsIgnoreCase(groupbean.getGroup_name())) {
					isAlreadyExists = true;
					break;
				}
			}
		}
		if (!isAlreadyExists) {
//			System.out.println("name :" + groupbean.getGroup_name());
			LOG.info("------Name:----- "+groupbean.getGroup_name());
			groupbean.setCreated_by((String) sessionMap.get(GlobalConstants.LOGIN_ID));
			groupbean.setUpdated_by((String) sessionMap.get(GlobalConstants.LOGIN_ID));
			int res = testService.createGroup(groupbean);
			groupID = res;
//			System.out.println("groupID" + res);
			LOG.info("------groupID:----- "+res);
		} else {
			ErrorMessages er = new ErrorMessages();
			er.setErrorMsg("Group already exists!!");
			errorMessagesList.add(er);
		}
		LOG.info("GroupAction---- execute()-- add group section--- end");
		return "success";
	}

	public String getAllGroupsInfo() throws Exception {
		groupList = testService.getAllGroupsInfo();
		sessionMap.put("groupList", groupList);
		return "success";
	}

	public String addSelectedQuestionsToGroup() {
		LOG.info("GroupAction---- addSelectedQuestionsToGroup--- start");
		try {
			List<QuestionsGroupBO> quGinfo = testService.getAllAddedQuestionsOfGroup();
			boolean isAlreadyExists = false;
			for (QuestionsGroupBO qg : quGinfo) {
				for (String que_ID : selectedQuestionIDs) {
					if (qg.getGroup_id() == selectedGroupID && qg.getQuestion_id() == Integer.parseInt(que_ID)) {
						isAlreadyExists = true;
						break;
					}
				}
			}
			if (!isAlreadyExists) {
				testService.addSelectedQuestionsToGroup(selectedGroupID, selectedQuestionIDs);
			} else {
				errorMessagesList.clear();
				ErrorMessages er = new ErrorMessages();
				er.setErrorMsg("Question already added!!");
				errorMessagesList.add(er);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		LOG.info("GroupAction---- addSelectedQuestionsToGroup--- end");
		return "success";
	}

	public String allAddedQuestionsOfSelectedGroup() throws Exception {
		LOG.info("GroupAction---- allAddedQuestionsOfSelectedGroup--- start");
		groupQuestionInfo = testService.getDetailsForSelectedGroup(selectedGId);
		totalQuestionsAddedForSelectGroup = groupQuestionInfo.size(); 
		LOG.info("GroupAction---- allAddedQuestionsOfSelectedGroup--- end");
		return "success";
	}
	
	public String deleteSelectedGroup() throws Exception{
		testService.deleteSelectedGroup(selectedGroupID);
		return "success";
	}
//	
//	public String removeSelectedQuestionFromGroup() throws Exception{
//		testService.removeSelectedQuestionFromGroup(selectedGroupID,questionId);
//		return "success";
//	}
//	
//	public String showUpdateGroupPage() {
//		return "success";
//	}
//	
//	public String getNotAddedQuestions() throws Exception {
//		questionInfo = testService.getNotAddedQuestions(addedQuestionIDs);
//		return "success";
//	}

	
}
