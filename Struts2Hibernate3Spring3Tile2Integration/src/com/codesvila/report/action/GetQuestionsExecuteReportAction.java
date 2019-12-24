package com.codesvila.report.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.service.ReportService;

public class GetQuestionsExecuteReportAction {
	
	@Autowired
	private ReportService reportService;
	
	
	private String startDate;
	private String endDate;
	private Integer questionId;
	private String createdBy;
	private String questionName;
	private List<QuestionInfoBO> questionInfo = new ArrayList<QuestionInfoBO>();
	
	/**
	 * @return the startDate
	 */
	public String getStartDate() {
		return startDate;
	}
	/**
	 * @param startDate the startDate to set
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}
	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
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
	 * @return the createdBy
	 */
	public String getCreatedBy() {
		return createdBy;
	}
	/**
	 * @param createdBy the createdBy to set
	 */
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	/**
	 * @return the questionName
	 */
	public String getQuestionName() {
		return questionName;
	}
	/**
	 * @param questionName the questionName to set
	 */
	public void setQuestionName(String questionName) {
		this.questionName = questionName;
	}
	
	/**
	 * @return the questionInfo
	 */
	public List<QuestionInfoBO> getQuestionInfo() {
		return questionInfo;
	}
	/**
	 * @param questionInfo the questionInfo to set
	 */
	public void setQuestionInfo(List<QuestionInfoBO> questionInfo) {
		this.questionInfo = questionInfo;
	}
	public String getQuestionReport() throws Exception{
		if(startDate != null && startDate != "" && StringUtils.isNotBlank(startDate)) {
			startDate = startDate+".000";
		}
		if(endDate != null && endDate != "" && StringUtils.isNotBlank(endDate)) {
			endDate = endDate+".000";
		}
		questionInfo = reportService.getQuestionReport(startDate,
				endDate,createdBy,questionName,questionId);
		
		return "success";
	}

}
