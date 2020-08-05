package com.codesvila.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.QuestionBO;
import com.codesvila.service.CandidateService;
import com.codesvila.utils.GlobalConstants;

public class AttendQuestionsAction extends BaseAction{

	private static final long serialVersionUID = 1L;
	
	@Autowired
	private CandidateService candidateService;
	
	private Integer groupId;
	private Integer testId;
	private String loginId;
	private String hasExamStarted;
	private String name;
	private List<Integer> questionIdList = new ArrayList<Integer>();
	private String quesID;
	private String optionId;
	private String answerIDS;
	
	/**
	 * @return the groupId
	 */
	public Integer getGroupId() {
		return groupId;
	}

	/**
	 * @param groupId the groupId to set
	 */
	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	/**
	 * @return the testId
	 */
	public Integer getTestId() {
		return testId;
	}

	/**
	 * @param testId the testId to set
	 */
	public void setTestId(Integer testId) {
		this.testId = testId;
	}

	/**
	 * @return the loginId
	 */
	public String getLoginId() {
		return loginId;
	}

	/**
	 * @param loginId the loginId to set
	 */
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	
	/**
	 * @return the hasExamStarted
	 */
	public String getHasExamStarted() {
		return hasExamStarted;
	}
	/**
	 * @param hasExamStarted the hasExamStarted to set
	 */
	public void setHasExamStarted(String hasExamStarted) {
		this.hasExamStarted = hasExamStarted;
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
	 * @return the questionIdList
	 */
	public List<Integer> getQuestionIdList() {
		return questionIdList;
	}

	/**
	 * @param questionIdList the questionIdList to set
	 */
	public void setQuestionIdList(List<Integer> questionIdList) {
		this.questionIdList = questionIdList;
	}

	/**
	 * @return the quesID
	 */
	public String getQuesID() {
		return quesID;
	}

	/**
	 * @param quesID the quesID to set
	 */
	public void setQuesID(String quesID) {
		this.quesID = quesID;
	}

	/**
	 * @return the optionId
	 */
	public String getOptionId() {
		return optionId;
	}

	/**
	 * @param optionId the optionId to set
	 */
	public void setOptionId(String optionId) {
		this.optionId = optionId;
	}

	/**
	 * @return the answerIDS
	 */
	public String getAnswerIDS() {
		return answerIDS;
	}

	/**
	 * @param answerIDS the answerIDS to set
	 */
	public void setAnswerIDS(String answerIDS) {
		this.answerIDS = answerIDS;
	}

	public String showQuestions() {
		setLoginId((String) sessionMap.get(GlobalConstants.LOGIN_ID));
		testId = (Integer) sessionMap.get("currentTestID");
//		hasExamStarted = (String) session.getAttribute("hasExamStarted");
		hasExamStarted = (String) sessionMap.get("hasExamStarted");
		return "success";
	}
	
	public String getQuestionIds() {
		Boolean randomQuestionsEnabled =false; 
		LOG.debug("AttendQuestionsAction : getQuestionIds - start");
		Map<String,Object> data = new HashMap<String,Object>();
		List<Integer> questionIdsSet = new ArrayList<Integer>(); 
		try {
			if( (groupId !=null && StringUtils.isNotBlank(Integer.toString(groupId) ))
				&& (testId !=null && StringUtils.isNotBlank(Integer.toString(testId)) )) {
				if(!randomQuestionsEnabled) {
					questionIdsSet = candidateService.getQuestionIds(groupId,testId);
					data.put("QUESTION_IDS", questionIdsSet);
				}
			}
		}catch(Exception e) {
			LOG.error("Error while populating the question ids", e);
		}
		LOG.debug("AttendQuestionsAction : getQuestionIds - end");
		return writeJsonResponse(data);
	}
	
	public String retrieveQustionWithOptions() {
		LOG.debug("AttendQuestionsAction : retrieveQustionWithOptions - start");
		Map<String,Object> data = new HashMap<String,Object>();
		try {
			if(quesID != null && !StringUtils.isEmpty(quesID)) {
				Map<String,Object> result = candidateService.retrieveQustionWithOptions(quesID);
				String question = (String) result.get("QUESTION");
				String questionType = (String) result.get("QUESTION_TYPE");
				List<String> options = (List<String>) result.get("OPTIONS");
				data.put("QUESTION", question);
				data.put("OPTIONS", options);
				data.put("QUESTION_TYPE", questionType);
			}
		}catch(Exception e) {
			LOG.error("Error while populating the question", e);
		}
		LOG.debug("AttendQuestionsAction : retrieveQustionWithOptions - end");
		return writeJsonResponse(data);
	}

	public String submitAnswer() {
		LOG.debug("AttendQuestionsAction.submitAnswer()--- start");
		Map<String, Object> data = new HashMap<String, Object>();
		String testContextId = null;
		try {
			testContextId = (String) session.getAttribute("TEST_CONTEXT_ID");
			if(!StringUtils.isNotBlank(answerIDS) || answerIDS == null) {
				data.put("errorMsg","Please select answer");
			}else {
				if(testId == null || groupId == null || quesID == null || testContextId == null ) {
					throw new Exception("Missing testID or groupID or question ID");
				}else {
					int result = candidateService.submitAnswer(testId,groupId,Integer.parseInt(quesID),answerIDS,testContextId);
					if(result > 0) {
						data.put("successMsg","Answer submitted!!");
					}else {
						data.put("errorMsg","Error while submitting the test");
					}
				}
			}
		}catch(Exception e) {
			LOG.error("Error while submitting the test", e);
		}
		LOG.debug("AttendQuestionsAction.submitAnswer()--- end");
		return writeJsonResponse(data);
	}

}
