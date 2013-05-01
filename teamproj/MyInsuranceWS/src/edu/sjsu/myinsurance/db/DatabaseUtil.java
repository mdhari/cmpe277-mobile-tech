package edu.sjsu.myinsurance.db;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;


public class DatabaseUtil {
	public static EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory(
			"MyInsuranceWS");
	
	public static <T> void commitObject(T object){
	
			
			EntityManager em = entityManagerFactory.createEntityManager();
			em.getTransaction().begin();
			em.persist(object);    
			em.getTransaction().commit();
			em.close();
	

	}
	
	public static EntityManager getEM(){
		return entityManagerFactory.createEntityManager();
	}
}
