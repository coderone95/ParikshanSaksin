package com.codesvila.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="tbl_user_answered")
public class UserAnswersDetails implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id  
	@GeneratedValue(strategy=GenerationType.AUTO)  
	@Column(name = "id", nullable = false)
	private Integer id;
	
	@Column(name = "test_answered_context_id")
	private Integer testAnswerContextId;
	
	@Column(name = "question_id")
	private Integer questionId;
	
	@Column(name = "answer_id")
	private Integer answerId;

	/**
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @return the testAnswerContextId
	 */
	public Integer getTestAnswerContextId() {
		return testAnswerContextId;
	}

	/**
	 * @param testAnswerContextId the testAnswerContextId to set
	 */
	public void setTestAnswerContextId(Integer testAnswerContextId) {
		this.testAnswerContextId = testAnswerContextId;
	}

	/**
	 * @return the questionId
	 */
	public Integer getQuestionId() {
		return questionId;
	}

	/**
	 * @param questionId the questionId to set
	 */
	public void setQuestionId(Integer questionId) {
		this.questionId = questionId;
	}

	/**
	 * @return the answerId
	 */
	public Integer getAnswerId() {
		return answerId;
	}

	/**
	 * @param answerId the answerId to set
	 */
	public void setAnswerId(Integer answerId) {
		this.answerId = answerId;
	}
	
}
