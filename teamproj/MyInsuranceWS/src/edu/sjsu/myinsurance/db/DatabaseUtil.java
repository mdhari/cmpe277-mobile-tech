package edu.sjsu.myinsurance.db;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class DatabaseUtil {
	public static EntityManagerFactory entityManagerFactory = Persistence
			.createEntityManagerFactory("MyInsuranceWS");

	public static <T> boolean commitObject(T object) {

		boolean success = true;
		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			
			em.getTransaction().begin();
			em.persist(object);
			em.getTransaction().commit();
			em.close();
		} catch (Exception e) {
			e.printStackTrace();
			success = false;
		}

		return success;

	}

	public static EntityManager getEM() {
		return entityManagerFactory.createEntityManager();
	}
}
