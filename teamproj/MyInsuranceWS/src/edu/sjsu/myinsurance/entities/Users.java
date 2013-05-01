package edu.sjsu.myinsurance.entities;

import java.io.Serializable;
import java.lang.String;
import javax.persistence.*;

/**
 * Entity implementation class for Entity: Users
 *
 */
@Entity
@Table(name="users")
public class Users implements Serializable {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="idusers")
	private int id;
	private String username;
	private String password;
	private int policy_number;
	private static final long serialVersionUID = 1L;

	public Users() {
		super();
	}   
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}   
	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}   
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}   
	public int getPolicy_number() {
		return this.policy_number;
	}

	public void setPolicy_number(int policy_number) {
		this.policy_number = policy_number;
	}
	
   
}
