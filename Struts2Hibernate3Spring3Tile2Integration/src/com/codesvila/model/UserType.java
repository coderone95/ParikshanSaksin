package com.codesvila.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="tbl_mst_user_type")
public class UserType implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id  
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="user_type_id",nullable = false)
	private int user_type_id;
	
	@Column(name="user_type",nullable = false)
	private String user_type;
	
	@Column(name="isManagment_User")
	private int isManagment_User;

	public int getUser_type_id() {
		return user_type_id;
	}

	public void setUser_type_id(int user_type_id) {
		this.user_type_id = user_type_id;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public int getIsManagment_User() {
		return isManagment_User;
	}

	public void setIsManagment_User(int isManagment_User) {
		this.isManagment_User = isManagment_User;
	}
	
}
