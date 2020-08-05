package com.codesvila.action;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.service.CandidateService;

public class TestSubmissionAction extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Autowired
	private CandidateService candidateService;
	private String jsonData;
	private Integer groupId;
	private Integer quesID;
	private String answerIDS;
	private String testContextId;
	private Integer testId;

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


	/**
	 * @return the testContextId
	 */
	public String getTestContextId() {
		return testContextId;
	}


	/**
	 * @param testContextId the testContextId to set
	 */
	public void setTestContextId(String testContextId) {
		this.testContextId = testContextId;
	}

	/**
	 * @return the jsonData
	 */
	public String getJsonData() {
		return jsonData;
	}


	/**
	 * @param jsonData the jsonData to set
	 */
	public void setJsonData(String jsonData) {
		this.jsonData = jsonData;
	}


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
	 * @return the quesID
	 */
	public Integer getQuesID() {
		return quesID;
	}


	/**
	 * @param quesID the quesID to set
	 */
	public void setQuesID(Integer quesID) {
		this.quesID = quesID;
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


	public String submitAnswer() {
		LOG.debug("TestSubmissionAction.submitAnswer()--- start");
		Map<String, Object> data = new HashMap<String, Object>();
//		HashMap<String, String> jsonData = new HashMap<String, String>();
//		String testId = null;
//		String groupId = null;
//		String quesID = null;
//		String answerIDS = null;
//		String testContextId = null;
		try {
//			jsonData = (HashMap<String, String>) com.googlecode.jsonplugin.JSONUtil.deserialize(this.jsonData);
//			if(jsonData !=null) {
//				testId = jsonData.get("testId");
//				groupId = jsonData.get("groupId");
//				quesID = jsonData.get("quesID");
//				answerIDS = jsonData.get("answerIDS");
//			}
			testContextId = (String) session.getAttribute("TEST_CONTEXT_ID");
			data.put("TEST_CONTEXT_ID", testContextId);
			LOG.info("Values:: TestID:\t "+testId+"\t groupId :"+groupId+"\t quesID :"+quesID+"\t contextid :"+testContextId);
			if(!StringUtils.isNotBlank(answerIDS) || answerIDS == null) {
				data.put("errorMsg","Please select answer");
			}else {
				if(testId == null || groupId == null || quesID == null || testContextId == null ) {
					throw new Exception("Missing testID or groupID or question ID");
				}else {
					int result = candidateService.submitAnswer(testId,groupId,quesID,answerIDS,testContextId);
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
		LOG.debug("TestSubmissionAction.submitAnswer()--- end");
		return writeJsonResponse(data);
	}
	
	public String populateSubmittedAnswer() {
		LOG.debug("TestSubmissionAction.submitAnswer()--- end");
		Map<String, Object> data = new HashMap<String, Object>();
		try {
			String contextID = (String) session.getAttribute("TEST_CONTEXT_ID");
			Map<String,String> answerData = candidateService.populateSubmittedAnswer(String.valueOf(testId),String.valueOf(groupId),String.valueOf(quesID),contextID);
			if(!answerData.isEmpty() && answerData != null) {
				data.put("ANSWER_IDS", answerData.get("ANSWER_IDS"));
			}
		}catch(Exception e) {
			LOG.error("Error while populatin the submitted answers", e);
		}
		
		LOG.debug("TestSubmissionAction.submitAnswer()--- end");
		return writeJsonResponse(data);
	}
}
