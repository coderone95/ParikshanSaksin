package com.codesvila.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.codesvila.bean.GroupBO;
import com.codesvila.bean.GroupsTestInfoBO;
import com.codesvila.bean.QuestionBO;
import com.codesvila.bean.QuestionsGroupBO;
import com.codesvila.bean.TestBO;
import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.model.Options;
import com.codesvila.model.Question;

public interface TestService {
	
	public int saveQuestion(Question question);

	public int saveOption(Options createOptionModel);
	
	public void deleteQuestion(Integer queID );

	public List<QuestionInfoBO> getOptionsForQuestion(String parseInt);

	public List<QuestionInfoBO> getQuestionAndAnswer(String quesID);

	public Integer updateQuestionDetails(String selelctedQuestionID, String loginId, String questionValue,
			String [] selectedCorrectOptions, Map<String, String> optionMap, String questionType) throws NumberFormatException, Exception;

	public int createGroup(GroupBO groupbean);

	public List<GroupBO> getAllGroupsInfo() throws Exception;

	public void addSelectedQuestionsToGroup(Integer selectedGroupID, List<String> selectedQuestionIDs);

	public List<QuestionsGroupBO> getAllAddedQuestionsOfGroup() throws Exception;

	public List<QuestionsGroupBO> getDetailsForSelectedGroup(String selectedGId) throws Exception;

	public void deleteSelectedGroup(Integer selectedGroupID) throws Exception;

	public void removeSelectedQuestionFromGroup(Integer selectedGroupID, Integer questionId) throws Exception;

	public void updateGroup(Integer selectedGroupID, String loginId, String groupName);

	public int createTest(String loginId,String testName, String testkey, String accessKey, List<Integer> groupIDs,
			String testInstructionsHtmlCode, Date expiresOn, Integer testTime);

	public List<TestBO> getAllTests() throws Exception;

	public void deleteTest(Integer testID) throws Exception;

	public List<TestBO> getTestInfoForSelectedID(Integer testID)throws Exception;

	public Integer updateTest(String loginID, Integer testID, String testName, String testKey, String testAccessKey,
			String testInstructions, Date formattedDate, Integer testTime);

	public List<GroupsTestInfoBO> getAddedGroupsForSelectedTest(Integer testID) throws Exception;

	public List<GroupsTestInfoBO> getAvailableGroupsForSelectedTest(Integer testID) throws Exception;

	public List<GroupsTestInfoBO> getAddedQuestionsForSelectedGroup(Integer selectedGroupID)  throws Exception ;

	public List<GroupsTestInfoBO> getAvailableQuestionsForSelectedGroup(Integer selectedGroupID) throws Exception;

	public int removeSelectedGroupFromSelectedTest(Integer testID, Integer groupId) throws Exception;

	public Integer addSelectedGroupsToTest(List<Integer> groupIDs, Integer testID) throws Exception;

	public int createTest(String loginID, String testName, String testkey, String accessKey, List<Integer> groupIDs,
			String testInstructionsHtmlCode, Date formattedDate, Date formattedDate2, Integer examTime,
			Integer passingCriteria);

	public Integer updateTest(String loginID, Integer testID, String testName, String testKey, String testAccessKey,
			String testInstructions, Date formattedDate, Date formattedDate2, Integer examTime,
			Integer passingCriteria);

	public List<QuestionBO> getAddedQuestionsForSelectTest(Integer testID) throws Exception;


}
