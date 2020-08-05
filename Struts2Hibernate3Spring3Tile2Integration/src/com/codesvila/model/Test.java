package com.codesvila.model;
import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="tbl_tests")
public class Test implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id  
	@GeneratedValue(strategy=GenerationType.AUTO)  
	@Column(name = "test_id", nullable = false)
	private int test_id;
	
	@Column(name = "test_name", nullable = false)
	private String test_name;
	
	@Column(name = "org_id")
	private int org_id;
	
	@Column(name = "access_key")
	private String access_key;
	
	@Column(name = "test_key")
	private String test_key;
	
	@Column(name = "is_live")
	private int is_live;
	
	@Column(name = "is_disabled")
	private int is_disabled;
	
	@Column(name = "test_instructions")
	private String test_instructions;
	
	@Column(name = "created_on")
	private Date created_on;
	
	@Column(name = "updated_on")
	private Date updated_on;
	
	@Column(name = "created_by")
	private String created_by;
	
	@Column(name = "updated_by")
	private String updated_by;
	
	@Column(name = "startOn")
	private Date startOn;
	
	@Column(name = "endOn")
	private Date endOn;
	
	@Column(name = "passingCriteria")
	private int passingCriteria;
	
	@Column(name = "test_time")
	private int test_time;
	
	@Column(name = "show_results_after_submit")
	private int showResultsAfterSubmit;
	
	@Column(name = "is_failure_session_allowed")
	private int isFailureSessionAllowed;
	
	@Column(name = "max_failure_session_allowed")
	private Integer maxFailureSessionAllowed;

	public int getTest_id() {
		return test_id;
	}

	public void setTest_id(int test_id) {
		this.test_id = test_id;
	}

	public String getTest_name() {
		return test_name;
	}

	public void setTest_name(String test_name) {
		this.test_name = test_name;
	}

	public int getOrg_id() {
		return org_id;
	}

	public void setOrg_id(int org_id) {
		this.org_id = org_id;
	}

	public String getTest_instructions() {
		return test_instructions;
	}

	public void setTest_instructions(String test_instructions) {
		this.test_instructions = test_instructions;
	}

	public Date getCreated_on() {
		return created_on;
	}

	public void setCreated_on(Date created_on) {
		this.created_on = created_on;
	}

	public Date getUpdated_on() {
		return updated_on;
	}

	public void setUpdated_on(Date updated_on) {
		this.updated_on = updated_on;
	}

	public String getCreated_by() {
		return created_by;
	}

	public void setCreated_by(String created_by) {
		this.created_by = created_by;
	}

	public String getUpdated_by() {
		return updated_by;
	}

	public void setUpdated_by(String updated_by) {
		this.updated_by = updated_by;
	}

	public String getAccess_key() {
		return access_key;
	}

	public void setAccess_key(String access_key) {
		this.access_key = access_key;
	}

	public String getTest_key() {
		return test_key;
	}

	public void setTest_key(String test_key) {
		this.test_key = test_key;
	}

	public int getIs_live() {
		return is_live;
	}

	public void setIs_live(int is_live) {
		this.is_live = is_live;
	}

	public int getIs_disabled() {
		return is_disabled;
	}

	public void setIs_disabled(int is_disabled) {
		this.is_disabled = is_disabled;
	}

	public int getTest_time() {
		return test_time;
	}

	public void setTest_time(int test_time) {
		this.test_time = test_time;
	}

	public Date getStartOn() {
		return startOn;
	}

	public void setStartOn(Date startOn) {
		this.startOn = startOn;
	}

	public Date getEndOn() {
		return endOn;
	}

	public void setEndOn(Date endOn) {
		this.endOn = endOn;
	}

	public int getPassingCriteria() {
		return passingCriteria;
	}

	public void setPassingCriteria(int passingCriteria) {
		this.passingCriteria = passingCriteria;
	}

	public int getShowResultsAfterSubmit() {
		return showResultsAfterSubmit;
	}

	public void setShowResultsAfterSubmit(int showResultsAfterSubmit) {
		this.showResultsAfterSubmit = showResultsAfterSubmit;
	}

	public int getIsFailureSessionAllowed() {
		return isFailureSessionAllowed;
	}

	public void setIsFailureSessionAllowed(int isFailureSessionAllowed) {
		this.isFailureSessionAllowed = isFailureSessionAllowed;
	}

	public Integer getMaxFailureSessionAllowed() {
		return maxFailureSessionAllowed;
	}

	public void setMaxFailureSessionAllowed(Integer maxFailureSessionAllowed) {
		this.maxFailureSessionAllowed = maxFailureSessionAllowed;
	}
	
	
}
