package com.codesvila.report.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.action.BaseAction;
import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.service.ReportService;
import com.codesvila.utils.GlobalConstants;

public class GetQuestionsExecuteReportAction extends BaseAction{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	@Autowired
	private ReportService reportService;
	
	
	private String startDate;
	private String endDate;
	private Integer questionId;
	private String createdBy;
	private String questionName;
	private List<QuestionInfoBO> questionInfo = new ArrayList<QuestionInfoBO>();
	private boolean hasQuestionEditAccess;
	private boolean hasQuestionDeleteAccess;
	private Integer groupId;
	
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
	/**
	 * @return the hasQuestionEditAccess
	 */
	public boolean isHasQuestionEditAccess() {
		return hasQuestionEditAccess;
	}
	/**
	 * @param hasQuestionEditAccess the hasQuestionEditAccess to set
	 */
	public void setHasQuestionEditAccess(boolean hasQuestionEditAccess) {
		this.hasQuestionEditAccess = hasQuestionEditAccess;
	}
	/**
	 * @return the hasQuestionDeleteAccess
	 */
	public boolean isHasQuestionDeleteAccess() {
		return hasQuestionDeleteAccess;
	}
	/**
	 * @param hasQuestionDeleteAccess the hasQuestionDeleteAccess to set
	 */
	public void setHasQuestionDeleteAccess(boolean hasQuestionDeleteAccess) {
		this.hasQuestionDeleteAccess = hasQuestionDeleteAccess;
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
	public String getQuestionReport() throws Exception{
		LOG.debug("GetQuestionReport.getQuestionReport()---start");
		Map<String,Object> data = new HashMap<String,Object>();
		try {
	//			if(startDate != null && startDate != "" && StringUtils.isNotBlank(startDate)) {
	//			startDate = startDate+".000";
	//		}
	//		if(endDate != null && endDate != "" && StringUtils.isNotBlank(endDate)) {
	//			endDate = endDate+".000";
	//		}
			Map<String,Boolean> accessListMap = getAccessMap();
			boolean hasQuestionEditAccess = accessListMap.get(GlobalConstants.M_EDIT_QUESTION);
			boolean hasQuestionDeleteAccess = accessListMap.get(GlobalConstants.M_DELETE_QUESTION);
			List<QuestionInfoBO> questionInfo = reportService.getQuestionReport(startDate,
					endDate,createdBy,questionName,questionId,groupId);
			data.put("QUESTION_REPORT", questionInfo);
			data.put("hasQuestionEditAccess", hasQuestionEditAccess);
			data.put("hasQuestionDeleteAccess", hasQuestionDeleteAccess);
			
		}catch(Exception e) {
			LOG.error("Error in getting que report", e);
		}
		
		LOG.debug("GetQuestionReport.getQuestionReport()---end");
		return writeJsonResponse(data);
	}

}
