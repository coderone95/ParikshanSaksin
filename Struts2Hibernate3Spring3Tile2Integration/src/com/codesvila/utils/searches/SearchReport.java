package com.codesvila.utils.searches;

import java.io.InputStream;
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
				if(paramMap != null) {
					for(String key: keys) {
						mapperBo.setQuery(SearchReportHandler.paramterizedQuery(mapperBo, paramMap.get(key)));
					}
				}
				sqlQuery = mapperBo.getQuery().replace("{", "");
				sqlQuery = sqlQuery.replace("}", "");
				mapperBo.setQuery(sqlQuery.trim());
			}
		}
		
	    }catch (Exception e) {
		e.printStackTrace();
	    }
		return mapperBo;
	  }

//	public static void main(String args[]) {
//
//		Map<String, ParamBO> mymap = new HashMap<String,ParamBO>();
//		ParamBO pStartDate = new ParamBO();
//		pStartDate.setParamName("pStartDate");
//		pStartDate.setParamType("SingleParamElement");
//		pStartDate.setParamreturnType("String");
//		pStartDate.setParamValue("24-12-2019 00:00:00");
//		
//		ParamBO pEndDate = new ParamBO();
//		pEndDate.setParamName("pEndDate");
//		pEndDate.setParamType("SingleParamElement");
//		pEndDate.setParamreturnType("String");
//		pEndDate.setParamValue("24-12-2019 23:00:00");
//		
//		ParamBO pCreatedBy = new ParamBO();
//		pCreatedBy.setParamName("pCreatedBy");
//		pCreatedBy.setParamType("SingleParamElement");
//		pCreatedBy.setParamreturnType("String");
//		pCreatedBy.setParamValue("sakshi@gmail.com");
//		
//		
//		ParamBO pQuestionName = new ParamBO();
//		pQuestionName.setParamName("pQuestionName");
//		pQuestionName.setParamType("SingleParamElement");
//		pQuestionName.setParamreturnType("String");
//		pQuestionName.setParamValue("How are you?");
//		
//		ParamBO pQuestionId = new ParamBO();
//		pQuestionId.setParamName("pQuestionId");
//		pQuestionId.setParamType("SingleParamElement");
//		pQuestionId.setParamreturnType("Integer");
//		pQuestionId.setParamValue(12);
//
//		mymap.put("pStartDate", pStartDate);
//		mymap.put("pEndDate", pEndDate);
//		mymap.put("pCreatedBy", pCreatedBy);
//		mymap.put("pQuestionName", pQuestionName);
//		mymap.put("pQuestionId", pQuestionId);
//		QueryMapperBO qmbo = SearchReport.getQuery("GET_QUESTIONS_REPORT", "ReportQuery", mymap);
//		System.out.println("QueryMapperBO qmbo : GET_QUESTIONS_REPORT" + qmbo.getQuery());
//	}
}
