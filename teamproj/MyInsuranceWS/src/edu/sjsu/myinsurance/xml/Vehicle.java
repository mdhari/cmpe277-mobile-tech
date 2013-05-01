package edu.sjsu.myinsurance.xml;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="vehicle")
public class Vehicle {
	
	public String getMake() {
		return make;
	}
	public void setMake(String make) {
		this.make = make;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public String getVin() {
		return vin;
	}
	public void setVin(String vin) {
		this.vin = vin;
	}
	private String make;
	private String model;
	private int year;
	private String vin;
	
	public Vehicle(){}
}
