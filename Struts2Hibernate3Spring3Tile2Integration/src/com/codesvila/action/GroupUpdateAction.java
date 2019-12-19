package com.codesvila.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.ErrorMessages;
import com.codesvila.bean.GroupBO;
import com.codesvila.bean.GroupsTestInfoBO;
import com.codesvila.bean.QuestionsGroupBO;
import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.service.TestService;
import com.codesvila.utils.GlobalConstants;

public class GroupUpdateAction extends BaseAction{
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
	private List<GroupsTestInfoBO> addedQuestionsList;
	private List<GroupsTestInfoBO> availableQuestionsList;

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
	
	public String removeSelectedQuestionFromGroup() throws Exception{
		testService.removeSelectedQuestionFromGroup(selectedGroupID,questionId);
		return "success";
	}
	
	public String showUpdateGroupPage() {
		return "success";
	}
	
	public List<GroupsTestInfoBO> getAddedQuestionsList() {
		return addedQuestionsList;
	}

	public void setAddedQuestionsList(List<GroupsTestInfoBO> addedQuestionsList) {
		this.addedQuestionsList = addedQuestionsList;
	}

	public List<GroupsTestInfoBO> getAvailableQuestionsList() {
		return availableQuestionsList;
	}

	public void setAvailableQuestionsList(List<GroupsTestInfoBO> availableQuestionsList) {
		this.availableQuestionsList = availableQuestionsList;
	}
	
	public String updateGroupInfo() {
		if(selectedGroupID !=null && groupName != null && StringUtils.isNotBlank(groupName)) {
			testService.updateGroup(selectedGroupID,(String) sessionMap.get(GlobalConstants.LOGIN_ID),groupName);
		}else {
			errorMessagesList.clear();
			ErrorMessages er = new ErrorMessages();
			er.setErrorMsg("Error while processing the update request!!");
			errorMessagesList.add(er);
		}
		return "success";
	}

	public String getAddedQuestionsForSelectedGroup()  throws Exception {
		addedQuestionsList = testService.getAddedQuestionsForSelectedGroup(selectedGroupID); 
		totalQuestionsAddedForSelectGroup = addedQuestionsList.size();
		return "success";
	}
	
	public String getAvailableQuestionsForSelectedGroup() throws Exception{
		availableQuestionsList = testService.getAvailableQuestionsForSelectedGroup(selectedGroupID);
		return "success";
	}
	
}
