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

	public String show() {
		loginId = (String) sessionMap.get(GlobalConstants.LOGIN_ID);
		return "success";
	}
	
	public String addQuestion() throws Exception {
		if(!validateInput()) {
			errorMsg = "Question is mandatory";
			return "success";
		}
		LOG.info("option 1 : : " + myoptions.get("" + correctOption));
		boolean isAlreadyExists = false;
		questionInfo = ApacheCommonsDBCP.DBCPDataSource("GET_ALL_QUESTIONS", null, false, null,null);
		if (questionInfo != null) {
			for (QuestionInfoBO q : questionInfo) {
				if (q.getQuestion().equalsIgnoreCase(question)) {
					isAlreadyExists = true;
					break;
				}
			}
		}
		if (!isAlreadyExists) {
			QuestionBO qbo = createTestBO();
			int generatedID = testService.saveQuestion(CommonUtility.createQuestionModel(qbo));
			LOG.info("generatedID : " + generatedID);
			if (generatedID > 0) {
				boolean isAdded = addOption(generatedID);
				if (isAdded) {
					SuccessMessages sm = new SuccessMessages();
					sm.setSuccessMsg("Question added successfully!!");
					successMessageList.add(sm);
				} else {
					errorMsg = "Error while adding the question";
				}
			}
		} else {
			errorMsg = "Question already exists!";
		}

		return "success";
	}

	public QuestionBO createTestBO() {
		QuestionBO qu = new QuestionBO();
		qu.setQuestion(question);
		qu.setCreated_by((String) sessionMap.get(GlobalConstants.LOGIN_ID));
		qu.setUpdated_by((String) sessionMap.get(GlobalConstants.LOGIN_ID));
		return qu;
	}

	public boolean addOption(int questionID) {
		// LOG.info("We are in addOptions");
		boolean isAdded = false;
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
		return isAdded;
	}

	@SuppressWarnings("unchecked")
	public String getAllQuestions() throws Exception {
		questionInfo = ApacheCommonsDBCP.DBCPDataSource("GET_ALL_QUESTIONS", null, false, null,null);

		return "success";
	}

	public String deleteQuestion() {
		if (queID != null) {
			testService.deleteQuestion(Integer.parseInt(queID));
		} else {
			re.setMessage("Unable to delete");
			re.setStatus(403);
		}

		return "success";
	}

	@SuppressWarnings("unchecked")
	public String getQuestionDetails() throws Exception {
		List<QuestionInfoBO> questionAnswerInfo = new ArrayList<QuestionInfoBO>();
		List<QuestionInfoBO> optionsList = new ArrayList<QuestionInfoBO>();
		List<String> options = new ArrayList<String>();
		
		if (quesID != null) {
			questionAnswerInfo = testService.getQuestionAndAnswer(quesID);
			for (QuestionInfoBO qi : questionAnswerInfo) {
				questionDetail.setQuestion(qi.getQuestion());
				questionDetail.setAnswer(qi.getAnswer());
			}

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

		} else {
			re.setMessage("Unable to fetch question details");
			re.setStatus(403);
		}

		return "success";
	}
	
	public String updateQuestionDetails()  throws Exception{
		Integer res = testService.updateQuestionDetails(selelctedQuestionID,(String) sessionMap.get(GlobalConstants.LOGIN_ID), questionValue,selectedCorrectOption,optionMap);
		return "success";
	}
	
	public boolean validateInput() {
		if(question == null || !StringUtils.isNotBlank(question)) {
			return false;
		}
		return true;
	}
}
