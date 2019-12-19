package com.codesvila.bean;

public class GroupBO {
	
	private int group_id;
	private String group_name;
	private String created_on;
	private String created_by;
	private String updated_on;
	private String updated_by;
	private int numberOfQuestionsCount;
	public int getGroup_id() {
		return group_id;
	}
	public void setGroup_id(int group_id) {
		this.group_id = group_id;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getCreated_on() {
		return created_on;
	}
	public void setCreated_on(String created_on) {
		this.created_on = created_on;
	}
	public String getCreated_by() {
		return created_by;
	}
	public void setCreated_by(String created_by) {
		this.created_by = created_by;
	}
	public String getUpdated_on() {
		return updated_on;
	}
	public void setUpdated_on(String updated_on) {
		this.updated_on = updated_on;
	}
	public String getUpdated_by() {
		return updated_by;
	}
	public void setUpdated_by(String updated_by) {
		this.updated_by = updated_by;
	}
	public int getNumberOfQuestionsCount() {
		return numberOfQuestionsCount;
	}
	public void setNumberOfQuestionsCount(int numberOfQuestionsCount) {
		this.numberOfQuestionsCount = numberOfQuestionsCount;
	}
	

}
