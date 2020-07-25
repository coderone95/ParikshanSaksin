package com.codesvila.dao;

import java.util.List;

public interface GenericDAO {
	@SuppressWarnings("rawtypes")
	public List nativeSQLQuery(String query);
	public void saveEntity(Object object);
	public void updateEntity(Object object);
	public void deleteEntity(Object object);
}
