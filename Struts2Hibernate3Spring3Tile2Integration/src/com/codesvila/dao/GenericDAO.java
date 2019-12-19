package com.codesvila.dao;

import java.util.List;

public interface GenericDAO {
	@SuppressWarnings("rawtypes")
	public List nativeSQLQuery(String query);
}
