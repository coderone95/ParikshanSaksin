package com.codesvila.utils;

//Java program to send email 
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmail {

	public static void sendEmail(String emailMsg, String sub, String sender, String recipient, String content, String contentType) {
		// email ID of Recipient.
		 //recipient = "recipient@gmail.com";

		// email ID of Sender.
		 if(sender == null ) {
			 sender = MessagePropertiesUtil.getMsgProp("default.email.sender");
		 }

		// using host as localhost
		String host = MessagePropertiesUtil.getMsgProp("smtp.host");
		String port = MessagePropertiesUtil.getMsgProp("smtp.port");
		Session session =createConnectionPool(port,host); 
		

		try {
			// MimeMessage object.
			MimeMessage message = new MimeMessage(session);

			// Set From Field: adding senders email to from field.
			message.setFrom(new InternetAddress(sender));

			// Set To Field: adding recipient's email to from field.
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

			// Set Subject: subject of the email
			message.setSubject(sub);
			
			// set body of the email.
			message.setText(emailMsg);

			
			// Send email.
			Transport.send(message);
			
		} catch (MessagingException mex) {
			mex.printStackTrace();
		}
	}
	
	public static Session createConnectionPool( String port, String host) {
		// Getting system properties
		Properties properties = System.getProperties();
				
		// Setting up mail server
		properties.setProperty("mail.smtp.host", host);
		properties.setProperty("mail.smtp.port", port);

		// creating session object to get properties
		Session session = Session.getDefaultInstance(properties);
		return session;
	}
}
