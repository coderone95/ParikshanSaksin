package com.codesvila.bean;

public class UserAnswersDetailsBO {
	private Integer id;
	private Integer testAnswerContextId;
	private Integer questionId;
	private String answerId;
	private Integer test_id;
	private Integer group_id;
	private Integer isCorrectAnswer;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getTestAnswerContextId() {
		return testAnswerContextId;
	}
	public void setTestAnswerContextId(Integer testAnswerContextId) {
		this.testAnswerContextId = testAnswerContextId;
	}
	public Integer getQuestionId() {
		return questionId;
	}
	public void setQuestionId(Integer questionId) {
		this.questionId = questionId;
	}
	public String getAnswerId() {
		return answerId;
	}
	public void setAnswerId(String answerId) {
		this.answerId = answerId;
	}
	public Integer getTest_id() {
		return test_id;
	}
	public void setTest_id(Integer test_id) {
		this.test_id = test_id;
	}
	public Integer getGroup_id() {
		return group_id;
	}
	public void setGroup_id(Integer group_id) {
		this.group_id = group_id;
	}
	/**
	 * @return the isCorrectAnswer
	 */
	public Integer getIsCorrectAnswer() {
		return isCorrectAnswer;
	}
	/**
	 * @param isCorrectAnswer the isCorrectAnswer to set
	 */
	public void setIsCorrectAnswer(Integer isCorrectAnswer) {
		this.isCorrectAnswer = isCorrectAnswer;
	}
	
}
