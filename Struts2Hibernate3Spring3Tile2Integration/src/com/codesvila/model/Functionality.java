package com.codesvila.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="tbl_functionalities")
public class Functionality implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id  
	@GeneratedValue(strategy=GenerationType.AUTO)  
	@Column(name = "functionality_id", nullable = false)
	private int functionality_id;
	
	@Column(name="user_id")
	private int user_id;
	
	@Column(name="user_type")
	private String user_type;
	
	@Column(name="functionality_name")
	private String functionality_name;
	
	@Column(name="functionality_code")
	private String functionality_code;
	/**
	 * @return the functionality_id
	 */
	public int getFunctionality_id() {
		return functionality_id;
	}
	/**
	 * @param functionality_id the functionality_id to set
	 */
	public void setFunctionality_id(int functionality_id) {
		this.functionality_id = functionality_id;
	}
	/**
	 * @return the user_id
	 */
	public int getUser_id() {
		return user_id;
	}
	/**
	 * @param user_id the user_id to set
	 */
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	/**
	 * @return the user_type
	 */
	public String getUser_type() {
		return user_type;
	}
	/**
	 * @param user_type the user_type to set
	 */
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	/**
	 * @return the functionality_name
	 */
	public String getFunctionality_name() {
		return functionality_name;
	}
	/**
	 * @param functionality_name the functionality_name to set
	 */
	public void setFunctionality_name(String functionality_name) {
		this.functionality_name = functionality_name;
	}
	/**
	 * @return the functionality_code
	 */
	public String getFunctionality_code() {
		return functionality_code;
	}
	/**
	 * @param functionality_code the functionality_code to set
	 */
	public void setFunctionality_code(String functionality_code) {
		this.functionality_code = functionality_code;
	}
}
