package com.codesvila.utils.searches;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.codesvila.bo.QueryMapperBO;

public class SearchReportHandler {

	public static String paramterizedQuery(QueryMapperBO querMapperBo, ParamBO paramBO, int count) {
		String query = null;
		if (querMapperBo != null) {
			if (paramBO != null) {
				query = querMapperBo.getQuery();
				query = returnClause(paramBO, query, count);
			}
		}
		return query;
	}

	public static String returnClause(ParamBO pmBo, String query, int count) {
		// String sss = "hello sagar {isNotNullOrBlank}";
		Pattern pattern = Pattern.compile("\\{(.*?)\\}");
		List<String> matchedGroup = matchPattern(query, pattern);
		StringBuilder sb = new StringBuilder();
		if (matchedGroup.size() > 0) {
			String group = matchedGroup.get(count);
			Pattern innerPattern = Pattern.compile("\\[(.*?)\\]");
			String matchedParam = matchParamPattern(group, innerPattern);
			//System.out.println("Matched Param String" + matchedParam);
			if (matchedParam.equals("[" + pmBo.getParamName() + "]")) {
				System.out.println("Matched");
				if (pmBo.getParamValue() != null) {
					if (pmBo.getParamType().equals("SingleParamElement")) {
						sb.append("$[");
						sb.append(pmBo.getParamName());
						sb.append("]");
						query = query.replace(sb.toString(), (String) pmBo.getParamValue());
					} else if (pmBo.getParamType().equals("List")) {
						if (pmBo.getParamreturnType().equals("String")) {
							StringBuilder params = stringParams((List) pmBo.getParamValue());
							sb.append("$[");
							sb.append(pmBo.getParamName());
							sb.append("]");
							query = query.replace(sb.toString(), params.toString());
						} else if (pmBo.getParamreturnType().equals("Integer")) {
							StringBuilder params = intParams((List) pmBo.getParamValue());
							query = query.replace(sb.toString(), params.toString());
						}
					}
				} else {
					query = query.replace("{" + group + "}", "true");
				}
			}
		}

		return query;
	}

	public static String matchParamPattern(String str, Pattern innerPattern) {
		Matcher m = innerPattern.matcher(str);
		while (m.find()) {
			return (String) m.group();
		}
		return null;
	}

	public static StringBuilder stringParams(List list) {
		String commaSeperator = ",";
		String stringSep = "'";
		StringBuilder sb = new StringBuilder();
		for (Object li : list) {
			String temp = (String) li;
			sb.append(stringSep);
			sb.append(temp);
			sb.append(stringSep);
			int index = list.indexOf(li);
			if (index != (list.size() - 1)) {
				sb.append(commaSeperator);
			}
		}
		return sb;
	}

	public static StringBuilder intParams(List list) {
		String commaSeperator = ",";
		StringBuilder sb = new StringBuilder();
		for (Object li : list) {
			Integer temp = (Integer) li;
			sb.append(temp);
			int index = list.indexOf(li);
			if (index != (list.size() - 1)) {
				sb.append(commaSeperator);
			}
		}
		return sb;
	}

	public static List<String> matchPattern(String str, Pattern pattern) {
		Matcher m = pattern.matcher(str);
		List<String> matchedGroup = new ArrayList<String>();
		int groupCount = m.groupCount();
		while (m.find()) {
			for (int i = 0; i <= groupCount; i++) {
				// Group i substring
				//System.out.println("Group " + i + ": " + m.group(i));
				if (i == 1) {
					matchedGroup.add((String) m.group(1));
				}
			}
		}
		//System.out.println("GroupList :\n" + matchedGroup.toString());

		return matchedGroup;
	}

}
