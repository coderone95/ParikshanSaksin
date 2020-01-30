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

	public Session session;

	public SendmailSSl() {
		final String fromEmail = "salvi.sagar.9596@gmail.com"; // requires valid gmail id
		final String password = "xuijkplxbekujrjo"; // correct password for gmail id
		System.out.println("TLSEmail Start");
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP Host
		props.put("mail.smtp.port", "587"); // TLS Port
		props.put("mail.smtp.auth", "true"); // enable authentication
		props.put("mail.smtp.starttls.enable", "true"); // enable STARTTLS

		// create Authenticator object to pass in Session.getInstance argument
		Authenticator auth = new Authenticator() {
			// override the getPasswordAuthentication method
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		};
		session = Session.getInstance(props, auth);
	}

	public static void main(String[] args) {
		SendmailSSl sendSL = new SendmailSSl();
		sendSL.TLSSend("sagar.salvi@idmission.com");
	}

	public static void sendEmail() {
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.port", "465");

		props.put("mail.smtp.auth", "false");
		// props.put("mail.smtp.port", "805");

		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("sagar.salvi@idmission.com", "oevtsyuovottnmmb");
			}
		});

		try {

			SMTPMessage message = new SMTPMessage(session);
			message.setFrom(new InternetAddress("sagar.salvi@idmission.com"));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("sagarsalvi5@gmail.com"));

			message.setSubject("Testing Subject");
			message.setText("This is Test mail");
			message.setContent("Demo", "text/html");
			message.setNotifyOptions(SMTPMessage.NOTIFY_SUCCESS);
			int returnOption = message.getReturnOption();
			System.out.println(returnOption);
			Transport.send(message);
			System.out.println("sent");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}

	public static void TLSSend(String emailMsg, String sub, String sender, String recipient, String content,
			String contentType) {
		final String fromEmail = "salvi.sagar.9596@gmail.com"; // requires valid gmail id
		final String password = "qzmqtaxwynbnmzuh"; // correct password for gmail id
		final String toEmail = "salvi.sagar.9596@gmail.com"; // can be any email id

		System.out.println("TLSEmail Start");
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP Host
		props.put("mail.smtp.port", "587"); // TLS Port
		props.put("mail.smtp.auth", "true"); // enable authentication
		props.put("mail.smtp.starttls.enable", "true"); // enable STARTTLS

		// create Authenticator object to pass in Session.getInstance argument
		Authenticator auth = new Authenticator() {
			// override the getPasswordAuthentication method
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		};
		Session session = Session.getInstance(props, auth);

		EmailUtil.sendEmail(session, toEmail, "TLSEmail Testing Subject", "TLSEmail Testing Body", null);

	}

	public void TLSSend(String reciever) {
		final String fromEmail = "salvi.sagar.9596@gmail.com"; // requires valid gmail id
		final String password = "xuijkplxbekujrjo"; // correct password for gmail id
		final String toEmail = "salvi.sagar.9596@gmail.com"; // can be any email id
		if (reciever == null) {
			reciever = toEmail;
		}
		// System.out.println("TLSEmail Start");
		// Properties props = new Properties();
		// props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
		// props.put("mail.smtp.port", "587"); //TLS Port
		// props.put("mail.smtp.auth", "true"); //enable authentication
		// props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS
		//
		// //create Authenticator object to pass in Session.getInstance argument
		// Authenticator auth = new Authenticator() {
		// //override the getPasswordAuthentication method
		// protected PasswordAuthentication getPasswordAuthentication() {
		// return new PasswordAuthentication(fromEmail, password);
		// }
		// };
		// Session session = Session.getInstance(props, auth);

		StringBuilder sb = new StringBuilder();
		sb.append(
				"<link href=\"//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css\" rel=\"stylesheet\" id=\"bootstrap-css\">\n"
						+ "<script src=\"//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js\"></script>\n"
						+ "<script src=\"//code.jquery.com/jquery-1.11.1.min.js\"></script>\n"
						+ "<!------ Include the above in your HEAD tag ---------->\n" + "\n" + "<style>\n" + "/***\n"
						+ "User Profile Sidebar by @keenthemes\n"
						+ "A component of Metronic Theme - #1 Selling Bootstrap 3 Admin Theme in Themeforest: http://j.mp/metronictheme\n"
						+ "Licensed under MIT\n" + "***/\n" + "\n" + "body {\n" + "    padding: 0;\n"
						+ "    margin: 0;\n" + "}\n" + "\n"
						+ "html { -webkit-text-size-adjust:none; -ms-text-size-adjust: none;}\n"
						+ "@media only screen and (max-device-width: 680px), only screen and (max-width: 680px) { \n"
						+ "    *[class=\"table_width_100\"] {\n" + "		width: 96% !important;\n" + "	}\n"
						+ "	*[class=\"border-right_mob\"] {\n" + "		border-right: 1px solid #dddddd;\n" + "	}\n"
						+ "	*[class=\"mob_100\"] {\n" + "		width: 100% !important;\n" + "	}\n"
						+ "	*[class=\"mob_center\"] {\n" + "		text-align: center !important;\n" + "	}\n"
						+ "	*[class=\"mob_center_bl\"] {\n" + "		float: none !important;\n"
						+ "		display: block !important;\n" + "		margin: 0px auto;\n" + "	}	\n"
						+ "	.iage_footer a {\n" + "		text-decoration: none;\n" + "		color: #929ca8;\n" + "	}\n"
						+ "	img.mob_display_none {\n" + "		width: 0px !important;\n"
						+ "		height: 0px !important;\n" + "		display: none !important;\n" + "	}\n"
						+ "	img.mob_width_50 {\n" + "		width: 40% !important;\n"
						+ "		height: auto !important;\n" + "	}\n" + "}\n" + ".table_width_100 {\n"
						+ "	width: 680px;\n" + "}\n" + "</style>\n" + "\n" + "<!--\n"
						+ "Responsive Email Template by @keenthemes\n"
						+ "A component of Metronic Theme - #1 Selling Bootstrap 3 Admin Theme in Themeforest: http://j.mp/metronictheme\n"
						+ "Licensed under MIT\n" + "-->\n" + "\n"
						+ "<div id=\"mailsub\" class=\"notification\" align=\"center\">\n"
						+ "    <!--<div align=\"center\">\n"
						+ "       <img src=\"http://talmanagency.com/wp-content/uploads/2014/12/cropped-logo-new.png\" width=\"250\" alt=\"Metronic\" border=\"0\"  /> \n"
						+ "    </div> -->\n"
						+ "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"min-width: 320px;\"><tr><td align=\"center\" bgcolor=\"#eff3f8\">\n"
						+ "\n" + "\n" + "<!--[if gte mso 10]>\n"
						+ "<table width=\"680\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n" + "<tr><td>\n"
						+ "<![endif]-->\n" + "\n"
						+ "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"table_width_100\" width=\"100%\" style=\"max-width: 680px; min-width: 300px;\">\n"
						+ "    <tr><td>\n" + "	<!-- padding -->\n" + "	</td></tr>\n" + "	<!--header -->\n"
						+ "	<tr><td align=\"center\" bgcolor=\"#ffffff\">\n" + "		<!-- padding -->\n"
						+ "		<table width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n"
						+ "			<tr><td align=\"center\">\n"
						+ "			    		<a href=\"#\" target=\"_blank\" style=\"color: #596167; font-family: Arial, Helvetica, sans-serif; float:left; width:100%; padding:20px;text-align:center; font-size: 13px;\">\n"
						+ "									<font face=\"Arial, Helvetica, sans-seri; font-size: 13px;\" size=\"3\" color=\"#596167\">\n"
						+ "									<img src=\"http://talmanagency.com/wp-content/uploads/2014/12/cropped-logo-new.png\" width=\"250\" alt=\"Metronic\" border=\"0\"  /></font></a>\n"
						+ "					</td>\n" + "					<td align=\"right\">\n"
						+ "				<!--[endif]--><!-- \n" + "\n" + "			</td>\n" + "			</tr>\n"
						+ "		</table>\n" + "		<!-- padding -->\n" + "	</td></tr>\n" + "	<!--header END-->\n"
						+ "\n" + "	<!--content 1 -->\n" + "	<tr><td align=\"center\" bgcolor=\"#fbfcfd\">\n"
						+ "	    <font face=\"Arial, Helvetica, sans-serif\" size=\"4\" color=\"#57697e\" style=\"font-size: 15px;\">\n"
						+ "		<table width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n"
						+ "			<tr><td>\n" + "			    Dear Candidate,<br/>\n"
						+ "			    Welcome to Creative Talent Management!<br/>\n"
						+ "			    We have created an account for you. Here are your details:<br/>\n"
						+ "			    Name:<br/>\n" + "			    Email:<br/>\n"
						+ "                Organization:<br/>\n" + "                Password:<br/>\n"
						+ "			</td></tr>\n" + "			<tr><td align=\"center\">\n"
						+ "				<div style=\"line-height: 24px;\">\n"
						+ "					<a href=\"#\" target=\"_blank\" class=\"btn btn-danger block-center\">\n"
						+ "					    click\n" + "					</a>\n" + "				</div>\n"
						+ "				<!-- padding --><div style=\"height: 60px; line-height: 60px; font-size: 10px;\"></div>\n"
						+ "			</td></tr>\n" + "\n" + "		</table>\n" + "		</font>\n" + "	</td></tr>\n"
						+ "</table>\n" + "</td></tr>\n" + "</table>\n" + "</td></tr>\n" + "</table>\n" + "			");

		EmailUtil.sendEmail(session, reciever, "TLSEmail Testing Subject", "TLSEmail Testing Body", sb.toString());

	}
	public void sendOTPViaEmail(String otp,String reciever) {
		StringBuilder sb = new StringBuilder();
		sb.append(
				"<link href=\"//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css\" rel=\"stylesheet\" id=\"bootstrap-css\">\n"
						+ "<script src=\"//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js\"></script>\n"
						+ "<script src=\"//code.jquery.com/jquery-1.11.1.min.js\"></script>\n"
						+ "<!------ Include the above in your HEAD tag ---------->\n" + "\n" + "<style>\n" + "/***\n"
						+ "User Profile Sidebar by @keenthemes\n"
						+ "A component of Metronic Theme - #1 Selling Bootstrap 3 Admin Theme in Themeforest: http://j.mp/metronictheme\n"
						+ "Licensed under MIT\n" + "***/\n" + "\n" + "body {\n" + "    padding: 0;\n"
						+ "    margin: 0;\n" + "}\n" + "\n"
						+ "html { -webkit-text-size-adjust:none; -ms-text-size-adjust: none;}\n"
						+ "@media only screen and (max-device-width: 680px), only screen and (max-width: 680px) { \n"
						+ "    *[class=\"table_width_100\"] {\n" + "		width: 96% !important;\n" + "	}\n"
						+ "	*[class=\"border-right_mob\"] {\n" + "		border-right: 1px solid #dddddd;\n" + "	}\n"
						+ "	*[class=\"mob_100\"] {\n" + "		width: 100% !important;\n" + "	}\n"
						+ "	*[class=\"mob_center\"] {\n" + "		text-align: center !important;\n" + "	}\n"
						+ "	*[class=\"mob_center_bl\"] {\n" + "		float: none !important;\n"
						+ "		display: block !important;\n" + "		margin: 0px auto;\n" + "	}	\n"
						+ "	.iage_footer a {\n" + "		text-decoration: none;\n" + "		color: #929ca8;\n" + "	}\n"
						+ "	img.mob_display_none {\n" + "		width: 0px !important;\n"
						+ "		height: 0px !important;\n" + "		display: none !important;\n" + "	}\n"
						+ "	img.mob_width_50 {\n" + "		width: 40% !important;\n"
						+ "		height: auto !important;\n" + "	}\n" + "}\n" + ".table_width_100 {\n"
						+ "	width: 680px;\n" + "}\n" + "</style>\n" + "\n" + "<!--\n"
						+ "Responsive Email Template by @keenthemes\n"
						+ "A component of Metronic Theme - #1 Selling Bootstrap 3 Admin Theme in Themeforest: http://j.mp/metronictheme\n"
						+ "Licensed under MIT\n" + "-->\n" + "\n"
						+ "<div id=\"mailsub\" class=\"notification\" align=\"center\">\n"
						+ "    <!--<div align=\"center\">\n"
						+ "       <img src=\"http://talmanagency.com/wp-content/uploads/2014/12/cropped-logo-new.png\" width=\"250\" alt=\"Metronic\" border=\"0\"  /> \n"
						+ "    </div> -->\n"
						+ "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"min-width: 320px;\"><tr><td align=\"center\" bgcolor=\"#eff3f8\">\n"
						+ "\n" + "\n" + "<!--[if gte mso 10]>\n"
						+ "<table width=\"680\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n" + "<tr><td>\n"
						+ "<![endif]-->\n" + "\n"
						+ "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"table_width_100\" width=\"100%\" style=\"max-width: 680px; min-width: 300px;\">\n"
						+ "    <tr><td>\n" + "	<!-- padding -->\n" + "	</td></tr>\n" + "	<!--header -->\n"
						+ "	<tr><td align=\"center\" bgcolor=\"#ffffff\">\n" + "		<!-- padding -->\n"
						+ "		<table width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n"
						+ "			<tr><td align=\"center\">\n"
						+ "			    		<a href=\"#\" target=\"_blank\" style=\"color: #596167; font-family: Arial, Helvetica, sans-serif; float:left; width:100%; padding:20px;text-align:center; font-size: 13px;\">\n"
						+ "									<font face=\"Arial, Helvetica, sans-seri; font-size: 13px;\" size=\"3\" color=\"#596167\">\n"
						+ "									<img src=\"http://talmanagency.com/wp-content/uploads/2014/12/cropped-logo-new.png\" width=\"250\" alt=\"Metronic\" border=\"0\"  /></font></a>\n"
						+ "					</td>\n" + "					<td align=\"right\">\n"
						+ "				<!--[endif]--><!-- \n" + "\n" + "			</td>\n" + "			</tr>\n"
						+ "		</table>\n" + "		<!-- padding -->\n" + "	</td></tr>\n" + "	<!--header END-->\n"
						+ "\n" + "	<!--content 1 -->\n" + "	<tr><td align=\"center\" bgcolor=\"#fbfcfd\">\n"
						+ "	    <font face=\"Arial, Helvetica, sans-serif\" size=\"4\" color=\"#57697e\" style=\"font-size: 15px;\">\n"
						+ "		<table width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n"
						+ "			<tr><td>\n" + "	Dear candidate, <br/>\n"
						+ "			    Welcome to Parikshan Saksin! Please use below generated One Time Password.<br/>\n"
						+ "			    OTP: "+otp+" <br/>\n"
						+ "				<!-- padding --><div style=\"height: 60px; line-height: 60px; font-size: 10px;\"></div>\n"
						+ "			</td></tr>\n" + "\n" + "		</table>\n" + "		</font>\n" + "	</td></tr>\n"
						+ "</table>\n" + "</td></tr>\n" + "</table>\n" + "</td></tr>\n" + "</table>\n" + "			");
		EmailUtil.sendEmail(session, reciever, "Parikshan Saksin : One Time Password (OTP) ", null, sb.toString());
	}

	public void sendLoginCredentialsViaEmail(String user, String userName, String password, String email) {
		// TODO Auto-generated method stub
		StringBuilder sb = new StringBuilder();
		sb.append(
				"<link href=\"//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css\" rel=\"stylesheet\" id=\"bootstrap-css\">\n"
						+ "<script src=\"//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js\"></script>\n"
						+ "<script src=\"//code.jquery.com/jquery-1.11.1.min.js\"></script>\n"
						+ "<!------ Include the above in your HEAD tag ---------->\n" + "\n" + "<style>\n" + "/***\n"
						+ "User Profile Sidebar by @keenthemes\n"
						+ "A component of Metronic Theme - #1 Selling Bootstrap 3 Admin Theme in Themeforest: http://j.mp/metronictheme\n"
						+ "Licensed under MIT\n" + "***/\n" + "\n" + "body {\n" + "    padding: 0;\n"
						+ "    margin: 0;\n" + "}\n" + "\n"
						+ "html { -webkit-text-size-adjust:none; -ms-text-size-adjust: none;}\n"
						+ "@media only screen and (max-device-width: 680px), only screen and (max-width: 680px) { \n"
						+ "    *[class=\"table_width_100\"] {\n" + "		width: 96% !important;\n" + "	}\n"
						+ "	*[class=\"border-right_mob\"] {\n" + "		border-right: 1px solid #dddddd;\n" + "	}\n"
						+ "	*[class=\"mob_100\"] {\n" + "		width: 100% !important;\n" + "	}\n"
						+ "	*[class=\"mob_center\"] {\n" + "		text-align: center !important;\n" + "	}\n"
						+ "	*[class=\"mob_center_bl\"] {\n" + "		float: none !important;\n"
						+ "		display: block !important;\n" + "		margin: 0px auto;\n" + "	}	\n"
						+ "	.iage_footer a {\n" + "		text-decoration: none;\n" + "		color: #929ca8;\n" + "	}\n"
						+ "	img.mob_display_none {\n" + "		width: 0px !important;\n"
						+ "		height: 0px !important;\n" + "		display: none !important;\n" + "	}\n"
						+ "	img.mob_width_50 {\n" + "		width: 40% !important;\n"
						+ "		height: auto !important;\n" + "	}\n" + "}\n" + ".table_width_100 {\n"
						+ "	width: 680px;\n" + "}\n" + "</style>\n" + "\n" + "<!--\n"
						+ "Responsive Email Template by @keenthemes\n"
						+ "A component of Metronic Theme - #1 Selling Bootstrap 3 Admin Theme in Themeforest: http://j.mp/metronictheme\n"
						+ "Licensed under MIT\n" + "-->\n" + "\n"
						+ "<div id=\"mailsub\" class=\"notification\" align=\"center\">\n"
						+ "    <!--<div align=\"center\">\n"
						+ "       <img src=\"http://talmanagency.com/wp-content/uploads/2014/12/cropped-logo-new.png\" width=\"250\" alt=\"Metronic\" border=\"0\"  /> \n"
						+ "    </div> -->\n"
						+ "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"min-width: 320px;\"><tr><td align=\"center\" bgcolor=\"#eff3f8\">\n"
						+ "\n" + "\n" + "<!--[if gte mso 10]>\n"
						+ "<table width=\"680\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n" + "<tr><td>\n"
						+ "<![endif]-->\n" + "\n"
						+ "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"table_width_100\" width=\"100%\" style=\"max-width: 680px; min-width: 300px;\">\n"
						+ "    <tr><td>\n" + "	<!-- padding -->\n" + "	</td></tr>\n" + "	<!--header -->\n"
						+ "	<tr><td align=\"center\" bgcolor=\"#ffffff\">\n" + "		<!-- padding -->\n"
						+ "		<table width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n"
						+ "			<tr><td align=\"center\">\n"
						+ "			    		<a href=\"#\" target=\"_blank\" style=\"color: #596167; font-family: Arial, Helvetica, sans-serif; float:left; width:100%; padding:20px;text-align:center; font-size: 13px;\">\n"
						+ "									<font face=\"Arial, Helvetica, sans-seri; font-size: 13px;\" size=\"3\" color=\"#596167\">\n"
						+ "									<img src=\"http://talmanagency.com/wp-content/uploads/2014/12/cropped-logo-new.png\" width=\"250\" alt=\"Metronic\" border=\"0\"  /></font></a>\n"
						+ "					</td>\n" + "					<td align=\"right\">\n"
						+ "				<!--[endif]--><!-- \n" + "\n" + "			</td>\n" + "			</tr>\n"
						+ "		</table>\n" + "		<!-- padding -->\n" + "	</td></tr>\n" + "	<!--header END-->\n"
						+ "\n" + "	<!--content 1 -->\n" + "	<tr><td align=\"center\" bgcolor=\"#fbfcfd\">\n"
						+ "	    <font face=\"Arial, Helvetica, sans-serif\" size=\"4\" color=\"#57697e\" style=\"font-size: 15px;\">\n"
						+ "		<table width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n"
						+ "			<tr><td>\n" + "	Dear "+user+", <br/>\n"
						+ "			    Welcome to Parikshan Saksin! Please use below login credentials.<br/>\n"
						+ "			    Username: "+userName+" <br/>\n"
						+ "			    Password: "+password+" <br/>\n"
						+ "				<!-- padding --><div style=\"height: 60px; line-height: 60px; font-size: 10px;\"></div>\n"
						+ "			</td></tr>\n" + "\n" + "		</table>\n" + "		</font>\n" + "	</td></tr>\n"
						+ "</table>\n" + "</td></tr>\n" + "</table>\n" + "</td></tr>\n" + "</table>\n" + "			");
		EmailUtil.sendEmail(session, email, "Parikshan Saksin : Login Credentials ", null, sb.toString());
	}
	
}