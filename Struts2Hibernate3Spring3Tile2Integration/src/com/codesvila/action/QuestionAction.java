package com.codesvila.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.ErrorMessages;
import com.codesvila.bean.OptionsBO;
import com.codesvila.bean.QuestionBO;
import com.codesvila.bean.Response;
import com.codesvila.bean.SuccessMessages;
import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.service.TestService;
import com.codesvila.utils.CommonUtility;
import com.codesvila.utils.GlobalConstants;

public class QuestionAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6146832095949963985L;
	private String question;

	private List<String> optionList;

	private String correctOption;

	@Autowired
	private TestService testService;

	private Map<String, String> myoptions = new HashMap<String, String>();

	public List<ErrorMessages> errorMessagesList = new ArrayList<ErrorMessages>();

	public List<SuccessMessages> successMessageList = new ArrayList<SuccessMessages>();

	private List<QuestionInfoBO> questionInfo = new ArrayList<QuestionInfoBO>();

	private QuestionInfoBO questionDetail = new QuestionInfoBO();
	
	private Map<String,String> optionMap;

	private Response re = new Response();

	private String selectedQuestion;

	private String queID;

	private String quesID;
	
	private String selelctedQuestionID;
	
	private String selectedCorrectOption;
	
	private String questionValue;

	private String loginId;
	private String errorMsg = null;
	
	private String answerMode;
	
	private String questionType;
	private String groupId;
	/**
	 * @return the answerMode
	 */
	public String getAnswerMode() {
		return answerMode;
	}

	/**
	 * @param answerMode the answerMode to set
	 */
	public void setAnswerMode(String answerMode) {
		this.answerMode = answerMode;
	}

	public String getCorrectOption() {
		return correctOption;
	}

	public void setCorrectOption(String correctOption) {
		this.correctOption = correctOption;
	}

	public List<String> getOptionList() {
		return optionList;
	}

	public void setOptionList(List<String> optionList) {
		this.optionList = optionList;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String testsPage() {
		return "success";
	}

	public Map<String, String> getMyoptions() {
		return myoptions;
	}

	public void setMyoptions(Map<String, String> myoptions) {
		this.myoptions = myoptions;
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

	public List<QuestionInfoBO> getQuestionInfo() {
		return questionInfo;
	}

	public void setQuestionInfo(List<QuestionInfoBO> questionInfo) {
		this.questionInfo = questionInfo;
	}

	public String getSelectedQuestion() {
		return selectedQuestion;
	}

	public void setSelectedQuestion(String selectedQuestion) {
		this.selectedQuestion = selectedQuestion;
	}

	public String getQueID() {
		return queID;
	}

	public void setQueID(String queID) {
		this.queID = queID;
	}

	public String getQuesID() {
		return quesID;
	}

	public void setQuesID(String quesID) {
		this.quesID = quesID;
	}

	public void setQuestionDetail(QuestionInfoBO questionDetail) {
		this.questionDetail = questionDetail;
	}

	public QuestionInfoBO getQuestionDetail() {
		return questionDetail;
	}

	public Response getRe() {
		return re;
	}

	public void setRe(Response re) {
		this.re = re;
	}

	public String getSelelctedQuestionID() {
		return selelctedQuestionID;
	}

	public void setSelelctedQuestionID(String selelctedQuestionID) {
		this.selelctedQuestionID = selelctedQuestionID;
	}

	public Map<String, String> getOptionMap() {
		return optionMap;
	}

	public void setOptionMap(Map<String, String> optionMap) {
		this.optionMap = optionMap;
	}

	public String getSelectedCorrectOption() {
		return selectedCorrectOption;
	}

	public void setSelectedCorrectOption(String selectedCorrectOption) {
		this.selectedCorrectOption = selectedCorrectOption;
	}

	public String getQuestionValue() {
		return questionValue;
	}

	public void setQuestionValue(String questionValue) {
		this.questionValue = questionValue;
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

	public String getQuestionType() {
		return questionType;
	}

	public void setQuestionType(String questionType) {
		this.questionType = questionType;
	}

	/**
	 * @return the groupId
	 */
	public String getGroupId() {
		return groupId;
	}

	/**
	 * @param groupId the groupId to set
	 */
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String show() {
		loginId = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
		return "success";
	}
	
	public String addQuestion() throws Exception {
		LOG.debug("QuestionAction.addQuestion() method --- start");
		Map<String,Object> data = new HashMap<String,Object>();
		try{
			if(!validateInput()) {
				errorMsg = "Question is mandatory";
				data.put("errorMsg",errorMsg);
				return writeJsonResponse(data);
			}
			LOG.info("option 1 : : " + myoptions.get("" + correctOption));
			boolean isAlreadyExists = false;
			List<QuestionInfoBO> questionInfo = ApacheCommonsDBCP.DBCPDataSource("GET_ALL_QUESTIONS", null, false, null,null);
			if (questionInfo != null) {
				for (QuestionInfoBO q : questionInfo) {
					if (q.getQuestion().equalsIgnoreCase(question) && q.getGroupId() == Integer.parseInt(groupId)) {
						isAlreadyExists = true;
						break;
					}
				}
			}
			if (!isAlreadyExists) {
				if(groupId != null) {
					QuestionBO qbo = createTestBO();
					int generatedID = testService.saveQuestion(CommonUtility.createQuestionModel(qbo));
					LOG.info("generatedID : " + generatedID);
					if (generatedID > 0) {
						boolean isAdded = addOption(generatedID,questionType);
						if (isAdded) {
							data.put("successMsg", "Question added successfully");
						} else {
							data.put("errorMsg","Error while adding the question");
						}
					}
				}else {
					data.put("errorMsg", "Please create group first!!");
				}
			} else {
				data.put("errorMsg","Question already exists!");
			}
		}catch(Exception e) {
			LOG.error("Error while adding the question");
		}
		LOG.debug("QuestionAction.addQuestion() method --- end");
		return writeJsonResponse(data);
	}

	public QuestionBO createTestBO() {
		QuestionBO qu = new QuestionBO();
		qu.setQuestion(question);
		qu.setGroupId(Integer.parseInt(groupId));
		qu.setQuestion_type(questionType);
		qu.setCreated_by((String) sessionMap.get(GlobalConstants.LOGIN_ID));
		qu.setUpdated_by((String) sessionMap.get(GlobalConstants.LOGIN_ID));
		return qu;
	}

	public boolean addOption(int questionID,String queType) {
		// LOG.info("We are in addOptions");
		boolean isAdded = false;
		
		if(queType.equalsIgnoreCase("multi-select")) {
			int index = 0;
			String correctAns [] = correctOption.split(",");
			for (String option : optionList) {
				OptionsBO opBO = new OptionsBO();
				opBO.setQuestion_id(questionID);
				opBO.setOption_value(option);
				opBO.setCreated_by((String) sessionMap.get(GlobalConstants.LOGIN_ID));
				opBO.setUpdated_by((String) sessionMap.get(GlobalConstants.LOGIN_ID));
				if (isCorrectOption(option,correctAns)) {
					opBO.setIsCorrect(1);
				}
				LOG.info("opBO.setIsCorrect: " + opBO.getIsCorrect());
				int generatedID = testService.saveOption(CommonUtility.createOptionModel(opBO));
				LOG.info("Options id : " + generatedID);
				if (generatedID > 0) {
					LOG.info("Option " + option + " inserted");
					isAdded = true;
				}
			}
		}else {
			for (String option : optionList) {
				OptionsBO opBO = new OptionsBO();
				opBO.setQuestion_id(questionID);
				opBO.setOption_value(option);
				opBO.setCreated_by((String) sessionMap.get(GlobalConstants.LOGIN_ID));
				opBO.setUpdated_by((String) sessionMap.get(GlobalConstants.LOGIN_ID));
				if (correctOption != null && option.equals(myoptions.get("" + correctOption))) {
					opBO.setIsCorrect(1);
				}
				LOG.info("opBO.setIsCorrect: " + opBO.getIsCorrect());
				int generatedID = testService.saveOption(CommonUtility.createOptionModel(opBO));
				LOG.info("Options id : " + generatedID);
				if (generatedID > 0) {
					LOG.info("Option " + option + " inserted");
					isAdded = true;
				}
			}
		}
		return isAdded;
	}
	
	public boolean isCorrectOption(String option,String [] correctAns) {
		boolean isCorrectOption = false;
		for(String id : correctAns) {
			for(String key : myoptions.keySet()) {
				String opt = myoptions.get(key);
				if(option.equals(opt)) {
					if(id.equals(key)) {
						isCorrectOption = true;
						break;
					}
				}
			}
		}
		return isCorrectOption;
	} 

	@SuppressWarnings("unchecked")
	public String getAllQuestions() throws Exception {
		questionInfo = ApacheCommonsDBCP.DBCPDataSource("GET_ALL_QUESTIONS", null, false, null,null);

		return "success";
	}

	public String deleteQuestion() {
		LOG.debug("QuestinAction.deleteQuestion()---start");
		Map<String,Object> data = new HashMap<String,Object>();
		try {
			if (queID != null) {
				testService.deleteQuestion(Integer.parseInt(queID));
				data.put("successMsg", "Question deleted successfully!");
			} else {
				data.put("errorMsg", "Unable to delete. Something went wrong!!");
			}
		}catch(Exception e) {
			LOG.error("Error in deleteQuestion()", e);
		}
		
		LOG.debug("QuestinAction.deleteQuestion()---end");
		return writeJsonResponse(data);
	}

	@SuppressWarnings("unchecked")
	public String getQuestionDetails() throws Exception {
		LOG.debug("QuestinAction.getQuestionDetails()---start");
		List<QuestionInfoBO> questionAnswerInfo = new ArrayList<QuestionInfoBO>();
		List<QuestionInfoBO> optionsList = new ArrayList<QuestionInfoBO>();
		QuestionInfoBO questionDetail = new QuestionInfoBO();
		List<String> options = new ArrayList<String>();
		Map<String,Object> data = new HashMap<String,Object>();
		try {
			if (quesID != null) {
				questionAnswerInfo = testService.getQuestionAndAnswer(quesID);
				List<String> answerList = new ArrayList<String>();
				for (QuestionInfoBO qi : questionAnswerInfo) {
					questionDetail.setQuestion(qi.getQuestion());
					questionDetail.setQuestionType(qi.getQuestionType());
					answerList.add(qi.getAnswer());
				}
				//splitting the answers and putting delimiter - 'answer-delimiter'
				int count = 0;
				String newAnswerString = "";
				for(String answer : answerList) {
					if(answerList.size() == 1) {
						newAnswerString += answer;
					}else {
						if(count < answerList.size()-1) {
							newAnswerString += answer+"answer-delimiter";
							count++;
						}else {
							newAnswerString += answer;
							count++;
						}
					}
				}
				//questionDetail.setAnswer(answerList.toString().replace("[", "").replace("]", ""));
				questionDetail.setAnswer(newAnswerString);
				optionsList = testService.getOptionsForQuestion(quesID);
				Map<Integer,String> myOptionMap = new HashMap<Integer,String>();
				if (optionsList != null) {
					for (QuestionInfoBO qi : optionsList) {
						options.add(qi.getOption());
						myOptionMap.put(qi.getOptionId(), qi.getOption());
					}
					questionDetail.setOptions(options);
					questionDetail.setOptionsMap(myOptionMap);
				}
				data.put("questionDetail", questionDetail);
				data.put("questionDetail", questionDetail);
			} else {
				data.put("re", "Unable to fetch question details");
				data.put("re.status",403);
			}
		}catch(Exception e) {
			LOG.error("Error in getQuestionDetails()", e);
		}
		
		LOG.debug("QuestinAction.getQuestionDetails()---start");
		return writeJsonResponse(data);
	}
	
	public String updateQuestionDetails()  throws Exception{
		LOG.debug("QuestinAction.updateQuestionDetails()---start");
		Map<String,Object> data = new HashMap<String,Object>();
		try {
			String answerList [] = selectedCorrectOption.split(",");
			Integer res = testService.updateQuestionDetails(selelctedQuestionID,(String) sessionMap.get(GlobalConstants.LOGIN_ID), 
					questionValue,answerList,optionMap,questionType);
			if(res > 0) {
				data.put("successMsg", "Question updated successfully!!");
			}else {
				data.put("errorMsg", "Error while updating question!!");
			}
		}catch(Exception e) {
			LOG.error("Error in updateQuestionDetails()", e);
		}
		LOG.debug("QuestinAction.updateQuestionDetails()---end");
		return writeJsonResponse(data);
	}
	
	public boolean validateInput() {
		if(question == null || !StringUtils.isNotBlank(question)) {
			return false;
		}
		return true;
	}
}
