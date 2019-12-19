package com.codesvila.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.codesvila.dao.GenericDAO;
@Service("genericService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true) 
public class GenericServiceImpl implements GenericService{

	@Autowired
	private GenericDAO genericDao;
	
	
}
