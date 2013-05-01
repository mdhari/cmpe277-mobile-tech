package edu.sjsu.myinsurance.entities;

import java.io.Serializable;
import java.lang.String;
import javax.persistence.*;

/**
 * Entity implementation class for Entity: Vehicles
 *
 */
@Entity
@Table(name="vehicles")
public class Vehicles implements Serializable {

	   
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="idvehicles")
	private int id;
	private String make;
	private String model;
	private int year;
	private String vin;
	private static final long serialVersionUID = 1L;
	private int policy_number;

	public Vehicles() {
		super();
	}   
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}   
	public String getMake() {
		return this.make;
	}

	public void setMake(String make) {
		this.make = make;
	}   
	public String getModel() {
		return this.model;
	}

	public void setModel(String model) {
		this.model = model;
	}   
	public int getYear() {
		return this.year;
	}

	public void setYear(int year) {
		this.year = year;
	}   
	public String getVin() {
		return this.vin;
	}

	public void setVin(String vin) {
		this.vin = vin;
	}
	public int getPolicy_number() {
		return policy_number;
	}
	public void setPolicy_number(int policy_number) {
		this.policy_number = policy_number;
	}   
	
   
}
