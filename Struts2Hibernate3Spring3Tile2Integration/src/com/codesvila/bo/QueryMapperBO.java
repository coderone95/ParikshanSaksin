package com.codesvila.bo;

public class QueryMapperBO {
	
	private String query;
	
	private String id;
	
	private String queryId;
	
	private String resultReturnType;

	public String getQuery() {
		return query;
	}

	public void setQuery(String query) {
		this.query = query;
	}

	public String getQueryId() {
		return queryId;
	}

	public void setQueryId(String queryId) {
		this.queryId = queryId;
	}

	public String getResultReturnType() {
		return resultReturnType;
	}

	public void setResultReturnType(String resultReturnType) {
		this.resultReturnType = resultReturnType;
	}

	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}
	
}
