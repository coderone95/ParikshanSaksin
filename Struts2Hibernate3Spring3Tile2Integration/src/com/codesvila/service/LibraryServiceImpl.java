package com.codesvila.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.codesvila.bean.LibraryBean;
import com.codesvila.dao.LibraryDAO;
import com.codesvila.model.Library;

@Service("libraryService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true) 
public class LibraryServiceImpl implements LibraryService {
	
	@Autowired
	private LibraryDAO libraryDao;
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)  
	public void saveBook(Library library) {
		
		libraryDao.saveBook(library); 
	}

	@Override
	public List<Library> getBookList() {
		
		return libraryDao.getBookList();
	}

	@Override
	public void deleteBook(int id) {
		// TODO Auto-generated method stub
		libraryDao.deleteBook(id);
	}

	@Override
	public void updateBook(int id, LibraryBean libraryBean) {
		// TODO Auto-generated method stub
		libraryDao.updateBook(id,libraryBean);
	}

}
