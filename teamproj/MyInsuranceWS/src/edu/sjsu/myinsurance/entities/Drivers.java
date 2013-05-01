package edu.sjsu.myinsurance.entities;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity implementation class for Entity: Drivers
 *
 */
@Entity
@Table(name="drivers")
public class Drivers implements Serializable {

	   
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="iddrivers")
	private int id;
	private String license_id;
	private String full_name;
	private String address1;
	private String address2;
	private String city;
	private String state;
	private int zipcode;
	@Temporal(TemporalType.DATE)
	@Column(name="date_of_birth")
	private Date dob;
	private int policy_number;

	private static final long serialVersionUID = 1L;

	public Drivers() {
		super();
	}   
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}   
	public String getLicense_id() {
		return this.license_id;
	}

	public void setLicense_id(String license_id) {
		this.license_id = license_id;
	}   
	public String getFull_name() {
		return this.full_name;
	}

	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}   
	public String getAddress1() {
		return this.address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}   
	public String getAddress2() {
		return this.address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}   
	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}   
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}   
	public int getZipcode() {
		return this.zipcode;
	}

	public void setZipcode(int zipcode) {
		this.zipcode = zipcode;
	}   
	public Date getDob() {
		return this.dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}
	public int getPolicy_number() {
		return policy_number;
	}
	public void setPolicy_number(int policy_number) {
		this.policy_number = policy_number;
	}
	
   
}
