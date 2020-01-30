package com.codesvila.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name="tbl_otp")
public class OTP implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id  
	@GeneratedValue(strategy=GenerationType.AUTO)  
	@Column(name = "id", nullable = false)
	private int id;
	
	@Column(name = "user_id", nullable = false)
	private int user_id;
	
	@Column(name = "otp")
	private String otp;
	
	@Column(name = "created_on")
	private Date created_on;
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
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
	 * @return the otp
	 */
	public String getOtp() {
		return otp;
	}
	/**
	 * @param otp the otp to set
	 */
	public void setOtp(String otp) {
		this.otp = otp;
	}
	/**
	 * @return the created_on
	 */
	public Date getCreated_on() {
		return created_on;
	}
	/**
	 * @param created_on the created_on to set
	 */
	public void setCreated_on(Date created_on) {
		this.created_on = created_on;
	}
	
}
