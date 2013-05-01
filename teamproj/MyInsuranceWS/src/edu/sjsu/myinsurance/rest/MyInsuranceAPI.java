package edu.sjsu.myinsurance.rest;

import java.awt.Color;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.servlet.ServletContext;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import de.brendamour.jpasskit.PKBarcode;
import de.brendamour.jpasskit.PKField;
import de.brendamour.jpasskit.PKPass;
import de.brendamour.jpasskit.enums.PKBarcodeFormat;
import de.brendamour.jpasskit.passes.PKGenericPass;
import de.brendamour.jpasskit.signing.PKSigningInformation;
import de.brendamour.jpasskit.signing.PKSigningUtil;
import edu.sjsu.myinsurance.db.DatabaseUtil;
import edu.sjsu.myinsurance.email.EmailClient;
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
	
	@SuppressWarnings("unchecked")
	@Path("/insurancecard")
	@GET
	public Response generateInsuranceCard(@QueryParam("policyNumber") int policyNumber,@Context ServletContext context){
		if(policyNumber==0)
			throw new WebApplicationException(400);
		PKPass pass = new PKPass();
		PKBarcode barcode = new PKBarcode();
		//PKStoreCard storeCard = new PKStoreCard();
		PKGenericPass storeCard = new PKGenericPass();
		List<PKField> primaryFields = new ArrayList<PKField>();
		List<PKField> secondaryFields = new ArrayList<PKField>();
		List<PKField> backFields = new ArrayList<PKField>();
		
		PKField balanceField = new PKField();
		balanceField.setKey( "status" );
		balanceField.setLabel( "Status" );
		balanceField.setValue("Don't worry, you're covered!");
		//balanceField.setCurrencyCode( "EUR" );

		primaryFields.add( balanceField );
		
		PKField secondField = new PKField();
		secondField.setKey( "policy" );
		secondField.setLabel( "Policy" );
		secondField.setValue("Please find your Policy Number in the QR Code below!");
		
		secondaryFields.add(secondField);
		
		String policyStr = "Drivers:\n";
		EntityManager em = DatabaseUtil.getEM();
		em.getTransaction().begin();
		Query query = em.createQuery("select x from Drivers x where x.policy_number="+policyNumber);
		List<Drivers> driversList=query.getResultList();
		for(Drivers drivers:driversList){
			policyStr+="Full Name: "+drivers.getFull_name()+"\n";
			policyStr+="License Id: "+drivers.getLicense_id()+"\n";
			policyStr+="Address:\n"+drivers.getAddress1()+"\n";
			if(drivers.getAddress2()!=null)
				policyStr+=drivers.getAddress2()+"\n";
			policyStr+=drivers.getCity()+", ";
			policyStr+=drivers.getState()+" ";
			policyStr+=drivers.getZipcode()+"\n";
			policyStr+="DOB: "+sdf.format(drivers.getDob())+"\n\n";
		}
		em.getTransaction().commit();
		em.close();
		
		policyStr+="Vehicles:\n";
		
		EntityManager em2 = DatabaseUtil.getEM();
		em2.getTransaction().begin();
		Query query2 = em2.createQuery("select x from Vehicles x where x.policy_number="+policyNumber);
		List<Vehicles> vehiclesList=query2.getResultList();
		for(Vehicles vehicles:vehiclesList){
			policyStr+="Make: "+vehicles.getMake()+"\n";
			policyStr+="Model: "+vehicles.getModel()+"\n";
			policyStr+="VIN: "+vehicles.getVin()+"\n";
			policyStr+="Year: "+vehicles.getYear()+"\n\n";
		}
		em2.getTransaction().commit();
		em2.close();
		
		PKField backField = new PKField();
		backField.setKey( "info" );
		backField.setLabel( "Information" );
		backField.setValue(policyStr);
		
		backFields.add(backField);
		
		PKField backField1 = new PKField();
		backField1.setKey( "tips" );
		backField1.setLabel( "Tips" );
		backField1.setValue("Never admit fault! Please just gather information from all those involved and contact us immediately!");

		backFields.add(backField1);
		
		PKField backField2 = new PKField();
		backField2.setKey( "office" );
		backField2.setLabel( "Customer Service" );
		backField2.setValue("MyInsurance\nOne Washington Square\nSan Jose, CA 95129\nTel:1-800-myinsur");

		backFields.add(backField2);
		
		barcode.setFormat( PKBarcodeFormat.PKBarcodeFormatQR );
		barcode.setMessage( String.valueOf(policyNumber) );
		barcode.setMessageEncoding( "utf-8" );

		storeCard.setPrimaryFields( primaryFields );
		storeCard.setSecondaryFields(secondaryFields);
		storeCard.setBackFields(backFields);
		
		Properties prop = new Properties();
		
		PKSigningInformation pkSigningInformation;
		try {
			prop.load(new FileInputStream(new File(context.getRealPath("/")+"/WEB-INF/classes/config.properties")));
			pass.setFormatVersion( 1 );
			pass.setPassTypeIdentifier( (String)prop.get("passId") );
			pass.setSerialNumber( String.valueOf(policyNumber) );
			pass.setTeamIdentifier( (String)prop.get("teamId") );
			pass.setBarcode( barcode );
			pass.setOrganizationName( "MyInsurance" );
			pass.setLogoText( "My Insurance Card" );
			pass.setGeneric(storeCard);
			pass.setDescription( "Insurance Card" );
			pass.setBackgroundColorAsObject( new Color(208,154,23) );
			pass.setForegroundColor( "rgb(255,255,255)" );
			System.out.println("the realpath: "+ context.getRealPath("/"));
			pkSigningInformation = PKSigningUtil.loadSigningInformationFromPKCS12FileAndIntermediateCertificateFile(
					"Certificates.p12",(String)prop.get("certPass"), "AppleWorldwideDeveloperRelationsCertificationAuthority.pem");
			byte[] passZipAsByteArray = PKSigningUtil.createSignedAndZippedPkPassArchive(pass, context.getRealPath("/") + "/WEB-INF/GenericCard", pkSigningInformation);
			
//			snmail.username=cmpe277spring2013@gmail.com
//					snmail.password=spartan123
//					snmail.smtp.auth=true
//					snmail.smtp.starttls.enable=true
//					snmail.smtp.host=smtp.gmail.com
//					snmail.smtp.port=587
//					snmail.recipientlist=michaeldhari@gmail.com
			EmailClient emailClient = new EmailClient("cmpe277spring2013@gmail.com", "spartan123", "true",
					"true", "smtp.gmail.com", "587","michaeldhari@gmail.com");
			
			
			FileOutputStream fos = new FileOutputStream(context.getRealPath("/")+"myinsurance-"+policyNumber+".pkpass");
			fos.write(passZipAsByteArray);
			fos.close();
			
			emailClient.sendMessage("MyInsurance card", "Please find your insurance card attached!", context.getRealPath("/")+"myinsurance-"+policyNumber+".pkpass");
			
			//cleanup
			File file = new File(context.getRealPath("/")+"myinsurance-"+policyNumber+".pkpass");
			 
    		if(file.delete()){
    			System.out.println(file.getName() + " is deleted!");
    		}else{
    			System.out.println("Delete operation is failed.");
    		}
			
		} catch (UnrecoverableKeyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CertificateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (KeyStoreException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchProviderException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return Response.status(200).build();
	}
	
	
	
}
