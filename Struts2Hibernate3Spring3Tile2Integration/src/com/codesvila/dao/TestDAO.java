package com.codesvila.dao;

import java.util.List;
import java.util.Map;

import com.codesvila.bean.GroupBO;
import com.codesvila.bean.GroupsTestInfoBO;
import com.codesvila.bean.QuestionBO;
import com.codesvila.bean.QuestionsGroupBO;
import com.codesvila.bean.TestBO;
import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.model.Group;
import com.codesvila.model.GroupsTest;
import com.codesvila.model.Options;
import com.codesvila.model.Question;
import com.codesvila.model.Test;

public interface TestDAO {
	
	public int saveQuestion(Question question);

	public int saveOptions(Options options);

	public void deleteQuestion(Integer questionId) throws Exception;

	public List<QuestionInfoBO> getQuestionAndAnswer(Integer questionId) throws Exception;

	public List<QuestionInfoBO> getOptionsForQuestion(Integer questionId) throws Exception;

	public Integer updateQuestionDetails(int questionid, String loginId, String questionValue, int correctOptionId, Map<String, String> optionMap) throws Exception;

	public int createGroup(Group group);

	public List<GroupBO> getAllGroupsInfo() throws Exception;

	public void addSelectedQuestionsToGroup(QuestionsGroupBO questionsGroupBean);

	public List<QuestionsGroupBO> getAllAddedQuestionsOfGroup() throws Exception;

	public List<QuestionsGroupBO> getDetailsForSelectedGroup(String selectedGId)  throws Exception;

	public void deleteSelectedGroup(Integer selectedGroupID) throws Exception ;

	public void removeSelectedQuestionFromGroup(Integer selectedGroupID, Integer questionId) throws Exception ;

	public void updateGroup(Group group, Integer selectedGroupID);

	public int createTest(Test tbo);

	public int addGroupsToTest(GroupsTest gt);

	public List<TestBO> getAllTests() throws Exception;

	public void deleteTest(Integer testID) throws Exception;

	public List<TestBO> getTestInfoForSelectedID(Integer testID) throws Exception;

	public Integer updateTest(Test tbo, Integer testID);

	public List<GroupsTestInfoBO> getAddedGroupsForSelectedTest(Integer testID) throws Exception;

	public List<GroupsTestInfoBO> getAvailableGroupsForSelectedTest(Integer testID)  throws Exception;

	public List<GroupsTestInfoBO> getAddedQuestionsForSelectedGroup(Integer selectedGroupID) throws Exception;

	public List<GroupsTestInfoBO> getAvailableQuestionsForSelectedGroup(Integer selectedGroupID)  throws Exception;

	public int removeSelectedGroupFromSelectedTest(Integer testID, Integer groupId) throws Exception;

	public Integer addSelectedGroupsToTest(Integer groupID, Integer testID) throws Exception;

	public List<QuestionBO> getAddedQuestionsForSelectTest(Integer testID)  throws Exception;

}
