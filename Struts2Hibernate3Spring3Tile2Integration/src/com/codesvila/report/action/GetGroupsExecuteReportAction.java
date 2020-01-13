package com.codesvila.report.action;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.action.BaseAction;
import com.codesvila.bean.GroupBO;
import com.codesvila.service.ReportService;
import com.codesvila.utils.GlobalConstants;

public class GetGroupsExecuteReportAction extends BaseAction{
	
	@Autowired
	private ReportService reportService;
	
	private String startDate;
	private String endDate;
	private Integer groupId;
	private String createdBy;
	private String groupName;
	private List<GroupBO> groupList;
	private boolean hasGroupEditAccess;
	private boolean hasGroupDeleteAccess;
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
	 * @return the groupName
	 */
	public String getGroupName() {
		return groupName;
	}
	/**
	 * @param groupName the groupName to set
	 */
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	/**
	 * @return the groupList
	 */
	public List<GroupBO> getGroupList() {
		return groupList;
	}
	/**
	 * @param groupList the groupList to set
	 */
	public void setGroupList(List<GroupBO> groupList) {
		this.groupList = groupList;
	}
	
	/**
	 * @return the hasGroupEditAccess
	 */
	public boolean isHasGroupEditAccess() {
		return hasGroupEditAccess;
	}
	/**
	 * @param hasGroupEditAccess the hasGroupEditAccess to set
	 */
	public void setHasGroupEditAccess(boolean hasGroupEditAccess) {
		this.hasGroupEditAccess = hasGroupEditAccess;
	}
	/**
	 * @return the hasGroupDeleteAccess
	 */
	public boolean isHasGroupDeleteAccess() {
		return hasGroupDeleteAccess;
	}
	/**
	 * @param hasGroupDeleteAccess the hasGroupDeleteAccess to set
	 */
	public void setHasGroupDeleteAccess(boolean hasGroupDeleteAccess) {
		this.hasGroupDeleteAccess = hasGroupDeleteAccess;
	}
	public String getGroupReport() throws Exception{
//		if(startDate != null && startDate != "" && StringUtils.isNotBlank(startDate)) {
//			startDate = startDate+".000";
//		}
//		if(endDate != null && endDate != "" && StringUtils.isNotBlank(endDate)) {
//			endDate = endDate+".000";
//		}
		Map<String,Boolean> accessListMap = getAccessMap();
		hasGroupEditAccess = accessListMap.get(GlobalConstants.M_EDIT_GROUP);
		hasGroupDeleteAccess = accessListMap.get(GlobalConstants.M_DELETE_GROUP);
		groupList = reportService.getGroupReport(startDate,
				endDate,createdBy,groupName,groupId);
		
		return "success";
	}

}
