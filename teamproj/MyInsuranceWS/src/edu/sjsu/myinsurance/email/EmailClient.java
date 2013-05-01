package edu.sjsu.myinsurance.email;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class EmailClient {
	// static Logger logger = Logger.getLogger(EmailClient.class);

	// snmail.smtp.auth=true snmail.smtp.starttls.enable=true
	// snmail.smtp.host=smtp.gmail.com snmail.smtp.port=587
	private String username;
	private String password;
	private String auth;
	private String starttls;
	private String host;
	private String port;
	private String recipientList;

	/**
	 * Constructor for creating an email client
	 * 
	 * @param username
	 * @param password
	 * @param auth
	 * @param starttls
	 * @param host
	 * @param port
	 * @param recipientList
	 */
	public EmailClient(String username, String password, String auth,
			String starttls, String host, String port, String recipientList) {
		super();
		this.username = username;
		this.password = password;
		this.auth = auth;
		this.starttls = starttls;
		this.host = host;
		this.port = port;
		this.recipientList = recipientList;
	}

	public void sendMessage(String subject, String messageBody, String file) {
		Properties props = new Properties();
		props.put("mail.smtp.auth", auth);
		props.put("mail.smtp.starttls.enable", starttls);
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);

		Session session = Session.getInstance(props,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(username, password);
					}
				});

		try {

			System.out.println("Sending Email to recipient list");
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("cmpe277spring2013@gmail.com", "MyInsurance"));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(recipientList));
			message.setSubject(subject);
			// message.setText(messageBody);
			BodyPart messageBodyPart = new MimeBodyPart();
			messageBodyPart.setText(messageBody);
			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBodyPart);

			messageBodyPart = new MimeBodyPart();
			DataSource source = new FileDataSource(file);
			messageBodyPart.setDataHandler(new DataHandler(source));
			String[] fileSplit = file.split("/");
			messageBodyPart.setFileName(fileSplit[fileSplit.length-1]);
			multipart.addBodyPart(messageBodyPart);

			message.setContent(multipart);
			Transport.send(message);

			System.out.println("Sent Email to recipient list");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
