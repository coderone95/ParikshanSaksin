package forward;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;

import com.sun.mail.smtp.SMTPMessage;

public class SendmailSSl {
//public static void main(String[] args) {
public static void sendEmail() {
    Properties props = new Properties();
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.socketFactory.port", "465");
    props.put("mail.smtp.socketFactory.class",
            "javax.net.ssl.SSLSocketFactory");
    props.put("mail.smtp.port", "465");

    props.put("mail.smtp.auth", "false");
   // props.put("mail.smtp.port", "805");

    Session session = Session.getDefaultInstance(props,new javax.mail.Authenticator() {
        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("sagar.salvi@idmission.com","oevtsyuovottnmmb");
        }
    });

    try {

        SMTPMessage message = new SMTPMessage(session);
        message.setFrom(new InternetAddress("sagar.salvi@idmission.com"));
        message.setRecipients(Message.RecipientType.TO,
                                 InternetAddress.parse( "sagarsalvi5@gmail.com" ));

        message.setSubject("Testing Subject");
        message.setText("This is Test mail");
        message.setContent("This Is my First Mail Through Java","text/html");
        message.setNotifyOptions(SMTPMessage.NOTIFY_SUCCESS);
        int returnOption = message.getReturnOption();
        System.out.println(returnOption);        
        Transport.send(message);
        System.out.println("sent");

    }
     catch (MessagingException e) {
        throw new RuntimeException(e);         
     }
  }
public static void TLSSend(String emailMsg, String sub, String sender, String recipient, String content, String contentType) {
	final String fromEmail = "salvi.sagar.9596@gmail.com"; //requires valid gmail id
	final String password = "qzmqtaxwynbnmzuh"; // correct password for gmail id
	final String toEmail = "salvi.sagar.9596@gmail.com"; // can be any email id 
	
	System.out.println("TLSEmail Start");
	Properties props = new Properties();
	props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
	props.put("mail.smtp.port", "587"); //TLS Port
	props.put("mail.smtp.auth", "true"); //enable authentication
	props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS
	
            //create Authenticator object to pass in Session.getInstance argument
	Authenticator auth = new Authenticator() {
		//override the getPasswordAuthentication method
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(fromEmail, password);
		}
	};
	Session session = Session.getInstance(props, auth);
	
	EmailUtil.sendEmail(session, toEmail,"TLSEmail Testing Subject", "TLSEmail Testing Body");
	
}
}