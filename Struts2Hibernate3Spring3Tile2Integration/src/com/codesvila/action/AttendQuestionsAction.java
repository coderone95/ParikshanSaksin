package com.codesvila.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.service.CandidateService;

public class AttendQuestionsAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Autowired
	private CandidateService candidateService;
	
	public String showQuestions() {
		return "success";
	}
	
	

}
