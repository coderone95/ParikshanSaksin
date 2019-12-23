package com.codesvila.utils.searches;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.codesvila.bo.QueryMapperBO;
public class SearchReport {
	
public static QueryMapperBO getQuery(String reportQueryId, String reportName, Map<String, ParamBO> paramMap) {
		
		QueryMapperBO mapperBo = new QueryMapperBO();
		String sqlQuery = null;
		 
	    try {
	    	
	    StringBuilder reportXML = new StringBuilder();
	    reportXML.append(reportName);
	    reportXML.append(".xml");
 
	    InputStream xmlFile = SearchReport.class.getResourceAsStream(reportXML.toString());
		DocumentBuilderFactory docbuildFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docbuildFactory.newDocumentBuilder();
		Document document = docBuilder.parse(xmlFile);
 
		document.getDocumentElement().normalize();
 
		//System.out.println("Root element name :- " + document.getDocumentElement().getNodeName());
		
		NodeList nodes = document.getElementsByTagName("query");

		System.out.println(nodes.getLength());
		for (int i = 0; i < nodes.getLength(); i++) {
			Node node = nodes.item(i);
			Element element = (Element) node;
			String elementQueryId = element.getAttribute("id");
			if(elementQueryId != null && elementQueryId.equals(reportQueryId)) {
				sqlQuery = nodes.item(i).getTextContent();
				mapperBo.setQuery(sqlQuery.trim());
				mapperBo.setId(elementQueryId);
				System.out.println(sqlQuery.trim());
				Set<String> keys = paramMap.keySet();
				int count = 0;
				for(String key: keys) {
					mapperBo.setQuery(SearchReportHandler.paramterizedQuery(mapperBo, paramMap.get(key), count));
					count++;
				}
				sqlQuery = mapperBo.getQuery().replace("{", "");
				sqlQuery = sqlQuery.replace("}", "");
				mapperBo.setQuery(sqlQuery.trim());
				//System.out.println("Generated Query \n "+sqlQuery.trim());
			}
		}
		
	    }catch (Exception e) {
		e.printStackTrace();
	    }
		return mapperBo;
	  }
}
