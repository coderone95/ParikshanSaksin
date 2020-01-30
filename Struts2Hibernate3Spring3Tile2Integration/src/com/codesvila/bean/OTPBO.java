package com.codesvila.bean;

public class OTPBO {
	private int id;
	private int user_id;
	private String otp;
	private String created_on;
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
	public String getCreated_on() {
		return created_on;
	}
	/**
	 * @param created_on the created_on to set
	 */
	public void setCreated_on(String created_on) {
		this.created_on = created_on;
	}
	
}
