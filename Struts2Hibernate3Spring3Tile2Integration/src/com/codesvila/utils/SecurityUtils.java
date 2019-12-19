package com.codesvila.utils;

import java.util.Base64;

public class SecurityUtils {

	public static String enryptPassword(String pwd) throws Exception {
		// Encode using basic encoder
        String base64encodedString = Base64.getEncoder().encodeToString(
           pwd.getBytes("utf-8"));
        
		return base64encodedString;
	}
	
	public static String decryptPassword(String encryptedString) throws Exception{
		 // Decode
        byte[] base64decodedBytes = Base64.getDecoder().decode(encryptedString);
        String descryptedPwd = new String(base64decodedBytes,"utf-8");
		return descryptedPwd;
	}
}

