package com.codesvila.datasource;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.Properties;

import javax.sql.DataSource;

import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

public class DBCPDataSourceFactory {
	public static DataSource getDataSource() {
		Properties props = new Properties();
		FileInputStream fis = null;
		MysqlDataSource mysqlDS = null;
		File file = getFileFromResources("database.properties");
		try {
			fis = new FileInputStream(file);
			props.load(fis);
			mysqlDS = new MysqlDataSource();
			mysqlDS.setURL(props.getProperty("database.url"));
			mysqlDS.setUser(props.getProperty("database.user"));
			mysqlDS.setPassword(props.getProperty("database.password"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return mysqlDS;
	}
	public static File getFileFromResources(String filename) {
		ClassLoader classLoader = DBCPDataSourceFactory.class.getClassLoader();

        URL resource = classLoader.getResource(filename);
        if (resource == null) {
            throw new IllegalArgumentException("file is not found!");
        } else {
            return new File(resource.getFile());
        }
		
	}
	
}
