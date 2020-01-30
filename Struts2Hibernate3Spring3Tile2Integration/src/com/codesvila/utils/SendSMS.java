package com.codesvila.utils;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.ProtocolException;
import java.net.URL;
public class SendSMS {

	public static String sendOTPViaSms(String phone, String otp) {
        try {
                // Construct data
                String message = "&message=" + "Use this OTP: "+otp+". It will expire after 10 minutes.";
                String numbers = "&numbers=" + phone;
//                String numbers = "&numbers=" + phone;
                return sendSMS(numbers, message);
        } catch (Exception e) {
                System.out.println("Error SMS "+e);
                return "Error";
        }
	}
	
	
	public static String sendSMS(String numbers, String message) throws Exception {
		 String sender = "&sender=" + "TXTLCL";
		String apiKey = "apikey=" + "PC78iwyyojw-4KEjgS87Bo2Y0lAC56L00tvMZ8sJaA";
        // Send data
        HttpURLConnection conn = (HttpURLConnection) new URL("https://api.textlocal.in/send/?").openConnection();
        String data = apiKey + numbers + message + sender;
        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Length", Integer.toString(data.length()));
        conn.getOutputStream().write(data.getBytes("UTF-8"));
        final BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        final StringBuffer stringBuffer = new StringBuffer();
        String line;
        while ((line = rd.readLine()) != null) {
                stringBuffer.append(line);
        }
        rd.close();
		return stringBuffer.toString();
	}

	public static String sendLoginCredentialsViaSMS(String userName, String password, String phone) {
		 try {
             String message = "&message=" + "You can login using following credentials.\nUsername: "+userName+"\nPasssword: "+password+"";
             String numbers = "&numbers=" + phone;
             return sendSMS(numbers, message);
     } catch (Exception e) {
             System.out.println("Error SMS "+e);
             return "Error";
     }
	}
}
