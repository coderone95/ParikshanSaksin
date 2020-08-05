package com.codesvila.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.codesvila.bean.GroupBO;
import com.codesvila.bean.GroupsTestInfoBO;
import com.codesvila.bean.QuestionBO;
import com.codesvila.bean.QuestionsGroupBO;
import com.codesvila.bean.TestBO;
import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.dao.TestDAO;
import com.codesvila.model.Group;
import com.codesvila.model.GroupsTest;
import com.codesvila.model.Options;
import com.codesvila.model.Question;
import com.codesvila.model.Test;
import com.codesvila.utils.DateUtils;

@Service("testService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true) 
public class TestServiceImpl implements TestService{
	
	@Autowired
	private TestDAO testDao;
	

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)  
	public int saveQuestion(Question question) {
		// TODO Auto-generated method stub
		int id = testDao.saveQuestion(question);
		return id;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public int saveOption(Options options) {
		// TODO Auto-generated method stub
		int id = testDao.saveOptions(options);
		return id;
	}

	@Override
	public void deleteQuestion(Integer questionId) {
		// TODO Auto-generated method stub
		try {
			testDao.deleteQuestion(questionId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List<QuestionInfoBO> getQuestionAndAnswer(String questionId) {
		List<QuestionInfoBO> quetionOptionsInfo = new ArrayList<QuestionInfoBO>();
		try {
			quetionOptionsInfo = testDao.getQuestionAndAnswer(Integer.parseInt(questionId));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return quetionOptionsInfo;
	}

	@Override
	public List<QuestionInfoBO> getOptionsForQuestion(String questionId) {
		List<QuestionInfoBO> optionList = new ArrayList<QuestionInfoBO>();
		try {
			optionList = testDao.getOptionsForQuestion(Integer.parseInt(questionId));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return optionList;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)  
	public Integer updateQuestionDetails(String selelctedQuestionID, String loginID,String questionValue, String [] selectedCorrectOptions,
			Map<String, String> optionMap, String questionType) throws NumberFormatException, Exception {
		// TODO Auto-generated method stub
		
		Integer res = testDao.updateQuestionDetails(Integer.parseInt(selelctedQuestionID), loginID, questionValue,
				selectedCorrectOptions,optionMap,questionType);
		return res;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)  
	public int createGroup(GroupBO groupbean) {
		Group group = new Group();
		group.setGroup_name(groupbean.getGroup_name());
		group.setCreated_by(groupbean.getCreated_by());
		group.setUpdated_by(groupbean.getUpdated_by());
		group.setCreated_on(DateUtils.getCurrentDate());
		group.setUpdated_on(DateUtils.getCurrentDate());
		int res = testDao.createGroup(group);
		return res;
	}

	@Override
	public List<GroupBO> getAllGroupsInfo() throws Exception {
		// TODO Auto-generated method stub
		return testDao.getAllGroupsInfo();
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)  
	public void addSelectedQuestionsToGroup(Integer selectedGroupID, List<String> selectedQuestionIDs) {
		// TODO Auto-generated method stub
		for(String id : selectedQuestionIDs) {
			QuestionsGroupBO questionsGroupBean = new QuestionsGroupBO();
			questionsGroupBean.setGroup_id(selectedGroupID);
			questionsGroupBean.setQuestion_id(Integer.parseInt(id));
			testDao.addSelectedQuestionsToGroup(questionsGroupBean);
		}
	}

	@Override
	public List<QuestionsGroupBO> getAllAddedQuestionsOfGroup() throws Exception{
		// TODO Auto-generated method stub
		return testDao.getAllAddedQuestionsOfGroup();
	}

	@Override
	public List<QuestionsGroupBO> getDetailsForSelectedGroup(String selectedGId) throws Exception {
		// TODO Auto-generated method stub
		return testDao.getDetailsForSelectedGroup(selectedGId);
	}


	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false) 
	public void deleteSelectedGroup(Integer selectedGroupID) throws Exception {
		// TODO Auto-generated method stub
		testDao.deleteSelectedGroup(selectedGroupID);
	}

	@Override
	public void removeSelectedQuestionFromGroup(Integer selectedGroupID, Integer questionId) throws Exception {
		// TODO Auto-generated method stub
		testDao.removeSelectedQuestionFromGroup(selectedGroupID,questionId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public void updateGroup(Integer selectedGroupID, String loginId, String groupName) {
		// TODO Auto-generated method stub
		Group group = new Group();
		group.setGroup_name(groupName);
		group.setUpdated_by(loginId);
		group.setUpdated_on(DateUtils.getCurrentDate());
		testDao.updateGroup(group,selectedGroupID);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false) 
	public int createTest(String loginId,String testName, String testkey, String accessKey, List<Integer> groupIDs,
			String testInstructionsHtmlCode, Date expiresOn, Integer testTime) {
		Integer res = 1;
		Test tbo = new Test();
		tbo.setTest_name(testName);
		tbo.setTest_key(testkey);
		tbo.setAccess_key(accessKey);
		tbo.setTest_instructions(testInstructionsHtmlCode);
		tbo.setCreated_by(loginId);
		tbo.setUpdated_by(loginId);
		tbo.setCreated_on(DateUtils.getCurrentDate());
		tbo.setUpdated_on(DateUtils.getCurrentDate());
		tbo.setIs_live(1);
		tbo.setTest_time(testTime);
		int testID = testDao.createTest(tbo);
		if(testID > 0) {
			for(Integer groupId: groupIDs) {
				GroupsTest gt = new GroupsTest();
				gt.setTest_id(testID);
				gt.setGroup_id(groupId);
				int i = testDao.addGroupsToTest(gt);
				if(i < 1 || i == 0) {
					res = 0;
					break;
				}
			}
		}else {
			res = 0;
		}
		return res;
	}

	@Override
	public List<TestBO> getAllTests() throws Exception {
		// TODO Auto-generated method stub
		return testDao.getAllTests();
	}

	@Override
	public void deleteTest(Integer testID) throws Exception{
		// TODO Auto-generated method stub
		try {
			testDao.deleteTest(testID);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List<TestBO> getTestInfoForSelectedID(Integer testID) throws Exception{
		// TODO Auto-generated method stub
		return testDao.getTestInfoForSelectedID(testID);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false) 
	public Integer updateTest(String loginID, Integer testID, String testName, String testKey, String testAccessKey,
			String testInstructions, Date expiresOn, Integer testTime) {
		// TODO Auto-generated method stub
		Test tbo = new Test();
		tbo.setTest_name(testName);
		tbo.setTest_key(testKey);
		tbo.setAccess_key(testAccessKey);
		tbo.setTest_instructions(testInstructions);
		tbo.setUpdated_by(loginID);
		tbo.setUpdated_on(DateUtils.getCurrentDate());
		tbo.setIs_live(1);
		tbo.setTest_time(testTime);
		return testDao.updateTest(tbo, testID);
	}

	@Override
	public List<GroupsTestInfoBO> getAddedGroupsForSelectedTest(Integer testID) throws Exception{
		// TODO Auto-generated method stub
		return testDao.getAddedGroupsForSelectedTest(testID);
	}

	@Override
	public List<GroupsTestInfoBO> getAvailableGroupsForSelectedTest(Integer testID) throws Exception {
		// TODO Auto-generated method stub
		return testDao.getAvailableGroupsForSelectedTest(testID);
	}

	@Override
	public List<GroupsTestInfoBO> getAddedQuestionsForSelectedGroup(Integer selectedGroupID) throws Exception {
		// TODO Auto-generated method stub
		return testDao.getAddedQuestionsForSelectedGroup(selectedGroupID);
	}

	@Override
	public List<GroupsTestInfoBO> getAvailableQuestionsForSelectedGroup(Integer selectedGroupID) throws Exception {
		// TODO Auto-generated method stub
		return testDao.getAvailableQuestionsForSelectedGroup(selectedGroupID);
	}

	@Override
	public int removeSelectedGroupFromSelectedTest(Integer testID, Integer groupId) throws Exception {
		// TODO Auto-generated method stub
		return testDao.removeSelectedGroupFromSelectedTest(testID,groupId);
	}

	@Override
	public Integer addSelectedGroupsToTest(List<Integer> groupIDs, Integer testID) throws Exception {
		// TODO Auto-generated method stub
		Integer result = 1;
		try{
			if(groupIDs.size() > 0 && !groupIDs.isEmpty()) {
				for(Integer groupID: groupIDs) {
					int i= testDao.addSelectedGroupsToTest(groupID,testID);
					if(i < 1) {
						return 0;
					}
				}
				result = 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
			result = 0;
		}
		
		return result;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false) 
	public int createTest(String loginID, String testName, String testkey, String accessKey, List<Integer> groupIDs,
			String testInstructionsHtmlCode, Date startOn, Date endOn, Integer examTime,
			Integer passingCriteria) {
		Integer res = 1;
		Test tbo = new Test();
		tbo.setTest_name(testName);
		tbo.setTest_key(testkey);
		tbo.setAccess_key(accessKey);
		tbo.setTest_instructions(testInstructionsHtmlCode);
		tbo.setCreated_by(loginID);
		tbo.setUpdated_by(loginID);
		tbo.setCreated_on(DateUtils.getCurrentDate());
		tbo.setUpdated_on(DateUtils.getCurrentDate());
		tbo.setIs_live(1);
		tbo.setStartOn(startOn);
		tbo.setEndOn(endOn);
		tbo.setPassingCriteria(passingCriteria);
		tbo.setTest_time(examTime);
		int testID = testDao.createTest(tbo);
		if(testID > 0) {
			for(Integer groupId: groupIDs) {
				GroupsTest gt = new GroupsTest();
				gt.setTest_id(testID);
				gt.setGroup_id(groupId);
				int i = testDao.addGroupsToTest(gt);
				if(i < 1 || i == 0) {
					res = 0;
					break;
				}
			}
		}else {
			res = 0;
		}
		return res;
	}

	@Override
	public Integer updateTest(String loginID, Integer testID, String testName, String testKey, String testAccessKey,
			String testInstructions, Date startOn, Date endOn, Integer examTime,
			Integer passingCriteria) {
		// TODO Auto-generated method stub
		Test tbo = new Test();
		tbo.setTest_name(testName);
		tbo.setTest_key(testKey);
		tbo.setAccess_key(testAccessKey);
		tbo.setTest_instructions(testInstructions);
		tbo.setUpdated_by(loginID);
		tbo.setUpdated_on(DateUtils.getCurrentDate());
		tbo.setIs_live(1);
		tbo.setStartOn(startOn);
		tbo.setEndOn(endOn);
		tbo.setPassingCriteria(passingCriteria);
		tbo.setTest_time(examTime);
		return testDao.updateTest(tbo, testID);
	}

	@Override
	public List<QuestionBO> getAddedQuestionsForSelectTest(Integer testID) throws Exception {
		// TODO Auto-generated method stub
		
		return testDao.getAddedQuestionsForSelectTest(testID);
	}

}
