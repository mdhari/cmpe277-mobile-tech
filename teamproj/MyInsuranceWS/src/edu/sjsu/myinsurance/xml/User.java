package edu.sjsu.myinsurance.xml;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="user")
public class User {
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getPolicy_number() {
		return policy_number;
	}
	public void setPolicy_number(int policy_number) {
		this.policy_number = policy_number;
	}
	
	private int id;
	private String username;
	private String password;
	private int policy_number;
	
	public User(){}
}
