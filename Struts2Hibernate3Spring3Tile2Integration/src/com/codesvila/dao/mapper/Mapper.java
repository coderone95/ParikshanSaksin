package com.codesvila.dao.mapper;
import java.io.InputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.codesvila.bo.QueryMapperBO;
 
public class Mapper {
	
	public static QueryMapperBO getQuery(String queryId) {
		
		QueryMapperBO mapperBo = new QueryMapperBO();
		
		String query = null;
		String resultReturnType = null;
		 
	    try {
 
	    InputStream xmlFile = Mapper.class.getResourceAsStream("Mapper.xml");
		DocumentBuilderFactory docbuildFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docbuildFactory.newDocumentBuilder();
		Document document = docBuilder.parse(xmlFile);
 
		document.getDocumentElement().normalize();
 
		System.out.println("Root element name :- " + document.getDocumentElement().getNodeName());
		
		
		NodeList nodeList = document.getElementsByTagName("QUERY_ELEMENT");
 
		for (int i = 0; i < nodeList.getLength(); i++) {
 
			Node node = nodeList.item(i);
 
			System.out.println("\nCurrent element name :- " + node.getNodeName());
			System.out.println("-------------------------------------");
			System.out.println("Passed Query ID:- " + queryId);
			if (node.getNodeType() == Node.ELEMENT_NODE) {
				
				Element element = (Element) node;
				Element el = (Element) element.getElementsByTagName("select").item(i);
				if(queryId.equalsIgnoreCase(el.getAttribute("id"))) {
					query = element.getElementsByTagName("select").item(i).getTextContent();
					resultReturnType = el.getAttribute("returnType");
					mapperBo.setQuery(query); 
					mapperBo.setResultReturnType(resultReturnType);
					mapperBo.setQueryId(queryId);
				}
			}
		}
	    } catch (Exception e) {
		e.printStackTrace();
	    }
		return mapperBo;
	  }

}
