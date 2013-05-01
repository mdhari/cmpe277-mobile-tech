package edu.sjsu.myinsurance.rest;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import edu.sjsu.myinsurance.db.DatabaseUtil;
import edu.sjsu.myinsurance.entities.Drivers;
import edu.sjsu.myinsurance.entities.Users;
import edu.sjsu.myinsurance.entities.Vehicles;
import edu.sjsu.myinsurance.xml.Driver;
import edu.sjsu.myinsurance.xml.DriverList;
import edu.sjsu.myinsurance.xml.Policy;
import edu.sjsu.myinsurance.xml.User;
import edu.sjsu.myinsurance.xml.Vehicle;
import edu.sjsu.myinsurance.xml.VehicleList;

@Path("/rest")
public class MyInsuranceAPI {
	
	private SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");

	@GET
	@Produces({ MediaType.TEXT_PLAIN,MediaType.APPLICATION_XML })
	public String sayPlainTextHello() {
		return "Hello World!";
	}
	
	@SuppressWarnings("unchecked")
	@Path("/checkcredentials")
	@POST
	@Produces({ MediaType.APPLICATION_XML })
	public User checkCredentials(@QueryParam("username") String username,
			@QueryParam("password") String password){
		EntityManager em = DatabaseUtil.getEM();
		em.getTransaction().begin();
		Query query = em.createQuery("select x from Users x where x.username=\'"+username+"\' and x.password=\'"+password+"\'");
		User user = new User();
		List<Users> userList;
		
		if((userList=query.getResultList()).size()>0){
			user.setPolicy_number(userList.get(0).getPolicy_number());
			user.setUsername(userList.get(0).getUsername());
		}
		em.getTransaction().commit();
		em.close();
		System.out.println("===Check Credentials===");
		System.out.println("username: " + username + " password: " + password);
		System.out.println("===END Check Credentials===");
		
		return user;
	}
	
	@Path("/register")
	@POST
	public void addUser(@QueryParam("email") String email,
			@QueryParam("password") String password){

		int policyNumber = Math.abs((int)UUID.randomUUID().getLeastSignificantBits());
		System.out.println("====Register====");
		System.out.println("email: " + email);
		System.out.println("password: " + password);
		System.out.println("policyNumber: " + policyNumber);
		System.out.println("====END Register====");
		
		Users user = new Users();
		user.setUsername(email);
		user.setPassword(password);
		user.setPolicy_number(policyNumber);
		
		DatabaseUtil.commitObject(user);
		
	}
	
	@Path("/vehicle")
	@POST
	public void addVehicle(@QueryParam("make") String make,
			@QueryParam("model") String model,
			@QueryParam("year") int year,
			@QueryParam("vin") String vin,
			@QueryParam("policyNumber") int policyNumber){
	
		System.out.println("===Add Vehicle===");
		System.out.println("make: " + make);
		System.out.println("model: " + model);
		System.out.println("year: " + year);
		System.out.println("vin: " + vin);
		System.out.println("===END Add Vehicle===");
		
		Vehicles vehicle = new Vehicles();
		vehicle.setMake(make);
		vehicle.setModel(model);
		vehicle.setYear(year);
		vehicle.setVin(vin);
		vehicle.setPolicy_number(policyNumber);
		
		DatabaseUtil.commitObject(vehicle);
		
		
		
	}
	
	@Path("/driver")
	@POST
	public void addDriver(@QueryParam("licenseId") String licenseId,
			@QueryParam("fullName") String fullName,
			@QueryParam("address1") String address1,
			@QueryParam("address2") String address2,
			@QueryParam("city") String city,
			@QueryParam("state") String state,
			@QueryParam("zipcode") int zipcode,
			@QueryParam("dob") String dob,
			@QueryParam("policyNumber") int policyNumber){
		
		System.out.println("====Add Driver====");
		System.out.println("licenseId: " + licenseId);
		System.out.println("fullName: " + fullName);
		System.out.println("address1: " + address1);
		System.out.println("address2: " + address2);
		System.out.println("city: " + city);
		System.out.println("state:" + state);
		System.out.println("zipcode: " + zipcode);
		System.out.println("dob: " + dob);
		System.out.println("=====END Add Driver=====");
		
		Drivers driver = new Drivers();
		driver.setLicense_id(licenseId);
		driver.setFull_name(fullName);
		driver.setAddress1(address1);
		driver.setAddress2(address2);
		driver.setCity(city);
		driver.setState(state);
		driver.setZipcode(zipcode);
		try {
			driver.setDob(sdf.parse(dob));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		driver.setPolicy_number(policyNumber);
		
		DatabaseUtil.commitObject(driver);
		
	}
	
	@SuppressWarnings("unchecked")
	@Path("/policy")
	@GET
	@Produces({ MediaType.APPLICATION_XML })
	public Policy getPolicyInfo(@QueryParam("policyNumber") int policyNumber){
		
		System.out.println("===Policy===");
		Policy policy = new Policy();
		DriverList driverListCls = new DriverList();
		VehicleList vehicleListCls = new VehicleList();
		
		List<Driver> driverList = new LinkedList<Driver>();
		List<Vehicle> vehicleList = new LinkedList<Vehicle>();
		
		
		EntityManager em = DatabaseUtil.getEM();
		em.getTransaction().begin();
		Query query = em.createQuery("select x from Drivers x where x.policy_number="+policyNumber);
		List<Drivers> driversList=query.getResultList();
		for(Drivers drivers:driversList){
			Driver driver = new Driver();
			driver.setFull_name(drivers.getFull_name());
			driver.setLicense_id(drivers.getLicense_id());
			driver.setAddress1(drivers.getAddress1());
			driver.setAddress2(drivers.getAddress2());
			driver.setCity(drivers.getCity());
			driver.setState(drivers.getState());
			driver.setZipcode(drivers.getZipcode());
			driver.setDob(sdf.format(drivers.getDob()));
			driverList.add(driver);
		}
		em.getTransaction().commit();
		em.close();
		
		driverListCls.setDrivers(driverList);
		
		EntityManager em2 = DatabaseUtil.getEM();
		em2.getTransaction().begin();
		Query query2 = em2.createQuery("select x from Vehicles x where x.policy_number="+policyNumber);
		List<Vehicles> vehiclesList=query2.getResultList();
		for(Vehicles vehicles:vehiclesList){
			Vehicle vehicle = new Vehicle();
			vehicle.setMake(vehicles.getMake());
			vehicle.setModel(vehicles.getModel());
			vehicle.setVin(vehicles.getVin());
			vehicle.setYear(vehicles.getYear());
			vehicleList.add(vehicle);
		}
		em2.getTransaction().commit();
		em2.close();
		
		vehicleListCls.setVehicles(vehicleList);
		
		policy.setDriverList(driverListCls);
		policy.setVehicleList(vehicleListCls);
		
		System.out.println("===END Policy===");
		
		return policy;
	}
	
}
