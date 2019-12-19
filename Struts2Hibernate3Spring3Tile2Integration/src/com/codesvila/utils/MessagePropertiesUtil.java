package com.codesvila.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.Properties;

import com.codesvila.datasource.DBCPDataSourceFactory;

public class MessagePropertiesUtil {

	public static String getMsgProp(String key) {
		Properties props = new Properties();
		FileInputStream fis = null;
		String msg = null;
		File file = getFileFromResources("myapp.properties");
		try {
			fis = new FileInputStream(file);
			props.load(fis);
			msg = props.getProperty(key);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return msg;
	}

	public static File getFileFromResources(String filename) {
		ClassLoader classLoader = DBCPDataSourceFactory.class.getClassLoader();

		URL resource = classLoader.getResource(filename);
		if (resource == null) {
			throw new IllegalArgumentException("Message Properties File is not found!");
		} else {
			return new File(resource.getFile());
		}

	}

}
