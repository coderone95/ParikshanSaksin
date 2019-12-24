package com.codesvila.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

public class DateUtils {
	
	public static Date getCurrentDate() {
		Date date = new Date();
		//SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		return date;
	}
	
	public static Date getFormattedDate(String strDate) throws ParseException {
		if(strDate != null && StringUtils.isNotBlank(strDate)) {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = formatter.parse(strDate);
			return date;
		}
		return null;
	}
	
}
