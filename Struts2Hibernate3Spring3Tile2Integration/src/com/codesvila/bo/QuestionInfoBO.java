package com.codesvila.bo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class QuestionInfoBO {
	
	private int question_id;
	
	private String question;
	
	private String answer;
	
	private String question_createdBy;
	
	private String question_updatedBy;
	
	private String question_createdOn;
	
	private String question_updatedOn;
	
	private String option;
	
	private int optionId;
	
	private List<String> options = new ArrayList<String>();
	
	private Map<Integer,String> optionsMap = new HashMap<Integer,String>();

	public int getQuestion_id() {
		return question_id;
	}

	public void setQuestion_id(int question_id) {
		this.question_id = question_id;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getQuestion_createdBy() {
		return question_createdBy;
	}

	public void setQuestion_createdBy(String question_createdBy) {
		this.question_createdBy = question_createdBy;
	}

	public String getQuestion_updatedBy() {
		return question_updatedBy;
	}

	public void setQuestion_updatedBy(String question_updatedBy) {
		this.question_updatedBy = question_updatedBy;
	}

	public String getQuestion_createdOn() {
		return question_createdOn;
	}

	public void setQuestion_createdOn(String question_createdOn) {
		this.question_createdOn = question_createdOn;
	}

	public String getQuestion_updatedOn() {
		return question_updatedOn;
	}

	public void setQuestion_updatedOn(String question_updatedOn) {
		this.question_updatedOn = question_updatedOn;
	}

	public List<String> getOptions() {
		return options;
	}

	public void setOptions(List<String> option) {
		this.options = option;
	}

	public String getOption() {
		return option;
	}

	public void setOption(String option) {
		this.option = option;
	}

	public int getOptionId() {
		return optionId;
	}

	public void setOptionId(int optionId) {
		this.optionId = optionId;
	}

	public Map<Integer, String> getOptionsMap() {
		return optionsMap;
	}

	public void setOptionsMap(Map<Integer, String> optionsMap) {
		this.optionsMap = optionsMap;
	}


}
