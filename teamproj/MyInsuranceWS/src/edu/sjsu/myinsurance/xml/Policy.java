package edu.sjsu.myinsurance.xml;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="policy")
public class Policy {
	
	DriverList driverList;
	VehicleList vehicleList;
	
	@XmlElement(name="drivers")
	public DriverList getDriverList() {
		return driverList;
	}
	public void setDriverList(DriverList driverList) {
		this.driverList = driverList;
	}
	@XmlElement(name="vehicles")
	public VehicleList getVehicleList() {
		return vehicleList;
	}
	public void setVehicleList(VehicleList vehicleList) {
		this.vehicleList = vehicleList;
	}
	
	

}
